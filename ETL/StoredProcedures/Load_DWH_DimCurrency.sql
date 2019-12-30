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
