-- ================================================================================================
-- Name: ddl_fact_product_rating.sql
-- Date: 22-Nov-2020
-- Purpose: 
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."FACT_PRODUCT_RATING"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
   
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT 
     review_date 
    ,reviewerid AS reviewer_id
    ,asin AS product_id
    ,overall AS overall_rating
    
FROM "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_REVIEW"
;