-- ================================================================================================
-- Name: ddl_report_product_rating_monthly.sql
-- Date: 26-Nov-2020
-- Purpose: 
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   26-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."REPORT"."REPORT_PRODUCT_RATING_MONTHLY"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
   
</PURPOSE>
<CHANGE LOG>
    26-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT fpr.product_id
    ,date_trunc(month,review_date)AS review_month
    ,dpr.product_category
    ,COUNT(1) AS number_of_reviews
    ,COUNT(DISTINCT reviewer_id) AS number_of_unique_reviewers
    ,SUM(overall_rating) AS sum_overall_rating
    ,SUM(CASE WHEN overall_rating = 5 THEN 1 ELSE 0 END) AS total_rating_5
    ,SUM(CASE WHEN overall_rating = 4 THEN 1 ELSE 0 END) AS total_rating_4
    ,SUM(CASE WHEN overall_rating = 3 THEN 1 ELSE 0 END) AS total_rating_3
    ,SUM(CASE WHEN overall_rating = 2 THEN 1 ELSE 0 END) AS total_rating_2
    ,SUM(CASE WHEN overall_rating = 1 THEN 1 ELSE 0 END) AS total_rating_1
    ,SUM(helpful_positive_feedback)AS total_positive_feedback
    ,SUM(helpful_total_feedback) AS total_feedback
    
FROM 
    "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."FACT_PRODUCT_RATING_MV" fpr
INNER JOIN 
    "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT_MV" dpr
        ON fpr.md5_hub_product = dpr.md5_hub_product
GROUP BY 1,2,3
;