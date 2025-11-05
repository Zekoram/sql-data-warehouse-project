/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
  In this query, we’re creating a new database named 'DataWarehouse' for our project.  
  Before creating it, we first check if a database with the same name already exists.  
  If it does, we drop it to avoid conflicts.   
  After creating the database, we add three schemas inside it: bronze, silver, and gold.  

Warning:
  ⚠️ Be careful running this script will permanently delete all existing data in the database 'DataWarehouse' if it exists.
  Proceed with caution and ensure you have proper backups before running this script.
*/

-- Step 1: Check if the database already exists; if yes, drop it
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'DataWarehouse')
BEGIN
    ALTER DATABASE DataWarehouse SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE DataWarehouse;
END;
GO

-- Step 2: Create the new database
CREATE DATABASE DataWarehouse;
GO

-- Step 3: Switch to the new database
USE DataWarehouse;
GO

-- Step 4: Create schemas
CREATE SCHEMA bronze;
GO

CREATE SCHEMA silver;
GO

CREATE SCHEMA gold;
GO
