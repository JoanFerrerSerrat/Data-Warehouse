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
