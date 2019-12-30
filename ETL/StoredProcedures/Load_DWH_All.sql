IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_All'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_All
GO
CREATE PROC ETL.Load_DWH_All
AS
BEGIN

    DECLARE 
        @LoadId DATETIME = GETDATE()
        , @LoadTo DATETIME = CONVERT(DATETIME, '2025-12-31 00:00:00.000')

    EXEC [ETL].[Load_DWH_DimCurrency] @LoadId
    EXEC [ETL].[Load_DWH_DimCustomer] @LoadId
    EXEC [ETL].[Load_DWH_DimProduct] @LoadId
    EXEC [ETL].[Load_DWH_DimDate] @LoadTo
    EXEC [ETL].[Load_DWH_DimSalesOrderDetail] @LoadId
    EXEC [ETL].[Load_DWH_DimSalesOrderHeader] @LoadId
    EXEC [ETL].[Load_DWH_DimSpecialOffer] @LoadId
    EXEC [ETL].[Load_DWH_FactCurrencyRate] @LoadId
    EXEC [ETL].[Load_DWH_FactSalesOrder] @LoadId

END
GO
