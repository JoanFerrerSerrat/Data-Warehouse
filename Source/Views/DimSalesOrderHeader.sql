IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimSalesOrderHeader')
DROP VIEW Source.DimSalesOrderHeader
GO
CREATE VIEW Source.DimSalesOrderHeader AS
SELECT
    soh.SalesOrderId                                                                              AS SalesOrderHeaderId, 
    soh.SalesOrderNumber,                                                    
    oo.OnlineOrder                                                                                AS OnlineOrder,
    soh.Status                                                                                    AS StatusOrder,
    soh.RevisionNumber                                                                            AS RevisionNumber,
    ISNULL(soh.PurchaseOrderNumber, '')                                                           AS CustomerPONumber,
    soh.ModifiedDate                                                                              AS ModifiedDate
    --COALESCE(dc.CurrencyKey, (SELECT CurrencyKey FROM dbo.DimCurrency WHERE CurrencyAlternateKey = N'USD')) AS CurrencyKey, --Updated to match OLTP which uses the RateID not the currency code.
    --soh.TerritoryID AS SalesTerritoryKey, --DW key mapping to SalesTerritory
FROM            AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
LEFT OUTER JOIN ETL.BooleanMapping oo
    ON soh.OnlineOrderFlag = oo.Id
GO
