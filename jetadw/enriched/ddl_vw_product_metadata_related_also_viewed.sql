-- =======================================================================================
-- Name: ddl_vw_product_metadata_related_also_viewed.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product metadata - related - also viewed dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";

CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA_RELATED_ALSO_VIEWED"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product metadata - related - also viewed dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      asin
    , also_viewed.value::string  as also_viewed
    , meta_load_dts
    , meta_source
    , meta_event_type
    
FROM  "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
    ,lateral flatten(input => related:also_viewed) also_viewed
;