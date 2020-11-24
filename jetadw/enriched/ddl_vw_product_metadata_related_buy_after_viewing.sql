-- ================================================================================================
-- Name: ddl_vw_product_metadata_related_buy_after_viewing.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product metadata - related - buy after viewing dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";

CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA_RELATED_BUY_AFTER_VIEWING"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product metadata - related - buy after viewing dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      asin
    , buy_after_viewing.value::string as buy_after_viewing
    , meta_load_dts
    , meta_source
    , meta_event_type
    
FROM  "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
    ,lateral flatten(input => related:buy_after_viewing) buy_after_viewing
;
