-- =======================================================================================
-- Name: ddl_tlink_product_reviewer.sql
-- Date: 25-Nov-2020
-- Purpose: This is the Link between HUB_PRODUCT and HUB_REVIEWER
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."TLINK_PRODUCT_REVIEWER"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
   Transaction Link for product_review
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH PRODUCT_REVIEW
AS
(
   SELECT
        meta_load_dts
      , meta_source
      , asin as product_id
      , reviewerid AS reviewer_id
      , review_date
      , overall AS overall_rating
      , CASE
            WHEN overall >= 3 THEN 'Good'
            WHEN overall <  3 THEN 'Bad'
            ELSE 'Unknown'
        END AS rating_class
      , helpful_positive_feedback
      , helpful_total_feedback
      , summary AS review_summary
      , reviewtext AS review_text
   FROM "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_REVIEW"

)
SELECT
     MD5(CONCAT(product_id,reviewer_id,IFNULL(review_date,'1900-01-01'))) AS md5_lnk_product_reviewer
   , MD5(product_id) AS md5_hub_product
   , MD5(reviewer_id) AS md5_hub_reviewer
   , product_id
   , reviewer_id
   , IFNULL(review_date,'1900-01-01') AS review_date
   , overall_rating
   , rating_class
   , helpful_positive_feedback
   , helpful_total_feedback
   , review_summary
   , review_text
   , meta_load_dts
   , meta_source
FROM
    PRODUCT_REVIEW
;