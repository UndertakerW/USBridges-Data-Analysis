-- DESIGN LOAD versus YEAR BUILT

create table design_load (DESIGN_LOAD_CODE varchar(2), METRIC_DESIGN_LOAD float);

insert into design_load values
	('1', 9),
	('2', 13.5),
    ('3', 13.5),
    ('4', 18),
    ('5', 18),
    ('6', 18),
    ('9', 22.5);

alter table design_load
add primary key(DESIGN_LOAD_CODE);

create index design_load_index on rawdata (DESIGN_LOAD_031);

create table design_load_by_year as (
select YEAR_BUILT_027 YEAR_BUILT, METRIC_DESIGN_LOAD
from rawdata, design_load
where DESIGN_LOAD_031 = DESIGN_LOAD_CODE );

create table avg_design_load_by_year as (
select YEAR_BUILT, count(*) BRIDGES_BUILT, avg(METRIC_DESIGN_LOAD) AVG_DESIGN_LOAD
from design_load_by_year
group by YEAR_BUILT
having count(*) > 100
order by YEAR_BUILT );

create table temp as (
select * from design_load_by_year );

update temp
set YEAR_BUILT = floor(YEAR_BUILT / 10) * 10;

create table design_load_by_decade as (
select YEAR_BUILT DECADE_BUILT, METRIC_DESIGN_LOAD
from temp );

drop table if exists temp;

create table avg_design_load_by_decade as (
select DECADE_BUILT, count(*) BRIDGES_BUILT, avg(METRIC_DESIGN_LOAD) AVG_DESIGN_LOAD
from design_load_by_decade
group by DECADE_BUILT
having count(*) > 100
order by DECADE_BUILT );

select * from avg_design_load_by_decade;

select 
	(avg(YEAR_BUILT * AVG_DESIGN_LOAD) 
    - avg(YEAR_BUILT) * avg(AVG_DESIGN_LOAD)) 
    / (sqrt(avg(YEAR_BUILT * YEAR_BUILT) 
    - avg(YEAR_BUILT) * avg(YEAR_BUILT)) 
    * sqrt(avg(AVG_DESIGN_LOAD * AVG_DESIGN_LOAD) 
    - avg(AVG_DESIGN_LOAD) * avg(AVG_DESIGN_LOAD))) 
as pcc
from avg_design_load_by_year
where (YEAR_BUILT regexp '[^0-9.]') = 0 
and (AVG_DESIGN_LOAD regexp '[^0-9.]') = 0;


-- STRUCTURE KIND versus YEAR BUILT

create table bridges_built_by_year as (
select YEAR_BUILT, count(*) BRIDGES_BUILT
from structure_kind_by_year
group by YEAR_BUILT );

create index year_index on bridges_built_by_year (YEAR_BUILT);

create table temp as (
select * from bridges_built_by_year );

update temp
set YEAR_BUILT = floor(YEAR_BUILT / 10) * 10;

create table bridges_built_by_decade as (
select YEAR_BUILT DECADE_BUILT, sum(BRIDGES_BUILT) BRIDGES_BUILT from temp
group by DECADE_BUILT
order by DECADE_BUILT );

drop table if exists temp;

create index structure_kind_index on rawdata (STRUCTURE_KIND_043A);

create table structure_kind_by_year as (
select YEAR_BUILT_027 YEAR_BUILT, STRUCTURE_KIND_043A STRUCTURE_KIND
from rawdata );

create table structure_kind_count_by_year as (
select YEAR_BUILT, STRUCTURE_KIND, count(*) BRIDGES_BUILT
from structure_kind_by_year
group by YEAR_BUILT, STRUCTURE_KIND
having YEAR_BUILT >= 1900 and STRUCTURE_KIND != ''
order by YEAR_BUILT, STRUCTURE_KIND );

alter table structure_kind_count_by_year
add column RATIO FLOAT;

update structure_kind_count_by_year
set RATIO = BRIDGES_BUILT / 
(select BRIDGES_BUILT 
from bridges_built_by_year 
where bridges_built_by_year.YEAR_BUILT = structure_kind_count_by_year.YEAR_BUILT);

select * from structure_kind_count_by_year;

create table temp as (
select * from structure_kind_count_by_year );

update temp
set YEAR_BUILT = floor(YEAR_BUILT / 10) * 10;

create table structure_kind_count_by_decade as (
select YEAR_BUILT DECADE_BUILT, STRUCTURE_KIND, sum(BRIDGES_BUILT) BRIDGES_BUILT from temp
group by DECADE_BUILT, STRUCTURE_KIND
order by DECADE_BUILT, STRUCTURE_KIND );

drop table if exists temp;

alter table structure_kind_count_by_decade
add column RATIO FLOAT;

update structure_kind_count_by_decade
set RATIO = BRIDGES_BUILT / 
(select BRIDGES_BUILT 
from bridges_built_by_decade 
where bridges_built_by_decade.DECADE_BUILT = structure_kind_count_by_decade.DECADE_BUILT);

select * from structure_kind_count_by_decade;



-- STRUCTURE TYPE versus YEAR BUILT

create index structure_type_index on rawdata (STRUCTURE_TYPE_043B);

create table structure_type_by_year as (
select YEAR_BUILT_027 YEAR_BUILT, STRUCTURE_TYPE_043B STRUCTURE_TYPE
from rawdata );

create table structure_type_count_by_year as (
select YEAR_BUILT, STRUCTURE_TYPE, count(*) BRIDGES_BUILT
from structure_type_by_year
group by YEAR_BUILT, STRUCTURE_TYPE
having YEAR_BUILT >= 1900 and STRUCTURE_TYPE != ''
order by YEAR_BUILT, STRUCTURE_TYPE );

alter table structure_type_count_by_year
add column RATIO FLOAT;

update structure_type_count_by_year
set RATIO = BRIDGES_BUILT / 
(select BRIDGES_BUILT 
from bridges_built_by_year 
where bridges_built_by_year.YEAR_BUILT = structure_type_count_by_year.YEAR_BUILT);

select * from structure_type_count_by_year;

create table temp as (
select * from structure_type_count_by_year );

update temp
set YEAR_BUILT = floor(YEAR_BUILT / 10) * 10;

create table structure_type_count_by_decade as (
select YEAR_BUILT DECADE_BUILT, STRUCTURE_TYPE, sum(BRIDGES_BUILT) BRIDGES_BUILT from temp
group by DECADE_BUILT, STRUCTURE_TYPE
order by DECADE_BUILT, STRUCTURE_TYPE );

drop table if exists temp;

alter table structure_type_count_by_decade
add column RATIO FLOAT;

update structure_type_count_by_decade
set RATIO = BRIDGES_BUILT / 
(select BRIDGES_BUILT 
from bridges_built_by_decade 
where bridges_built_by_decade.DECADE_BUILT = structure_type_count_by_decade.DECADE_BUILT);

select * from structure_type_count_by_decade;