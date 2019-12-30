IF NOT EXISTS(
    SELECT 1
    FROM [Datawarehouse].sys.filegroups
    WHERE name='SalesOrder')
BEGIN
    ALTER DATABASE [Datawarehouse] ADD FILEGROUP [SalesOrder]

    ALTER DATABASE [Datawarehouse] ADD FILE ( NAME = N'Datawarehouse_SalesOrder'
                                              , FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_SalesOrder.ndf' 
                                              , SIZE = 73728KB 
                                              , FILEGROWTH = 65536KB ) 
                                       TO FILEGROUP [SalesOrder]

END
GO
