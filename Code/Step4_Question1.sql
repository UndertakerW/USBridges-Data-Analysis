drop table if exists bridge_count;
create table bridge_count as
SELECT STATE_CODE_001 as count_state, year_built_027 as count_year,count(*) as count
from rawdata
group by year_built_027,state_code_001
having YEAR_BUILT_027!='';

select a.* 
from bridge_count a inner join 
(select count_state,max(count) count from bridge_count group by count_state)b 
on a.count_state = b.count_state and a.count = b.count order by a.count_state;


