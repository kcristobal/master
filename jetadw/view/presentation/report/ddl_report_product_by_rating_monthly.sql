-- ================================================================================================
-- Name: ddl_report_product_by_rating_monthly.sql
-- Date: 26-Nov-2020
-- Purpose: 
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   26-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."REPORT"."REPORT_PRODUCT_BY_RATING_MONTHLY"
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
    ,fpr.overall_rating
    ,fpr.rating_class
    ,COUNT(1) AS number_of_reviews
    ,COUNT(DISTINCT reviewer_id) AS number_of_unique_reviewers
    ,SUM(overall_rating) AS sum_overall_rating
    ,SUM(helpful_positive_feedback)AS total_positive_feedback
    ,SUM(helpful_total_feedback) AS total_feedback
    
FROM 
    "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."FACT_PRODUCT_RATING_MV" fpr
INNER JOIN 
    "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT_MV" dpr
        ON fpr.md5_hub_product = dpr.md5_hub_product
GROUP BY 1,2,3,4,5
;