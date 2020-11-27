-- =======================================================================================
-- Name: ddl_hub_reviewer.sql
-- Date: 25-Nov-2020
-- Purpose: Hub for Reviewer
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."HUB_REVIEWER"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Hub for Reviewer
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH REVIEWER AS
(
  SELECT 
        reviewerid AS reviewer_id
      , MIN(meta_load_dts) AS meta_load_dts
      , meta_source
  
  FROM 
    "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_REVIEW"
  GROUP BY 
       reviewerid,
       meta_source

)

SELECT
    MD5(reviewer_id) AS md5_hub_reviewer
  , reviewer_id
  , MIN(meta_load_dts) AS meta_load_dts
  , meta_source 

FROM
    REVIEWER
GROUP BY
   reviewer_id
  ,meta_source
;
