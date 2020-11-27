-- ================================================================================================
-- Name: ddl_dim_product.sql
-- Date: 22-Nov-2020
-- Purpose: Product dimension for information mart
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- Kristine Cristobal   26-Nov2020    Changed the source to integration - sat_product
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_PRODUCT"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Product dimension for information mart
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT *
FROM "JETADW_PROD_INTEGRATION_DB"."EDW"."SAT_PRODUCT"
;
