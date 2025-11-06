/*
===============================================================================
Stored Procedure: Load Bronze Layer (Source -> Bronze)
===============================================================================
Script Purpose:
       This script creates a stored procedure in the 'bronze' layer from external csv files.
       It performs to main operations:
              - Truncate the table to remove any existing values.
              - Insert data in bulk from external csv files into the tables created.

Parameters:
      None. This stored procedure don't accept any parameter and return values.

Usage Example:
    EXEC bronze.load_bronze;
===============================================================================
*/

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME
	BEGIN TRY	
		SET @batch_start_time = GETDATE();
		PRINT '============================================================='
		PRINT 'Loading Bronze Layer';
		PRINT '============================================================='

		PRINT '============================================================='
		PRINT 'Loading CRM Tables';
		PRINT '============================================================='

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.crm_cust_info TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.crm_cust_info;

		-- INSERT DATA INTO TABLE: bronze.crm_cust_info
		BULK INSERT bronze.crm_cust_info
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.crm_prd_info TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.crm_prd_info;

		-- INSERT DATA INTO TABLE: bronze.crm_prd_info
		BULK INSERT bronze.crm_prd_info
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.crm_sales_details TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.crm_sales_details;

		-- INSERT DATA INTO TABLE: bronze.crm_sales_details
		BULK INSERT bronze.crm_sales_details
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		PRINT '============================================================='
		PRINT 'Loading ERP Tables';
		PRINT '============================================================='

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.erp_cust_az12 TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.erp_cust_az12;

		-- INSERT DATA INTO TABLE: bronze.erp_cust_az12
		BULK INSERT bronze.erp_cust_az12
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\cust_az12.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.erp_loc_a101 TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.erp_loc_a101;

		-- INSERT DATA INTO TABLE: bronze.erp_loc_a101
		BULK INSERT bronze.erp_loc_a101
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\loc_a101.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		SET @start_time = GETDATE();
		-- TRUNCATING TABLE bronze.erp_px_cat_g1v2 TO AVOID ADDING REPEATING VALUE
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		-- INSERT DATA INTO TABLE: bronze.erp_px_cat_g1v2
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'D:\SQL BY BARA\sql-data-warehouse-project\sql-data-warehouse-project\datasets\source_erp\px_cat_g1v2.csv'
		WITH(
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE()
		PRINT '>> Loading Duration: ' + CAST(DATEDIFF(SECOND, @start_time, @end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------'

		SET @batch_end_time = GETDATE()
		PRINT 'Complete Loading Bronze Layer';
		PRINT '>> Total Loading Duration: ' + CAST(DATEDIFF(SECOND, @batch_start_time, @batch_end_time) AS VARCHAR) + ' seconds';
		PRINT '>> -------------';
	END TRY
	BEGIN CATCH
		PRINT '============================================================='
		PRINT 'ERROR OCCURRED DURING LOADING BRONZE LAYER'
		PRINT 'ERROR MESSAGE' + ERROR_MESSAGE();
		PRINT 'ERROR MESSAGE' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT 'ERROR MESSAGE' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '============================================================='
	END CATCH
END
