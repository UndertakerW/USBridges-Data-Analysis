-- Is the physical condition rating and the customer appraisal rating corelated?

drop table if exists further_question_1;

create table further_question_1 as
select 
	STATE_CODE_001,
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
add primary key (STATE_CODE_001, STRUCTURE_NUMBER_008, RECORD_TYPE_005A);