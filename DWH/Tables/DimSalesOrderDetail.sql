IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimSalesOrderDetail')
BEGIN
    CREATE TABLE DWH.DimSalesOrderDetail(
        SalesOrderDetailID    INT               PRIMARY KEY NOT NULL,
        CarrierTrackingNumber NVARCHAR(25)                  NOT NULL,
        ModifiedDate          DATETIME                      NOT NULL,
        ImportedAt            DATETIME          DEFAULT GETDATE(),
        LoadId                DATETIME
    )
END
GO
