-- Foreign key integrity (dimensions) check
SELECT * FROM gold.fact_sales


-- Fact check: Check if all dimension tables can successfully join to the fact table
-- i.e. tryin to connect the entire data model to find any issues
SELECT * FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c
ON c.customer_key = f.customer_key
LEFT JOIN gold.dim_products p
ON p.product_key = f.product_key
WHERE p.product_key IS NULL 
-- WHERE c.customer_key IS NULL 
-- No null. Everything matched perfectly