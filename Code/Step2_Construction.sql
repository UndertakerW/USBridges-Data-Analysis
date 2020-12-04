drop table if exists bridge_condtion;
create table bridge_condtion
(
    STATE_CODE_001 VARCHAR(50),
    STRUCTURE_NUMBER_008 VARCHAR(50),
    YEAR_BUILT_027 VARCHAR(50),
    RECORD_TYPE_005A VARCHAR(50),
    DECK_COND_058 VARCHAR(50),
    SUPERSTRUCTURE_COND_059 VARCHAR(50),
    SUBSTRUCTURE_COND_060 VARCHAR(50),
    CHANNEL_COND_061 VARCHAR(50),
    CULVERT_COND_062 VARCHAR(50),
    BRIDGE_IMP_COST_094 VARCHAR(50),
    FED_AGENCY VARCHAR(50)
);

insert into bridge_condtion
	(
    STATE_CODE_001,
    STRUCTURE_NUMBER_008,
    YEAR_BUILT_027,
    RECORD_TYPE_005A,
    DECK_COND_058,
    SUPERSTRUCTURE_COND_059,
    SUBSTRUCTURE_COND_060,
    CHANNEL_COND_061,
    CULVERT_COND_062,
    BRIDGE_IMP_COST_094,
    FED_AGENCY
    )
select
    STATE_CODE_001,
    STRUCTURE_NUMBER_008,
    YEAR_BUILT_027,
    RECORD_TYPE_005A,
    DECK_COND_058,
    SUPERSTRUCTURE_COND_059,
    SUBSTRUCTURE_COND_060,
    CHANNEL_COND_061,
    CULVERT_COND_062,
    BRIDGE_IMP_COST_094,
    FED_AGENCY
from rawdata;

drop table if exists condition_rating;
create table condition_rating
(
    RATING_CODE VARCHAR(2),
    RATING_DESCRIPTION VARCHAR(400)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/ConditionRating.csv'   
into table condition_rating
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n';  

drop table if exists record_type;
create table record_type
(
	RECORD_TYPE VARCHAR(2),
    RECORD_TYPE_DESCRIPTION VARCHAR(50)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/RecordType.csv'   
into table record_type
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists channel_rating;
create table channel_rating
(
	RATING_CODE VARCHAR(2),
    RATING_DESCRIPTION VARCHAR(400)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/ChannelRating.csv'   
into table channel_rating
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists culvert_rating;
create table culvert_rating
(
	RATING_CODE VARCHAR(2),
    RATING_DESCRIPTION VARCHAR(500)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/CulvertRating.csv'   
into table culvert_rating
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists bridge_structure;
create table bridge_structure
(
	STATE_CODE_001 VARCHAR(50),
    STRUCTURE_NUMBER_008 VARCHAR(50),
    RECORD_TYPE_005A VARCHAR(50),
    MEDIAN_CODE_033 VARCHAR(50),
    STRUCTURE_FLARED_035 VARCHAR(50),
    STRUCTURE_KIND_043A VARCHAR(50),
    STRUCTURE_TYPE_043B VARCHAR(50),
    APPR_KIND_044A VARCHAR(50),
    APPR_TYPE_044B VARCHAR(50),
    MAIN_UNIT_SPANS_045 VARCHAR(50),
    APPR_SPANS_046 VARCHAR(50),
    MAX_SPAN_LEN_MT_048 VARCHAR(50),
    STRUCTURE_LEN_MT_049 VARCHAR(50),
    DECK_WIDTH_MT_052 VARCHAR(50),
    BRIDGE_IMP_COST_094 VARCHAR(50),
    DECK_STRUCTURE_TYPE_107 VARCHAR(50),
    SURFACE_TYPE_108A VARCHAR(50),
    MEMBRANE_TYPE_108B VARCHAR(50),
    DECK_PROTECTION_108C VARCHAR(50),
    FED_AGENCY VARCHAR(50)
);

insert into bridge_structure
	(
	STATE_CODE_001,
    STRUCTURE_NUMBER_008,
    RECORD_TYPE_005A,
    MEDIAN_CODE_033,
    STRUCTURE_FLARED_035,
    STRUCTURE_KIND_043A,
    STRUCTURE_TYPE_043B,
    APPR_KIND_044A,
    APPR_TYPE_044B,
    MAIN_UNIT_SPANS_045,
    APPR_SPANS_046,
    MAX_SPAN_LEN_MT_048,
    STRUCTURE_LEN_MT_049,
    DECK_WIDTH_MT_052,
    BRIDGE_IMP_COST_094,
    DECK_STRUCTURE_TYPE_107,
    SURFACE_TYPE_108A,
    MEMBRANE_TYPE_108B,
    DECK_PROTECTION_108C,
    FED_AGENCY
    )
select
	STATE_CODE_001,
    STRUCTURE_NUMBER_008,
    RECORD_TYPE_005A,
    MEDIAN_CODE_033,
    STRUCTURE_FLARED_035,
    STRUCTURE_KIND_043A,
    STRUCTURE_TYPE_043B,
    APPR_KIND_044A,
    APPR_TYPE_044B,
    MAIN_UNIT_SPANS_045,
    APPR_SPANS_046,
    MAX_SPAN_LEN_MT_048,
    STRUCTURE_LEN_MT_049,
    DECK_WIDTH_MT_052,
    BRIDGE_IMP_COST_094,
    DECK_STRUCTURE_TYPE_107,
    SURFACE_TYPE_108A,
    MEMBRANE_TYPE_108B,
    DECK_PROTECTION_108C,
    FED_AGENCY
from rawdata;

drop table if exists structure_kind;
create table structure_kind
(
	STRUCTURE_KIND VARCHAR(2),
    STRUCTURE_KIND_DESCRIPTION VARCHAR(50)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/StructureKind.csv'   
into table structure_kind
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists bridge_median;
create table bridge_median
(
	MEDIAN_CODE VARCHAR(2),
    MEDIAN_DESCRIPTION VARCHAR(100)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/BridgeMedian.csv'   
into table bridge_median
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists structure_flared;
create table structure_flared
(
	STRUCTURE_FLARED VARCHAR(2),
    STRUCTURE_FLARED_DESCRIPTION VARCHAR(100)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/StructureFlared.csv'   
into table structure_flared
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists structure_type;
create table structure_type
(
	STRUCTURE_TYPE VARCHAR(2),
    STRUCTURE_TYPE_DESCRIPTION VARCHAR(50)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/StructureType.csv'   
into table structure_type
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists deck_structure_type;
create table deck_structure_type
(
	DECK_STRUCTURE_TYPE VARCHAR(2),
    DECK_STRUCTURE_TYPE_DESCRIPTION VARCHAR(50)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/DeckStructureType.csv'   
into table deck_structure_type
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists surface_type;
create table surface_type
(
	SURFACE_TYPE VARCHAR(2),
    SURFACE_TYPE_DESCRIPTION VARCHAR(200)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/SurfaceType.csv'   
into table surface_type
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists membrane_type;
create table membrane_type
(
	MEMBRANE_TYPE VARCHAR(2),
    MEMBRANE_DESCRIPTION VARCHAR(100)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/MembraneType.csv'   
into table membrane_type
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists deck_protection;
create table deck_protection
(
	DECK_PROTECTION VARCHAR(2),
    DECK_PROTECTION_DESCRIPTION VARCHAR(100)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/DeckProtection.csv'   
into table deck_protection
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

drop table if exists state_code;
create table state_code
(
	STATE_CODE VARCHAR(5),
    STATE_NAME VARCHAR(50)
);

load data infile 'D:/CUHK/Y3T1/ERG3010/ERG3010-Project/Data/StateCode.csv'   
into table state_code
fields terminated by ','  optionally enclosed by '"' escaped by '"'   
lines terminated by '\r\n'; 

-- set up indexes
create index rawdata_state_code_index on rawdata(STATE_CODE_001);
create index rawdata_highway_district_index on rawdata(HIGHWAY_DISTRICT_002);
create index rawdata_county_code_index on rawdata(COUNTY_CODE_003);
create index rawdata_structure_number_index on rawdata(STRUCTURE_NUMBER_008);
create index rawdata_year_build_index on rawdata(YEAR_BUILT_027);