-- Is the physical condition rating and the customer appraisal rating correlated?

drop table if exists pcc_test;

create table pcc_test as
select 
	STATE_CODE_001,
    MAINTENANCE_021,
    STRUCTURE_NUMBER_008,
    RECORD_TYPE_005A,
    
    DECK_COND_058,
    SUPERSTRUCTURE_COND_059,
    SUBSTRUCTURE_COND_060,
    CHANNEL_COND_061,
    CULVERT_COND_062,
    
    STRUCTURAL_EVAL_067,
    DECK_GEOMETRY_EVAL_068,
    UNDCLRENCE_EVAL_069,
    POSTING_EVAL_070,
    WATERWAY_EVAL_071,
    APPR_ROAD_EVAL_072
    
from rawdata;

alter table pcc_test
add primary key (STATE_CODE_001, STRUCTURE_NUMBER_008, RECORD_TYPE_005A, MAINTENANCE_021);

delete 
from pcc_test
where (DECK_COND_058 regexp '[^0-9.]') != 0 
or (STRUCTURAL_EVAL_067 regexp '[^0-9.]') != 0;

-- fast pcc
select 
	(avg(DECK_COND_058 * STRUCTURAL_EVAL_067) 
    - avg(DECK_COND_058) * avg(STRUCTURAL_EVAL_067)) 
    / (sqrt(avg(DECK_COND_058 * DECK_COND_058) 
    - avg(DECK_COND_058) * avg(DECK_COND_058)) 
    * sqrt(avg(STRUCTURAL_EVAL_067 * STRUCTURAL_EVAL_067) 
    - avg(STRUCTURAL_EVAL_067) * avg(STRUCTURAL_EVAL_067))) 
as pcc_058_067
from pcc_test;

-- slow pcc
DELIMITER //

drop procedure if exists pcc;
create procedure pcc()
    begin
		declare count int;
        declare i int;
        declare mean1, mean2 float;
        declare upper, lowerleft, lowerright float;
        declare x1, x2 float;
        declare r float;
        select count(*) 
        from pcc_test 
        into count;
        select avg(DECK_COND_058) 
        from pcc_test 
        into mean1;
        select avg(STRUCTURAL_EVAL_067) 
        from pcc_test
        into mean2;
        set i = 0;
        set upper = 0;
        set lowerleft = 0;
        set lowerright = 0;
        while i < 10
        do
			select DECK_COND_058 
            from pcc_test
            limit i,1 into x1;
            select STRUCTURAL_EVAL_067
            from pcc_test
            limit i,1 
            into x2;
			set upper = upper + (x1 - mean1) * (x2 - mean2);
            set lowerleft = lowerleft + pow((x1-mean1), 2);
            set lowerright = lowerright + pow((x2-mean2), 2);
            set i = i;
		end while;
        set lowerleft = sqrt(lowerleft);
        set lowerright = sqrt(lowerright);
        set r = upper / (lowerleft * lowerright);
        select r;
    end//

DELIMITER ;
call pcc();


