-- First restore database source in Datawarehouse\Database\SourceBackup 
USE master 
 
-- Create Datawarehouse database 
IF NOT EXISTS (
    SELECT 1 
    FROM master.dbo.sysdatabases 
    WHERE name = 'Datawarehouse')
BEGIN
    CREATE DATABASE Datawarehouse
        CONTAINMENT = NONE
        ON  PRIMARY (
            NAME = N'Datawarehouse',
            FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse.mdf',
            SIZE = 8192KB,
            MAXSIZE = UNLIMITED,
            FILEGROWTH = 65536KB
        )
        LOG ON (
            NAME = N'Datawarehouse_log',
            FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_log.ldf',
            SIZE = 73728KB,
            MAXSIZE = 2048GB,
            FILEGROWTH = 65536KB
        )
END
GO
-- Add filegroup 
IF NOT EXISTS(
    SELECT 1
    FROM [Datawarehouse].sys.filegroups
    WHERE name='SalesOrder')
BEGIN
    ALTER DATABASE [Datawarehouse] ADD FILEGROUP [SalesOrder]

    ALTER DATABASE [Datawarehouse] ADD FILE ( NAME = N'Datawarehouse_SalesOrder'
                                              , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_SalesOrder.ndf' 
                                              , SIZE = 73728KB 
                                              , FILEGROWTH = 65536KB ) 
                                       TO FILEGROUP [SalesOrder]

END
GO
 
USE Datawarehouse 
 
-- Create partition functions 
IF NOT EXISTS (SELECT * FROM sys.partition_functions WHERE name = N'pfByDate')
BEGIN
    CREATE PARTITION FUNCTION [pfByDate](date) AS RANGE RIGHT FOR VALUES
    (
        CONVERT(DATE, '2011-05-01')
        , CONVERT(DATE, '2011-06-01')
        , CONVERT(DATE, '2011-07-01')
        , CONVERT(DATE, '2011-08-01')
        , CONVERT(DATE, '2011-09-01')
        , CONVERT(DATE, '2011-10-01')
        , CONVERT(DATE, '2011-11-01')
        , CONVERT(DATE, '2011-12-01')
        , CONVERT(DATE, '2012-01-01')
        , CONVERT(DATE, '2012-02-01')
        , CONVERT(DATE, '2012-03-01')
        , CONVERT(DATE, '2012-04-01')
        , CONVERT(DATE, '2012-05-01')
        , CONVERT(DATE, '2012-06-01')
        , CONVERT(DATE, '2012-07-01')
        , CONVERT(DATE, '2012-08-01')
        , CONVERT(DATE, '2012-09-01')
        , CONVERT(DATE, '2012-10-01')
        , CONVERT(DATE, '2012-11-01')
        , CONVERT(DATE, '2012-12-01')
        , CONVERT(DATE, '2013-01-01')
        , CONVERT(DATE, '2013-02-01')
        , CONVERT(DATE, '2013-03-01')
        , CONVERT(DATE, '2013-04-01')
        , CONVERT(DATE, '2013-05-01')
        , CONVERT(DATE, '2013-06-01')
        , CONVERT(DATE, '2013-07-01')
        , CONVERT(DATE, '2013-08-01')
        , CONVERT(DATE, '2013-09-01')
        , CONVERT(DATE, '2013-10-01')
        , CONVERT(DATE, '2013-11-01')
        , CONVERT(DATE, '2013-12-01')
        , CONVERT(DATE, '2014-01-01')
        , CONVERT(DATE, '2014-02-01')
        , CONVERT(DATE, '2014-03-01')
        , CONVERT(DATE, '2014-04-01')
        , CONVERT(DATE, '2014-05-01')   
        , CONVERT(DATE, '2014-06-01')
        , CONVERT(DATE, '2014-07-01')
        , CONVERT(DATE, '2014-08-01')
        , CONVERT(DATE, '2014-09-01')
        , CONVERT(DATE, '2014-10-01')
        , CONVERT(DATE, '2014-11-01')
        , CONVERT(DATE, '2014-12-01')
        , CONVERT(DATE, '2015-01-01')
        , CONVERT(DATE, '2015-02-01')
        , CONVERT(DATE, '2015-03-01')
        , CONVERT(DATE, '2015-04-01')
        , CONVERT(DATE, '2015-05-01')
        , CONVERT(DATE, '2015-06-01')
        , CONVERT(DATE, '2015-07-01')
        , CONVERT(DATE, '2015-08-01')
        , CONVERT(DATE, '2015-09-01')
        , CONVERT(DATE, '2015-10-01')
        , CONVERT(DATE, '2015-11-01')
        , CONVERT(DATE, '2015-12-01')
        , CONVERT(DATE, '2016-01-01')
        , CONVERT(DATE, '2016-02-01')
        , CONVERT(DATE, '2016-03-01')
        , CONVERT(DATE, '2016-04-01')
        , CONVERT(DATE, '2016-05-01')
        , CONVERT(DATE, '2016-06-01')
        , CONVERT(DATE, '2016-07-01')
        , CONVERT(DATE, '2016-08-01')
        , CONVERT(DATE, '2016-09-01')
        , CONVERT(DATE, '2016-10-01')
        , CONVERT(DATE, '2016-11-01')
        , CONVERT(DATE, '2016-12-01')
        , CONVERT(DATE, '2017-01-01')
        , CONVERT(DATE, '2017-02-01')
        , CONVERT(DATE, '2017-03-01')
        , CONVERT(DATE, '2017-04-01')
        , CONVERT(DATE, '2017-05-01')
        , CONVERT(DATE, '2017-06-01')
        , CONVERT(DATE, '2017-07-01')
        , CONVERT(DATE, '2017-08-01')
        , CONVERT(DATE, '2017-09-01')
        , CONVERT(DATE, '2017-10-01')
        , CONVERT(DATE, '2017-11-01')
        , CONVERT(DATE, '2017-12-01')
        , CONVERT(DATE, '2018-01-01')
        , CONVERT(DATE, '2018-02-01')
        , CONVERT(DATE, '2018-03-01')
        , CONVERT(DATE, '2018-04-01')
        , CONVERT(DATE, '2018-05-01')
        , CONVERT(DATE, '2018-06-01')
        , CONVERT(DATE, '2018-07-01')
        , CONVERT(DATE, '2018-08-01')
        , CONVERT(DATE, '2018-09-01')
        , CONVERT(DATE, '2018-10-01')
        , CONVERT(DATE, '2018-11-01')
        , CONVERT(DATE, '2018-12-01')
        , CONVERT(DATE, '2019-01-01')
        , CONVERT(DATE, '2019-02-01')
        , CONVERT(DATE, '2019-03-01')
        , CONVERT(DATE, '2019-04-01')
        , CONVERT(DATE, '2019-05-01')
        , CONVERT(DATE, '2019-06-01')
        , CONVERT(DATE, '2019-07-01')
        , CONVERT(DATE, '2019-08-01')
        , CONVERT(DATE, '2019-09-01')
        , CONVERT(DATE, '2019-10-01')
        , CONVERT(DATE, '2019-11-01')
        , CONVERT(DATE, '2019-12-01')
        , CONVERT(DATE, '2020-01-01')
        , CONVERT(DATE, '2020-02-01')
        , CONVERT(DATE, '2020-03-01')
        , CONVERT(DATE, '2020-04-01')
        , CONVERT(DATE, '2020-05-01')
        , CONVERT(DATE, '2020-06-01')
        , CONVERT(DATE, '2020-07-01')
        , CONVERT(DATE, '2020-08-01')
        , CONVERT(DATE, '2020-09-01')
        , CONVERT(DATE, '2020-10-01')
        , CONVERT(DATE, '2020-11-01')
        , CONVERT(DATE, '2020-12-01'))
END
GO
 
-- Create partition schema 
CREATE PARTITION SCHEME [psSalesOrder] AS PARTITION [pfByDate] TO 
(
   [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder]
    , [SalesOrder])
GO
-- Create schemas 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'Source')
BEGIN
    EXEC('CREATE SCHEMA Source AUTHORIZATION dbo')
END
GO
 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'Logging')
BEGIN
    EXEC('CREATE SCHEMA Logging AUTHORIZATION dbo')
END
GO
 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'ETL')
BEGIN
    EXEC('CREATE SCHEMA ETL AUTHORIZATION dbo')
END
GO
 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'DWH')
BEGIN
    EXEC('CREATE SCHEMA DWH AUTHORIZATION dbo')
END
GO
 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'ExtDWH')
BEGIN
    EXEC('CREATE SCHEMA ExtDWH AUTHORIZATION dbo')
END
GO
 
-- Objects of DWH 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimCustomer')
BEGIN
    CREATE TABLE DWH.DimCustomer(
        CustomerId          INT             NOT NULL IDENTITY PRIMARY KEY,
        CustomerCode        NVARCHAR(10)    NOT NULL,
        AccountNumber       NVARCHAR(10)    NOT NULL,
        PersonType          NVARCHAR(28)    NOT NULL,
        Store               NVARCHAR(50)    NULL,
        EmailPromotion      NVARCHAR(41)    NOT NULL,
        Region              NVARCHAR(30)    NOT NULL,
        StartDate           DATE            NOT NULL,
        EndDate             DATE            NULL,
        [Status]            NVARCHAR(7)     NULL,
        ModifiedDate        DATETIME        NOT NULL,
        ImportedAt          DATETIME        DEFAULT GETDATE(),
        LoadId              DATETIME        NOT NULL
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimCustomer_CustomerCode_StartDate] ON DWH.DimCustomer( CustomerCode, StartDate )
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME ='DimDate')
DROP TABLE DWH.DimDate
GO
CREATE TABLE DWH.DimDate(
    [Date]           DATE          NOT NULL PRIMARY KEY,
    [DateName]       NVARCHAR(10)  NOT NULL,
    [DayOfMonth]     INTEGER       NOT NULL,
    DaySuffix        NVARCHAR(8)   NOT NULL,
    [DayCharacter]   NVARCHAR(15)  NOT NULL,
    [DayOfWeek]      INTEGER       NOT NULL,
    [DayOfYear]      INTEGER       NOT NULL,
    WeekOfYear       INTEGER       NOT NULL,
    WeekOfYearName   NVARCHAR(7)   NULL,
    MonthId          INT           NOT NULL,
    [Month]          INTEGER       NOT NULL,
    [MonthName]      NVARCHAR(20)  NOT NULL,
    MonthOfQuarter   INTEGER       NOT NULL,
    QuarterId        INTEGER       NOT NULL,
    [Quarter]        INTEGER       NOT NULL,
    QuarterName      NVARCHAR(7)   NOT NULL,
    [Year]           INTEGER       NOT NULL,
    YearName         NVARCHAR(4)   NOT NULL,
    MonthYear        NVARCHAR(8)   NOT NULL,
    IsWeekday        INTEGER       NOT NULL,
    ImportedAt       DATETIME      DEFAULT GETDATE()
)
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME = 'DimCurrency'
)
BEGIN
    CREATE TABLE DWH.DimCurrency(
        CurrencyId            INT           NOT NULL IDENTITY PRIMARY KEY,
        CurrencyCode          NCHAR(3)      NOT NULL,
        CurrencyName          NVARCHAR(50)  NOT NULL,
        ImportedAt            DATETIME      DEFAULT GETDATE(),
        LoadId                DATETIME
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimCurrency_CurrencyCode] ON DWH.DimCurrency( CurrencyCode )
GO
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
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimSpecialOffer')
BEGIN
    CREATE TABLE DWH.DimSpecialOffer(
        SpecialOfferId   INT           IDENTITY(1,1) PRIMARY KEY NOT NULL,
        SpecialOfferCode INT                                     NOT NULL,
        SpecialOffer     NVARCHAR(255)                           NOT NULL,
        DiscountPct      SMALLMONEY                              NOT NULL,
        [Type]           NVARCHAR(50)                            NOT NULL,
        Category         NVARCHAR(50)                            NOT NULL,
        StartDate        DATETIME                                NOT NULL,
        EndDate          DATETIME                                NOT NULL,
        MinQty           INT                                     NOT NULL,
        MaxQty           INT                                     NULL,
        ModifiedDate     DATETIME                                NOT NULL,
        ImportedAt       DATETIME                                DEFAULT GETDATE(),
        LoadId           DATETIME                                NOT NULL
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimSpecialOffer_SpecialOfferCode ] ON DWH.DimSpecialOffer( SpecialOfferCode )
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME ='DimStatusOrder')
BEGIN
    CREATE TABLE DWH.DimStatusOrder(
        StatusOrderId     SMALLINT    PRIMARY KEY NOT NULL,
        StatusOrder       NVARCHAR(20) NOT NULL
    )
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='FactCurrencyRate')
BEGIN
    CREATE TABLE DWH.FactCurrencyRate(
        CurrencyRateId     INT          PRIMARY KEY,
        CurrencyFromId     INT          NOT NULL,
        CurrencyToId       INT          NOT NULL,
        [Date]             DATE         NULL,
        AverageRate        FLOAT        NOT NULL,
        EndOfDayRate       FLOAT        NOT NULL,
        ModifiedDate       DATETIME     NOT NULL,
        ImportedAt         DATETIME     DEFAULT GETDATE(),
        LoadId             DATETIME
    )

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimCurrencyFrom FOREIGN KEY(CurrencyFromId)
    REFERENCES DWH.DimCurrency (CurrencyId)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimCurrencyFrom

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimCurrencyTo FOREIGN KEY(CurrencyToId)
    REFERENCES DWH.DimCurrency (CurrencyId)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimCurrencyTo

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimDate FOREIGN KEY(Date)
    REFERENCES DWH.DimDate (Date)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimDate

    CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_FactCurrencyRate_CurrencyFromId_CurrencyToId_Date ] ON DWH.FactCurrencyRate( CurrencyFromId, CurrencyToId, [Date] )
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='FactSalesOrder')
BEGIN

    CREATE TABLE DWH.FactSalesOrder(
        CurrencyId                          INT              NULL,
        CurrencyRateId                      INT              NULL,
        SalesOrderNumber                    NVARCHAR(25)     NOT NULL,
        SalesOrderHeaderId                  INT              NOT NULL,
        SalesOrderDetailId                  INT              NOT NULL,
        SpecialOfferId                      INT              NOT NULL,
        ProductId                           INT              NOT NULL,
        CustomerId                          INT              NOT NULL,
        OrderLineNumber                     BIGINT           NULL,
        OrderDate                           DATE             NULL,
        DueDate                             DATE             NULL,
        ShipDate                            DATE             NULL,
        Quantity                            SMALLINT         NOT NULL,
        UnitPrice                           NUMERIC(38, 6)   NULL,
        UnitPriceLocalCurrency              NUMERIC(38, 6)   NULL, -- float
        UnitPriceDiscountPct                NUMERIC(38, 6)   NULL,
        TaxAmt                              NUMERIC(38, 6)   NULL,
        Freight                             NUMERIC(38, 6)   NULL,
        TotalDue                            NUMERIC(38, 6)   NULL,
        SubTotal                            NUMERIC(38, 6)   NULL,
        SalesAmount                         NUMERIC(38, 6)   NOT NULL,
        SalesAmountLocalCurrency            NUMERIC(38, 6)   NULL, -- float
        OriginalSalesAmount                 NUMERIC(38, 6)   NULL,
        OriginalSalesAmountLocalCurrency    NUMERIC(38, 6)   NULL, -- float
        DiscountAmount                      NUMERIC(38, 6)   NULL,
        DiscountAmountLocalCurrency         NUMERIC(38, 6)   NULL, -- float
        ProductStandardCost                 NUMERIC(38, 6)   NULL, -- money
        ProductStandardCostLocalCurrency    NUMERIC(38, 6)   NULL, -- float
        TotalProductCost                    NUMERIC(38, 6)   NULL, -- money
        TotalProductCostLocalCurrency       NUMERIC(38, 6)   NULL, -- float
        ModifiedDate                        DATETIME         NOT NULL,
        ImportedAt                          DATETIME         DEFAULT GETDATE(),
        LoadId                              DATETIME         NOT NULL
    ) ON psSalesOrder(OrderDate) WITH (DATA_COMPRESSION = PAGE)
END
GO

CREATE CLUSTERED COLUMNSTORE INDEX ccfso ON DWH.FactSalesOrder
    
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_FactSalesOrder_SalesOrderHeaderId_SalesOrderDetailId ] ON DWH.FactSalesOrder( SalesOrderHeaderId, SalesOrderDetailId, OrderDate )

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DimSalesOrderHeader FOREIGN KEY(SalesOrderHeaderId)
REFERENCES DWH.DimSalesOrderHeader (SalesOrderHeaderId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DimSalesOrderHeader

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DimSalesOrderDetail FOREIGN KEY(SalesOrderDetailId)
REFERENCES DWH.DimSalesOrderDetail (SalesOrderDetailId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DimSalesOrderDetail

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_FactCurrencyRate_DimCurrency FOREIGN KEY(CurrencyId)
REFERENCES DWH.DimCurrency (CurrencyId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_FactCurrencyRate_DimCurrency

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_FactCurrencyRate FOREIGN KEY(CurrencyRateId)
REFERENCES DWH.FactCurrencyRate (CurrencyRateId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_FactCurrencyRate

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DimProduct FOREIGN KEY(ProductId)
REFERENCES DWH.DimProduct (ProductId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DimProduct

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DimCustomer FOREIGN KEY(CustomerId)
REFERENCES DWH.DimCustomer (CustomerId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DimCustomer

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DimSpecialOffer FOREIGN KEY(SpecialOfferId)
REFERENCES DWH.DimSpecialOffer (SpecialOfferId)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DimSpecialOffer

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_OrderDate FOREIGN KEY(OrderDate)
REFERENCES DWH.DimDate (Date)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_OrderDate

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_DueDate FOREIGN KEY(DueDate)
REFERENCES DWH.DimDate (Date)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_DueDate

ALTER TABLE DWH.FactSalesOrder  WITH CHECK ADD CONSTRAINT FK_DWH_FactSalesOrder_ShipDate FOREIGN KEY(ShipDate)
REFERENCES DWH.DimDate (Date)

ALTER TABLE DWH.FactSalesOrder CHECK CONSTRAINT FK_DWH_FactSalesOrder_ShipDate

GO
 
 
-- Tables of ETL 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'ProductClassMapping'
)
BEGIN
    CREATE TABLE ETL.ProductClassMapping(
        Code    CHAR(1) NOT NULL PRIMARY KEY,
        [Name]  NVARCHAR(20)
    )
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'ProductStyleMapping'
)
BEGIN
    CREATE TABLE ETL.ProductStyleMapping(
        Code    CHAR(1) NOT NULL PRIMARY KEY,
        [Name]  NVARCHAR(20)
    )
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'ProductLineMapping'
)
BEGIN
    CREATE TABLE ETL.ProductLineMapping(
        Code    CHAR(1) NOT NULL PRIMARY KEY,
        [Name]  NVARCHAR(20)
    )
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'BooleanMapping'
)
BEGIN
    CREATE TABLE ETL.BooleanMapping(
        Id           BIT NOT NULL PRIMARY KEY,
        OnlineOrder  NVARCHAR(18) NOT NULL
    )
END
GO
 
-- Objects of Source 
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimCustomer')
DROP VIEW Source.DimCustomer
GO
CREATE VIEW Source.DimCustomer AS
SELECT 
    CONVERT(NVARCHAR(50), C.CustomerID) AS CustomerCode,
    C.AccountNumber,
    --http://www.elsasoft.com/samples/sqlserver_adventureworks/SqlServer.SPRING.KATMAI.AdventureWorks/table_PersonContact.htm
    CASE WHEN P.PersonType = 'SC' THEN 'Store Contact'
         WHEN P.PersonType = 'IN' THEN 'Individual (retail) customer'
         WHEN P.PersonType = 'SP' THEN 'Sales person'
         WHEN P.PersonType = 'EM' THEN 'Employee (non-sales)'
         WHEN P.PersonType = 'VC' THEN 'Vendor contact'
         WHEN P.PersonType = 'GC' THEN 'General contact'
         ELSE 'Unknown'
    END AS PersonType,
    COALESCE(S.Name, 'Unknown ' + CASE WHEN ST.CountryRegionCode = 'US' THEN ST.[Name] + ' USA' ELSE ST.[Name] END) AS Store,
    CASE WHEN P.EmailPromotion = 0 THEN 'No Emails'
         WHEN P.EmailPromotion = 1 THEN 'Accepted from AdventureWorks'
         WHEN P.EmailPromotion = 2 THEN 'Accepted from AdventureWorks and partners'
         ELSE 'Unknown'
    END AS EmailPromotion,
    CASE WHEN ST.CountryRegionCode = 'US' THEN ST.[Name] + ' USA'
         ELSE                                  ST.[Name]
    END AS Region,
    C.ModifiedDate,
   (SELECT MAX(ModifiedDate)
    FROM (VALUES (C.ModifiedDate),(P.ModifiedDate),(S.ModifiedDate), (ST.ModifiedDate)) AS UpdateDate(ModifiedDate)) AS UpdatedDate,
    GetDate() AS ImportedAt
FROM      AdventureWorks2016_EXT.Sales.Customer       AS C
LEFT JOIN AdventureWorks2016_EXT.Person.Person        AS P  ON C.PersonID = P.BusinessEntityID
LEFT JOIN AdventureWorks2016_EXT.Sales.Store          AS S  ON C.StoreID  = S.BusinessEntityID
LEFT JOIN AdventureWorks2016_EXT.Sales.SalesTerritory AS ST ON C.TerritoryID = ST.TerritoryID
GO 

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
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimProduct')
DROP VIEW Source.DimProduct
GO
CREATE VIEW Source.DimProduct AS
SELECT
    DM.ProductID                                              AS ProductCode,
    DM.ProductNumber,
    DM.Name                                                   AS ProductName,
    CASE WHEN DM.MakeFlag=1 THEN 'Yes' ELSE 'No' END          AS MakeIntern,
    CASE WHEN DM.FinishedGoodsFlag=1 THEN 'Yes' ELSE 'No' END AS FinishedGood,                             
    COALESCE(DM.Color, 'Unknown')                             AS Color,
    DM.SafetyStockLevel,                      
    DM.ReorderPoint,                          
    DM.StandardCost,                          
    DM.ListPrice                                              AS SalesPrice,
    DM.Size,
    COALESCE(DM.SizeUnitMeasureCode, 'N/A')                   AS SizeUnitMeasureCode,
    COALESCE(DM.WeightUnitMeasureCode, 'N/A')                 AS WeightUnitMeasureCode,
    DM.[Weight],
    DM.DaysToManufacture,
    PLM.[Name]                                                AS ProductLine,
    PCM.[Name]                                                AS Class,
    PSM.[Name]                                                AS Style,
    COALESCE(PS.[Name], 'Unknown')                            AS ProductSubcategory,
    COALESCE(PC.[Name], 'Unknown')                            AS ProductCategory,
    COALESCE(PM.[Name], 'Unknown')                            AS ProductModel,
    DM.SellStartDate,
    DM.SellEndDate,
   (SELECT MAX(ModifiedDate)
    FROM (VALUES (DM.ModifiedDate),(PS.ModifiedDate),(PC.ModifiedDate), (PM.ModifiedDate)) AS UpdateDate(ModifiedDate)) AS ModifiedDate,
    GETDATE() AS ImportedAt
FROM       AdventureWorks2016CTP3.Production.Product                AS DM
INNER JOIN [ETL].[ProductLineMapping]                               AS PLM ON DM.ProductLine          = PLM.Code
INNER JOIN [ETL].[ProductClassMapping]                              AS PCM ON DM.Class                = PCM.Code
INNER JOIN [ETL].[ProductStyleMapping]                              AS PSM ON DM.Style                = PSM.Code
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductSubcategory] AS PS  ON DM.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductCategory]    AS PC  ON PS.ProductCategoryID    = PC.ProductCategoryID
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductModel]       AS PM  ON DM.ProductModelID       = PM.ProductModelID
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimSalesOrderDetail')
DROP VIEW Source.DimSalesOrderDetail
GO
CREATE VIEW Source.DimSalesOrderDetail AS
SELECT                   
    sod.SalesOrderDetailID,                                               
    ISNULL(sod.CarrierTrackingNumber, '')    AS CarrierTrackingNumber, 
    sod.[ModifiedDate]                       AS ModifiedDate
    --COALESCE(dc.CurrencyKey, (SELECT CurrencyKey FROM dbo.DimCurrency WHERE CurrencyAlternateKey = N'USD')) AS CurrencyKey, --Updated to match OLTP which uses the RateID not the currency code.
    --soh.TerritoryID AS SalesTerritoryKey, --DW key mapping to SalesTerritory
FROM AdventureWorks2016_EXT.Sales.SalesOrderDetail sod
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimSalesOrderHeader')
DROP VIEW Source.DimSalesOrderHeader
GO
CREATE VIEW Source.DimSalesOrderHeader AS
SELECT
    soh.SalesOrderId                                                                              AS SalesOrderHeaderId, 
    soh.SalesOrderNumber,                                                    
    oo.OnlineOrder                                                                                AS OnlineOrder,
    soh.Status                                                                                    AS StatusOrder,
    soh.RevisionNumber                                                                            AS RevisionNumber,
    ISNULL(soh.PurchaseOrderNumber, '')                                                           AS CustomerPONumber,
    soh.ModifiedDate                                                                              AS ModifiedDate
    --COALESCE(dc.CurrencyKey, (SELECT CurrencyKey FROM dbo.DimCurrency WHERE CurrencyAlternateKey = N'USD')) AS CurrencyKey, --Updated to match OLTP which uses the RateID not the currency code.
    --soh.TerritoryID AS SalesTerritoryKey, --DW key mapping to SalesTerritory
FROM            AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
LEFT OUTER JOIN ETL.BooleanMapping oo
    ON soh.OnlineOrderFlag = oo.Id
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimSpecialOffer')
DROP VIEW Source.DimSpecialOffer
GO
CREATE VIEW Source.DimSpecialOffer AS
SELECT 
    SpecialOfferID    AS SpecialOfferCode,
    [Description]     AS SpecialOffer,
    DiscountPct,
    [Type],
    Category,
    StartDate,
    EndDate,
    MinQty,
    ISNULL(MaxQty, 0) AS MaxQty,
    ModifiedDate
FROM 
    AdventureWorks2016_EXT.Sales.SpecialOffer
GO
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
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'FactSalesOrder')
DROP VIEW Source.FactSalesOrder
GO
CREATE VIEW Source.FactSalesOrder AS
SELECT
    dc.CurrencyId,
    ISNULL(soh.CurrencyRateID, -1)                                        AS CurrencyRateID,
    soh.SalesOrderNumber,
    soh.SalesOrderId                                                      AS SalesOrderHeaderId,                                                     
    sod.SalesOrderDetailID,                                               
    ROW_NUMBER() OVER ( PARTITION BY soh.SalesOrderNumber                 
                        ORDER BY sod.SalesOrderDetailID )                 AS OrderLineNumber,
    dp.ProductId,                                                         
    c.CustomerID,                                                       
    sod.SpecialOfferID                                                    AS SpecialOfferId,
    CONVERT(DATE, soh.OrderDate)                                          AS OrderDate,
    CONVERT(DATE, soh.DueDate)                                            AS DueDate,
    CONVERT(DATE, soh.ShipDate)                                           AS ShipDate,
    sod.OrderQty                                                          AS Quantity, 
    CONVERT(numeric(38, 6), sod.UnitPrice)                                AS UnitPrice,
    CONVERT(numeric(38, 6), sod.UnitPrice)  * CONVERT(numeric(38, 6), cr.EndOfDayRate ) AS UnitPriceLocalCurrency,
    CONVERT(numeric(38, 6), sod.UnitPriceDiscount)                        AS UnitPriceDiscountPct,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.TaxAmt)   ELSE 0 END AS TaxAmt,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.Freight)  ELSE 0 END AS Freight,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.TotalDue) ELSE 0 END AS TotalDue,
    CASE WHEN MIN(sod.SalesOrderDetailID) OVER (PARTITION BY soh.SalesOrderId) = sod.SalesOrderDetailID THEN CONVERT(numeric(38, 6), soh.SubTotal) ELSE 0 END AS SubTotal,
    sod.LineTotal                                                         AS SalesAmount,
    sod.LineTotal * CONVERT(numeric(38, 6), cr.EndOfDayRate)              AS SalesAmountLocalCurrency,
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice)                 AS OriginalSalesAmount, 
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), cr.EndOfDayRate)                                                   AS OriginalSalesAmountLocalCurrency,
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), sod.UnitPriceDiscount)                                             AS DiscountAmount, 
    sod.OrderQty * CONVERT(numeric(38, 6), sod.UnitPrice) * CONVERT(numeric(38, 6), sod.UnitPriceDiscount) * CONVERT(numeric(38, 6), cr.EndOfDayRate)  AS DiscountAmountLocalCurrency, 
    pch.StandardCost                                                      AS ProductStandardCost, 
    pch.StandardCost * CONVERT(numeric(38, 6), cr.EndOfDayRate)           AS ProductStandardCostLocalCurrency, 
    sod.OrderQty * CONVERT(numeric(38, 6), pch.StandardCost)              AS TotalProductCost,
    sod.OrderQty * pch.StandardCost * CONVERT(numeric(38, 6), cr.EndOfDayRate) AS TotalProductCostLocalCurrency,
    (SELECT MAX(ModDate) FROM (VALUES (soh.[ModifiedDate]), (sod.[ModifiedDate])) AS v (ModDate)) AS ModifiedDate
    --de.EmployeeKey AS EmployeeKey, --DW key mapping to Employee and SalesPerson
        --COALESCE(dc.CurrencyKey, (SELECT CurrencyKey FROM dbo.DimCurrency WHERE CurrencyAlternateKey = N'USD')) AS CurrencyKey, --Updated to match OLTP which uses the RateID not the currency code.
    --soh.TerritoryID AS SalesTerritoryKey, --DW key mapping to SalesTerritory
FROM       AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
INNER JOIN AdventureWorks2016_EXT.Sales.SalesOrderDetail sod 
    ON soh.SalesOrderID = sod.SalesOrderID 
INNER JOIN AdventureWorks2016_EXT.Production.Product p 
    ON sod.ProductID = p.ProductID 
INNER JOIN Datawarehouse.DWH.DimProduct dp 
    ON dp.ProductNumber = p.ProductNumber
INNER JOIN DWH.DimCustomer c 
    ON soh.CustomerId = c.CustomerCode
LEFT OUTER JOIN AdventureWorks2016_EXT.Production.ProductCostHistory pch 
    ON p.ProductID = pch.ProductID
       AND soh.OrderDate BETWEEN pch.StartDate AND pch.EndDate
LEFT OUTER JOIN DWH.FactCurrencyRate cr 
    ON ISNULL(soh.CurrencyRateID, -1) = cr.CurrencyRateID
LEFT OUTER JOIN DWH.DimCurrency dc 
    ON cr.CurrencyToId = dc.CurrencyId
--LEFT OUTER JOIN AdventureWorks2016_EXT.HumanResources.Employee e 
--    ON soh.SalesPersonID = e.BusinessEntityID 
--LEFT OUTER JOIN dbo.DimEmployee de 
--    ON e.NationalIDNumber = de.EmployeeNationalIDAlternateKey COLLATE SQL_Latin1_General_CP1_CI_AS 
--ORDER BY OrderDateKey, ResellerKey;
--AdventureWorks2016_EXT.Sales.SalesOrderHeader soh 
--INNER JOIN AdventureWorks2016_EXT.Sales.SalesOrderDetail
GO
 
-- Objects of Source 
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


IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimDate')
DROP VIEW ExtDWH.DimDate
GO
CREATE VIEW ExtDWH.DimDate
AS
SELECT 
    [Date]
    , [DayOfMonth]
    , DaySuffix
    , [DayCharacter]
    , [DayOfWeek]
    , [DayOfYear]
    , WeekOfYear
    , WeekOfYearName
    , [Month]
    , [MonthName]
    , MonthOfQuarter
    , [Quarter]
    , QuarterName
    , [DateName]
    , [Year]
    , YearName
    , MonthYear
    , IsWeekday
    , ImportedAt
FROM 
    DWH.DimDate
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimProduct')
DROP VIEW ExtDWH.DimProduct
GO
CREATE VIEW ExtDWH.DimProduct
AS
SELECT 
    ProductId
    , ProductCode
    , ProductNumber
    , ProductName
    , MakeIntern
    , FinishedGood
    , Color
    , SafetyStockLevel
    , ReorderPoint
    , StandardCost
    , SalesPrice
    , Size
    , SizeUnitMeasureCode
    , WeightUnitMeasureCode
    , [Weight]
    , DaysToManufacture
    , ProductLine
    , Class
    , Style
    , ProductSubcategory
    , ProductCategory
    , ProductModel
FROM
    DWH.DimProduct
GO
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
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimSpecialOffer')
DROP VIEW ExtDWH.DimSpecialOffer
GO
CREATE VIEW ExtDWH.DimSpecialOffer
AS
SELECT 
    SpecialOfferId
    , SpecialOfferCode
    , SpecialOffer
    , DiscountPct
    , [Type]
    , Category
    , MinQty
    , MaxQty
FROM
    DWH.DimSpecialOffer
GO


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

IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'FactSalesOrder')
DROP VIEW ExtDWH.FactSalesOrder
GO
CREATE VIEW ExtDWH.FactSalesOrder
AS
SELECT
    CurrencyId
    , CurrencyRateId
    , SalesOrderNumber
    , SalesOrderHeaderId
    , SalesOrderDetailId
    , OrderLineNumber
    , ProductId
    , CustomerId
    --, StatusOrderId
    , SpecialOfferId
    --, RevisionNumber
    --, CarrierTrackingNumber
    --, CustomerPONumber
    --, LocalCurrency
    , OrderDate
    , DueDate
    , ShipDate
    , Quantity
    , UnitPrice
    , UnitPriceLocalCurrency
    , UnitPriceDiscountPct
    , TaxAmt
    , Freight
    , TotalDue
    , SubTotal
    , SalesAmount
    , SalesAmountLocalCurrency
    , OriginalSalesAmount
    , OriginalSalesAmountLocalCurrency
    , DiscountAmount
    , DiscountAmountLocalCurrency
    , ProductStandardCost
    , ProductStandardCostLocalCurrency
    , TotalProductCost
    , TotalProductCostLocalCurrency
FROM
    DWH.FactSalesOrder
GO
 
-- Objects of Logging 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA='Logging'
      AND TABLE_NAME  ='ETL_Loading')
BEGIN
    CREATE TABLE Logging.ETL_Loading(
        ProcessName            NVARCHAR(50)    NOT NULL,
        StartDate              DATETIME        NOT NULL,
        EndDate                DATETIME        NOT NULL,
        Duration               INTEGER         NOT NULL,
        Inserts                INTEGER         NOT NULL,
        Updates                INTEGER         NOT NULL,
        Success                BIT             NOT NULL, 
        ErrorNumber            INTEGER         NULL,
        ErrorMessage           NVARCHAR(4000)  NULL,
        LoadId                 DATETIME        NOT NULL, -- Key all loads
    )
END
GO
 
-- Objects of ETL 
INSERT INTO ETL.ProductClassMapping(
    Code,
    [Name])
VALUES
    ('U', 'Unknown'),
    ('H', 'High'),
    ('M', 'Medium'),
    ('L', 'Low')
GO
INSERT INTO ETL.ProductStyleMapping(
    Code,
    [Name]) 
VALUES
    ('U', 'Unknown'),
    ('W', 'Women''s'),
    ('M', 'Men''s'),
    ('L', 'Universal')
GO
INSERT INTO ETL.ProductLineMapping(
    Code,
    [Name])
VALUES
    ('U', 'Unknown'),
    ('R', 'Road'),
    ('M', 'Mountain'),
    ('T', 'Touring'),
    ('S', 'Standard')
GO
WITH Q_StatusOrder AS(
    SELECT 1 AS StatusOrderId, 'In process' AS StatusOrder UNION ALL
    SELECT 2, 'Approved'UNION ALL
    SELECT 3, 'Back ordered'UNION ALL
    SELECT 4, 'Rejected'UNION ALL
    SELECT 5, 'Shipped'UNION ALL
    SELECT 6, 'Canceled'
)
INSERT INTO DWH.DimStatusOrder(
                StatusOrderId,
                StatusOrder )
SELECT *
FROM Q_StatusOrder AS Q
WHERE NOT EXISTS(
    SELECT 1
    FROM DWH.DimStatusOrder AS d
    WHERE Q.StatusOrderId = d.StatusOrderId
          AND Q.StatusOrder = d.StatusOrder )
GO
INSERT INTO ETL.BooleanMapping(
    Id,
    OnlineOrder)
VALUES
    (0, 'Not Online'),
    (1, 'Online')
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_DimCustomer'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_DimCustomer
GO
CREATE PROC ETL.Load_DWH_DimCustomer
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName        NVARCHAR(50) = 'DimCustomer'
        , @Inserts            INT
        , @Updates            INT
        , @LoadFrom           DATETIME
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            NVARCHAR(5)
        , @LoadId_            DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SET NOCOUNT ON;

    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.DimCustomer WITH(NOLOCK)
    
    BEGIN TRY
        BEGIN TRANSACTION
    
            SELECT
                Source.CustomerCode
                , COALESCE( Datawarehouse.AccountNumber, Source.AccountNumber) AS AccountNumber
                , COALESCE( Datawarehouse.PersonType, Source.PersonType)       AS PersonType
                , CASE 
                    WHEN ( Source.Store != Datawarehouse.Store OR Source.EmailPromotion != Datawarehouse.EmailPromotion )
                         AND Source.Region != Datawarehouse.Region
                        THEN 'SCD 1 and SCD 2'
                    WHEN ( Source.Store != Datawarehouse.Store OR Source.EmailPromotion != Datawarehouse.EmailPromotion )
                        THEN 'SCD 1'
                    WHEN Source.Region != Datawarehouse.Region
                        THEN 'SCD 2'
                    WHEN Datawarehouse.CustomerCode IS NULL
                        THEN 'New Customer'
                END AS StatusLoad
                , Source.Store
                , Source.EmailPromotion
                , Source.Region
                , Source.ModifiedDate
                , Source.ImportedAt
            INTO #LoadCustomers
            FROM      Source.DimCustomer  AS Source
            LEFT JOIN DWH.DimCustomer     AS Datawarehouse  ON source.CustomerCode = Datawarehouse.CustomerCode
                                                               AND Datawarehouse.[Status] = 'Current'
            WHERE
                -- SC1 
                ( Source.Store != Datawarehouse.Store 
                OR Source.EmailPromotion != Datawarehouse.EmailPromotion
                -- SC2
                OR Source.Region != Datawarehouse.Region
                -- New Customer
                OR Datawarehouse.CustomerCode IS NULL)
                AND Source.ModifiedDate >= @LoadFrom
            
            -- IF SCD 1 UPDATE Store and EmailPromotion with new values
            UPDATE DWH.DimCustomer
            SET Store            = Source.Store
                , EmailPromotion = Source.EmailPromotion
                , ModifiedDate   = Source.ModifiedDate
                , LoadId = @LoadId_ 
            FROM       DWH.DimCustomer AS DataWarehouse_DimCustomer
            INNER JOIN #LoadCustomers  AS Source ON DataWarehouse_DimCustomer.CustomerCode = Source.CustomerCode
            WHERE
                Source.StatusLoad = 'SCD 1 and SCD 2'
                OR Source.StatusLoad = 'SCD 1';

            SET @Updates = @@ROWCOUNT
            
            -- IF SCD 2 UPDATE EndDate with ModifiedDate and Status with NULL where Status = 'Current'
            UPDATE DWH.DimCustomer
            SET EndDate    = Source.ModifiedDate
                , [Status] = NULL
                , LoadId = @LoadId_
            FROM       DWH.DimCustomer AS DataWarehouse_DimCustomer
            INNER JOIN #LoadCustomers  AS Source ON DataWarehouse_DimCustomer.CustomerCode = Source.CustomerCode 
                                                    AND DataWarehouse_DimCustomer.[Status] = 'Current'
            WHERE
                Source.StatusLoad = 'SCD 1 and SCD 2'
                OR Source.StatusLoad = 'SCD 2'

            SET @Updates = @Updates + @@ROWCOUNT
            
            -- IF SC2 or new customer INSERT
            INSERT INTO DWH.DimCustomer(
                CustomerCode
                , AccountNumber
                , PersonType
                , Store
                , EmailPromotion
                , Region
                , StartDate
                , EndDate
                , [Status]
                , ModifiedDate
                , LoadId
            )
            SELECT
                Source.CustomerCode
                , Source.AccountNumber
                , Source.PersonType
                , Source.Store
                , Source.EmailPromotion
                , Source.Region
                , Source.ModifiedDate
                , NULL
                , 'Current'
                , Source.ModifiedDate
                , @LoadId_
            FROM #LoadCustomers AS Source
            WHERE
                Source.StatusLoad = 'SCD 1 and SCD 2'
                OR Source.StatusLoad = 'SCD 2'
                OR Source.StatusLoad = 'New Customer'

            SET @Inserts = @@ROWCOUNT
            
            SELECT 
                @EndDate = GETDATE()
                , @Success = 'True'
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate
                , EndDate
                , Inserts
                , Updates 
                , Duration   
                , Success
                , LoadId
            ) 
            SELECT
                @ProcessName
                , @StartDate
                , @EndDate
                , @Inserts
                , @Updates
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_

            COMMIT
    
    END TRY
    
    BEGIN CATCH
        
        ROLLBACK
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_
    
    END CATCH
END
GO
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_DimDate'
          AND SPECIFIC_SCHEMA  = 'ETL')
DROP PROC ETL.Load_DWH_DimDate
GO
CREATE PROC ETL.Load_DWH_DimDate
    @LoadTo DATETIME = NULL
AS
BEGIN
    DECLARE
        @LoadFrom             DATETIME
        , @StartDate          DATETIME     = GetDate()
        , @EndDate            DATETIME
        , @Insert             INT
        , @LoadFromDefault    DATETIME     = CONVERT(DATETIME, '01.01.2011', 104)
        , @ETLName            NVARCHAR(50) = 'DimDate'
        , @Success            NVARCHAR(5);

    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION

        -- One day after the maximum date in the table
        -- If there is no data in the table start with the default start date
        SELECT 
            @LoadFrom = COALESCE(DATEADD(dd, 1, MAX([Date])), @LoadFromDefault)
            , @LoadTo = ISNULL( @LoadTo, GETDATE())
        FROM
            DWH.DimDate

        IF ( @LoadFrom >= @LoadTo )
        BEGIN
            RAISERROR ('LoadTo Date parameter is already loaded', 16, 0) WITH NOWAIT;
        END
        ELSE
        BEGIN
            SET @Success = 'True'
        END;

            ;WITH ctedaterange AS (
                SELECT [Date]=@LoadFrom 
                UNION ALL
                SELECT [Date] + 1 
                FROM   ctedaterange 
                WHERE  [Date] + 1 <= @LoadTo
            )
            INSERT DWH.[DimDate]
            (
                [Date]    
                , [DateName]    
                , [DayOfMonth] 
                , DaySuffix     
                , [DayCharacter]    
                , [DayOfWeek]  
                , [DayOfYear]
                , WeekOfYear
                , WeekOfYearName
                , MonthId
                , [Month]
                , [MonthName]
                , MonthOfQuarter
                , [QuarterId]
                , [Quarter]
                , QuarterName
                , [Year]
                , YearName
                , MonthYear
                , IsWeekday
            )
            SELECT
                CONVERT(DATE, [Date])                                                                           AS [Date]
                , CONVERT(NVARCHAR(10), CONVERT(DATE, [Date]))                                                  AS [DateName]
                , DATEPART(DD, [Date])                                                                          AS [DayOfMonth]
                --Apply Suffix values like 1st, 2nd 3rd etc..                                                   
                , CASE                                                                                          
                    WHEN DATEPART(DD, [Date]) IN (11,12,13)                                                     
                        THEN CAST(DATEPART(DD, [Date]) AS VARCHAR) + 'th'                                       
                    WHEN RIGHT(DATEPART(DD, [Date]),1) = 1                                                      
                        THEN CAST(DATEPART(DD, [Date]) AS VARCHAR) + 'st'                                       
                    WHEN RIGHT(DATEPART(DD, [Date]),1) = 2                                                      
                        THEN CAST(DATEPART(DD, [Date]) AS VARCHAR) + 'nd'                                       
                    WHEN RIGHT(DATEPART(DD, [Date]),1) = 3                                                      
                        THEN CAST(DATEPART(DD, [Date]) AS VARCHAR) + 'rd'                                       
                    ELSE CAST(DATEPART(DD, [Date]) AS VARCHAR) + 'th'                                           
                  END                                                                                           AS DaySuffix
                , DATENAME(DW, [Date])                                                                          AS [DayCharacter]
                , DATEPART(DW, [Date])                                                                          AS [DayOfWeek]
                , DATEPART(DY, [Date])                                                                          AS [DayOfYear]
                , DATEPART(WW, [Date])                                                                          AS WeekOfYear
                , CONVERT(VARCHAR(4), DATEPART(YEAR, [Date])) + '-'+ CONVERT(NVARCHAR(2),DATEPART(WW, [Date]))  AS WeekOfYearName
                , DATEPART(YEAR, [Date])*100 + DATEPART(MM, [Date])                                             AS MonthId
                , DATEPART(MM, [Date])                                                                          AS [Month]
                , CONVERT(VARCHAR(7), [Date], 126)                                                              AS [MonthName]
                , CASE                                                                                          
                    WHEN DATEPART(MM, [Date]) IN (1, 4, 7, 10) THEN 1                                           
                    WHEN DATEPART(MM, [Date]) IN (2, 5, 8, 11) THEN 2                                           
                    WHEN DATEPART(MM, [Date]) IN (3, 6, 9, 12) THEN 3                                           
                  END                                                                                           AS MonthOfQuarter
                , DATEPART(YEAR, [Date])*100  + DATEPART(QQ, [Date])                                            AS [QuarterId]
                , DATEPART(QQ, [Date])                                                                          AS [Quarter]
                , CONVERT(VARCHAR(4), DATEPART(YEAR, [Date]))+'-Q' + CONVERT(NVARCHAR(1), DATEPART(QQ, [Date])) AS QuarterName
                , DATEPART(YEAR, [Date])                                                                        AS [Year]
                , CONVERT(VARCHAR(4), DATEPART(YEAR, [Date]))                                                   AS YearName
                , LEFT(DATENAME(MM, [Date]), 3) + '-' + CONVERT(VARCHAR, DATEPART(YY, [Date]))                  AS MonthYear
                , CASE 
                    WHEN 
                        DATEPART(DW, [Date]) BETWEEN 1 AND 5
                            THEN 1
                    ELSE 0
                END                                                                                             AS IsWeekday
            FROM ctedaterange
            OPTION(MAXRECURSION 0);
            
            SELECT 
                @EndDate = GetDate(),
                @Insert = @@ROWCOUNT
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate   
                , EndDate 
                , Duration
                , Inserts
                , Updates    
                , Success
                , LoadId
            ) 
            SELECT
                @ETLName
                , @StartDate
                , @EndDate
                , DATEDIFF(millisecond,@StartDate, @EndDate)
                , @Insert
                , 0
                , @Success
                , GETDATE()
            
            COMMIT
    
    END TRY
    
    BEGIN CATCH

        ROLLBACK
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Duration
            , Inserts
            , Updates
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId 
        ) 
        SELECT
            @ETLName
            , @StartDate
            , @EndDate
            , DATEDIFF(millisecond,@StartDate, @EndDate)
            , 0
            , 0
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , GETDATE()
    
    END CATCH
END
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_DimCurrency'
          AND SPECIFIC_SCHEMA  = 'ETL')
DROP PROC ETL.Load_DWH_DimCurrency
GO
CREATE PROC ETL.Load_DWH_DimCurrency
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName          NVARCHAR(50) = 'DimCurrency'
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Inserts            INT          = 0
        , @Updates            INT          = 0
        , @Success            BIT          = 'True'
        , @LoadId_            DATETIME     = ISNULL(@LoadId, GETDATE())
    
    SET NOCOUNT ON;

    BEGIN TRY

        BEGIN TRANSACTION
            -- Test DECLARE @RaiseError INT = 1/0  Result expected
            INSERT INTO DWH.DimCurrency(
                CurrencyCode
                , CurrencyName
                , ImportedAt
                , LoadId
            )
            SELECT 
                CurrencyCode
                , [Name]
                , GETDATE()
                , @LoadId_
            FROM AdventureWorks2016CTP3.Sales.Currency AS Source
            WHERE NOT EXISTS(
                SELECT 1
                FROM DWH.DimCurrency AS Datawarehouse
                WHERE Datawarehouse.CurrencyCode = Source.CurrencyCode);
            
            SELECT 
                @Inserts = @@ROWCOUNT
                , @EndDate = GETDATE()
            
            -- Test DECLARE @RaiseError INT = 1/0  Result expected
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate  
                , EndDate
                , Duration
                , Inserts
                , Updates  
                , Success
                , LoadId
            ) 
            SELECT
                @ProcessName
                , @StartDate
                , @EndDate
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Inserts
                , @Updates
                , @Success
                , @LoadId_

            COMMIT

    END TRY

    BEGIN CATCH

        ROLLBACK

        SELECT
            @EndDate = GETDATE(),
            @Success = 'False',
            @Inserts = 0
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName   
            , StartDate   
            , EndDate
            , Duration 
            , Inserts
            , Updates
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId

        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Inserts
            , @Updates
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_

    END CATCH

END
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_DimProduct'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_DimProduct
GO
CREATE PROC ETL.Load_DWH_DimProduct
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName            NVARCHAR(50) = 'DimProduct'
        , @LoadFrom             DATETIME
        , @StartDate            DATETIME     = GETDATE()
        , @EndDate              DATETIME
        , @Success              BIT          = 'True'
        , @LoadId_              DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.DimSalesOrderDetail WITH(NOLOCK)

        CREATE TABLE #InsertsUpdates( 
        ChangeType VARCHAR(25)
    )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
    
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION

            MERGE  DWH.DimProduct    AS [Target]
            USING ( SELECT * FROM Source.DimProduct WHERE ModifiedDate >= @LoadFrom) AS [Source]
            ON (Source.ProductNumber = [Target].ProductNumber)
            WHEN NOT MATCHED BY TARGET
                THEN INSERT(
                         ProductCode
                         , ProductNumber
                         , ProductName
                         , MakeIntern
                         , FinishedGood
                         , Color
                         , SafetyStockLevel
                         , ReorderPoint
                         , StandardCost
                         , SalesPrice
                         , Size
                         , SizeUnitMeasureCode
                         , WeightUnitMeasureCode
                         , [Weight]
                         , DaysToManufacture
                         , ProductLine
                         , Class
                         , Style
                         , ProductSubcategory
                         , ProductCategory
                         , ProductModel
                         , SellStartDate
                         , SellEndDate
                         , ImportedAt
                         , ModifiedDate
                         , LoadId)
                     VALUES(
                         [Source].ProductCode
                         , [Source].ProductNumber
                         , [Source].ProductName
                         , [Source].MakeIntern
                         , [Source].FinishedGood
                         , [Source].Color
                         , [Source].SafetyStockLevel
                         , [Source].ReorderPoint
                         , [Source].StandardCost
                         , [Source].SalesPrice
                         , [Source].Size
                         , [Source].SizeUnitMeasureCode
                         , [Source].WeightUnitMeasureCode
                         , [Source].[Weight]
                         , [Source].DaysToManufacture
                         , [Source].ProductLine
                         , [Source].Class
                         , [Source].Style
                         , [Source].ProductSubcategory
                         , [Source].ProductCategory
                         , [Source].ProductModel
                         , [Source].SellStartDate
                         , [Source].SellEndDate
                         , SOURCE.ImportedAt
                         , SOURCE.ModifiedDate
                         , @LoadId_ )
            WHEN MATCHED AND (Source.ProductNumber = [Target].ProductNumber)
             AND (       [Target].ProductCode !=              [Source].ProductCode
                         OR [Target].ProductName !=           [Source].ProductName
                         OR [Target].MakeIntern !=            [Source].MakeIntern
                         OR [Target].FinishedGood !=          [Source].FinishedGood
                         OR [Target].Color !=                 [Source].Color
                         OR [Target].SafetyStockLevel !=      [Source].SafetyStockLevel
                         OR [Target].ReorderPoint !=          [Source].ReorderPoint
                         OR [Target].StandardCost !=          [Source].StandardCost
                         OR [Target].SalesPrice !=            [Source].SalesPrice
                         OR [Target].Size !=                  [Source].Size
                         OR [Target].SizeUnitMeasureCode !=   [Source].SizeUnitMeasureCode
                         OR [Target].WeightUnitMeasureCode != [Source].WeightUnitMeasureCode
                         OR [Target].[Weight] !=              [Source].[Weight]
                         OR [Target].DaysToManufacture !=     [Source].DaysToManufacture
                         OR [Target].ProductLine !=           [Source].ProductLine
                         OR [Target].Class !=                 [Source].Class
                         OR [Target].Style !=                 [Source].Style
                         OR [Target].ProductSubcategory !=    [Source].ProductSubcategory
                         OR [Target].ProductModel !=          [Source].ProductModel
                         OR [Target].SellStartDate !=         [Source].SellStartDate
                         OR [Target].SellEndDate !=           [Source].SellEndDate )
                THEN UPDATE SET
                         ProductCode =           [Source].ProductCode
                         , ProductName =           [Source].ProductName
                         , MakeIntern =            [Source].MakeIntern
                         , FinishedGood =          [Source].FinishedGood
                         , Color =                 [Source].Color
                         , SafetyStockLevel =      [Source].SafetyStockLevel
                         , ReorderPoint =          [Source].ReorderPoint
                         , StandardCost =          [Source].StandardCost
                         , SalesPrice =            [Source].SalesPrice
                         , Size =                  [Source].Size
                         , SizeUnitMeasureCode =   [Source].SizeUnitMeasureCode
                         , WeightUnitMeasureCode = [Source].WeightUnitMeasureCode
                         , [Weight] =              [Source].[Weight]
                         , DaysToManufacture =     [Source].DaysToManufacture
                         , ProductLine =           [Source].ProductLine
                         , Class =                 [Source].Class
                         , Style =                 [Source].Style
                         , ProductSubcategory =    [Source].ProductSubcategory
                         , ProductModel =          [Source].ProductModel
                         , SellStartDate =         [Source].SellStartDate
                         , SellEndDate =           [Source].SellEndDate
                         , ImportedAt =            [Source].ImportedAt
                         , ModifiedDate =          [Source].ModifiedDate
                         , LoadId =                @LoadId_ 
            OUTPUT $action INTO #InsertsUpdates( ChangeType );;
            
            SELECT 
                @EndDate = GETDATE()
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate 
                , EndDate  
                , Inserts
                , Updates
                , Duration  
                , Success
                , LoadId
            ) 
            SELECT
                @ProcessName
                , @StartDate
                , @EndDate
                , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
                , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_
            FROM #InsertsUpdates

            COMMIT
    
    END TRY
    
    BEGIN CATCH
        
        ROLLBACK

        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName 
            , StartDate   
            , EndDate 
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_
    
    END CATCH
END
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE SPECIFIC_SCHEMA = 'ETL'
      AND SPECIFIC_NAME = 'Load_DWH_DimSalesOrderDetail')
DROP PROC ETL.Load_DWH_DimSalesOrderDetail
GO
CREATE PROC ETL.Load_DWH_DimSalesOrderDetail
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName         NVARCHAR(50) = 'DimSalesOrderDetail'
        , @LoadFrom          DATETIME
        , @StartDate         DATETIME     = GetDate()
        , @EndDate           DATETIME
        , @ModifiedDate      DATETIME
        , @Success           BIT          = 'True'
        , @LoadId_           DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SET NOCOUNT ON;
    
    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.DimSalesOrderDetail WITH(NOLOCK)

    CREATE TABLE #InsertsUpdates( 
         ChangeType VARCHAR(25)
     )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
    
    BEGIN TRY
        BEGIN TRANSACTION
    
            MERGE DWH.DimSalesOrderDetail AS TARGET
            USING ( SELECT
                        SalesOrderDetailID
                        , CarrierTrackingNumber
                        , ModifiedDate 
                    FROM Source.DimSalesOrderDetail WITH(NOLOCK)
                    WHERE ModifiedDate >= @LoadFrom ) AS SOURCE
            ON (TARGET.SalesOrderDetailID = SOURCE.SalesOrderDetailID)
            WHEN MATCHED 
             AND SOURCE.CarrierTrackingNumber <> TARGET.CarrierTrackingNumber
             OR  SOURCE.ModifiedDate          <> TARGET.ModifiedDate
            THEN UPDATE 
                SET TARGET.CarrierTrackingNumber = SOURCE.CarrierTrackingNumber
                    , TARGET.ImportedAt       = GETDATE()
                    , TARGET.ModifiedDate     = SOURCE.ModifiedDate
                    , TARGET.LoadId           = @LoadId_
            WHEN NOT MATCHED BY TARGET
            THEN INSERT ( SalesOrderDetailID
                          , CarrierTrackingNumber
                          , ImportedAt
                          , ModifiedDate 
                          , LoadId )
            VALUES( SOURCE.SalesOrderDetailID
                    , SOURCE.CarrierTrackingNumber
                    , GETDATE()
                    , SOURCE.ModifiedDate
                    , @LoadId_  )
            OUTPUT $action 
            INTO #InsertsUpdates( ChangeType );
            
            SET @EndDate = GETDATE()
            
            INSERT INTO Logging.ETL_Loading(
                            ProcessName
                            , StartDate  
                            , EndDate
                            , Inserts   
                            , Updates                
                            , Duration
                            , Success
                            , LoadId )
            SELECT 
                @ProcessName
                , @StartDate
                , @EndDate
                , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
                , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_
            FROM #InsertsUpdates;
            
            COMMIT
    
    END TRY
    
    BEGIN CATCH
    
        ROLLBACK

        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName   
            , StartDate   
            , EndDate
            , Inserts
            , Updates 
            , Duration 
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_

    END CATCH
    
END
GO
IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE SPECIFIC_SCHEMA = 'ETL'
      AND SPECIFIC_NAME = 'Load_DWH_DimSalesOrderHeader')
DROP PROC ETL.Load_DWH_DimSalesOrderHeader
GO
CREATE PROC ETL.Load_DWH_DimSalesOrderHeader 
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName         NVARCHAR(50) = 'DimSalesOrderHeader'
        , @LoadFrom          DATETIME
        , @StartDate         DATETIME     = GetDate()
        , @EndDate           DATETIME
        , @Success           BIT          = 'True'
        , @LoadId_           DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SET NOCOUNT ON;
    
    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.DimSalesOrderHeader WITH(NOLOCK)

    CREATE TABLE #InsertsUpdates( 
         ChangeType VARCHAR(25)
     )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
    
    BEGIN TRY
        BEGIN TRANSACTION
    
            MERGE DWH.DimSalesOrderHeader AS TARGET
            USING ( SELECT
                        SalesOrderHeaderId
                        , SalesOrderNumber
                        , OnlineOrder
                        , StatusOrder
                        , RevisionNumber
                        , CustomerPONumber
                        , ModifiedDate 
                    FROM Source.DimSalesOrderHeader WITH(NOLOCK)
                    WHERE ModifiedDate >= @LoadFrom ) AS SOURCE
            ON (TARGET.SalesOrderHeaderID = SOURCE.SalesOrderHeaderID)
            WHEN MATCHED 
             AND SOURCE.SalesOrderNumber   <> TARGET.SalesOrderNumber
             OR  SOURCE.OnlineOrder        <> TARGET.OnlineOrder
             OR  SOURCE.StatusOrder        <> TARGET.StatusOrder
             OR  SOURCE.RevisionNumber     <> TARGET.RevisionNumber
             OR  SOURCE.CustomerPONumber   <> TARGET.CustomerPONumber
             OR  SOURCE.ModifiedDate       <> TARGET.ModifiedDate
            THEN UPDATE 
                SET TARGET.SalesOrderNumber   = SOURCE.SalesOrderNumber
                    , TARGET.OnlineOrder      = SOURCE.OnlineOrder
                    , TARGET.StatusOrder      = SOURCE.StatusOrder 
                    , TARGET.RevisionNumber   = SOURCE.RevisionNumber 
                    , TARGET.CustomerPONumber = SOURCE.CustomerPONumber
                    , TARGET.ImportedAt       = GETDATE()
                    , TARGET.ModifiedDate     = SOURCE.ModifiedDate
                    , TARGET.LoadId           = @LoadId_
            WHEN NOT MATCHED BY TARGET
            THEN INSERT ( SalesOrderHeaderID
                          , SalesOrderNumber
                          , OnlineOrder
                          , StatusOrder
                          , RevisionNumber
                          , CustomerPONumber
                          , ImportedAt
                          , ModifiedDate
                          , LoadId )
            VALUES( SOURCE.SalesOrderHeaderID
                    , SOURCE.SalesOrderNumber
                    , SOURCE.OnlineOrder
                    , SOURCE.StatusOrder
                    , SOURCE.RevisionNumber
                    , SOURCE.CustomerPONumber
                    , GETDATE()
                    , SOURCE.ModifiedDate
                    , @LoadId_ )
            OUTPUT $action 
            INTO #InsertsUpdates( ChangeType );
            
            SET @EndDate = GETDATE()
            
            INSERT INTO Logging.ETL_Loading(
                            ProcessName
                            , StartDate  
                            , EndDate
                            , Inserts   
                            , Updates                 
                            , Duration
                            , Success
                            , LoadId )
            SELECT 
                @ProcessName
                , @StartDate
                , @EndDate
                , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
                , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_
            FROM #InsertsUpdates;
            
            COMMIT
       END TRY
    
    BEGIN CATCH
    
        ROLLBACK

        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName   
            , StartDate   
            , EndDate
            , Duration 
            , Inserts
            , Updates 
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , 0
            , 0
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_

    END CATCH

END
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_DimSpecialOffer'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_DimSpecialOffer
GO
CREATE PROC ETL.Load_DWH_DimSpecialOffer
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName          NVARCHAR(50) = 'DimSpecialOffer'
        , @LoadFrom           DATETIME
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            BIT          = 'True'
        , @LoadId_            DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.DimSpecialOffer WITH(NOLOCK)
    
    CREATE TABLE #InsertsUpdates( 
        ChangeType VARCHAR(25)
    )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)
    
    SET NOCOUNT ON;

    BEGIN TRY
        BEGIN TRANSACTION
        
            -- Store and EmailPromotion are Slowly Changing Dimension Type 1, the other fields are Slowly Changing Dimension Type 0
           
            MERGE DWH.DimSpecialOffer      AS [Target]
            USING ( 
                SELECT
                    SpecialOfferCode
                    , SpecialOffer
                    , DiscountPct
                    , [Type]
                    , Category
                    , StartDate
                    , EndDate
                    , MinQty
                    , MaxQty
                    , ModifiedDate
                FROM
                    [Source].DimSpecialOffer
                WHERE
                    ModifiedDate >= @LoadFrom ) AS [Source]
            ON ( [Target].SpecialOfferCode = [Source].SpecialOfferCode )
            WHEN NOT MATCHED THEN
                INSERT(
                    SpecialOfferCode
                    , SpecialOffer
                    , DiscountPct
                    , [Type]
                    , Category
                    , StartDate
                    , EndDate
                    , MinQty
                    , MaxQty
                    , ModifiedDate
                    , ImportedAt
                    , LoadId
                    )
            VALUES
                ( [Source].SpecialOfferCode
                  , [Source].SpecialOffer
                  , [Source].DiscountPct
                  , [Source].[Type]
                  , [Source].Category
                  , [Source].StartDate
                  , [Source].EndDate
                  , [Source].MinQty
                  , [Source].MaxQty
                  , ModifiedDate
                  , GETDATE()
                  , @LoadId_ )
            WHEN MATCHED AND ( [Source].SpecialOffer   != [Target].SpecialOffer
                               OR [Source].DiscountPct != [Target].DiscountPct
                               OR [Source].[Type]      != [Target].[Type]
                               OR [Source].Category    != [Target].Category
                               OR [Source].StartDate   != [Target].StartDate
                               OR [Source].EndDate     != [Target].EndDate
                               OR [Source].MinQty      != [Target].MinQty
                               OR [Source].MaxQty      != [Target].MaxQty )
            THEN
                UPDATE SET 
                    SpecialOffer   = [Source].SpecialOffer
                    , DiscountPct  = [Source].DiscountPct
                    , [Type]       = [Source].[Type]
                    , Category     = [Source].Category
                    , StartDate    = [Source].StartDate
                    , EndDate      = [Source].EndDate
                    , MinQty       = [Source].MinQty
                    , MaxQty       = [Source].MaxQty
                    , ModifiedDate = [Source].ModifiedDate
                    , ImportedAt   = GETDATE()
                    , LoadId       = @LoadId_ 
                OUTPUT $action 
                INTO #InsertsUpdates( ChangeType );
            
            SELECT 
                @EndDate = GETDATE()
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate
                , EndDate
                , Inserts
                , Updates
                , Duration
                , Success
                , LoadId
            ) 
            SELECT
                @ProcessName
                , @StartDate
                , @EndDate
                , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
                , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_
            FROM #InsertsUpdates;
            
            COMMIT
    
    END TRY
    
    BEGIN CATCH

        ROLLBACK
    
        SELECT
            @EndDate = GETDATE()
            , @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(second,@StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId
    
    END CATCH
END
GO
IF EXISTS (
    SELECT 1
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_FactCurrencyRate'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_FactCurrencyRate
GO
CREATE PROC ETL.Load_DWH_FactCurrencyRate
    @LoadId DATETIME = NULL
AS
BEGIN

    DECLARE
        @ProcessName              NVARCHAR(50) = 'FactCurrencyRate'
        , @LoadFrom               DATETIME
        , @StartDate              DATETIME     = GETDATE()
        , @EndDate                DATETIME
        , @Success                BIT          = 'True'
        , @LoadId_                DATETIME     = ISNULL(@LoadId, GETDATE())
        , @StandardCurrencyId     INTEGER
        , @CountFactCurrencyRate  INTEGER

    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.FactCurrencyRate WITH(NOLOCK)
    
    CREATE TABLE #InsertsUpdates( 
        ChangeType VARCHAR(25)
    )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

    SET NOCOUNT ON;
    
    BEGIN TRY
        BEGIN TRANSACTION
        
            SELECT @StandardCurrencyId = CurrencyId FROM DWH.DimCurrency WHERE CurrencyCode='USD'

            SELECT @CountFactCurrencyRate = COUNT(*) FROM DWH.FactCurrencyRate

            IF (@CountFactCurrencyRate = 0)
            BEGIN
                -- If it's null, we suppose it is the standard currency
                INSERT INTO DWH.FactCurrencyRate(
                                CurrencyRateId
                                , CurrencyFromId
                                , CurrencyToId 
                                , [Date]
                                , AverageRate
                                , EndOfDayRate
                                , ModifiedDate)
                SELECT
                    -1
                    , @StandardCurrencyId
                    , @StandardCurrencyId
                    , NULL
                    , 1
                    , 1 
                    , CONVERT(DATETIME, '1753-01-01 00:00:00.000')
            END;          


        WITH Q_Source AS(
            SELECT
                SourceCurrencyRate.CurrencyRateId
                , SourceCurrencyRate.CurrencyRateDate
                , FromCurrency.CurrencyId                 AS CurrencyIdFrom
                , ToCurrency.CurrencyId                   AS CurrencyIdTo
                , SourceCurrencyRate.AverageRate
                , SourceCurrencyRate.EndOfDayRate
                , SourceCurrencyRate.ModifiedDate
            FROM 
                      Source.FactCurrencyRate AS SourceCurrencyRate
            LEFT JOIN DWH.DimCurrency         AS FromCurrency          ON SourceCurrencyRate.FromCurrencyCode = FromCurrency.CurrencyCode
            LEFT JOIN DWH.DimCurrency         AS ToCurrency            ON SourceCurrencyRate.ToCurrencyCode   = ToCurrency.CurrencyCode
            WHERE SourceCurrencyRate.ModifiedDate >= @LoadFrom
        )
        MERGE DWH.FactCurrencyRate AS [Target]
        USING Q_Source             AS [Source]
        ON ([Source].CurrencyRateId  = [Target].CurrencyRateId)
        WHEN NOT MATCHED BY TARGET
            THEN INSERT(
                     CurrencyRateId
                     , CurrencyFromId
                     , CurrencyToId
                     , [Date]
                     , AverageRate
                     , EndOfDayRate
                     , ModifiedDate
                     , ImportedAt
                     , LoadId)
                 VALUES(
                     [Source].CurrencyRateId
                     , [Source].CurrencyIdFrom
                     , [Source].CurrencyIdTo
                     , [Source].CurrencyRateDate
                     , [Source].AverageRate
                     , [Source].EndOfDayRate
                     , [Source].ModifiedDate
                     , GETDATE()
                     , @LoadId_)
        WHEN MATCHED AND ([Target].AverageRate != [Source].AverageRate 
                       OR [Target].EndOfDayRate != [Source].EndOfDayRate)
            THEN UPDATE SET
                     CurrencyFromId = [Source].CurrencyIdFrom
                     , CurrencyToId = [Source].CurrencyIdTo
                     , [Date] =       [Source].CurrencyRateDate
                     , AverageRate  = [Source].AverageRate
                     , EndOfDayRate = [Source].EndOfDayRate
                     , ModifiedDate = [Source].ModifiedDate
                     , ImportedAt   = GETDATE()
                     , LoadId       = @LoadId_ 
        OUTPUT $action INTO #InsertsUpdates( ChangeType );

        SELECT 
            @EndDate = GETDATE()

        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
            , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId_
        FROM
            #InsertsUpdates

        COMMIT
    
    END TRY
    
    BEGIN CATCH
        ROLLBACK
    
        SELECT
            @EndDate = GETDATE()
            , @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND,@StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_
    
    END CATCH
END
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_FactSalesOrder'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_FactSalesOrder
GO
CREATE PROC ETL.Load_DWH_FactSalesOrder
    @LoadId DATETIME = NULL
AS
BEGIN
    DECLARE
        @ProcessName         NVARCHAR(50) = 'FactSalesOrder'
        , @LoadFrom          DATETIME
        , @StartDate         DATETIME     = GetDate()
        , @EndDate           DATETIME
        , @Success           BIT          = 'True'
        , @LoadId_           DATETIME     = ISNULL(@LoadId, GETDATE()) 

    SET NOCOUNT ON;
    
    SELECT @LoadFrom = ISNULL(MAX(ModifiedDate), CONVERT(DATETIME, '1753-01-01 00:00:00.000'))
    FROM DWH.FactSalesOrder WITH(NOLOCK)

    CREATE TABLE #InsertsUpdates( 
         ChangeType VARCHAR(25)
     )
     
    CREATE CLUSTERED COLUMNSTORE INDEX CCI_InsertsUpdates ON #InsertsUpdates WITH (DROP_EXISTING = OFF, COMPRESSION_DELAY = 0)

    BEGIN TRY
        BEGIN TRANSACTION

            MERGE DWH.FactSalesOrder                     AS [Target]
            USING ( SELECT * 
                    FROM Source.FactSalesOrder 
                    WHERE ModifiedDate >= @LoadFrom )     AS [Source]
            ON ([Source].SalesOrderDetailID = [Target].SalesOrderDetailID)
            WHEN NOT MATCHED BY TARGET
                THEN INSERT(
                       [CurrencyId]
                       , [CurrencyRateID]
                       , [SalesOrderNumber]
                       , [SalesOrderHeaderId]
                       , [SalesOrderDetailID]
                       , [OrderLineNumber]
                       , [ProductId]
                       , [CustomerID]
                       , [SpecialOfferId]
                       , [OrderDate]
                       , [DueDate]
                       , [ShipDate]
                       , [Quantity]
                       , [UnitPrice]
                       , [UnitPriceLocalCurrency]
                       , [UnitPriceDiscountPct]
                       , [TaxAmt]
                       , [Freight]
                       , [TotalDue]
                       , [SubTotal]
                       , [SalesAmount]
                       , [SalesAmountLocalCurrency]
                       , [OriginalSalesAmount]
                       , [OriginalSalesAmountLocalCurrency]
                       , [DiscountAmount]
                       , [DiscountAmountLocalCurrency]
                       , [ProductStandardCost]
                       , [ProductStandardCostLocalCurrency]
                       , [TotalProductCost]
                       , [TotalProductCostLocalCurrency]
                       , ImportedAt
                       , ModifiedDate
                       , LoadId )
                     VALUES(
                         [Source].[CurrencyId]
                       , [Source].[CurrencyRateID]
                       , [Source].[SalesOrderNumber]
                       , [Source].[SalesOrderHeaderId]
                       , [Source].[SalesOrderDetailID]
                       , [Source].[OrderLineNumber]
                       , [Source].[ProductId]
                       , [Source].[CustomerID]
                       , [Source].[SpecialOfferId]
                       , [Source].[OrderDate]
                       , [Source].[DueDate]
                       , [Source].[ShipDate]
                       , [Source].[Quantity]
                       , [Source].[UnitPrice]
                       , [Source].[UnitPriceLocalCurrency]
                       , [Source].[UnitPriceDiscountPct]
                       , [Source].[TaxAmt]
                       , [Source].[Freight]
                       , [Source].[TotalDue]
                       , [Source].[SubTotal]
                       , [Source].[SalesAmount]
                       , [Source].[SalesAmountLocalCurrency]
                       , [Source].[OriginalSalesAmount]
                       , [Source].[OriginalSalesAmountLocalCurrency]
                       , [Source].[DiscountAmount]
                       , [Source].[DiscountAmountLocalCurrency]
                       , [Source].[ProductStandardCost]
                       , [Source].[ProductStandardCostLocalCurrency]
                       , [Source].[TotalProductCost]
                       , [Source].[TotalProductCostLocalCurrency]
                       , GETDATE()
                       , [Source].ModifiedDate
                       , @LoadId_ )
            WHEN MATCHED
                AND (  [Target].[CurrencyId] !=                             [Source].[CurrencyId]
                       OR [Target].[CurrencyRateID] !=                      [Source].[CurrencyRateID]
                       OR [Target].[SalesOrderNumber] !=                    [Source].[SalesOrderNumber]
                       OR [Target].[OrderLineNumber] !=                     [Source].[OrderLineNumber]
                       OR [Target].[SalesOrderHeaderId] !=                  [Source].[SalesOrderHeaderId]
                       OR [Target].[SalesOrderDetailId] !=                  [Source].[SalesOrderDetailId]
                       OR [Target].[ProductId] !=                           [Source].[ProductId]
                       OR [Target].[CustomerID] !=                          [Source].[CustomerID]
                       OR [Target].[SpecialOfferId] !=                      [Source].[SpecialOfferId]
                       OR [Target].[OrderDate] !=                           [Source].[OrderDate]
                       OR [Target].[DueDate] !=                             [Source].[DueDate]
                       OR [Target].[ShipDate] !=                            [Source].[ShipDate]
                       OR [Target].[Quantity] !=                            [Source].[Quantity]
                       OR [Target].[UnitPrice] !=                           [Source].[UnitPrice]
                       OR [Target].[UnitPriceLocalCurrency] !=              [Source].[UnitPriceLocalCurrency]
                       OR [Target].[UnitPriceDiscountPct] !=                [Source].[UnitPriceDiscountPct]
                       OR [Target].[TaxAmt] !=                              [Source].[TaxAmt]
                       OR [Target].[Freight] !=                             [Source].[Freight]
                       OR [Target].[TotalDue] !=                            [Source].[TotalDue]
                       OR [Target].[SubTotal] !=                            [Source].[SubTotal]
                       OR [Target].[SalesAmount] !=                         [Source].[SalesAmount]
                       OR [Target].[SalesAmountLocalCurrency] !=            [Source].[SalesAmountLocalCurrency]
                       OR [Target].[OriginalSalesAmount] !=                 [Source].[OriginalSalesAmount]
                       OR [Target].[OriginalSalesAmountLocalCurrency] !=    [Source].[OriginalSalesAmountLocalCurrency]
                       OR [Target].[DiscountAmount] !=                      [Source].[DiscountAmount]
                       OR [Target].[DiscountAmountLocalCurrency] !=         [Source].[DiscountAmountLocalCurrency]
                       OR [Target].[ProductStandardCost] !=                 [Source].[ProductStandardCost]
                       OR [Target].[ProductStandardCostLocalCurrency] !=    [Source].[ProductStandardCostLocalCurrency]
                       OR [Target].[TotalProductCost] !=                    [Source].[TotalProductCost]
                       OR [Target].[TotalProductCostLocalCurrency] !=       [Source].[TotalProductCostLocalCurrency] )
                THEN UPDATE SET
                         [CurrencyId] =                         [Source].[CurrencyId]
                       , [CurrencyRateID] =                     [Source].[CurrencyRateID]
                       , [SalesOrderNumber] =                   [Source].[SalesOrderNumber]
                       , [SalesOrderHeaderId] =                 [Source].[SalesOrderHeaderId]
                       , [SalesOrderDetailId] =                 [Source].[SalesOrderDetailId]
                       , [OrderLineNumber] =                    [Source].[OrderLineNumber]
                       , [ProductId] =                          [Source].[ProductId]
                       , [CustomerID] =                         [Source].[CustomerID]
                       , [SpecialOfferId] =                     [Source].[SpecialOfferId]
                       , [OrderDate] =                          [Source].[OrderDate]
                       , [DueDate] =                            [Source].[DueDate]
                       , [ShipDate] =                           [Source].[ShipDate]
                       , [Quantity] =                           [Source].[Quantity]
                       , [UnitPrice] =                          [Source].[UnitPrice]
                       , [UnitPriceLocalCurrency] =             [Source].[UnitPriceLocalCurrency]
                       , [UnitPriceDiscountPct] =               [Source].[UnitPriceDiscountPct]
                       , [TaxAmt] =                             [Source].[TaxAmt]
                       , [Freight] =                            [Source].[Freight]
                       , [TotalDue] =                           [Source].[TotalDue]
                       , [SubTotal] =                           [Source].[SubTotal]
                       , [SalesAmount] =                        [Source].[SalesAmount]
                       , [SalesAmountLocalCurrency] =           [Source].[SalesAmountLocalCurrency]
                       , [OriginalSalesAmount] =                [Source].[OriginalSalesAmount]
                       , [OriginalSalesAmountLocalCurrency] =   [Source].[OriginalSalesAmountLocalCurrency]
                       , [DiscountAmount] =                     [Source].[DiscountAmount]
                       , [DiscountAmountLocalCurrency] =        [Source].[DiscountAmountLocalCurrency]
                       , [ProductStandardCost] =                [Source].[ProductStandardCost]
                       , [ProductStandardCostLocalCurrency] =   [Source].[ProductStandardCostLocalCurrency]
                       , [TotalProductCost] =                   [Source].[TotalProductCost]
                       , [TotalProductCostLocalCurrency] =      [Source].[TotalProductCostLocalCurrency]
                       , ImportedAt =                           GETDATE()
                       , ModifiedDate =                         [Source].ModifiedDate
                       , LoadId =                               @LoadId_
            OUTPUT $action INTO #InsertsUpdates( ChangeType );
            
            SELECT 
                @EndDate = GETDATE()
            
            INSERT INTO Logging.ETL_Loading(
                ProcessName
                , StartDate  
                , EndDate
                , Inserts   
                , Updates                 
                , Duration
                , Success
                , LoadId
            ) 
            SELECT
                @ProcessName
                , @StartDate
                , @EndDate
                , ISNULL(SUM( CASE WHEN ChangeType = 'INSERT' THEN 1 ELSE 0 END), 0)
                , ISNULL(SUM( CASE WHEN ChangeType = 'UPDATE' THEN 1 ELSE 0 END), 0)
                , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
                , @Success
                , @LoadId_
            FROM #InsertsUpdates;

            COMMIT
    
    END TRY
    
    BEGIN CATCH
        ROLLBACK
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts   
            , Updates                 
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @StartDate
            , @EndDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_
    
    END CATCH
END
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'Load_DWH_All'
          AND SPECIFIC_SCHEMA = 'ETL')
DROP PROC ETL.Load_DWH_All
GO
CREATE PROC ETL.Load_DWH_All
AS
BEGIN

    DECLARE 
        @LoadId DATETIME = GETDATE()
        , @LoadTo DATETIME = CONVERT(DATETIME, '2025-12-31 00:00:00.000')

    EXEC [ETL].[Load_DWH_DimCurrency] @LoadId
    EXEC [ETL].[Load_DWH_DimCustomer] @LoadId
    EXEC [ETL].[Load_DWH_DimProduct] @LoadId
    EXEC [ETL].[Load_DWH_DimDate] @LoadTo
    EXEC [ETL].[Load_DWH_DimSalesOrderDetail] @LoadId
    EXEC [ETL].[Load_DWH_DimSalesOrderHeader] @LoadId
    EXEC [ETL].[Load_DWH_DimSpecialOffer] @LoadId
    EXEC [ETL].[Load_DWH_FactCurrencyRate] @LoadId
    EXEC [ETL].[Load_DWH_FactSalesOrder] @LoadId

END
GO
DECLARE
    @LoadTo_ DATETIME = CONVERT(DATETIME, '31.12.2020', 104)

EXEC [ETL].[Load_DWH_DimDate] @LoadTo = @LoadTo_
GO
 
-- Objects of Cubes Metadata 
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'CubesMetadata')
BEGIN
    EXEC('CREATE SCHEMA CubesMetadata AUTHORIZATION dbo')
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM [Datawarehouse].sys.filegroups
    WHERE name='CubesMetadata')
BEGIN
    ALTER DATABASE [Datawarehouse] ADD FILEGROUP [CubesMetadata]

    ALTER DATABASE [Datawarehouse] ADD FILE ( NAME = N'Datawarehouse_CubesMetadata'
                                              , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_CubesMetadata.ndf' 
                                              , SIZE = 73728KB 
                                              , FILEGROWTH = 65536KB ) 
                                   TO FILEGROUP [CubesMetadata]

END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='Cube')
BEGIN
    CREATE TABLE CubesMetadata.[Cube](
        [Id] [int] NOT NULL,
        [CubeId] [nvarchar](128) NOT NULL,
        [CubeName] [nvarchar](128) NOT NULL,
        [CubeDescription] [nvarchar](1000) NULL,
        [DatasourceID] [nvarchar](200) NULL,
        [Created] [smalldatetime] NOT NULL CONSTRAINT [DF_Cubes_Created]  DEFAULT (getdate()),
        [Changed] [smalldatetime] NOT NULL CONSTRAINT [DF_Cubes_Changed]  DEFAULT (getdate()),
 CONSTRAINT [PK_Cube] PRIMARY KEY CLUSTERED ( Id ASC )
    ) ON CubesMetadata
END
GO
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='OLAPDatabase')
BEGIN
    CREATE TABLE [CubesMetadata].[OLAPDatabase](
        [Id] [int] NOT NULL,
        [OLAPDatabaseId] [nvarchar](200) NULL,
        [OLAPDatabaseName] [nvarchar](200) NULL,
        [DeletePartitionModel] [nvarchar](max) NULL,
        [Created] [smalldatetime] NOT NULL CONSTRAINT [DF_OLAPDatabases_Created]  DEFAULT (getdate()),
        [Changed] [smalldatetime] NOT NULL CONSTRAINT [DF_OLAPDatabases_Changed]  DEFAULT (getdate()),
     CONSTRAINT [PK_OLAPDatabase] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]
END
GO
-- Table [CubesMetadata].[CubeXOLAPDatabase]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='CubeXOLAPDatabase')
BEGIN
    CREATE TABLE [CubesMetadata].[CubeXOLAPDatabase](
        [CubeXOLAPDatabaseId] [int] NOT NULL,
        [CubeId] [int] NOT NULL,
        [OLAPDatabaseId] [int] NOT NULL,
     CONSTRAINT [PK_CubeXOLAPDatabase] PRIMARY KEY CLUSTERED ( [CubeXOLAPDatabaseId] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]
END
GO
-- NONCLUSTERED INDEX [UQ_CubeXOLAPDatabase]
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes
    WHERE 
        object_id = OBJECT_ID(N'[CubesMetadata].[CubeXOLAPDatabase]') AND
        name = N'UQ_CubeXOLAPDatabase'
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_CubeXOLAPDatabase] ON [CubesMetadata].[CubeXOLAPDatabase]
    (
        CubeId ASC,
        OLAPDatabaseId ASC
    ) ON CubesMetadata
END
GO
-- FOREIGN KEY FK_CubeXOLAPDatabase_Cubes
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    WHERE 
        TABLE_SCHEMA = 'CubesMetadata' AND
        TABLE_NAME = 'CubeXOLAPDatabase' AND
        CONSTRAINT_NAME = 'FK_CubeXOLAPDatabase_Cubes'
)
BEGIN
    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase]  WITH CHECK ADD  CONSTRAINT [FK_CubeXOLAPDatabase_Cube] FOREIGN KEY([CubeId])
    REFERENCES [CubesMetadata].[Cube] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase] CHECK CONSTRAINT [FK_CubeXOLAPDatabase_Cube]
END
GO
-- FOREIGN KEY [CubesMetadata].[CubeXOLAPDatabase]
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    WHERE 
        TABLE_SCHEMA = 'CubesMetadata' AND
        TABLE_NAME = 'CubeXOLAPDatabase' AND
        CONSTRAINT_NAME = 'FK_CubeXOLAPDatabase_OLAPDatabases'
)
BEGIN
    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase]  WITH CHECK ADD  CONSTRAINT [FK_CubeXOLAPDatabase_OLAPDatabase] FOREIGN KEY([OLAPDatabaseId])
    REFERENCES [CubesMetadata].[OLAPDatabase] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase] CHECK CONSTRAINT [FK_CubeXOLAPDatabase_OLAPDatabase]
END
GO
-- Table [ManageCubes].[MeasureGroup]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='MeasureGroup')
BEGIN
    CREATE TABLE [CubesMetadata].[Measuregroup](
        [Id] [int] IDENTITY(1,1) NOT NULL,
        [CubeId] [int] NOT NULL,
        [MeasureGroupId] [nvarchar](200) NOT NULL,
        [MeasureGroupName] [nvarchar](200) NOT NULL,
        [AggregationDesign] [varchar](50) NULL,
        [Frequency] [nvarchar](20) NOT NULL,
        [CreatePartition] [bit] DEFAULT 1,
        [Query] [nvarchar](max) NULL,
        [StartDate] [datetime] NULL,
        [AllBeginning] [bit] DEFAULT 0,
        [Slice] [nvarchar](max) NULL,
        [InitialSlice] [nvarchar](max) NULL,
        [InitialQuery] [nvarchar](max) NULL,
        [ProcessQuery] [nvarchar](max) NULL,
        [CreatePartitionModel] [nvarchar](max) NULL,
     CONSTRAINT [PK_Measuregroup] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata] TEXTIMAGE_ON [CubesMetadata]

    ALTER TABLE [CubesMetadata].[Measuregroup]  WITH CHECK ADD  CONSTRAINT [FK_Measuregroup_CubeId] FOREIGN KEY([CubeId])
    REFERENCES [CubesMetadata].[Cube] ([Id])

    ALTER TABLE [CubesMetadata].[Measuregroup] CHECK CONSTRAINT [FK_Measuregroup_CubeId]
END
GO
-- Table [CubesMetadata].[CubeXMeasureGroup]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='CubeXMeasureGroup')
BEGIN
    CREATE TABLE [CubesMetadata].[CubeXMeasureGroup](
        [CubeXMeasuregroupID] [int] NOT NULL,
        [MeasureGroupID] [int] NOT NULL,
     CONSTRAINT [PK_CubeXMeasureGroup] PRIMARY KEY CLUSTERED ( [CubeXMeasuregroupID] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]

    ALTER TABLE [CubesMetadata].[CubeXMeasureGroup]  WITH CHECK ADD  CONSTRAINT [FK_CubeXMeasureGroup_MeasureGroup] FOREIGN KEY([MeasureGroupId])
    REFERENCES [CubesMetadata].[MeasureGroup] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXMeasureGroup] CHECK CONSTRAINT [FK_CubeXMeasureGroup_MeasureGroup]
END
GO
CREATE TABLE [CubesMetadata].[Partition](
    [CubeId] [int] DEFAULT 1,
    [MeasureGroupId] [int] NOT NULL,
    [PartitionId] [int] NOT NULL,
    [Frequency] [nvarchar](20) NULL,
    [FromDate] [datetime] NULL,
    [ToDate] [datetime] NULL,
    [Script] [nvarchar](max) NULL,
    [PartitionName] [nvarchar](50) NULL,
    [ActualisedDate] [datetime] DEFAULT (getdate()),
 CONSTRAINT [PK_CubesMetadata_Partition] PRIMARY KEY CLUSTERED 
    (
        [PartitionId] ASC,
        [MeasureGroupId] ASC,
        [CubeId] ASC
    ) ON [CubesMetadata]
) ON [CubesMetadata] TEXTIMAGE_ON [CubesMetadata]

GO

INSERT INTO [CubesMetadata].[Cube](
    [Id]
    , [CubeId]
    , [CubeName])
VALUES( 1, 'Datawarehouse', 'Datawarehouse')
GO
INSERT INTO [CubesMetadata].[OLAPDatabase](
    [Id]
    , [OLAPDatabaseId]
    , [OLAPDatabaseName]
    , [DeletePartitionModel])
VALUES(1
       , 'Datawarehouse'
       , 'Datawarehouse'
       , '<Delete xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <Object>
                   <DatabaseID>##DatabaseID##</DatabaseID>
                   <CubeID>##CubeID##</CubeID>
                   <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                   <PartitionID>##PartitionID##</PartitionID>
               </Object>
           </Delete>')
GO
INSERT INTO [CubesMetadata].[CubeXOLAPDatabase](
    [CubeXOLAPDatabaseId]
    , [CubeId]
    , [OLAPDatabaseId])
VALUES( 1, 1, 1)
GO
INSERT INTO [CubesMetadata].[Measuregroup](
    [CubeID]
    , [MeasureGroupId]
    , [MeasureGroupName]
    , [Frequency]
    , [CreatePartition] 
    , [ProcessQuery]
    , [StartDate]
    , [CreatePartitionModel]
    , [Query])
VALUES( 1
        , 'Fact Currency Rate'
        , 'Fact Currency Rate'
        , 'Unique'
        , 0
        , '<Batch xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <Parallel>
                 <Process xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                   <Object>
                     <DatabaseID>##DatabaseID##</DatabaseID>
                     <CubeID>##CubeID##</CubeID>
                     <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                     <PartitionID>##PartitionID##</PartitionID>
                   </Object>
                   <Type>ProcessFull</Type>
                   <WriteBackTableCreation>UseExisting</WriteBackTableCreation>
                 </Process>
               </Parallel>
             </Batch>'
        , CONVERT(DATETIME, '2011-05-01')
        , '<Create xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
               <ParentObject>
                   <DatabaseID>##DatabaseID##</DatabaseID>
                   <CubeID>##CubeID##</CubeID>
                   <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
               </ParentObject>
               <ObjectDefinition>
                   <Partition xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                       <ID>##PartitionID##</ID>
                       <Name>##PartitionName##</Name>
                       <Source xsi:type="DsvTableBinding">
                           <DataSourceViewID>Datawarehouse</DataSourceViewID>
                           <TableID>##Query##</TableID>
                       </Source>
                       <StorageMode>Molap</StorageMode>
                       <ProcessingMode>Regular</ProcessingMode>
                       <ProactiveCaching>
                           <SilenceInterval>-PT1S</SilenceInterval>
                           <Latency>-PT1S</Latency>
                           <SilenceOverrideInterval>-PT1S</SilenceOverrideInterval>
                           <ForceRebuildInterval>-PT1S</ForceRebuildInterval>
                           <Source xsi:type="ProactiveCachingInheritedBinding" />
                       </ProactiveCaching>
                       <EstimatedRows>13533</EstimatedRows>
                       <AggregationDesignID>AggregationDesign_FactCurrencyRate</AggregationDesignID>
                   </Partition>
               </ObjectDefinition>
           </Create>'
         , 'ExtDWH_FactCurrencyRate'),
      ( 1
        , 'Fact Sales Order'
        , 'Fact Sales Order'
        --, 'FactSalesOrder_##PartitionId##'
        , 'Monthly'
        , 1
        , '<Batch xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
            <Parallel>
              <Process xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                <Object>
                  <DatabaseID>##DatabaseID##</DatabaseID>
                  <CubeID>##CubeID##</CubeID>
                  <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
                  <PartitionID>##PartitionId##</PartitionID>
                </Object>
                <Type>ProcessFull</Type>
                <WriteBackTableCreation>UseExisting</WriteBackTableCreation>
              </Process>
            </Parallel>
          </Batch>'
        , CONVERT(DATETIME, '2011-05-01')
        , '<Create xmlns="http://schemas.microsoft.com/analysisservices/2003/engine">
              <ParentObject>
                  <DatabaseID>##DatabaseID##</DatabaseID>
                  <CubeID>##CubeID##</CubeID>
                  <MeasureGroupID>##MeasureGroupID##</MeasureGroupID>
              </ParentObject>
              <ObjectDefinition>
                  <Partition xmlns:xsd="http://www.w3.org/2001/XMLSchema" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance" xmlns:ddl2="http://schemas.microsoft.com/analysisservices/2003/engine/2" xmlns:ddl2_2="http://schemas.microsoft.com/analysisservices/2003/engine/2/2" xmlns:ddl100_100="http://schemas.microsoft.com/analysisservices/2008/engine/100/100" xmlns:ddl200="http://schemas.microsoft.com/analysisservices/2010/engine/200" xmlns:ddl200_200="http://schemas.microsoft.com/analysisservices/2010/engine/200/200" xmlns:ddl300="http://schemas.microsoft.com/analysisservices/2011/engine/300" xmlns:ddl300_300="http://schemas.microsoft.com/analysisservices/2011/engine/300/300" xmlns:ddl400="http://schemas.microsoft.com/analysisservices/2012/engine/400" xmlns:ddl400_400="http://schemas.microsoft.com/analysisservices/2012/engine/400/400" xmlns:ddl500="http://schemas.microsoft.com/analysisservices/2013/engine/500" xmlns:ddl500_500="http://schemas.microsoft.com/analysisservices/2013/engine/500/500">
                      <ID>##PartitionId##</ID>
                      <Name>##MeasureGroupID##_##PartitionId##</Name>
                      <Source xsi:type="QueryBinding">
                          <DataSourceID>Datawarehouse</DataSourceID>
                          <QueryDefinition>##Query##</QueryDefinition>
                      </Source>
                      <StorageMode>Molap</StorageMode>
                      <ProcessingMode>Regular</ProcessingMode>
                      <ProactiveCaching>
                          <SilenceInterval>-PT1S</SilenceInterval>
                          <Latency>-PT1S</Latency>
                          <SilenceOverrideInterval>-PT1S</SilenceOverrideInterval>
                          <ForceRebuildInterval>-PT1S</ForceRebuildInterval>
                          <Source xsi:type="ProactiveCachingInheritedBinding" />
                      </ProactiveCaching>
                  </Partition>
              </ObjectDefinition>
          </Create>'
        , 'SELECT [CurrencyId],[CurrencyRateId],[SalesOrderNumber],[SalesOrderHeaderId],[SalesOrderDetailId],[OrderLineNumber],[ProductId],[CustomerId],[SpecialOfferId],[OrderDate],[DueDate],[ShipDate],[Quantity],[UnitPrice],[UnitPriceLocalCurrency],[UnitPriceDiscountPct],[TaxAmt],[Freight],[TotalDue],[SubTotal],[SalesAmount],[SalesAmountLocalCurrency],[OriginalSalesAmount],[OriginalSalesAmountLocalCurrency],[DiscountAmount],[DiscountAmountLocalCurrency],[ProductStandardCost],[ProductStandardCostLocalCurrency],[TotalProductCost],[TotalProductCostLocalCurrency] FROM [ExtDWH].[FactSalesOrder] WHERE [OrderDate] BETWEEN ##StartDate## AND ##EndDate##')

           --'2011-05-01' AND '2011-05-31'
        
        
        
        
        
























INSERT INTO [CubesMetadata].[CubeXMeasureGroup](
    [CubeXMeasureGroupId]
    , [MeasureGroupId])
VALUES( 1, 1), (2, 2)
GO
IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_CreatePartition'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_CreatePartition]
GO
CREATE PROC [CubesMetadata].[p_CreatePartition]
    @DatabaseId               NVARCHAR(50),
    @CubeId                   NVARCHAR(50),
    @MeasureGroupId           NVARCHAR(50),
    @MeasureGroupId_INT       INT,
    @Frequency                NVARCHAR(20),-- = 'Monthly','Yearly','Monthly',
    @PartitionId              INT,
    @PartitionName            NVARCHAR(50),
    @Query                    NVARCHAR(MAX),
    @Slice                    NVARCHAR(MAX) = '',
    @FromDate                 DATETIME,
    @ToDate                   DATETIME,
    @LoadId                   DATETIME
AS
BEGIN

    DECLARE
        @ProcessName          NVARCHAR(50) = 'CreatePartition'
        , @Inserts            INT
        , @Updates            INT          = 0
        --, @LoadFrom           DATETIME     = @FromDate 
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            NVARCHAR(5)
        , @LoadId_            DATETIME     = GETDATE()

    BEGIN TRY

        DECLARE
            @CubeId_INT         INT
            , @connectivity       INT

        SELECT @CubeId_INT=Id 
        FROM [CubesMetadata].[Cube] 
        WHERE CubeId = @CubeId
        
        -- Verify connectivity to the cube
        SELECT @connectivity = 1
        FROM OPENQUERY([SSAS_PROD] , 'SELECT [Measures].[Sales Amount] ON 0 FROM [Datawarehouse]')
        
        IF ( @connectivity = 1
             AND EXISTS( SELECT 1
                         FROM       CubesMetadata.[OLAPDatabase]
                         INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id          = CubeXOLAPDatabase.OLAPDatabaseId
                         INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
                         INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id                = [Measuregroup].CubeId
                         INNER JOIN CubesMetadata.[Partition]       ON [Measuregroup].Id        = [Partition].MeasuregroupId
                         WHERE
                             [OLAPDatabase].OLAPDatabaseId     = @DatabaseId
                             AND [Cube].CubeId                 = @CubeId
                             AND [Measuregroup].MeasureGroupId = @MeasureGroupId
                             AND [Partition].PartitionId       = @PartitionId))
        BEGIN
            --PRINT 'Delete Partition ' + convert(nvarchar(10), @PartitionId)
            EXECUTE [CubesMetadata].[p_DeletePartition] 
                                        @DatabaseId
                                       ,@CubeId
                                       ,@MeasureGroupId
                                       ,@PartitionId
        
        END
        
        DECLARE
            @PartitionModel NVARCHAR(MAX)
        
        SELECT
            @PartitionModel = [Measuregroup].CreatePartitionModel
        FROM
            CubesMetadata.[Measuregroup]
        WHERE
            [Measuregroup].MeasureGroupId = @MeasureGroupId
        
        SET
           @Slice = ISNULL(@Slice, '')
        
        
        SELECT
            @PartitionModel = REPLACE(
                              REPLACE(
                              REPLACE(
                              REPLACE( 
                              REPLACE(
                              REPLACE( 
                              REPLACE(@PartitionModel, '##DatabaseID##', @DatabaseId),
                                                       '##CubeID##', @CubeId), 
                                                       '##MeasureGroupID##', @MeasureGroupId),
                                                       '##PartitionID##', CONVERT(NVARCHAR(10), @PartitionId)),
                                                       '##PartitionName##', @PartitionName),
                                                       '##Query##', @Query),
                                                       '##Slice##', @Slice)
        
        SELECT
            @PartitionModel = REPLACE(
                              REPLACE(@PartitionModel, '##StartDate##', CONVERT(NVARCHAR(10), CONVERT(DATE, @FromDate))),
                                                       '##EndDate##', CONVERT(NVARCHAR(10), CONVERT(DATE, @ToDate)))
        
        EXEC (@PartitionModel) At [SSAS_PROD];
        
        INSERT INTO [CubesMetadata].[Partition](
            CubeId,
            [MeasureGroupId],
            [PartitionId],
            [Frequency],
            [FromDate],
            [ToDate],
            [Script],
            [PartitionName])
        SELECT
            @CubeId_INT,
            @MeasureGroupId_INT,
            @PartitionId,
            @Frequency,
            CONVERT(DATE, @FromDate),
            CONVERT(DATE, @ToDate),
            @PartitionModel,
            @PartitionName

        SET @Inserts = @@ROWCOUNT
        
        SELECT 
            @EndDate = GETDATE()
            , @Success = 'True'
        
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates 
            , Duration   
            , Success
            , LoadId
        ) 
        SELECT
            @ProcessName
            , CONVERT(DATE, @FromDate)
            , CONVERT(DATE, @ToDate)
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId_

    END TRY

    BEGIN CATCH
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , CONVERT(DATE, @FromDate)
            , CONVERT(DATE, @ToDate)
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId_

    END CATCH
END


GO


IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_CreatePartitions'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_CreatePartitions]
GO
--EXEC [CubesMetadata].[p_CreatePartitions] 'Datawarehouse', 'Fact Sales Order', '2013-06-01', '2013-07-02'

CREATE PROC [CubesMetadata].[p_CreatePartitions]
    @CubeName         NVARCHAR(200)  = 'Datawarehouse',
    @MeasureGroupName NVARCHAR(200) = NULL,  --='SalesCustomers';
    @FromDate         DATETIME = NULL, -- = '2018-01-01',
    @ToDate           DATETIME = NULL -- = '2019-01-01';
AS
BEGIN

    DECLARE
            @ProcessName          NVARCHAR(50) = 'CreatePartitions'
            , @Inserts            INT
            , @Updates            INT          = 0
            , @StartDate          DATETIME     = GETDATE()
            , @EndDate            DATETIME
            , @Success            NVARCHAR(5)
            , @LoadId             DATETIME     = GETDATE()

    BEGIN TRY
        
        DECLARE 
            @TotalPartitionsToBeCreated       INT,
            @CounterPartitionsToBeCreated     INT = 1,
            @DatabaseId                       NVARCHAR(50),
            @CubeId                           NVARCHAR(50),
            @CubeId_INT                       INT,
            @MeasureGroupId                   NVARCHAR(50),
            @PartitionId                      NVARCHAR(50),
            @MeasureGroupId_INT               INT,
            @Frequency                        NVARCHAR(20),
            @PartitionName                    NVARCHAR(50), 
            @Query                            NVARCHAR(MAX),
            @Slice                            NVARCHAR(MAX)
        
        SELECT @CubeId_INT=Id 
        FROM [CubesMetadata].[Cube] 
        WHERE CubeName = @CubeName
        
        DECLARE 
            @MaxMonthId INT = CONVERT(INT, CONVERT(nvarchar(6), DATEADD(MONTH, 1, GetDate()), 112)),
            @MaxYear INT = YEAR(GetDate())+1;
        
        WITH Q_Monthly AS(
            SELECT
                [MonthId],
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate]
            WHERE
                [MonthId] <= @MaxMonthId
            GROUP BY
                [MonthId]
        ),
        Q_Quarterly AS(
            SELECT
                QuarterId,
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate] d
            WHERE
                [MonthId] <= @MaxMonthId
            GROUP BY
                QuarterId
        ),
        Q_Yearly AS(
            SELECT
                [Year],
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate]
            WHERE
                [Year] <= @MaxYear
            GROUP BY
                [Year]
        ),
        Q_Partitions AS(
            -- Monthly
            SELECT 
                [OLAPDatabase].OLAPDatabaseId AS OLAPDatabaseId,
                [Cube].CubeId                 AS CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                'Monthly' AS Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QM.MonthId as PartitionId,
                QM.MinDate,
                QM.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Monthly AS QM
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND ([Measuregroup].Frequency='Monthly' 
                    OR ([Measuregroup].Frequency='Quarterly' 
                         AND QM.MinDate >= CONVERT(CHAR(10), DATEADD(yy, DATEDIFF(yy, 0, DATEADD(MONTH, 1, GETDATE())) -2, 0), 126)))
                AND [Measuregroup].StartDate <= QM.MinDate
            UNION ALL
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].InitialQuery,
                [Measuregroup].InitialSlice,
                [Measuregroup].CreatePartitionModel,
                175301,
                NULL,
                [Measuregroup].StartDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Monthly'
                AND AllBeginning=1
            UNION ALL
            
             --Yearly
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QY.[Year],
                QY.MinDate,
                QY.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Yearly AS QY
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Yearly'
                AND [Measuregroup].StartDate <= QY.MinDate
            
            UNION ALL
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].InitialQuery,
                [Measuregroup].InitialSlice,
                [Measuregroup].CreatePartitionModel,
                1753,
                NULL,
                [Measuregroup].StartDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Yearly'
                AND AllBeginning=1
            UNION ALL
            
            --Quarterly
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QM.QuarterId,
                QM.MinDate,
                QM.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Quarterly AS QM
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Quarterly' 
                AND QM.MinDate < CONVERT(CHAR(10), DATEADD(yy, DATEDIFF(yy, 0, DATEADD(MONTH, 1, GETDATE())) -2, 0), 126)   
                AND [Measuregroup].StartDate <= QM.MinDate
        )
        SELECT 
            ROW_NUMBER() OVER (ORDER BY OLAPDatabaseId,
                                        CubeId,
                                        MeasureGroupId,
                                        PartitionId) AS ID
            , [OLAPDatabaseId]
            , [CubeId]
            , [MeasureGroupId_INT]
            , [MeasureGroupId]
            , [MeasureGroupName]
            , [Frequency]
            , [Query]
            , ISNULL([Slice], '') AS Slice
            , [CreatePartitionModel]
            , [PartitionId]
            , [MinDate]
            , [MaxDate]
        INTO #Partitions
        FROM Q_Partitions AS Q
        WHERE
            (@FromDate IS NULL OR MinDate >= @FromDate) 
            AND (@ToDate IS NULL OR MaxDate <= @ToDate)
            AND NOT EXISTS ( SELECT 1
                             FROM [CubesMetadata].[Partition] AS p
                             WHERE p.CubeId = @CubeId_INT
                                   AND p.MeasureGroupId = Q.[MeasureGroupId_INT]
                                   AND p.PartitionId =Q.PartitionId )
        
        -- create partitions
        SELECT @TotalPartitionsToBeCreated = COUNT(*)
        FROM #Partitions
        
        WHILE ( @CounterPartitionsToBeCreated <= @TotalPartitionsToBeCreated )
        BEGIN
        
            SELECT 
                @DatabaseId         = OLAPDatabaseId,
                @CubeId             = CubeId,
                @MeasureGroupId     = MeasureGroupId,
                @MeasureGroupId_INT = MeasureGroupId_INT,
                @Frequency          = Frequency,
                @PartitionId        = PartitionId,
                @PartitionName      = MeasureGroupId+'_'+CONVERT(NVARCHAR(6), PartitionId), 
                @Query              = Query, 
                @Slice              = Slice, 
                @FromDate           = CONVERT(NVARCHAR(10),CONVERT(DATE, MinDate)), 
                @ToDate             = CONVERT(NVARCHAR(10),CONVERT(DATE, MaxDate))
            FROM #Partitions
            WHERE
                ID = @CounterPartitionsToBeCreated
        
            EXECUTE [CubesMetadata].[p_CreatePartition] 
                                       @DatabaseId
                                       , @CubeId
                                       , @MeasureGroupId
                                       , @MeasureGroupId_INT
                                       , @Frequency
                                       , @PartitionId
                                       , @PartitionName
                                       , @Query
                                       , @Slice
                                       , @FromDate
                                       , @ToDate
                                       , @LoadId               
                                         
        
            SET @CounterPartitionsToBeCreated = @CounterPartitionsToBeCreated + 1
        
        END

        SET @Inserts = @TotalPartitionsToBeCreated
        
        SELECT 
            @EndDate = GETDATE()
            , @Success = 'True'

        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates 
            , Duration   
            , Success
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @FromDate
            , @ToDate
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId

    END TRY


    BEGIN CATCH
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @FromDate
            , @ToDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId

    END CATCH
END

GO


IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_DeletePartition'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_DeletePartition]
GO

--exec [CubesMetadata].[p_DeletePartition] 
--    'Datawarehouse',
--  'Datawarehouse',
--  'Fact Sales Order',
--  201201

CREATE PROC [CubesMetadata].[p_DeletePartition]
    @DatabaseId               NVARCHAR(50),
    @CubeId                   NVARCHAR(50),
    @MeasureGroupId           NVARCHAR(50),
    @PartitionId              INT,
    @LoadId                   DATETIME
AS
BEGIN

    DECLARE
            @ProcessName          NVARCHAR(50) = 'DeletePartition'
            , @Inserts            INT
            , @Updates            INT          = 0
            , @LoadFrom           DATETIME 
            , @StartDate          DATETIME     = GETDATE()
            , @EndDate            DATETIME
            , @Success            NVARCHAR(5)
            , @FromDate           DATE
            , @ToDate             DATE

    BEGIN TRY
        
        -- Verify connectivity to the cube
        DECLARE 
            @connectivity    INT,
            @existsRecord    BIT
        
        SELECT @connectivity = 1
        FROM OPENQUERY([SSAS_PROD] , 'SELECT [Measures].[Sales Amount] ON 0 FROM [Datawarehouse]')
        
        IF ( @connectivity = 1
             AND EXISTS( SELECT 1
                         FROM       CubesMetadata.[OLAPDatabase]
                         INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
                         INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
                         INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
                         INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
                         WHERE 
                             [OLAPDatabase].OLAPDatabaseId = @DatabaseId
                             AND [Cube].CubeId = @CubeId
                             AND [Measuregroup].[MeasureGroupId] = @MeasureGroupId
                             AND [Partition].[PartitionId] = @PartitionId))
        BEGIN
            DECLARE
                @PartitionModel NVARCHAR(MAX)
            
            SELECT
                @PartitionModel = DeletePartitionModel
            FROM
                CubesMetadata.[OLAPDatabase]
            WHERE
                [OLAPDatabase].OLAPDatabaseId = @DatabaseId
            
            SELECT
                @PartitionModel = REPLACE( 
                                  REPLACE(
                                  REPLACE( 
                                  REPLACE(@PartitionModel, '##DatabaseId##', @DatabaseId),
                                                           '##CubeId##', @CubeId), 
                                                           '##MeasureGroupID##', @MeasureGroupId),
                                                           '##PartitionId##', CONVERT(NVARCHAR(50), @PartitionId))

            SELECT
                @FromDate = [Partition].FromDate
                , @ToDate = [Partition].ToDate
            FROM
                       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
            INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
            WHERE
                OLAPDatabase.OLAPDatabaseId = @DatabaseId
                AND [Cube].CubeId = @CubeId
                AND MeasureGroup.MeasureGroupId = @MeasureGroupId
                AND [Partition].PartitionId = @PartitionId
            
            EXEC (@PartitionModel) At [SSAS_PROD];
            
            DELETE [CubesMetadata].[Partition]
            FROM
                       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
            INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
            WHERE
                OLAPDatabase.OLAPDatabaseId = @DatabaseId
                AND [Cube].CubeId = @CubeId
                AND MeasureGroup.MeasureGroupId = @MeasureGroupId
                AND [Partition].PartitionId = @PartitionId
        END

        SET @Inserts = @@ROWCOUNT
        
        SELECT 
            @EndDate = GETDATE()
            , @Success = 'True'
        
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates 
            , Duration   
            , Success
            , LoadId
        ) 
        SELECT
            @ProcessName
            , @FromDate
            , @ToDate
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId

    END TRY


    BEGIN CATCH
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , ISNULL(@FromDate, @LoadId)
            , ISNULL(@ToDate, @LoadId)
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId

    END CATCH
END

GO


IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_DeletePartitions'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_DeletePartitions]
GO

-- EXEC [CubesMetadata].[p_DeletePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2012-03-02'
CREATE PROC [CubesMetadata].[p_DeletePartitions]
    @CubeName         NVARCHAR(200) = 'Datawarehouse',
    @MeasureGroupId   NVARCHAR(200) = NULL,  --='SalesCustomers';
    @FromDate         DATETIME = NULL, -- = '2018-01-01',
    @ToDate           DATETIME = NULL -- = '2019-01-01';
AS
BEGIN

    DECLARE
        @ProcessName          NVARCHAR(50) = 'DeletePartitions'
        , @Inserts            INT
        , @Updates            INT          = 0
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            NVARCHAR(5)
        , @LoadId             DATETIME     = GETDATE()

    BEGIN TRY

        DECLARE 
            @TotalPartitionsToBeDeleted       INT,
            @CounterPartitionsToBeDeleted     INT = 1,
            @DatabaseId                       NVARCHAR(50),
            @CubeId                           NVARCHAR(50),
            @PartitionId                      INT

        SELECT 
            ROW_NUMBER() OVER( ORDER BY [OLAPDatabase].OLAPDatabaseId,
                                        [Cube].CubeId,
                                        [Measuregroup].MeasureGroupId) AS ID,
            [OLAPDatabase].OLAPDatabaseId,
            [Cube].CubeId,
            [Measuregroup].MeasureGroupId,
            [Partition].[PartitionId] AS PartitionId
        INTO #PartitionsToDelete
        FROM       CubesMetadata.[OLAPDatabase]
        INNER JOIN CubesMetadata.CubeXOLAPDatabase  ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
        INNER JOIN CubesMetadata.[Cube]             ON [CubeXOLAPDatabase].CubeId = [Cube].Id
        INNER JOIN CubesMetadata.[Measuregroup]     ON [Cube].Id = [Measuregroup].CubeId
        INNER JOIN CubesMetadata.[Partition]        ON [Measuregroup].Id = [Partition].MeasureGroupId
        INNER JOIN [CubesMetadata].[Partition] AS p ON p.CubeId = [Partition].CubeId
                                               AND p.MeasureGroupId = [Partition].[MeasureGroupId]
                                               AND p.PartitionId =[Partition].PartitionId
        WHERE
            (@FromDate IS NULL OR [Partition].[FromDate] >= @FromDate) 
            AND (@ToDate IS NULL OR [Partition].[ToDate] <= @ToDate)
            AND (@MeasureGroupId IS NULL OR [Measuregroup].[MeasureGroupName] = @MeasureGroupId)
            AND (@CubeName IS NULL OR [Cube].[CubeName] = @CubeName)    
        
        
        SELECT @TotalPartitionsToBeDeleted = COUNT(*)
        FROM #PartitionsToDelete
     
        WHILE ( @CounterPartitionsToBeDeleted <= @TotalPartitionsToBeDeleted )
        BEGIN
        
            SELECT 
                @DatabaseId         = OLAPDatabaseId,
                @CubeId             = CubeId,
                @MeasureGroupId     = MeasureGroupId,
                @PartitionId        = PartitionId
            FROM #PartitionsToDelete
            WHERE
                ID = @CounterPartitionsToBeDeleted
        
        
            EXECUTE [CubesMetadata].[p_DeletePartition] 
                                       @DatabaseId
                                       , @CubeId
                                       , @MeasureGroupId
                                       , @PartitionId
                                       , @LoadId
        
            SET @CounterPartitionsToBeDeleted = @CounterPartitionsToBeDeleted + 1
        
        END

        SET @Inserts = @CounterPartitionsToBeDeleted
        
        SELECT 
            @EndDate = GETDATE()
            , @Success = 'True'

        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate
            , EndDate
            , Inserts
            , Updates 
            , Duration   
            , Success
            , LoadId
        ) 
        SELECT
            @ProcessName
            , CONVERT(DATETIME, @FromDate)
            , @ToDate
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId

    END TRY

    
    BEGIN CATCH
    
        SELECT
            @EndDate = GETDATE(),
            @Success = 'False'
    
        INSERT INTO Logging.ETL_Loading(
            ProcessName
            , StartDate  
            , EndDate
            , Inserts
            , Updates
            , Duration
            , Success
            , ErrorNumber
            , ErrorMessage
            , LoadId
        ) 
        SELECT
            @ProcessName
            , CONVERT(DATETIME, @FromDate)
            , @ToDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId

    END CATCH


END

GO


