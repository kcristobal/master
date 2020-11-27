-- =======================================================================================
-- Name: ddl_sat_product.sql
-- Date: 25-Nov-2020
-- Purpose: Sattelite for Product Main
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."SAT_PRODUCT"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Sattelite for Product
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH PRODUCT
AS
(
      SELECT DISTINCT 
          meta_load_dts
        , meta_source
        , asin AS product_id
        , title AS product_title
        , description AS product_description
        , brand AS product_brand
        , price AS product_price
        , CASE
            WHEN product_price < 1 THEN 'Free Product'
            WHEN product_price >= 1 AND product_price < 8 THEN 'Less than $8.00'
            WHEN product_price > 8 AND product_price <= 15 THEN '$8.00 - $15.00'
            WHEN product_price > 15 AND product_price <= 30 THEN  '$15.00 - $30.00'
            WHEN product_price > 30 THEN 'Above $30.00'
            ELSE 'Unknown'
          END AS price_bucket
        , salesrank_key AS product_rank_category
        , salesrank_value AS product_rank
        , categories AS product_categories
  
      FROM 
        "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
      UNION
      SELECT -- The zero records!
         '1900-01-01' AS meta_load_dts
        ,'Data Warehouse' AS meta_source
        , CAST(-1 AS string) AS product_id 
        , NULL AS product_title 
        , NULL AS product_description 
        , NULL AS product_brand 
        , NULL AS price 
        , 'Unknown' AS price_bucket
        , NULL AS product_rank_category 
        , CAST(-1 AS string) AS product_rank 
        , NULL AS product_categories 

)
,PRODUCT_CATEGORY AS
(
SELECT 
      asin AS product_id
    , categories.index::int AS categories_index
    , categories.value::string AS categories_value
    , sub_category.index::int AS sub_category_index
    , sub_category.value::string AS sub_category_value
    , categories
    , meta_load_dts
    , meta_source
    , meta_event_type
    
FROM 
    "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_METADATA"
        ,lateral flatten(input => categories) categories
        ,lateral flatten(input => categories.value) sub_category
WHERE 
    categories.index::int = 0 AND sub_category.index::int = 0

)
SELECT 
     MD5(p.product_id) AS md5_hub_product
   , p.meta_load_dts AS meta_valid_from_dts
   , COALESCE 
        ( LEAD (p.meta_load_dts) OVER
   		        (PARTITION BY p.product_id
   		         ORDER BY p.meta_load_dts),
   		  CAST('9999-12-31' AS DATETIME)
        ) AS meta_valid_to_dts
   , CASE
        WHEN (RANK() OVER 
                (PARTITION BY p.product_id 
                 ORDER BY p.meta_load_dts DESC)
             ) = 1
        THEN 'Y'
        ELSE 'N'
      END AS meta_valid_current_flag
   , p.product_id
   , p.product_title 
   , p.product_description 
   , p.product_brand 
   , p.product_price
   , p.price_bucket
   , p.product_rank_category
   , p.product_rank
   , p.product_categories
   , CASE
        WHEN c.sub_category_value IS NULL
            OR TRIM(c.sub_category_value) IN ('','#508510')
        THEN 'UNKNOWN'
        ELSE c.sub_category_value
     END AS product_category
   , MD5(CONCAT(IFNULL(p.product_title,'')
                ,IFNULL(p.product_description,'')
                ,IFNULL(p.product_brand,'')
                ,IFNULL(p.product_price,'')
                ,IFNULL(p.product_rank_category,'')
                ,IFNULL(p.product_rank,'')
                ,IFNULL(p.product_categories,'')
               )
        ) AS hash_diff
   , ROW_NUMBER() OVER (PARTITION  BY 
         p.product_id 
      ORDER BY 
         p.product_id
         ,p.meta_load_dts ) 
     AS meta_row_num -- Not necessarily required. useful to instantly see the number of changes per business key in time
   , p.meta_source
FROM PRODUCT p
    LEFT JOIN PRODUCT_CATEGORY c
        ON p.product_id = c.product_id
;   
