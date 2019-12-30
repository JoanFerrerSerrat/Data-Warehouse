IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='CubesMetadata'
          AND TABLE_NAME  ='OLAPDatabase')
BEGIN
    CREATE TABLE [CubesMetadata].[OLAPDatabase](
        [Id] [int] NOT NULL,
        [OLAPDatabaseId] [nvarchar](200) NULL,
        [OLAPDatabaseName] [nvarchar](200) NULL,
        [DeletePartitionModel] [nvarchar](max) NULL,
        [Created] [smalldatetime] NOT NULL CONSTRAINT [DF_OLAPDatabases_Created]  DEFAULT (getdate()),
        [Changed] [smalldatetime] NOT NULL CONSTRAINT [DF_OLAPDatabases_Changed]  DEFAULT (getdate()),
     CONSTRAINT [PK_OLAPDatabase] PRIMARY KEY CLUSTERED ( [Id] ASC ) ON [CubesMetadata]
    ) ON [CubesMetadata]
END
GO
