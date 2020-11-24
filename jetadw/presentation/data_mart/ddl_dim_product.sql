-- ================================================================================================
-- Name: ddl_dim_product.sql
-- Date: 22-Nov-2020
-- Purpose: Product dimension for information mart
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Product dimension for information mart
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      asin as product_id
    , title as product_title
    , price as product_price
    , brand as product_brand
    , salesrank_key as product_rank_category
    , salesrank_value as product_rank
    , meta_source
    , meta_load_dts
    
FROM "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
;
