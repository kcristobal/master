-- ================================================================================================
-- Name: ddl_vw_product_review.sql
-- Date: 22-Nov-2020
-- Purpose: Schema on read for Amazon - Product review dataset
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- Kristine Cristobal   27-Nov2020    Exclude invalid product_id
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_ENRICHED_DB"."AMAZON";

CREATE OR REPLACE VIEW "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_REVIEW"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Schema on read for Amazon - Product review dataset
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
      TO_TIMESTAMP(json_src:unixReviewTime)::date AS review_date
    , json_src:unixReviewTime::int AS unixReviewTime
    , json_src:asin::string AS asin
    , json_src:reviewerID::string AS reviewerID
    , json_src:reviewerName::string AS reviewerName
    , json_src:overall::int AS overall
    , json_src:helpful::string AS helpful
    , CAST(REPLACE(REPLACE(SPLIT_PART(helpful, ',', 1), '[', ''), ']', '')AS INT) AS helpful_positive_feedback
    , CAST(REPLACE(REPLACE(SPLIT_PART(helpful, ',', 2), '[', ''), ']', '')AS INT) AS helpful_total_feedback
    , json_src:reviewTime::string AS reviewTime
    , json_src:summary::string AS summary
    , json_src:reviewText::string AS reviewText
    , meta_load_dts
    , meta_source
    
FROM "JETADW_PROD_LAKE_DB"."AMAZON"."PRODUCT_REVIEW"
WHERE TRIM(asin) NOT IN ('\n    \n')
;
