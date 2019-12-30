
-- Test 1: Normal load to empty table
TRUNCATE TABLE DWH.[DimDate]

DECLARE 
    @LoadTo DATETIME = CONVERT(DATETIME, '31.12.2025', 104)

EXEC ETL.LoadDimDate @LoadTo

SELECT * FROM DWH.[DimDate]
-- Data Loaded as expected

-- Test 2: LoadTo parameter to a date that has already been loaded
DECLARE  
    @LoadTo  DATETIME = CONVERT(DATETIME, '31.12.2022', 104)

EXEC ETL.LoadDimDate @LoadTo

SELECT * FROM Logging.ETL_Loading
-- Error as expected

-- Test 3: Add dates
DECLARE  
    @LoadTo  DATETIME = CONVERT(DATETIME, '31.12.2028', 104)

EXEC ETL.LoadDimDate @LoadTo

SELECT * FROM DWH.[DimDate]
-- Data Loaded as expected