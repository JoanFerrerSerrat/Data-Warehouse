IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='FactCurrencyRate')
BEGIN
    CREATE TABLE DWH.FactCurrencyRate(
        CurrencyRateId     INT          PRIMARY KEY,
        CurrencyFromId     INT          NOT NULL,
        CurrencyToId       INT          NOT NULL,
        [Date]             DATE         NULL,
        AverageRate        FLOAT        NOT NULL,
        EndOfDayRate       FLOAT        NOT NULL,
        ModifiedDate       DATETIME     NOT NULL,
        ImportedAt         DATETIME     DEFAULT GETDATE(),
        LoadId             DATETIME
    )

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimCurrencyFrom FOREIGN KEY(CurrencyFromId)
    REFERENCES DWH.DimCurrency (CurrencyId)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimCurrencyFrom

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimCurrencyTo FOREIGN KEY(CurrencyToId)
    REFERENCES DWH.DimCurrency (CurrencyId)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimCurrencyTo

    ALTER TABLE DWH.FactCurrencyRate  WITH CHECK ADD  CONSTRAINT FK_FactCurrencyRate_DimDate FOREIGN KEY(Date)
    REFERENCES DWH.DimDate (Date)

    ALTER TABLE DWH.FactCurrencyRate CHECK CONSTRAINT FK_FactCurrencyRate_DimDate

    CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_FactCurrencyRate_CurrencyFromId_CurrencyToId_Date ] ON DWH.FactCurrencyRate( CurrencyFromId, CurrencyToId, [Date] )
END
GO
