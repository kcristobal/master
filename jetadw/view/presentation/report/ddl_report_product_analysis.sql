-- ================================================================================================
-- Name: ddl_report_product_analysis.sql
-- Date: 26-Nov-2020
-- Purpose: 
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   26-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."REPORT"."REPORT_PRODUCT_ANALYSIS"
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
SELECT 
     dpr.product_id
    ,dpr.product_category
    ,dpr.price_bucket
    ,COUNT(1) AS number_of_products
    
FROM 
    "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT_MV" dpr
WHERE META_VALID_CURRENT_FLAG = 'Y'
GROUP BY 1,2,3
;