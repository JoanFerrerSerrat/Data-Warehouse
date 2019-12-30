IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'FactCurrencyRate')
DROP VIEW Source.FactCurrencyRate
GO
CREATE VIEW Source.FactCurrencyRate AS
SELECT
    CurrencyRateId,
    CONVERT(DATE, CurrencyRateDate) AS CurrencyRateDate,
    FromCurrencyCode,
    ToCurrencyCode,
    AverageRate,
    EndOfDayRate,
    ModifiedDate
FROM 
    AdventureWorks2016_EXT.Sales.CurrencyRate
GO
