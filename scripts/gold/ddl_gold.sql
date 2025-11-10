/*
===============================================================================
DDL Script: Create Gold Views
===============================================================================
Script Purpose:
      This script create view for the gold layer in the data warehouse.
      The gold layer represents the dimension and fact tables (star schema).

      Each view performs transformations and combines data from the Silver layer 
      to produce a clean, enriched, and business-ready dataset.

Usage:
    This views can be quered directly for analytics and reporting.

===============================================================================
*/

-- =============================================================================
-- Create Dimension: gold.dim_customers
-- =============================================================================
IF OBJECT_ID('gold.dim_customers', 'V') IS NOT NULL
	DROP VIEW gold.dim_customers;
GO

CREATE VIEW gold.dim_customers AS 
SELECT 
	ROW_NUMBER() OVER(ORDER BY cu.cst_id) AS customer_key,
	cu.cst_id AS customer_id,
	cu.cst_key AS customer_number,
	cu.cst_firstname AS firstname,
	cu.cst_lastname AS lastname,
	cu.cst_marital_status AS marital_status,
	la.cntry AS country,
	ca.bdate AS birthdate,
	CASE
		WHEN cu.cst_gndr != 'n/a' THEN cu.cst_gndr
		ELSE COALESCE(ca.gen, 'n/a')
	END AS gender,
	cu.cst_create_date AS create_date
FROM silver.crm_cust_info cu
LEFT JOIN silver.erp_cust_az12 ca
ON ca.cid = cu.cst_key
LEFT JOIN silver.erp_loc_a101 la
ON la.cid = cu.cst_key;
GO

-- =============================================================================
-- Create Dimension: gold.dim_products
-- =============================================================================
  
IF OBJECT_ID('gold.dim_products', 'V') IS NOT NULL
	DROP VIEW gold.dim_products;
GO

CREATE VIEW gold.dim_products AS 
SELECT
	ROW_NUMBER() OVER(ORDER BY pr.prd_start_dt, pr.prd_end_dt) AS product_key,
	pr.prd_id AS product_id,
	pr.prd_key AS product_number,
	pr.prd_nm AS product_name,
	pr.prd_cost AS product_cost,
	pr.prd_line AS product_line,
	px.cat AS category,
	px.subcat AS subcategory,
	px.maintenance AS maintenance,
	pr.prd_start_dt AS start_date
FROM silver.crm_prd_info pr
LEFT JOIN silver.erp_px_cat_g1v2 px
ON px.id = pr.cat_id;
GO

-- =============================================================================
-- Create Fact Table: gold.fact_sales
-- =============================================================================
  
IF OBJECT_ID('gold.fact_sales', 'V') IS NOT NULL
	DROP VIEW gold.fact_sales;
GO

CREATE VIEW gold.fact_sales AS
SELECT 
	sl.sls_ord_num AS order_number,
	cu.customer_key AS customer_key,
	pr.product_key AS product_key,
	sl.sls_order_dt AS order_date,
	sl.sls_ship_dt AS shipping_date,
	sl.sls_due_dt AS due_date,
	sl.sls_sales AS sales_amount,
	sl.sls_quantity AS quantity,
	sl.sls_price AS price
FROM silver.crm_sales_details sl
LEFT JOIN gold.dim_customers cu
ON sl.sls_cust_id = cu.customer_id
LEFT JOIN gold.dim_products pr
ON sl.sls_prd_key = pr.product_number;
GO
