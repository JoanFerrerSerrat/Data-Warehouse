IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME = 'DimCurrency'
)
BEGIN
    CREATE TABLE DWH.DimCurrency(
        CurrencyId            INT           NOT NULL IDENTITY PRIMARY KEY,
        CurrencyCode          NCHAR(3)      NOT NULL,
        CurrencyName          NVARCHAR(50)  NOT NULL,
        ImportedAt            DATETIME      DEFAULT GETDATE(),
        LoadId                DATETIME
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimCurrency_CurrencyCode] ON DWH.DimCurrency( CurrencyCode )
GO
