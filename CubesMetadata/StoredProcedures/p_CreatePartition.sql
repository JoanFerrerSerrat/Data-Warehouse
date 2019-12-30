IF EXISTS (
    SELECT *
    FROM INFORMATION_SCHEMA.ROUTINES
    WHERE ROUTINE_NAME = 'p_CreatePartition'
          AND SPECIFIC_SCHEMA  = 'CubesMetadata')
DROP PROC [CubesMetadata].[p_CreatePartition]
GO
CREATE PROC [CubesMetadata].[p_CreatePartition]
    @DatabaseId               NVARCHAR(50),
    @CubeId                   NVARCHAR(50),
    @MeasureGroupId           NVARCHAR(50),
    @MeasureGroupId_INT       INT,
    @Frequency                NVARCHAR(20),-- = 'Monthly','Yearly','Monthly',
    @PartitionId              INT,
    @PartitionName            NVARCHAR(50),
    @Query                    NVARCHAR(MAX),
    @Slice                    NVARCHAR(MAX) = '',
    @FromDate                 DATETIME,
    @ToDate                   DATETIME,
    @LoadId                   DATETIME
AS
BEGIN

    DECLARE
        @ProcessName          NVARCHAR(50) = 'CreatePartition'
        , @Inserts            INT
        , @Updates            INT          = 0
        --, @LoadFrom           DATETIME     = @FromDate 
        , @StartDate          DATETIME     = GETDATE()
        , @EndDate            DATETIME
        , @Success            NVARCHAR(5)
        , @LoadId_            DATETIME     = GETDATE()

    BEGIN TRY

        DECLARE
            @CubeId_INT         INT
            , @connectivity       INT

        SELECT @CubeId_INT=Id 
        FROM [CubesMetadata].[Cube] 
        WHERE CubeId = @CubeId
        
        -- Verify connectivity to the cube
        SELECT @connectivity = 1
        FROM OPENQUERY([SSAS_PROD] , 'SELECT [Measures].[Sales Amount] ON 0 FROM [Datawarehouse]')
        
        IF ( @connectivity = 1
             AND EXISTS( SELECT 1
                         FROM       CubesMetadata.[OLAPDatabase]
                         INNER JOIN CubesMetadata.CubeXOLAPDatabase ON OLAPDatabase.Id          = CubeXOLAPDatabase.OLAPDatabaseId
                         INNER JOIN CubesMetadata.[Cube]            ON CubeXOLAPDatabase.CubeId = [Cube].Id
                         INNER JOIN CubesMetadata.[Measuregroup]    ON [Cube].Id                = [Measuregroup].CubeId
                         INNER JOIN CubesMetadata.[Partition]       ON [Measuregroup].Id        = [Partition].MeasuregroupId
                         WHERE
                             [OLAPDatabase].OLAPDatabaseId     = @DatabaseId
                             AND [Cube].CubeId                 = @CubeId
                             AND [Measuregroup].MeasureGroupId = @MeasureGroupId
                             AND [Partition].PartitionId       = @PartitionId))
        BEGIN
            --PRINT 'Delete Partition ' + convert(nvarchar(10), @PartitionId)
            EXECUTE [CubesMetadata].[p_DeletePartition] 
                                        @DatabaseId
                                       ,@CubeId
                                       ,@MeasureGroupId
                                       ,@PartitionId
        
        END
        
        DECLARE
            @PartitionModel NVARCHAR(MAX)
        
        SELECT
            @PartitionModel = [Measuregroup].CreatePartitionModel
        FROM
            CubesMetadata.[Measuregroup]
        WHERE
            [Measuregroup].MeasureGroupId = @MeasureGroupId
        
        SET
           @Slice = ISNULL(@Slice, '')
        
        
        SELECT
            @PartitionModel = REPLACE(
                              REPLACE(
                              REPLACE(
                              REPLACE( 
                              REPLACE(
                              REPLACE( 
                              REPLACE(@PartitionModel, '##DatabaseID##', @DatabaseId),
                                                       '##CubeID##', @CubeId), 
                                                       '##MeasureGroupID##', @MeasureGroupId),
                                                       '##PartitionID##', CONVERT(NVARCHAR(10), @PartitionId)),
                                                       '##PartitionName##', @PartitionName),
                                                       '##Query##', @Query),
                                                       '##Slice##', @Slice)
        
        SELECT
            @PartitionModel = REPLACE(
                              REPLACE(@PartitionModel, '##StartDate##', CONVERT(NVARCHAR(10), CONVERT(DATE, @FromDate))),
                                                       '##EndDate##', CONVERT(NVARCHAR(10), CONVERT(DATE, @ToDate)))
        
        EXEC (@PartitionModel) At [SSAS_PROD];
        
        INSERT INTO [CubesMetadata].[Partition](
            CubeId,
            [MeasureGroupId],
            [PartitionId],
            [Frequency],
            [FromDate],
            [ToDate],
            [Script],
            [PartitionName])
        SELECT
            @CubeId_INT,
            @MeasureGroupId_INT,
            @PartitionId,
            @Frequency,
            CONVERT(DATE, @FromDate),
            CONVERT(DATE, @ToDate),
            @PartitionModel,
            @PartitionName

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
            , CONVERT(DATE, @FromDate)
            , CONVERT(DATE, @ToDate)
            , @Inserts
            , @Updates
            , DATEDIFF(MILLISECOND, @StartDate, @EndDate)
            , @Success
            , @LoadId_

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
            , CONVERT(DATE, @FromDate)
            , CONVERT(DATE, @ToDate)
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


