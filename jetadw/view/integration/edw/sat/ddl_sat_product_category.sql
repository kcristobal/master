-- =======================================================================================
-- Name: ddl_sat_product_category.sql
-- Date: 25-Nov-2020
-- Purpose: Sattelite for Product Category
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."SAT_PRODUCT_CATEGORY"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Sattelite for Product Category
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH PRODUCT_CATEGORY
AS
(
      SELECT DISTINCT 
          meta_load_dts
        , meta_source
        , asin AS product_id
        , categories AS product_categories
  
      FROM 
        "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
      UNION
      SELECT -- The zero records!
        '1900-01-01' AS meta_load_dts
        ,'Data Warehouse' AS meta_source
        , CAST(-1 AS string) AS product_id 
        , NULL AS product_categories 

)
SELECT 
     MD5(product_id) AS md5_hub_product
   , meta_load_dts AS meta_valid_from_dts
   , COALESCE 
        ( LEAD (meta_load_dts) OVER
   		        (PARTITION BY product_id,product_categories
   		         ORDER BY meta_load_dts),
   		  CAST('9999-12-31' AS DATETIME)
        ) AS meta_valid_to_dts
   , CASE
        WHEN (RANK() OVER 
                (PARTITION BY product_id 
                 ORDER BY meta_load_dts DESC)
             ) = 1
        THEN 'Y'
        ELSE 'N'
      END AS meta_valid_current_flag
   , product_id
   , product_categories
   , MD5(IFNULL(product_categories,'')) AS hash_diff
   , meta_source
FROM 
    PRODUCT_CATEGORY
;  