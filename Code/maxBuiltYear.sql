with subquery as (
    select state_code_001, year_built_027, count(*) count
    from bridge group by state_code_001, year_built_027
    having year_built_027 != ''
    )
select a.state_code_001, year_built_027, maxcount from
    (select state_code_001, max(count) maxcount from subquery group by state_code_001) a
    join subquery b on a.state_code_001 = b.state_code_001 and a.maxcount = b.count;