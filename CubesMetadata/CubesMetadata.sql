IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.SCHEMATA
    WHERE SCHEMA_NAME = 'CubesMetadata')
BEGIN
    EXEC('CREATE SCHEMA CubesMetadata AUTHORIZATION dbo')
END
GO