IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ETL'
          AND TABLE_NAME = 'BooleanMapping'
)
BEGIN
    CREATE TABLE ETL.BooleanMapping(
        Id           BIT NOT NULL PRIMARY KEY,
        OnlineOrder  NVARCHAR(18) NOT NULL
    )
END
GO
