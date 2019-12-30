IF NOT EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA='Logging'
      AND TABLE_NAME  ='ETL_Loading')
BEGIN
    CREATE TABLE Logging.ETL_Loading(
        ProcessName            NVARCHAR(50)    NOT NULL,
        StartDate              DATETIME        NOT NULL,
        EndDate                DATETIME        NOT NULL,
        Duration               INTEGER         NOT NULL,
        Inserts                INTEGER         NOT NULL,
        Updates                INTEGER         NOT NULL,
        Success                BIT             NOT NULL, 
        ErrorNumber            INTEGER         NULL,
        ErrorMessage           NVARCHAR(4000)  NULL,
        LoadId                 DATETIME        NOT NULL, -- Key all loads
    )
END
GO
