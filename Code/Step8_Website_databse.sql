drop table if exists temp_table;
create table temp_table(
	STATE_CODE_001 varchar(50),
	STRUCTURE_NUMBER_008 varchar(50),
	HIGHWAY_DISTRICT_002 varchar(50),
	COUNTY_CODE_003 varchar(50),
	YEAR_BUILT_027 varchar(50),
    STRUCTURE_KIND_043A varchar(50),
	STRUCTURE_TYPE_043B varchar(50)
)
select
    STATE_CODE_001,
    STRUCTURE_NUMBER_008,
    HIGHWAY_DISTRICT_002,
    COUNTY_CODE_003,
    YEAR_BUILT_027,
    STRUCTURE_KIND_043A,
	STRUCTURE_TYPE_043B
from rawdata limit 9999999;

drop table if exists temp_table_2;
create table temp_table_2(
	STATE_CODE_001 varchar(50),
	STRUCTURE_NUMBER_008 varchar(50),
	HIGHWAY_DISTRICT_002 varchar(50),
	COUNTY_CODE_003 varchar(50),
	YEAR_BUILT_027 varchar(50),
    STRUCTURE_KIND_043A varchar(50),
	STRUCTURE_TYPE_043B varchar(50),
    STRUCTURE_KIND_DESCRIPTION VARCHAR(50)
)
SELECT STATE_CODE_001, STRUCTURE_NUMBER_008, HIGHWAY_DISTRICT_002, COUNTY_CODE_003, YEAR_BUILT_027, STRUCTURE_KIND_043A, 
STRUCTURE_TYPE_043B, STRUCTURE_KIND_DESCRIPTION FROM temp_table 
INNER JOIN structure_kind 
ON STRUCTURE_KIND_043A = STRUCTURE_KIND limit 9999999;

UPDATE temp_table_2 SET STRUCTURE_TYPE_043B = null WHERE STRUCTURE_TYPE_043B = '';
UPDATE temp_table_2 SET STRUCTURE_TYPE_043B = convert(STRUCTURE_TYPE_043B, UNSIGNED);

drop table if exists website_database;
create table website_database(
	STATE_CODE_001 varchar(50),
	STRUCTURE_NUMBER_008 varchar(50),
	HIGHWAY_DISTRICT_002 varchar(50),
	COUNTY_CODE_003 varchar(50),
	YEAR_BUILT_027 varchar(50),
    STRUCTURE_KIND_043A varchar(50),
	STRUCTURE_TYPE_043B varchar(50),
    STRUCTURE_KIND_DESCRIPTION VARCHAR(50),
    STRUCTURE_TYPE_DESCRIPTION VARCHAR(50)
)
SELECT STATE_CODE_001, STRUCTURE_NUMBER_008, HIGHWAY_DISTRICT_002, COUNTY_CODE_003, YEAR_BUILT_027, STRUCTURE_KIND_043A, 
STRUCTURE_TYPE_043B, STRUCTURE_KIND_DESCRIPTION, STRUCTURE_TYPE_DESCRIPTION FROM temp_table_2 
INNER JOIN structure_type 
ON STRUCTURE_TYPE_043B = STRUCTURE_TYPE limit 9999999;

drop table if exists temp_table;
drop table if exists temp_table_2;

-- set up indexes
create index website_state_code_index on website_database(STATE_CODE_001);
create index website_highway_district_index on website_database(HIGHWAY_DISTRICT_002);
create index website_county_code_index on website_database(COUNTY_CODE_003);
create index website_structure_number_index on website_database(STRUCTURE_NUMBER_008);
create index website_year_build_index on website_database(YEAR_BUILT_027);