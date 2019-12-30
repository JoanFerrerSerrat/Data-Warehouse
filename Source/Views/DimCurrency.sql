IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimCurrency')
DROP VIEW Source.DimCurrency
GO
CREATE VIEW Source.DimCurrency AS
SELECT 
    CurrencyCode,
    [Name],
    GETDATE()    AS ImportAt
FROM AdventureWorks2016_EXT.Sales.Currency
GO
