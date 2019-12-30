IF NOT EXISTS (
    SELECT 1 
    FROM master.dbo.sysdatabases 
    WHERE name = 'Datawarehouse')
BEGIN
    CREATE DATABASE Datawarehouse
        CONTAINMENT = NONE
        ON  PRIMARY (
            NAME = N'Datawarehouse',
            FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse.mdf',
            SIZE = 8192KB,
            MAXSIZE = UNLIMITED,
            FILEGROWTH = 65536KB
        )
        LOG ON (
            NAME = N'Datawarehouse_log',
            FILENAME = N'C:\Program Files\Microsoft SQL Server\MSSQL13.MSSQLSERVER2016\MSSQL\DATA\Datawarehouse_log.ldf',
            SIZE = 73728KB,
            MAXSIZE = 2048GB,
            FILEGROWTH = 65536KB
        )
END
GO
