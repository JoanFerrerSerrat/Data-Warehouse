EXEC master.dbo.sp_addlinkedserver @server = N'SSAS_PROD', @srvproduct=N'MSOLAP', @provider=N'MSOLAP', @datasrc=N'Robocop\MSSQLSERVER2016', @catalog=N'Datawarehouse'
GO
EXEC master.dbo.sp_addlinkedsrvlogin @rmtsrvname=N'SSAS_PROD',@useself=N'False',@locallogin=NULL,@rmtuser=NULL,@rmtpassword=NULL
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'collation compatible', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'data access', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'dist', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'pub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'rpc', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'rpc out', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'sub', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'connect timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'collation name', @optvalue=null
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'lazy schema validation', @optvalue=N'false'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'query timeout', @optvalue=N'0'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'use remote collation', @optvalue=N'true'
GO
EXEC master.dbo.sp_serveroption @server=N'SSAS_PROD', @optname=N'remote proc transaction promotion', @optvalue=N'true'
GO
