IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimSalesOrderHeader')
DROP VIEW ExtDWH.DimSalesOrderHeader
GO
CREATE VIEW ExtDWH.DimSalesOrderHeader
AS
SELECT 
    SalesOrderHeaderId
    , SalesOrderNumber
    , OnlineOrder
    , StatusOrder
    , RevisionNumber
    , CustomerPONumber
FROM
    DWH.DimSalesOrderHeader
GO
