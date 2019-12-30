IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA='DWH'
          AND TABLE_NAME  ='DimCustomer')
BEGIN
    CREATE TABLE DWH.DimCustomer(
        CustomerId          INT             NOT NULL IDENTITY PRIMARY KEY,
        CustomerCode        NVARCHAR(10)    NOT NULL,
        AccountNumber       NVARCHAR(10)    NOT NULL,
        PersonType          NVARCHAR(28)    NOT NULL,
        Store               NVARCHAR(50)    NULL,
        EmailPromotion      NVARCHAR(41)    NOT NULL,
        Region              NVARCHAR(30)    NOT NULL,
        StartDate           DATE            NOT NULL,
        EndDate             DATE            NULL,
        [Status]            NVARCHAR(7)     NULL,
        ModifiedDate        DATETIME        NOT NULL,
        ImportedAt          DATETIME        DEFAULT GETDATE(),
        LoadId              DATETIME        NOT NULL
    )
END
GO
CREATE UNIQUE NONCLUSTERED INDEX [IX_DWH_DimCustomer_CustomerCode_StartDate] ON DWH.DimCustomer( CustomerCode, StartDate )
GO
