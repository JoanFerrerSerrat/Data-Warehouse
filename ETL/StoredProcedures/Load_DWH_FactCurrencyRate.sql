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
