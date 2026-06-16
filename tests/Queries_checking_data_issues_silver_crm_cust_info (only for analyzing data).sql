/* Detecting Quality issues in the Bronze layer to 
then clean it in the silver layer */

-- Check for Nulls or Duplicates in Primary key
--Expectation: No Result
-- Before cleaning: showed some data. After cleaning: no result shown
SELECT 
cst_id,
COUNT(*)
from bronze.crm_cust_info
GROUP BY cst_id
HAVING COUNT(*) > 1 OR cst_id IS NULL 

-- Checking for unwanted Space in data
-- Expectation: No results
-- Before cleaning: showed some data. After cleaning: no result shown
SELECT cst_firstname
FROM bronze.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

/* Checking for unwanted Space in gender column. 
(using the same query. You can do this with multiple data) */
SELECT cst_gndr
FROM bronze.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)

SELECT cst_key
FROM bronze.crm_cust_info
WHERE cst_key != TRIM(cst_key)


/* Data Standardization & Consistency: 
TO check if all genders are named correctly. 
Result was: M and F and NULL. WIll change this to Female and Male and n/a for NULL */
SELECT DISTINCT cst_gndr
FROM bronze.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM bronze.crm_cust_info


--------------------------------------------------------------------------------------------------------------------------------
--------------------------------------------------------------------------------------------------------------------------------
/* Checking all the data changes in the silver layer. Make sure to change all the bronze. to silver. */
SELECT cst_firstname
FROM silver.crm_cust_info
WHERE cst_firstname != TRIM(cst_firstname)

/* Checking for unwanted Space in gender column. 
(using the same query. You can do this with multiple data) */
SELECT cst_gndr
FROM silver.crm_cust_info
WHERE cst_gndr != TRIM(cst_gndr)



/* Data Standardization & Consistency: 
TO check if all genders are named correctly. 
Result was: M and F and NULL. WIll change this to Female and Male and n/a for NULL */
SELECT DISTINCT cst_gndr
FROM silver.crm_cust_info

SELECT DISTINCT cst_marital_status
FROM silver.crm_cust_info

-- Final check
SELECT * from silver.crm_cust_info