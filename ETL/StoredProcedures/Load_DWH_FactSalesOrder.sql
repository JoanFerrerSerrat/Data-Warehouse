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
