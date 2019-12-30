IF NOT EXISTS(
    SELECT 1
    FROM [Datawarehouse].sys.filegroups
    WHERE name='CubesMetadata')
BEGIN
    ALTER DATABASE [Datawarehouse] ADD FILEGROUP [CubesMetadata]

    ALTER DATABASE [Datawarehouse] ADD FILE ( NAME = N'Datawarehouse_CubesMetadata'
                                              , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_CubesMetadata.ndf' 
                                              , SIZE = 73728KB 
                                              , FILEGROWTH = 65536KB ) 
                                   TO FILEGROUP [CubesMetadata]

END
GO
