IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'ProductLineMapping'
)
BEGIN
    CREATE TABLE ETL.ProductLineMapping(
        Code    CHAR(1) NOT NULL PRIMARY KEY,
        [Name]  NVARCHAR(20)
    )
END
GO
