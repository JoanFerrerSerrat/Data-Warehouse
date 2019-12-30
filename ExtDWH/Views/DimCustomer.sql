IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimCustomer')
DROP VIEW ExtDWH.DimCustomer
GO
CREATE VIEW ExtDWH.DimCustomer
AS
SELECT 
    CustomerId
    , CustomerCode
    , AccountNumber
    , PersonType
    , Store
    , EmailPromotion
    , Region
FROM 
    DWH.DimCustomer
GO


