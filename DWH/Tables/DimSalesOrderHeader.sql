IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimSalesOrderHeader')
BEGIN
    CREATE TABLE DWH.DimSalesOrderHeader(
        SalesOrderHeaderId              INT          NOT NULL PRIMARY KEY,
        SalesOrderNumber                NVARCHAR(25) NOT NULL,
        OnlineOrder                     NVARCHAR(18) NULL,
        StatusOrder                     NVARCHAR(10) NOT NULL,
        RevisionNumber                  TINYINT      NOT NULL,
        CustomerPONumber                NVARCHAR(25) NULL,
        ModifiedDate                    DATETIME     NOT NULL,
        ImportedAt                      DATETIME     DEFAULT GETDATE(),
        LoadId                          DATETIME     NOT NULL
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimSalesOrderHeader_SalesOrderNumber ] ON DWH.DimSalesOrderHeader( SalesOrderNumber )
GO
