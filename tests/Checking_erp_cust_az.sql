-- Identify out of range dates
SELECT DISTINCT 
bdate 
FROM bronze.erp_cust_az12
WHERE bdate < '1924-01-01' OR bdate > GETDATE() -- customers cant really be less than a hundred or more than current date
-- We can either transfor this or leave it. We will transform in transformation query


-- CHecking data standardization and inconsistencies 
SELECT DISTINCT 
gen
FROM silver.erp_cust_az12

SELECT * from silver.erp_cust_az12