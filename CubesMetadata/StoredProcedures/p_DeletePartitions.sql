IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_DeletePartitions'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_DeletePartitions]
GO

-- EXEC [CubesMetadata].[p_DeletePartitions] 'Datawarehouse', 'Fact Sales Order', '2012-01-01', '2012-03-02'
CREATE PROC [CubesMetadata].[p_DeletePartitions]
    @CubeName         NVARCHAR(200) = 'Datawarehouse',
    @MeasureGroupId   NVARCHAR(200) = NULL,  --='SalesCustomers';
    @FromDate         DATETIME = NULL, -- = '2018-01-01',
    @ToDate           DATETIME = NULL -- = '2019-01-01';
AS
BEGIN

    DECLARE
        @ProcessName          NVARCHAR(50) = 'DeletePartitions'
        , @Inserts            INT
        , @Updates            INT          = 0
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            NVARCHAR(5)
        , @LoadId             DATETIME     = GETDATE()

    BEGIN TRY

        DECLARE 
            @TotalPartitionsToBeDeleted       INT,
            @CounterPartitionsToBeDeleted     INT = 1,
            @DatabaseId                       NVARCHAR(50),
            @CubeId                           NVARCHAR(50),
            @PartitionId                      INT

        SELECT 
            ROW_NUMBER() OVER( ORDER BY [OLAPDatabase].OLAPDatabaseId,
                                        [Cube].CubeId,
                                        [Measuregroup].MeasureGroupId) AS ID,
            [OLAPDatabase].OLAPDatabaseId,
            [Cube].CubeId,
            [Measuregroup].MeasureGroupId,
            [Partition].[PartitionId] AS PartitionId
        INTO #PartitionsToDelete
        FROM       CubesMetadata.[OLAPDatabase]
        INNER JOIN CubesMetadata.CubeXOLAPDatabase  ON [OLAPDatabase].Id = CubeXOLAPDatabase.OLAPDatabaseID
        INNER JOIN CubesMetadata.[Cube]             ON [CubeXOLAPDatabase].CubeId = [Cube].Id
        INNER JOIN CubesMetadata.[Measuregroup]     ON [Cube].Id = [Measuregroup].CubeId
        INNER JOIN CubesMetadata.[Partition]        ON [Measuregroup].Id = [Partition].MeasureGroupId
        INNER JOIN [CubesMetadata].[Partition] AS p ON p.CubeId = [Partition].CubeId
                                               AND p.MeasureGroupId = [Partition].[MeasureGroupId]
                                               AND p.PartitionId =[Partition].PartitionId
        WHERE
            (@FromDate IS NULL OR [Partition].[FromDate] >= @FromDate) 
            AND (@ToDate IS NULL OR [Partition].[ToDate] <= @ToDate)
            AND (@MeasureGroupId IS NULL OR [Measuregroup].[MeasureGroupName] = @MeasureGroupId)
            AND (@CubeName IS NULL OR [Cube].[CubeName] = @CubeName)    
        
        
        SELECT @TotalPartitionsToBeDeleted = COUNT(*)
        FROM #PartitionsToDelete
     
        WHILE ( @CounterPartitionsToBeDeleted <= @TotalPartitionsToBeDeleted )
        BEGIN
        
            SELECT 
                @DatabaseId         = OLAPDatabaseId,
                @CubeId             = CubeId,
                @MeasureGroupId     = MeasureGroupId,
                @PartitionId        = PartitionId
            FROM #PartitionsToDelete
            WHERE
                ID = @CounterPartitionsToBeDeleted
        
        
            EXECUTE [CubesMetadata].[p_DeletePartition] 
                                       @DatabaseId
                                       , @CubeId
                                       , @MeasureGroupId
                                       , @PartitionId
                                       , @LoadId
        
            SET @CounterPartitionsToBeDeleted = @CounterPartitionsToBeDeleted + 1
        
        END

        SET @Inserts = @CounterPartitionsToBeDeleted
        
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
            , CONVERT(DATETIME, @FromDate)
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
            , CONVERT(DATETIME, @FromDate)
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


