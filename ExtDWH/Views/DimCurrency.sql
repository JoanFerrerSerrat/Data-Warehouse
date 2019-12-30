IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimCurrency')
DROP VIEW ExtDWH.DimCurrency
GO
CREATE VIEW ExtDWH.DimCurrency
AS
SELECT 
    CurrencyId
    , CurrencyCode
    , CurrencyName
FROM 
    DWH.DimCurrency
GO


