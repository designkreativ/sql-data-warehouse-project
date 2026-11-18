/*
==================================================================================
STORED PROCEDURE: Load Bronze Layer (Source -> Bronze)
==================================================================================

SCRIPT PURPOSE:
This stored procedure loads data into 'bronze' schema from external CSV files.
it performs the following actions: 
  - Truncates the bronze tables before loading data.
  - Uses the BULK INSERT' command to load data from csv Files to bronze tables.

Parameters:
  None.
  This stored protedure does not accept any parameters or return any values.
Usage Example:
  EXEC bronze.load_bronze;
==================================================================================

  */

CREATE OR ALTER PROCEDURE bronze.load_bronze AS
BEGIN
	DECLARE @start_time DATETIME, @end_time DATETIME, @batch_start_time DATETIME, @batch_end_time DATETIME;
	BEGIN TRY

		--- TABLE FOR SOURCE CRM ---- 

		SET @batch_start_time = GETDATE();
		PRINT '==================================';
		PRINT 'Loading Bronze Layer';
		PRINT '==================================';

		PRINT '----------------------------------';
		PRINT 'Loading CRM Tables';
		PRINT '----------------------------------';

		--- TRUNCATE ---

		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_cust_info';
		TRUNCATE TABLE bronze.crm_cust_info;
		--- BULK INSERT---
		PRINT '>> Inserting Data Into: bronze.crm_cust_info';
		BULK INSERT bronze.crm_cust_info
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_crm\cust_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
		);
		SET @end_time = GETDATE();
		PRINT '>> Load Duration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> --------------'
		

		------ 



		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: bronze.crm_prd_info';
		TRUNCATE TABLE bronze.crm_prd_info;

		PRINT '>> Inserting Table: bronze.crm_prd_info';
		BULK INSERT bronze.crm_prd_info
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_crm\prd_info.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duaration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ______________'


		------
		SET @start_time = GETDATE();
		PRINT '>> Truncating Table: ';
		TRUNCATE TABLE bronze.crm_sales_details;

		PRINT '>> Inserting Table: ';
		BULK INSERT bronze.crm_sales_details
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_crm\sales_details.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


		SET @end_time = GETDATE();
		PRINT '>> Load Duaration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ______________'


		--- TABLE FOR SOURCE ERP ---- 
	


		PRINT '----------------------------------';
		PRINT 'Loading ERP Tables';
		PRINT '----------------------------------';
		------

		SET @end_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_cust_az12';
		TRUNCATE TABLE bronze.erp_cust_az12;

		PRINT '>> Inserting Table: bronze.erp_cust_az12';
		BULK INSERT bronze.erp_cust_az12
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_erp\cust_az12.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duaration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ______________'


		------

		SET @end_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_loc_a101';
		TRUNCATE TABLE bronze.erp_loc_a101;

		PRINT '>> Inserting Table: bronze.erp_loc_a101';
		BULK INSERT bronze.erp_loc_a101
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_erp\loc_a101.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);

		SET @end_time = GETDATE();
		PRINT '>> Load Duaration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ______________'


		-------

		SET @end_time = GETDATE();
		PRINT '>> Truncating Table: bronze.erp_px_cat_g1v2';
		TRUNCATE TABLE bronze.erp_px_cat_g1v2;

		PRINT '>> Inserting Table: bronze.erp_px_cat_g1v2';
		BULK INSERT bronze.erp_px_cat_g1v2
		FROM 'E:\DEV MODE\Courses\Data Engineering\SQL\DataWarehouse Project\sql-data-warehouse-project\01_datasets\source_erp\px_cat_g1v2.csv'
		WITH (
			FIRSTROW = 2,
			FIELDTERMINATOR = ',',
			TABLOCK
			);


		SET @end_time = GETDATE();
		PRINT '>> Load Duaration: ' + CAST(DATEDIFF(second, @start_time, @end_time) AS NVARCHAR) + ' seconds'
		PRINT '>> ______________'


		SET @batch_end_time = GETDATE();

		PRINT '=========================================='
		PRINT 'Load Bronze Layer is Completed'
		PRINT '  - Total Load Duration: ' + CAST(DATEDIFF(second, @batch_start_time, @batch_end_time) AS NVARCHAR) + ' seconds';
		PRINT '=========================================='
		------
	END TRY
	BEGIN CATCH
		PRINT '=========================================';
		PRINT 'ERROR OCCURE DURING LOADING BRONZE LAYER';
		PRINT 'Error Message' + ERROR_MESSAGE();
		PRINT 'Error Message' + CAST (ERROR_NUMBER() AS NVARCHAR);
		PRINT 'Error Message' + CAST (ERROR_STATE() AS NVARCHAR);
		PRINT '=========================================';
	END CATCH
END


