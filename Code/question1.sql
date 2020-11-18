create table bridge_count as
select STATE_CODE_001,Structure_number_008,record_type_005A,fed_agency,year_built_027
from rawdata
group by state_code_001,STRUCTURE_NUMBER_008
having count(RECORD_TYPE_005A)=1;

SELECT year_built_027 as count_year,count(year_built_027) as count
from bridge_count
group by year_built_027
order by count desc
limit 1;