TRUNCATE TABLE dbo.DimCurrency

SELECT * FROM ETL.LoadDimCurrency
-- Empty

EXEC ETL.LoadDimCurrency

SELECT * FROM ETL.LoadDimCurrency
-- 105 Currencies

EXEC ETL.LoadDimCurrency

SELECT * FROM ETL.LoadDimCurrency
-- 105 Currencies

SELECT * FROM Logging.ETL_Loading
-- No errors