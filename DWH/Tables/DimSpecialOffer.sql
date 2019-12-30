IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimSpecialOffer')
BEGIN
    CREATE TABLE DWH.DimSpecialOffer(
        SpecialOfferId   INT           IDENTITY(1,1) PRIMARY KEY NOT NULL,
        SpecialOfferCode INT                                     NOT NULL,
        SpecialOffer     NVARCHAR(255)                           NOT NULL,
        DiscountPct      SMALLMONEY                              NOT NULL,
        [Type]           NVARCHAR(50)                            NOT NULL,
        Category         NVARCHAR(50)                            NOT NULL,
        StartDate        DATETIME                                NOT NULL,
        EndDate          DATETIME                                NOT NULL,
        MinQty           INT                                     NOT NULL,
        MaxQty           INT                                     NULL,
        ModifiedDate     DATETIME                                NOT NULL,
        ImportedAt       DATETIME                                DEFAULT GETDATE(),
        LoadId           DATETIME                                NOT NULL
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimSpecialOffer_SpecialOfferCode ] ON DWH.DimSpecialOffer( SpecialOfferCode )
GO
