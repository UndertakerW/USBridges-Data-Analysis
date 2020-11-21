-- Is the physical condition rating and the customer appraisal rating correlated?

drop table if exists further_question_1;

create table further_question_1 as
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

alter table further_question_1
add primary key (STATE_CODE_001, STRUCTURE_NUMBER_008, RECORD_TYPE_005A, MAINTENANCE_021);

drop table if exists correlation_1;

create table correlation_1 as
select DECK_COND_058, STRUCTURAL_EVAL_067, count(STRUCTURAL_EVAL_067)
from further_question_1
where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
group by DECK_COND_058, STRUCTURAL_EVAL_067
having DECK_COND_058 >= 0 and STRUCTURAL_EVAL_067 >= 0
order by DECK_COND_058;

select * from correlation_1;

-- fast pcc 1
select 
	(avg(DECK_COND_058 * STRUCTURAL_EVAL_067) 
    - avg(DECK_COND_058) * avg(STRUCTURAL_EVAL_067)) 
    / (sqrt(avg(DECK_COND_058 * DECK_COND_058) 
    - avg(DECK_COND_058) * avg(DECK_COND_058)) 
    * sqrt(avg(STRUCTURAL_EVAL_067 * STRUCTURAL_EVAL_067) 
    - avg(STRUCTURAL_EVAL_067) * avg(STRUCTURAL_EVAL_067))) 
as pcc_058_067
from further_question_1
where (DECK_COND_058 regexp '[^0-9.]') = 0 
and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0;

-- fast pcc 2
select  (count(*) * sum(DECK_COND_058 * STRUCTURAL_EVAL_067) - sum(DECK_COND_058) * sum(STRUCTURAL_EVAL_067)) / 
        (sqrt(count(*) * sum(DECK_COND_058 * DECK_COND_058) - sum(DECK_COND_058) * sum(DECK_COND_058)) * sqrt(count(*) * sum(STRUCTURAL_EVAL_067 * STRUCTURAL_EVAL_067) - sum(STRUCTURAL_EVAL_067) * sum(STRUCTURAL_EVAL_067))) 
as pcc_058_067
from further_question_1
where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0;


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
        from further_question_1 
        where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
        into count;
        select avg(DECK_COND_058) 
        from further_question_1 
        where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
        into mean1;
        select avg(STRUCTURAL_EVAL_067) 
        from further_question_1
        where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
        into mean2;
        set i = 0;
        set upper = 0;
        set lowerleft = 0;
        set lowerright = 0;
        while i < count
        do
			select DECK_COND_058 
            from further_question_1
            where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
            limit i,1 into x1;
            select STRUCTURAL_EVAL_067
            from further_question_1
            where (DECK_COND_058 regexp '[^0-9.]') = 0 and (STRUCTURAL_EVAL_067 regexp '[^0-9.]') = 0
            limit i,1 
            into x2;
			set upper = upper + (x1 - mean1) * (x2 - mean2);
            set lowerleft = lowerleft + pow((x1-mean1), 2);
            set lowerright = lowerright + pow((x2-mean2), 2);
            set i = i + 1;
		end while;
        set lowerleft = sqrt(lowerleft);
        set lowerright = sqrt(lowerright);
        set r = upper / (lowerleft * lowerright);
        select r;
    end//

DELIMITER ;
call pcc();


