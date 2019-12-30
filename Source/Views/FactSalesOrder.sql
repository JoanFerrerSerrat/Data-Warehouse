IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'FactSalesOrder')
DROP VIEW Source.FactSalesOrder
GO
CREATE VIEW Source.FactSalesOrder AS
SELECT
    dc.CurrencyId,
    ISNULL(soh.CurrencyRateID, -1)                                        AS CurrencyRateID,
    soh.SalesOrderNumber,
    soh.SalesOrderId                                                      AS SalesOrderHeaderId,                                                     
    sod.SalesOrderDetailID,                                               
    ROW_NUMBER() OVER ( PARTITION BY soh.SalesOrderNumber                 
                        ORDER BY sod.SalesOrderDetailID )                 AS OrderLineNumber,
    dp.ProductId,                                                         
    c.CustomerID,                                                       
    sod.SpecialOfferID                                                    AS SpecialOfferId,
    CONVERT(DATE, soh.OrderDate)                                          AS OrderDate,
    CONVERT(DATE, soh.DueDate)                                            AS DueDate,
    CONVERT(DATE, soh.ShipDate)                                           AS ShipDate,
    sod.OrderQty                                                          AS Quantity, 
    CONVERT(numeric(38, 6), sod.UnitPrice)                                AS UnitPrice,
    CONVERT(numeric(38, 6), sod.UnitPrice)  * CONVERT(numeric(38, 6), cr.EndOfDayRate ) AS UnitPriceLocalCurrency,
    CONVERT(numeric(38, 6), sod.UnitPriceDiscount)                        AS UnitPriceDiscountPct,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.TaxAmt)   ELSE 0 END AS TaxAmt,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.Freight)  ELSE 0 END AS Freight,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.TotalDue) ELSE 0 END AS TotalDue,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.SubTotal) ELSE 0 END AS SubTotal,
    sod.LineTotal                                                         AS SalesAmount,
    sod.LineTotal * CONVERT(numeric(38, 6), cr.EndOfDayRate)              AS SalesAmountLocalCurrency,
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice)                 AS OriginalSalesAmount, 
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), cr.EndOfDayRate)                                                   AS OriginalSalesAmountLocalCurrency,
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), sod.UnitPriceDiscount)                                             AS DiscountAmount, 
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), sod.UnitPriceDiscount) * CONVERT(numeric(38, 6), cr.EndOfDayRate)  AS DiscountAmountLocalCurrency, 
    pch.StandardCost                                                      AS ProductStandardCost, 
    pch.StandardCost * CONVERT(numeric(38, 6), cr.EndOfDayRate)           AS ProductStandardCostLocalCurrency, 
    sod.OrderQty * CONVERT(numeric(38, 6), pch.StandardCost)              AS TotalProductCost,
    sod.OrderQty * pch.StandardCost * CONVERT(numeric(38, 6), cr.EndOfDayRate) AS TotalProductCostLocalCurrency,
    (SELECT MAX(ModDate) FROM (VALUES (soh.[ModifiedDate]), (sod.[ModifiedDate])) AS v (ModDate)) AS ModifiedDate
    --de.EmployeeKey AS EmployeeKey, --DW key mapping to Employee and SalesPerson
        --COALESCE(dc.CurrencyKey, (SELECT CurrencyKey FROM dbo.DimCurrency WHERE CurrencyAlternateKey = N'USD')) AS CurrencyKey, --Updated to match OLTP which uses the RateID not the currency code.
    --soh.TerritoryID AS SalesTerritoryKey, --DW key mapping to SalesTerritory
FROM       AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
INNER JOIN AdventureWorks2016_EXT.Sales.SalesOrderDetail sod 
    ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN AdventureWorks2016_EXT.Production.Product p 
    ON sod.ProductID = p.ProductID 
INNER JOIN Datawarehouse.DWH.DimProduct dp 
    ON dp.ProductNumber = p.ProductNumber
INNER JOIN DWH.DimCustomer c 
    ON soh.CustomerId = c.CustomerCode
LEFT OUTER JOIN AdventureWorks2016_EXT.Production.ProductCostHistory pch 
    ON p.ProductID = pch.ProductID
       AND soh.OrderDate BETWEEN pch.StartDate AND pch.EndDate
LEFT OUTER JOIN DWH.FactCurrencyRate cr 
    ON ISNULL(soh.CurrencyRateID, -1) = cr.CurrencyRateID
LEFT OUTER JOIN DWH.DimCurrency dc 
    ON cr.CurrencyToId = dc.CurrencyId
--LEFT OUTER JOIN AdventureWorks2016_EXT.HumanResources.Employee e 
--    ON soh.SalesPersonID = e.BusinessEntityID 
--LEFT OUTER JOIN dbo.DimEmployee de 
--    ON e.NationalIDNumber = de.EmployeeNationalIDAlternateKey COLLATE SQL_Latin1_General_CP1_CI_AS 
--ORDER BY OrderDateKey, ResellerKey;
--AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
--INNER JOIN AdventureWorks2016_EXT.Sales.SalesOrderDetail
GO
