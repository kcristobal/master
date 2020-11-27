-- =======================================================================================
-- Name: ddl_hub_product.sql
-- Date: 25-Nov-2020
-- Purpose: Hub for Product
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."HUB_PRODUCT"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Hub for Product
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH PRODUCT AS
(
  SELECT 
        asin AS product_id
      , MIN(meta_load_dts) AS meta_load_dts
      , meta_source
  
  FROM 
    "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
  GROUP BY 
       asin,
       meta_source

)

SELECT
    MD5(product_id) AS md5_hub_product
  , product_id
  , MIN(meta_load_dts) AS meta_load_dts
  , meta_source 

FROM
    PRODUCT
GROUP BY
   product_id
  ,meta_source
;
