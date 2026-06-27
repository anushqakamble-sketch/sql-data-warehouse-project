/*
========================================================================================================
DDL sript: Create Views for the gold layer of data warehouse
Script purpose:
  This script creates views for the Gold layer in the data warehouse. 
  Gold layer consists of the final dimensions and fact tables (Star schema) 

  The purpose of each view is to transform and combine the data from the silver layer
  in order to product a clean, enriched, and business-ready dataset

Usage: These views can be queried directly for analytics and reporting.
*/
=========================================================================================================
-- Creating an alias 
-- we are going to join the data cid from erp_px to the cst_key. So we are joining data with another table
/* Avoiding using inner join becasue if other table doesnt have all customer data then we might loose customers.
 Always start with master table and try to avoid inner joins when u r joining it with data from other table */


 -- Giving user-friendly names and also changing the sequence of the columns
 IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
go

CREATE VIEW gold.dim_customers AS
SELECT 
	ROW_NUMBER() OVER (ORDER BY cst_id) AS customer_key,   -- Created a surrogate key 
	ci.cst_id AS customer_id,
	ci.cst_key AS customer_number,
	ci.cst_firstname AS first_name,
	ci.cst_lastname AS last_name,
	la.cntry AS country,
	ci.cst_marital_status AS marital_status,
	CASE WHEN ci.cst_gndr != 'n/a' THEN ci.cst_gndr  -- CRM is the Master for gender info
		ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	ca.bdate AS birthdate,
	ci.cst_create_date as create_date

FROM silver.crm_cust_info ci
LEFT JOIN silver.erp_cust_az12 ca
ON ci.cst_key = ca.cid
LEFT JOIN silver.erp_loc_a101 la
ON ci.cst_key = la.cid
