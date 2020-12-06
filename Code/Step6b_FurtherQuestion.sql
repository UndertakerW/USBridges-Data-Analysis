 DROP TABLE design_load;

create table design_load as 
select distinct STATE_CODE_001, STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B, DESIGN_LOAD_031, YEAR_BUILT_027
from erg3010.rawdata;

alter table design_load
add column design_load_metric float;



select * from design_load;

update design_load
set design_load_metric = 9 where DESIGN_LOAD_031 = '1';

update design_load
set design_load_metric = 13.5 where DESIGN_LOAD_031 = '2' or DESIGN_LOAD_031 = '3';

update design_load
set design_load_metric = 18 where DESIGN_LOAD_031 = '4' or DESIGN_LOAD_031 = '5' or DESIGN_LOAD_031 = '6';

update design_load
set design_load_metric = 22.5 where DESIGN_LOAD_031 = '9';

delete from design_load where design_load_metric is null;


select STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B, YEAR_BUILT_027, count(*) from design_load
group by STRUCTURE_KIND_043A,STRUCTURE_TYPE_043B
order by STRUCTURE_KIND_043A, STRUCTURE_TYPE_043B;