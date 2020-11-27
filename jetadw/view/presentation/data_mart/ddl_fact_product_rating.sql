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
-- Kristine Cristobal   26-Nov2020    Changed the source to integration - TLINK_PRODUCT_REVIEWER
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
SELECT *
FROM "JETADW_PROD_INTEGRATION_DB"."EDW"."TLINK_PRODUCT_REVIEWER"
;