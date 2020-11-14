-- set primary keys
alter table bridge_structure add primary key(STATE_CODE_001, STRUCTURE_NUMBER_008, RECORD_TYPE_005A, MAX_SPAN_LEN_MT_048, STRUCTURE_LEN_MT_049, BRIDGE_IMP_COST_094);
alter table structure_kind add primary key(STRUCTURE_KIND);
alter table structure_type add primary key(STRUCTURE_TYPE);
alter table record_type add primary key(RECORD_TYPE);
alter table condition_rating add primary key(RATING_CODE);
alter table bridge_condtion add primary key(STATE_CODE_001, STRUCTURE_NUMBER_008, RECORD_TYPE_005A, BRIDGE_IMP_COST_094);
alter table deck_protection add primary key(DECK_PROTECTION);
alter table membrane_type add primary key(MEMBRANE_TYPE);
alter table structure_flared add primary key(STRUCTURE_FLARED);
alter table deck_structure_type add primary key(DECK_STRUCTURE_TYPE);
alter table surface_type add primary key(SURFACE_TYPE);
alter table bridge_median add primary key(MEDIAN_CODE);
alter table culvert_rating add primary key(RATING_CODE);
alter table channel_rating add primary key(RATING_CODE);

-- set foreign keys
-- 1. modify the formats of some values
-- 1.1 convert '' to null
SET SQL_SAFE_UPDATES = 0;
UPDATE bridge_structure SET MEDIAN_CODE_033 = null WHERE MEDIAN_CODE_033 = '';
UPDATE bridge_structure SET STRUCTURE_FLARED_035 = null WHERE STRUCTURE_FLARED_035 = '';
UPDATE bridge_structure SET STRUCTURE_KIND_043A = null WHERE STRUCTURE_KIND_043A = '';
UPDATE bridge_structure SET STRUCTURE_TYPE_043B = null WHERE STRUCTURE_TYPE_043B = '';
UPDATE bridge_structure SET DECK_STRUCTURE_TYPE_107 = null WHERE DECK_STRUCTURE_TYPE_107 = '';
UPDATE bridge_structure SET SURFACE_TYPE_108A = null WHERE SURFACE_TYPE_108A = '';
UPDATE bridge_structure SET MEMBRANE_TYPE_108B = null WHERE MEMBRANE_TYPE_108B = '';
UPDATE bridge_structure SET DECK_PROTECTION_108C = null WHERE DECK_PROTECTION_108C = '';
UPDATE bridge_condtion SET RECORD_TYPE_005A = null WHERE RECORD_TYPE_005A = '';
UPDATE bridge_condtion SET DECK_COND_058 = null WHERE DECK_COND_058 = '';
UPDATE bridge_condtion SET SUPERSTRUCTURE_COND_059 = null WHERE SUPERSTRUCTURE_COND_059 = '';
UPDATE bridge_condtion SET SUBSTRUCTURE_COND_060 = null WHERE SUBSTRUCTURE_COND_060 = '';
UPDATE bridge_condtion SET CHANNEL_COND_061 = null WHERE CHANNEL_COND_061 = '';
UPDATE bridge_condtion SET CULVERT_COND_062 = null WHERE CULVERT_COND_062 = '';
-- 1.2 remove the zeros before the numbers ( '0001' -> '1')
UPDATE bridge_structure SET STRUCTURE_TYPE_043B = convert(STRUCTURE_TYPE_043B, UNSIGNED);

-- 2.2 	set foreign keys
alter table bridge_structure add constraint FK_ID_RECORD_TYPE foreign key(RECORD_TYPE_005A) REFERENCES record_type(RECORD_TYPE);
alter table bridge_structure add constraint FK_ID_MEDIAN_CODE foreign key(MEDIAN_CODE_033) REFERENCES bridge_median(MEDIAN_CODE);
alter table bridge_structure add constraint FK_ID_STRUCT_FLARED foreign key(STRUCTURE_FLARED_035) REFERENCES structure_flared(STRUCTURE_FLARED);
alter table bridge_structure add constraint FK_ID_STRUCT_KIND foreign key(STRUCTURE_KIND_043A) REFERENCES structure_kind(STRUCTURE_KIND);
alter table bridge_structure add constraint FK_ID_STRUCT_TYPE foreign key(STRUCTURE_TYPE_043B) REFERENCES structure_type(STRUCTURE_TYPE);
alter table bridge_structure add constraint FK_ID_DECK_STRUCT_TYPE foreign key(DECK_STRUCTURE_TYPE_107) REFERENCES deck_structure_type(DECK_STRUCTURE_TYPE);
alter table bridge_structure add constraint FK_ID_SURFACE_TYPE foreign key(SURFACE_TYPE_108A) REFERENCES surface_type(SURFACE_TYPE);
alter table bridge_structure add constraint FK_ID_MEMBRANE_TYPE foreign key(MEMBRANE_TYPE_108B) REFERENCES membrane_type(MEMBRANE_TYPE);
alter table bridge_structure add constraint FK_ID_DECK_PROTECTION foreign key(DECK_PROTECTION_108C) REFERENCES deck_protection(DECK_PROTECTION);
alter table bridge_condtion add constraint FK_ID_RECORD_TYPE_CONDITION foreign key(RECORD_TYPE_005A) REFERENCES record_type(RECORD_TYPE);
alter table bridge_condtion add constraint FK_ID_DECK_CONDITION foreign key(DECK_COND_058) REFERENCES condition_rating(RATING_CODE);
alter table bridge_condtion add constraint FK_ID_SUPERSTRUCT_CONDITION foreign key(SUPERSTRUCTURE_COND_059) REFERENCES condition_rating(RATING_CODE);
alter table bridge_condtion add constraint FK_ID_SUBSTRUCT_CONDITION foreign key(SUBSTRUCTURE_COND_060) REFERENCES condition_rating(RATING_CODE);
alter table bridge_condtion add constraint FK_ID_CHANNEL_CONDITION foreign key(CHANNEL_COND_061) REFERENCES channel_rating(RATING_CODE);
alter table bridge_condtion add constraint FK_ID_CULVERT_CONDITION foreign key(CULVERT_COND_062) REFERENCES culvert_rating(RATING_CODE);
