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
