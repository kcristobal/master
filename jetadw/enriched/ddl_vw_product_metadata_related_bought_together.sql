-- =======================================================================================
-- Name: ddl_vw_product_metadata_related_bought_together.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product metadata - related - bought together dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";

CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA_RELATED_BOUGHT_TOGETHER"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product metadata - related - bought together dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      asin
    , bought_together.value::string as bought_together
    , meta_load_dts
    , meta_source
    , meta_event_type
    
FROM  "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
    ,lateral flatten(input => related:bought_together) bought_together
;
