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
