IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME ='DimStatusOrder')
BEGIN
    CREATE TABLE DWH.DimStatusOrder(
        StatusOrderId     SMALLINT    PRIMARY KEY NOT NULL,
        StatusOrder       NVARCHAR(20) NOT NULL
    )
END
GO
