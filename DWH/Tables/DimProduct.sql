IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimProduct')
BEGIN
    CREATE TABLE DWH.DimProduct(
        ProductId             INT           NOT NULL IDENTITY PRIMARY KEY,
        ProductCode           INT           NOT NULL,
        ProductNumber         NVARCHAR(25)  NOT NULL,
        ProductName           NVARCHAR(50)  NOT NULL,
        MakeIntern            VARCHAR(3)    NOT NULL,
        FinishedGood          VARCHAR(3)    NOT NULL,
        Color                 NVARCHAR(15)  NULL,
        SafetyStockLevel      SMALLINT      NOT NULL,
        ReorderPoint          SMALLINT      NOT NULL,
        StandardCost          MONEY         NOT NULL,
        SalesPrice            MONEY         NOT NULL,
        Size                  NVARCHAR(5)   NULL,
        SizeUnitMeasureCode   NVARCHAR(3)   NULL,
        WeightUnitMeasureCode NVARCHAR(3)   NULL,
        [Weight]              DECIMAL(8, 2) NULL,
        DaysToManufacture     INT           NOT NULL,
        ProductLine           NVARCHAR(20)  NULL,
        Class                 NVARCHAR(20)  NULL,
        Style                 NVARCHAR(20)  NULL,
        ProductSubcategory    NVARCHAR(50)  NULL,
        ProductCategory       NVARCHAR(50)  NULL,
        ProductModel          NVARCHAR(50)  NULL,
        SellStartDate         DATETIME      NOT NULL,
        SellEndDate           DATETIME      NULL,
        ModifiedDate          DATETIME      NOT NULL,
        ImportedAt            DATETIME      DEFAULT GETDATE(),
        LoadId                DATETIME      NOT NULL
    )
END
GO
