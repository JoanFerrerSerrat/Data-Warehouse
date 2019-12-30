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
