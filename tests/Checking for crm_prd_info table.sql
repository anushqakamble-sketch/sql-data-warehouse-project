/* This query checks the data quality issues, in the crm_prd_info table such as spaces, 
nulls,and duplicates. This is not an official query to run but its only used to 
analyzed data before and after transformations are applied.

-------------------------------------------------------------------------------------------
-------------------------------------------------------------------------------------------
Bronze layer checks */
-- Check for Nulls or Duplicates in Primary key 
-- Expectation: No result
SELECT 
prd_id,
COUNT(*)
FROM bronze.crm_prd_info
GROUP BY prd_id
HAVING COUNT(*) > 1 OR prd_id IS NULL

-- Checking to see the cateogry id's existence in both tables. 
-- There is one category shown in the cust table which is not present in erp
FROM bronze.crm_prd_info
WHERE REPLACE(SUBSTRING(prd_key, 1, 5), '-', '_') NOT IN 
(SELECT distinct id from bronze.erp_px_cat_g1v2)

-- CHECK FOR UNWANTED SPACES
-- EXPECTATION: NO RESULTS
SELECT prd_nm
FROM bronze.crm_prd_info
WHERE prd_nm != TRIM(prd_nm)

-- Check for NULLS or Negative Numbers in cost
-- Expectation: No Results
SELECT prd_cost
FROM bronze.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data standardization & Consistency 
SELECT DISTINCT prd_line
FROM bronze.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM bronze.crm_prd_info
WHERE prd_end_dt < prd_start_dt

--------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------
--Checking the silver layer

-- Check for NULLS or Negative Numbers in cost
-- Expectation: No Results
SELECT prd_cost
FROM silver.crm_prd_info
WHERE prd_cost < 0 OR prd_cost IS NULL

-- Data standardization & Consistency 
SELECT DISTINCT prd_line
FROM silver.crm_prd_info

-- Check for Invalid Date Orders
SELECT *
FROM silver.crm_prd_info
WHERE prd_end_dt < prd_start_dt

SELECT * FROM silver.crm_prd_info