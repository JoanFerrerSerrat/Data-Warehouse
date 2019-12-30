CREATE TABLE [CubesMetadata].[Partition](
    [CubeId] [int] DEFAULT 1,
    [MeasureGroupId] [int] NOT NULL,
    [PartitionId] [int] NOT NULL,
    [Frequency] [nvarchar](20) NULL,
    [FromDate] [datetime] NULL,
    [ToDate] [datetime] NULL,
    [Script] [nvarchar](max) NULL,
    [PartitionName] [nvarchar](50) NULL,
    [ActualisedDate] [datetime] DEFAULT (getdate()),
 CONSTRAINT [PK_CubesMetadata_Partition] PRIMARY KEY CLUSTERED 
    (
        [PartitionId] ASC,
        [MeasureGroupId] ASC,
        [CubeId] ASC
    ) ON [CubesMetadata]
) ON [CubesMetadata] TEXTIMAGE_ON [CubesMetadata]

GO

