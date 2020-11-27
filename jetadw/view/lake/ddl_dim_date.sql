-- ================================================================================================
-- Name: ddl_dim_date.sql
-- Date: 22-Nov-2020
-- Purpose: Reference table for date dimension
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_LAKE_DB"."REFERENCE_DATA";

CREATE OR REPLACE TABLE  "JETADW_PROD_LAKE_DB"."REFERENCE_DATA"."DIM_DATE"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Reference table for date dimension
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT *
    , CURRENT_TIMESTAMP AS META_LOAD_DTS
    ,'JETADW_PROD_LAKE_DB.REFERENCE_DATA.DIM_DATE_V' AS META_SOURCE
    
FROM "JETADW_PROD_LAKE_DB"."REFERENCE_DATA"."VW_DIM_DATE"
;
