IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_DeletePartition'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_DeletePartition]
GO

--exec [CubesMetadata].[p_DeletePartition] 
--    'Datawarehouse',
--  'Datawarehouse',
--  'Fact Sales Order',
--  201201

CREATE PROC [CubesMetadata].[p_DeletePartition]
    @DatabaseId               NVARCHAR(50),
    @CubeId                   NVARCHAR(50),
    @MeasureGroupId           NVARCHAR(50),
    @PartitionId              INT,
    @LoadId                   DATETIME
AS
BEGIN

    DECLARE
            @ProcessName          NVARCHAR(50) = 'DeletePartition'
            , @Inserts            INT
            , @Updates            INT          = 0
            , @LoadFrom           DATETIME 
            , @StartDate          DATETIME     = GETDATE()
            , @EndDate            DATETIME
            , @Success            NVARCHAR(5)
            , @FromDate           DATE
            , @ToDate             DATE

    BEGIN TRY
        
        -- Verify connectivity to the cube
        DECLARE 
            @connectivity    INT,
            @existsRecord    BIT
        
        SELECT @connectivity = 1
        FROM OPENQUERY([SSAS_PROD] , 'SELECT [Measures].[Sales Amount] ON 0 FROM [Datawarehouse]')
        
        IF ( @connectivity = 1
             AND EXISTS( SELECT 1
                         FROM       CubesMetadata.[OLAPDatabase]
                         INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
                         INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
                         INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
                         INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
                         WHERE 
                             [OLAPDatabase].OLAPDatabaseId = @DatabaseId
                             AND [Cube].CubeId = @CubeId
                             AND [Measuregroup].[MeasureGroupId] = @MeasureGroupId
                             AND [Partition].[PartitionId] = @PartitionId))
        BEGIN
            DECLARE
                @PartitionModel NVARCHAR(MAX)
            
            SELECT
                @PartitionModel = DeletePartitionModel
            FROM
                CubesMetadata.[OLAPDatabase]
            WHERE
                [OLAPDatabase].OLAPDatabaseId = @DatabaseId
            
            SELECT
                @PartitionModel = REPLACE( 
                                  REPLACE(
                                  REPLACE( 
                                  REPLACE(@PartitionModel, '##DatabaseId##', @DatabaseId),
                                                           '##CubeId##', @CubeId), 
                                                           '##MeasureGroupID##', @MeasureGroupId),
                                                           '##PartitionId##', CONVERT(NVARCHAR(50), @PartitionId))

            SELECT
                @FromDate = [Partition].FromDate
                , @ToDate = [Partition].ToDate
            FROM
                       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
            INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
            WHERE
                OLAPDatabase.OLAPDatabaseId = @DatabaseId
                AND [Cube].CubeId = @CubeId
                AND MeasureGroup.MeasureGroupId = @MeasureGroupId
                AND [Partition].PartitionId = @PartitionId
            
            EXEC (@PartitionModel) At [SSAS_PROD];
            
            DELETE [CubesMetadata].[Partition]
            FROM
                       CubesMetadata.[OLAPDatabase]
            INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id = CubeXOLAPDatabase.OLAPDatabaseId
            INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
            INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id = [Measuregroup].CubeId
            INNER JOIN [CubesMetadata].[Partition]     ON [Measuregroup].Id = [Partition].[MeasureGroupId]
            WHERE
                OLAPDatabase.OLAPDatabaseId = @DatabaseId
                AND [Cube].CubeId = @CubeId
                AND MeasureGroup.MeasureGroupId = @MeasureGroupId
                AND [Partition].PartitionId = @PartitionId
        END

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
            , ISNULL(@FromDate, @LoadId)
            , ISNULL(@ToDate, @LoadId)
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


