drop table if exists bridge_count;
create table bridge_count as
select STATE_CODE_001,Structure_number_008,record_type_005A,year_built_027
from rawdata
group by state_code_001,STRUCTURE_NUMBER_008
having count(RECORD_TYPE_005A)=1;

drop table if exists bridge_count1;
create table bridge_count1 as
SELECT STATE_CODE_001 as count_state, year_built_027 as count_year,count(STATE_CODE_001) as count
from bridge_count
group by year_built_027,state_code_001;

select count_state,count_year,max(count) from bridge_count1
group by count_state ;
