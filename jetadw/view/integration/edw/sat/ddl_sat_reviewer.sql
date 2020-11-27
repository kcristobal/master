-- =======================================================================================
-- Name: ddl_sat_reviewer.sql
-- Date: 25-Nov-2020
-- Purpose: Sattelite for Reviewer
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   25-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_INTEGRATION_DB"."EDW";


CREATE OR REPLACE VIEW "JETADW_PROD_INTEGRATION_DB"."EDW"."SAT_REVIEWER"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    Sattelite for Reviewer
</PURPOSE>
<CHANGE LOG>
    25-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
WITH REVIEWER
AS
(
      SELECT DISTINCT 
          meta_load_dts
        , meta_source
        , reviewerid AS reviewer_id
        , reviewername AS reviewer_name
  
      FROM 
        "JETADW_PROD_ENRICHED_DB"."AMAZON"."VW_PRODUCT_REVIEW"
)
SELECT 
     MD5(reviewer_id) AS md5_hub_reviewer
   , meta_load_dts AS meta_valid_from_dts
   , COALESCE 
        ( LEAD (meta_load_dts) OVER
   		        (PARTITION BY reviewer_id
   		         ORDER BY meta_load_dts, reviewer_name NULLS FIRST),
   		  CAST('9999-12-31' AS DATETIME)
        ) AS meta_valid_to_dts
   , CASE
        WHEN (RANK() OVER 
                (PARTITION BY reviewer_id
                 ORDER BY meta_load_dts DESC, reviewer_name NULLS LAST)
             ) = 1
        THEN 'Y'
        ELSE 'N'
      END AS meta_valid_current_flag
   , reviewer_id
   , reviewer_name
   , MD5(IFNULL(reviewer_name,'')) AS hash_diff
   , meta_source
FROM 
    REVIEWER
; 
