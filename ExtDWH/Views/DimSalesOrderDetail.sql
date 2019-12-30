IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimSalesOrderDetail')
DROP VIEW ExtDWH.DimSalesOrderDetail
GO
CREATE VIEW ExtDWH.DimSalesOrderDetail
AS
SELECT 
    SalesOrderDetailId
    , CarrierTrackingNumber
FROM
    DWH.DimSalesOrderDetail
GO
