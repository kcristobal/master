-- ================================================================================================
-- Name: ddl_dim_date.sql
-- Date: 22-Nov-2020
-- Purpose: Date dimension for information mart
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

CREATE OR REPLACE VIEW "JETADW_PROD_PRESENTATION_DB"."DATA_MART"."DIM_DATE"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Date dimension for information mart
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT *
FROM "JETADW_PROD_LAKE_DB"."REFERENCE_DATA"."DIM_DATE"
;
