-- =======================================================================================
-- Name: ddl_vw_product_metadata_category.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product metadata - category dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";


CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA_CATEGORY"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product metadata - category dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      asin
    , categories.index::int AS categories_index
    , categories.value::string AS categories_value
    , sub_category.index::int AS sub_category_index
    , sub_category.value::string AS sub_category_value
    , categories
    , meta_load_dts
    , meta_source
    , meta_event_type
    
FROM "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
    ,lateral flatten(input => categories) categories
    ,lateral flatten(input => categories.value) sub_category
;