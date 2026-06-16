-- For the id column we dont need to check because we had already checked it with crm_prd table

-- Check for unwanted space
SELECT * FROM bronze.erp_px_cat_g1v2
WHERE cat!= TRIM(cat) OR subcat != TRIM(subcat) OR maintainance != TRIM(maintainance) -- no unwanted spaces

-- Data standardization & consistency 
SELECT DISTINCT 
cat, 
maintainance,
subcat
FROM bronze.erp_px_cat_g1v2 -- no changes required 