-- Analyzing the crm_sales table
-- Check for invalid Dates
SELECT 
NULLIF(sls_order_dt, 0) sls_order_dt
FROM bronze.crm_sales_details
WHERE sls_order_dt <= 0     -- check because negative numbers or zeros cant be cast as dates
OR LEN(sls_order_dt) != 8   --length of date must not be less than or higher than 8
OR sls_order_dt > 20500101  -- Checking the boundaries of the business
OR sls_order_dt < 19000101 

-- Checking for invalid Date orders. The order date must not be higher than the shipping or the due date
SELECT *
FROM silver.crm_sales_details
WHERE sls_order_dt > sls_ship_dt or sls_order_dt > sls_due_dt
-- since, all the data is already clean, we dont need to do any transformations


-- Check Data Consistency: Between Sales, Quantity, and Price
-- >> Sales = Quantity * Price
-- >> Values must not be NULL, zero or negative

SELECT DISTINCT
sls_sales,
sls_quantity,
sls_price
FROM silver.crm_sales_details
WHERE sls_sales != sls_quantity * sls_price
OR sls_sales IS NULL OR sls_quantity IS NULL OR sls_price IS NULL
OR sls_sales <= 0 OR sls_quantity <= 0 or sls_price <= 0
ORDER BY sls_sales, sls_quantity, sls_price

SELECT * from silver.crm_sales_details