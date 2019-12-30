-- Table [ManageCubes].[MeasureGroup]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='MeasureGroup')
BEGIN
    CREATE TABLE [CubesMetadata].[Measuregroup](
        [Id] [int] IDENTITY(1,1) NOT NULL,
        [CubeId] [int] NOT NULL,
        [MeasureGroupId] [nvarchar](200) NOT NULL,
        [MeasureGroupName] [nvarchar](200) NOT NULL,
        [AggregationDesign] [varchar](50) NULL,
        [Frequency] [nvarchar](20) NOT NULL,
        [CreatePartition] [bit] DEFAULT 1,
        [Query] [nvarchar](max) NULL,
        [StartDate] [datetime] NULL,
        [AllBeginning] [bit] DEFAULT 0,
        [Slice] [nvarchar](max) NULL,
        [InitialSlice] [nvarchar](max) NULL,
        [InitialQuery] [nvarchar](max) NULL,
        [ProcessQuery] [nvarchar](max) NULL,
        [CreatePartitionModel] [nvarchar](max) NULL,
     CONSTRAINT [PK_Measuregroup] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata] TEXTIMAGE_ON [CubesMetadata]

    ALTER TABLE [CubesMetadata].[Measuregroup]  WITH CHECK ADD  CONSTRAINT [FK_Measuregroup_CubeId] FOREIGN KEY([CubeId])
    REFERENCES [CubesMetadata].[Cube] ([Id])

    ALTER TABLE [CubesMetadata].[Measuregroup] CHECK CONSTRAINT [FK_Measuregroup_CubeId]
END
GO
