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
