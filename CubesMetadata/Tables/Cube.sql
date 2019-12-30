IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='Cube')
BEGIN
    CREATE TABLE CubesMetadata.[Cube](
        [Id] [int] NOT NULL,
        [CubeId] [nvarchar](128) NOT NULL,
        [CubeName] [nvarchar](128) NOT NULL,
        [CubeDescription] [nvarchar](1000) NULL,
        [DatasourceID] [nvarchar](200) NULL,
        [Created] [smalldatetime] NOT NULL CONSTRAINT [DF_Cubes_Created]  DEFAULT (getdate()),
        [Changed] [smalldatetime] NOT NULL CONSTRAINT [DF_Cubes_Changed]  DEFAULT (getdate()),
 CONSTRAINT [PK_Cube] PRIMARY KEY CLUSTERED ( Id ASC )
    ) ON CubesMetadata
END
GO
