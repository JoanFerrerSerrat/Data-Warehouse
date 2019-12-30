-- Table [CubesMetadata].[CubeXOLAPDatabase]
IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='CubeXOLAPDatabase')
BEGIN
    CREATE TABLE [CubesMetadata].[CubeXOLAPDatabase](
        [CubeXOLAPDatabaseId] [int] NOT NULL,
        [CubeId] [int] NOT NULL,
        [OLAPDatabaseId] [int] NOT NULL,
     CONSTRAINT [PK_CubeXOLAPDatabase] PRIMARY KEY CLUSTERED ( [CubeXOLAPDatabaseId] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]
END
GO
-- NONCLUSTERED INDEX [UQ_CubeXOLAPDatabase]
IF NOT EXISTS (
    SELECT 1 
    FROM sys.indexes
    WHERE 
        object_id = OBJECT_ID(N'[CubesMetadata].[CubeXOLAPDatabase]') AND
        name = N'UQ_CubeXOLAPDatabase'
)
BEGIN
    CREATE UNIQUE NONCLUSTERED INDEX [UQ_CubeXOLAPDatabase] ON [CubesMetadata].[CubeXOLAPDatabase]
    (
        CubeId ASC,
        OLAPDatabaseId ASC
    ) ON CubesMetadata
END
GO
-- FOREIGN KEY FK_CubeXOLAPDatabase_Cubes
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    WHERE 
        TABLE_SCHEMA = 'CubesMetadata' AND
        TABLE_NAME = 'CubeXOLAPDatabase' AND
        CONSTRAINT_NAME = 'FK_CubeXOLAPDatabase_Cubes'
)
BEGIN
    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase]  WITH CHECK ADD  CONSTRAINT [FK_CubeXOLAPDatabase_Cube] FOREIGN KEY([CubeId])
    REFERENCES [CubesMetadata].[Cube] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase] CHECK CONSTRAINT [FK_CubeXOLAPDatabase_Cube]
END
GO
-- FOREIGN KEY [CubesMetadata].[CubeXOLAPDatabase]
IF NOT EXISTS (
    SELECT 1 
    FROM INFORMATION_SCHEMA.CONSTRAINT_TABLE_USAGE
    WHERE 
        TABLE_SCHEMA = 'CubesMetadata' AND
        TABLE_NAME = 'CubeXOLAPDatabase' AND
        CONSTRAINT_NAME = 'FK_CubeXOLAPDatabase_OLAPDatabases'
)
BEGIN
    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase]  WITH CHECK ADD  CONSTRAINT [FK_CubeXOLAPDatabase_OLAPDatabase] FOREIGN KEY([OLAPDatabaseId])
    REFERENCES [CubesMetadata].[OLAPDatabase] ([Id])

    ALTER TABLE [CubesMetadata].[CubeXOLAPDatabase] CHECK CONSTRAINT [FK_CubeXOLAPDatabase_OLAPDatabase]
END
GO
