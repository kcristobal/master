-- ================================================================================================
-- Name: ddl_dim_product_price_bucket.sql
-- Date: 22-Nov-2020
-- Purpose: Product dimension for information mart
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT_PRICE_BUCKET"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Product price bucket dimension for information mart
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH price AS
(
SELECT price
FROM JETADW_PROD_ENRICHED_DB.AMAZON.VW_PRODUCT_METADATA
GROUP BY 1
)
SELECT 
     CASE
        WHEN price = 0  then 5
        WHEN price > 0 and  price <= 8 then  1
        WHEN price > 8 and  price <= 15 then  2
        WHEN price > 15 and price <= 30 then 3
        WHEN price > 30  then 4
        ELSE -1
     END AS price_bucket_id
     ,CASE
        WHEN price = 0  then 'Free product'
        WHEN price > 0 and  price <= 8 then  'Less than $8.00'
        WHEN price > 8 and  price <= 15 then  '$8.00 - $15.00'
        WHEN price > 15 and price <= 30 then '$15.00 - $30.00'
        WHEN price > 30  then 'Above $30.00'
        ELSE 'Unknown'
     END AS price_bucket
FROM PRICE
GROUP BY 1,2
ORDER BY 1
;
