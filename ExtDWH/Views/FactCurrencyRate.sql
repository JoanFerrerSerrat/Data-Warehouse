IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'FactCurrencyRate')
DROP VIEW ExtDWH.FactCurrencyRate
GO
CREATE VIEW ExtDWH.FactCurrencyRate
AS
SELECT 
    CurrencyRateId
    , CurrencyFromId
    , CurrencyToId
    , [Date]
    , AverageRate
    , EndOfDayRate
FROM 
    DWH.FactCurrencyRate
GO

