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
