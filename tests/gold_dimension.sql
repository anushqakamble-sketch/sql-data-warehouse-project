-- Data integration
-- While checking we found 2 different values male and female assigned to the same person in two different databases.
-- To fix this issue, we ask the experts about which source is the master source, and then we proceed with further steps.
-- We also found null value when we ran this query but that value is only due to mismatch not because of a null value
SELECT DISTINCT
ci.cst_gndr,
ca.gen
FROM		silver.crm_cust_info ci
LEFT JOIN	silver.erp_cust_az12 ca
ON			ci.cst_key = ca.cid
LEFT JOIN	silver.erp_loc_a101 la
ON			ci.cst_key = la.cid
ORDER BY 1,2

-- So the master data for customer information was crm
-- Below is the fix:

SELECT DISTINCT
ci.cst_gndr,
ca.gen,
CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr  -- CRM is the Master for gender info
	ELSE COALESCE(ca.gen, 'n/a')
END AS new_gen
FROM		silver.crm_cust_info ci
LEFT JOIN	silver.erp_cust_az12 ca
ON			ci.cst_key = ca.cid
LEFT JOIN	silver.erp_loc_a101 la
ON			ci.cst_key = la.cid
ORDER BY 1,2

-- CHecking the quality of the dim gold
SELECT * from gold.dim_customers

SELECT distinct gender FROM gold.dim_customers