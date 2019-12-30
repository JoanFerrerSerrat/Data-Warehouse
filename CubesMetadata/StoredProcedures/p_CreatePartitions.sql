IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_CreatePartitions'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_CreatePartitions]
GO
--EXEC [CubesMetadata].[p_CreatePartitions] 'Datawarehouse', 'Fact Sales Order', '2013-06-01', '2013-07-02'

CREATE PROC [CubesMetadata].[p_CreatePartitions]
    @CubeName         NVARCHAR(200)  = 'Datawarehouse',
    @MeasureGroupName NVARCHAR(200) = NULL,  --='SalesCustomers';
    @FromDate         DATETIME = NULL, -- = '2018-01-01',
    @ToDate           DATETIME = NULL -- = '2019-01-01';
AS
BEGIN

    DECLARE
            @ProcessName          NVARCHAR(50) = 'CreatePartitions'
            , @Inserts            INT
            , @Updates            INT          = 0
            , @StartDate          DATETIME     = GETDATE()
            , @EndDate            DATETIME
            , @Success            NVARCHAR(5)
            , @LoadId             DATETIME     = GETDATE()

    BEGIN TRY
        
        DECLARE 
            @TotalPartitionsToBeCreated       INT,
            @CounterPartitionsToBeCreated     INT = 1,
            @DatabaseId                       NVARCHAR(50),
            @CubeId                           NVARCHAR(50),
            @CubeId_INT                       INT,
            @MeasureGroupId                   NVARCHAR(50),
            @PartitionId                      NVARCHAR(50),
            @MeasureGroupId_INT               INT,
            @Frequency                        NVARCHAR(20),
            @PartitionName                    NVARCHAR(50), 
            @Query                            NVARCHAR(MAX),
            @Slice                            NVARCHAR(MAX)
        
        SELECT @CubeId_INT=Id 
        FROM [CubesMetadata].[Cube] 
        WHERE CubeName = @CubeName
        
        DECLARE 
            @MaxMonthId INT = CONVERT(INT, CONVERT(nvarchar(6), DATEADD(MONTH, 1, GetDate()), 112)),
            @MaxYear INT = YEAR(GetDate())+1;
        
        WITH Q_Monthly AS(
            SELECT
                [MonthId],
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate]
            WHERE
                [MonthId] <= @MaxMonthId
            GROUP BY
                [MonthId]
        ),
        Q_Quarterly AS(
            SELECT
                QuarterId,
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate] d
            WHERE
                [MonthId] <= @MaxMonthId
            GROUP BY
                QuarterId
        ),
        Q_Yearly AS(
            SELECT
                [Year],
                MIN([DATE]) AS [MinDate],
                DATEADD(DD, 1, MAX([DATE])) AS [MaxDate]
            FROM
                [DWH].[DimDate]
            WHERE
                [Year] <= @MaxYear
            GROUP BY
                [Year]
        ),
        Q_Partitions AS(
            -- Monthly
            SELECT 
                [OLAPDatabase].OLAPDatabaseId AS OLAPDatabaseId,
                [Cube].CubeId                 AS CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                'Monthly' AS Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QM.MonthId as PartitionId,
                QM.MinDate,
                QM.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Monthly AS QM
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND ([Measuregroup].Frequency='Monthly' 
                    OR ([Measuregroup].Frequency='Quarterly' 
                         AND QM.MinDate >= CONVERT(CHAR(10), DATEADD(yy, DATEDIFF(yy, 0, DATEADD(MONTH, 1, GETDATE())) -2, 0), 126)))
                AND [Measuregroup].StartDate <= QM.MinDate
            UNION ALL
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].InitialQuery,
                [Measuregroup].InitialSlice,
                [Measuregroup].CreatePartitionModel,
                175301,
                NULL,
                [Measuregroup].StartDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Monthly'
                AND AllBeginning=1
            UNION ALL
            
             --Yearly
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QY.[Year],
                QY.MinDate,
                QY.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Yearly AS QY
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Yearly'
                AND [Measuregroup].StartDate <= QY.MinDate
            
            UNION ALL
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].InitialQuery,
                [Measuregroup].InitialSlice,
                [Measuregroup].CreatePartitionModel,
                1753,
                NULL,
                [Measuregroup].StartDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Yearly'
                AND AllBeginning=1
            UNION ALL
            
            --Quarterly
            SELECT 
                OLAPDatabase.OLAPDatabaseId,
                [Cube].CubeId,
                [Measuregroup].Id AS MeasureGroupId_INT,
                [Measuregroup].MeasureGroupId,
                [Measuregroup].MeasureGroupName,
                [Measuregroup].Frequency,
                [Measuregroup].Query,
                [Measuregroup].Slice,
                [Measuregroup].CreatePartitionModel,
                QM.QuarterId,
                QM.MinDate,
                QM.MaxDate
            FROM       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
            INNER JOIN CubesMetadata.[Cube]            ON [CubeXOLAPDatabase].CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            CROSS JOIN Q_Quarterly AS QM
            WHERE
                [Measuregroup].CreatePartition = 1
                AND (@MeasureGroupName IS NULL OR  [Measuregroup].MeasureGroupName=@MeasureGroupName)
                AND (@CubeName IS NULL OR  [Cube].CubeName=@CubeName)
                AND [Measuregroup].Frequency='Quarterly' 
                AND QM.MinDate < CONVERT(CHAR(10), DATEADD(yy, DATEDIFF(yy, 0, DATEADD(MONTH, 1, GETDATE())) -2, 0), 126)   
                AND [Measuregroup].StartDate <= QM.MinDate
        )
        SELECT 
            ROW_NUMBER() OVER (ORDER BY OLAPDatabaseId,
                                        CubeId,
                                        MeasureGroupId,
                                        PartitionId) AS ID
            , [OLAPDatabaseId]
            , [CubeId]
            , [MeasureGroupId_INT]
            , [MeasureGroupId]
            , [MeasureGroupName]
            , [Frequency]
            , [Query]
            , ISNULL([Slice], '') AS Slice
            , [CreatePartitionModel]
            , [PartitionId]
            , [MinDate]
            , [MaxDate]
        INTO #Partitions
        FROM Q_Partitions AS Q
        WHERE
            (@FromDate IS NULL OR MinDate >= @FromDate) 
            AND (@ToDate IS NULL OR MaxDate <= @ToDate)
            AND NOT EXISTS ( SELECT 1
                             FROM [CubesMetadata].[Partition] AS p
                             WHERE p.CubeId = @CubeId_INT
                                   AND p.MeasureGroupId = Q.[MeasureGroupId_INT]
                                   AND p.PartitionId =Q.PartitionId )
        
        -- create partitions
        SELECT @TotalPartitionsToBeCreated = COUNT(*)
        FROM #Partitions
        
        WHILE ( @CounterPartitionsToBeCreated <= @TotalPartitionsToBeCreated )
        BEGIN
        
            SELECT 
                @DatabaseId         = OLAPDatabaseId,
                @CubeId             = CubeId,
                @MeasureGroupId     = MeasureGroupId,
                @MeasureGroupId_INT = MeasureGroupId_INT,
                @Frequency          = Frequency,
                @PartitionId        = PartitionId,
                @PartitionName      = MeasureGroupId+'_'+CONVERT(NVARCHAR(6), PartitionId), 
                @Query              = Query, 
                @Slice              = Slice, 
                @FromDate           = CONVERT(NVARCHAR(10),CONVERT(DATE, MinDate)), 
                @ToDate             = CONVERT(NVARCHAR(10),CONVERT(DATE, MaxDate))
            FROM #Partitions
            WHERE
                ID = @CounterPartitionsToBeCreated
        
            EXECUTE [CubesMetadata].[p_CreatePartition] 
                                       @DatabaseId
                                       , @CubeId
                                       , @MeasureGroupId
                                       , @MeasureGroupId_INT
                                       , @Frequency
                                       , @PartitionId
                                       , @PartitionName
                                       , @Query
                                       , @Slice
                                       , @FromDate
                                       , @ToDate
                                       , @LoadId               
                                         
        
            SET @CounterPartitionsToBeCreated = @CounterPartitionsToBeCreated + 1
        
        END

        SET @Inserts = @TotalPartitionsToBeCreated
        
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
            , @FromDate
            , @ToDate
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId

    END TRY


    BEGIN CATCH
    
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
            , @FromDate
            , @ToDate
            , 0
            , 0
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , ERROR_NUMBER()
            , ERROR_MESSAGE()
            , @LoadId

    END CATCH
END

GO


