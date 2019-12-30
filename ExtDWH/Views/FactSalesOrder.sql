IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'FactSalesOrder')
DROP VIEW ExtDWH.FactSalesOrder
GO
CREATE VIEW ExtDWH.FactSalesOrder
AS
SELECT
    CurrencyId
    , CurrencyRateId
    , SalesOrderNumber
    , SalesOrderHeaderId
    , SalesOrderDetailId
    , OrderLineNumber
    , ProductId
    , CustomerId
    --, StatusOrderId
    , SpecialOfferId
    --, RevisionNumber
    --, CarrierTrackingNumber
    --, CustomerPONumber
    --, LocalCurrency
    , OrderDate
    , DueDate
    , ShipDate
    , Quantity
    , UnitPrice
    , UnitPriceLocalCurrency
    , UnitPriceDiscountPct
    , TaxAmt
    , Freight
    , TotalDue
    , SubTotal
    , SalesAmount
    , SalesAmountLocalCurrency
    , OriginalSalesAmount
    , OriginalSalesAmountLocalCurrency
    , DiscountAmount
    , DiscountAmountLocalCurrency
    , ProductStandardCost
    , ProductStandardCostLocalCurrency
    , TotalProductCost
    , TotalProductCostLocalCurrency
FROM
    DWH.FactSalesOrder
GO
