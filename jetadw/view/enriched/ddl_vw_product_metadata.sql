-- =======================================================================================
-- Name: ddl_vw_product_metadata.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product metadata main dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point

-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";


CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product metadata main dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      json_src:asin::string AS asin
    , json_src:title::string AS title
    , json_src:description::string AS description
    , json_src:price::float AS price
    , salesRank.key::string AS salesrank_key
    , salesRank.value::string AS salesrank_value
    , json_src:brand::string AS brand
    , json_src:imUrl::string AS imurl
    , json_src:categories AS categories
    , json_src:related AS related
    , meta_load_dts
    , meta_source
    , meta_event_type


FROM "JETADW_PROD_LAKE_DB"."AMAZON"."PRODUCT_METADATA"
    ,lateral flatten(input => json_src:salesRank, OUTER => TRUE) salesRank
;
