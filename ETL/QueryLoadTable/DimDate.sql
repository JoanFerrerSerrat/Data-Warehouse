DECLARE
    @LoadTo_ DATETIME = CONVERT(DATETIME, '31.12.2020', 104)

EXEC [ETL].[Load_DWH_DimDate] @LoadTo = @LoadTo_
GO
