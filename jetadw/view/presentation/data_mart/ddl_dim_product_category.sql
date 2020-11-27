-- ================================================================================================
-- Name: ddl_dim_product_category.sql
-- Date: 22-Nov-2020
-- Purpose: Product category dimension for information mart
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT_CATEGORY"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Product category dimension for information mart
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT sub_category_value AS product_category
FROM JETADW_PROD_ENRICHED_DB.AMAZON.VW_PRODUCT_METADATA_CATEGORY 
WHERE categories_index = 0
    AND sub_category_index = 0
GROUP BY 1
ORDER BY 1
;