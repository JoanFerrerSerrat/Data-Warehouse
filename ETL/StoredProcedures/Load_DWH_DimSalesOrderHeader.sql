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
