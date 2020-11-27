-- ================================================================================================
-- Name: ddl_vw_dim_date.sql
-- Date: 22-Nov-2020
-- Purpose: To build a date dimension view
--
-- Change history
-- --------------
-- Author               Date          Description
-- -------------------------------------------------------------------------------------------------
-- Kristine Cristobal   22-Nov2020    Initial version created as a starting point
-- =================================================================================================

USE ROLE SYSADMIN;
USE SCHEMA "JETADW_PROD_LAKE_DB"."REFERENCE_DATA";

CREATE OR REPLACE VIEW "JETADW_PROD_LAKE_DB"."REFERENCE_DATA"."VW_DIM_DATE"
/*
<LAST AUTHOR> 
    Kristine Cristobal
</LAST AUTHOR>
<PURPOSE>
    To build date dimension
</PURPOSE>
<CHANGE LOG>
    22-11-2020: Initial Version, Kristine Cristobal
</CHANGE LOG>
*/
AS
SELECT
      date_id
    , date_key
    , date_value
    , year_number
    , year_day_number
    , first_of_year
    , quarter_number
    , quarter_name
    , quarter_name_short
    , month_number
    , month_name
    , month_name_short
    , first_of_month
    , year_week_number
    , year_week_name
    , year_week_name_short
    , week_day_number
    , first_of_week
    , day_name_short
    , month_day_number
FROM
(
SELECT 
         CAST(seq + 1 AS INTEGER)                    AS date_id
       , REPLACE(CAST(datum AS DATE), '-', '')::INT  AS date_key
-- DATE
       , datum                                       AS date_value

-- YEAR
       , CAST(EXTRACT(YEAR FROM datum) AS SMALLINT)  AS year_number
       , CAST(EXTRACT(DOY FROM datum) AS SMALLINT)   AS year_day_number
       , DATE_TRUNC('year', datum)::date             AS first_of_year

-- QUARTER
       , QUARTER(datum)                             AS quarter_number
       , CONCAT('Quarter',' ',quarter_number)       AS quarter_name
       , CONCAT('Q',quarter_number)                 AS quarter_name_short

-- MONTH
       , MONTH(datum)                               AS month_number
       , TO_CHAR(datum,'MMMM')                      AS month_name
       , TO_CHAR(datum, 'Mon')                      AS month_name_short
       , DATE_TRUNC(month, datum)::date             AS first_of_month

-- WEEK
       , WEEK(datum)                                AS year_week_number
       , CONCAT('Week',' ',year_week_number)        AS year_week_name
       , CONCAT('W',year_week_number)               AS year_week_name_short
       , DAYOFWEEK(datum)                           AS week_day_number
       , DATE_TRUNC(week, datum)::date              AS first_of_week

-- DAY
       , TO_CHAR(datum, 'Dy')                        AS day_name_short
       , CAST(EXTRACT(DAY FROM datum) AS SMALLINT)   AS month_day_number


FROM
    -- Generate days for the next ~10 years starting from 1996.
    (
        SELECT ('1996-01-01' :: DATE + SEQ4() )::DATE AS datum
               , SEQ4()                               AS seq
        FROM TABLE(GENERATOR(ROWCOUNT => 7000)) v 
    ) date_generator
  
UNION ALL
  
SELECT -1,19000101,'1900-01-01',1900,-1,'1900-01-01',-1,'Unknown','Unk',-1,'Unknown','Unk','1900-01-01','-1','Unknown','Unk',-1,'1900-01-01','Unk',-1
)
ORDER BY 1
;
