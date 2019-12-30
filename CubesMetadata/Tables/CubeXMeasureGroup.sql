-- Table [CubesMetadata].[CubeXMeasureGroup]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='CubeXMeasureGroup')
BEGIN
    CREATE TABLE [CubesMetadata].[CubeXMeasureGroup](
        [CubeXMeasuregroupID] [int] NOT NULL,
        [MeasureGroupID] [int] NOT NULL,
     CONSTRAINT [PK_CubeXMeasureGroup] PRIMARY KEY CLUSTERED ( [CubeXMeasuregroupID] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]

    ALTER TABLE [CubesMetadata].[CubeXMeasureGroup]  WITH CHECK ADD  CONSTRAINT [FK_CubeXMeasureGroup_MeasureGroup] FOREIGN KEY([MeasureGroupId])
    REFERENCES [CubesMetadata].[MeasureGroup] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXMeasureGroup] CHECK CONSTRAINT [FK_CubeXMeasureGroup_MeasureGroup]
END
GO
