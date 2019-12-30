
CREATE TABLE #DataWarehouse_DimCustomer(
    CustomerId          INT             NOT NULL IDENTITY(1,1) PRIMARY KEY,
    CustomerCode        NVARCHAR(10)    NOT NULL,
    AccountNumber       NVARCHAR(10)    NOT NULL,
    PersonType          NVARCHAR(28)    NOT NULL,
    Store               NVARCHAR(50)    NULL,
    EmailPromotion      NVARCHAR(41)    NOT NULL,
    Region              NVARCHAR(30)    NOT NULL,
    StartDate           DATE            NOT NULL,
    EndDate             DATE            NULL,
    [Status]            NVARCHAR(7)     NULL,
    ImportedAt          DATETIME        DEFAULT GETDATE()
);

-- Load fake Data Warehouse dimension Customer before the test load
WITH Q_DWH AS(
SELECT
    1                         AS CustomerId,
    'C1'                      AS CustomerCode,
    'C1'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20100101') AS StartDate,
    CONVERT(DATE, '20180101') AS EndDate,
    NULL                      AS [Status]
UNION ALL
SELECT
    2                         AS CustomerId,
    'C1'                      AS CustomerCode,
    'C1'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180102') AS StartDate,
    NULL                      AS EndDate,
    'Current'                 AS [Status]
UNION ALL
SELECT
    3                         AS CustomerId,
    'C2'                      AS CustomerCode,
    'C2'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store3'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20100101') AS StartDate,
    CONVERT(DATE, '20180101') AS EndDate,
    NULL                      AS [Status]
UNION ALL
SELECT
    4                         AS CustomerId,
    'C2'                      AS CustomerCode,
    'C2'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store3'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180102') AS StartDate,
    NULL                      AS EndDate,
    'Current'                 AS [Status]
UNION ALL
SELECT
    5                         AS CustomerId,
    'C3'                      AS CustomerCode,
    'C3'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20100101') AS StartDate,
    CONVERT(DATE, '20180101') AS EndDate,
    NULL                      AS [Status]
UNION ALL
SELECT
    6                         AS CustomerId,
    'C3'                      AS CustomerCode,
    'C3'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180102') AS StartDate,
    NULL                      AS EndDate,
    'Current'                 AS [Status]
UNION ALL
SELECT
    7                         AS CustomerId,
    'C4'                      AS CustomerCode,
    'C4'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store3'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20100101') AS StartDate,
    CONVERT(DATE, '20180101') AS EndDate,
    NULL                      AS [Status]
UNION ALL
SELECT
    8                         AS CustomerId,
    'C4'                      AS CustomerCode,
    'C4'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store3'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180102') AS StartDate,
    NULL                      AS EndDate,
    'Current'                 AS [Status]
)
INSERT INTO #DataWarehouse_DimCustomer(
    CustomerCode,
    AccountNumber,
    PersonType,
    Store,
    EmailPromotion,
    Region,
    StartDate,
    EndDate,
    [Status])
SELECT
    CustomerCode,
    AccountNumber,
    PersonType,
    Store,
    EmailPromotion,
    Region,
    StartDate,
    EndDate,
    [Status]
FROM Q_DWH;

-- Test Load - Identify diferent cases that requires an action in the load:
-- SCD 1:        Update
-- SCD 2:        Update and Insert
-- SCD 2 and 1:  Update and Insert
-- New Customer: Insert
WITH Q_Source AS(
--C1 SCD 0
SELECT
    'C1'                      AS CustomerCode,
    'C1'                      AS AccountNumber,
    'P1'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180202') AS ModifiedDate,
    CONVERT(DATE, '20180203') AS UpdatedDate,
    GETDATE()                 AS ImportedAt
UNION ALL
--C2 SCD 1
SELECT
    'C2'                      AS CustomerCode,
    'C2'                      AS AccountNumber,
    'P2'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'Europe'                  AS Region,
    CONVERT(DATE, '20180202') AS ModifiedDate,
    CONVERT(DATE, '20180203') AS UpdatedDate,
    GETDATE()                 AS ImportedAt
UNION ALL
--C3 SCD 2
SELECT
    'C3'                      AS CustomerCode,
    'C3'                      AS AccountNumber,
    'P1'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20180202') AS ModifiedDate,
    CONVERT(DATE, '20180203') AS UpdatedDate,
    GETDATE()                 AS ImportedAt
UNION ALL
--C4 SCD 1 and 2
SELECT
    'C4'                      AS CustomerCode,
    'C4'                      AS AccountNumber,
    'P1'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20180202') AS ModifiedDate,
    CONVERT(DATE, '20180203') AS UpdatedDate,
    GETDATE()                 AS ImportedAt
UNION ALL
-- C5 New Customer
SELECT
    'C5'                      AS CustomerCode,
    'C5'                      AS AccountNumber,
    'P1'                      AS PersonType,
    'Store2'                  AS Store,
    'b@b.com'                 AS EmailPromotion,
    'America'                 AS Region,
    CONVERT(DATE, '20180202') AS ModifiedDate,
    CONVERT(DATE, '20180203') AS UpdatedDate,
    GETDATE()                 AS ImportedAt
)
SELECT
    Source.CustomerCode,
    COALESCE( Datawarehouse.AccountNumber, Source.AccountNumber) AS AccountNumber,
    COALESCE( Datawarehouse.PersonType, Source.PersonType)       AS PersonType,
    CASE 
        WHEN ( Source.Store != Datawarehouse.Store OR Source.EmailPromotion != Datawarehouse.EmailPromotion )
             AND Source.Region != Datawarehouse.Region
            THEN 'SCD 1 and SCD 2'
        WHEN ( Source.Store != Datawarehouse.Store OR Source.EmailPromotion != Datawarehouse.EmailPromotion )
            THEN 'SCD 1'
        WHEN Source.Region != Datawarehouse.Region
            THEN 'SCD 2'
        WHEN Datawarehouse.CustomerCode IS NULL
            THEN 'New Customer'
    END AS StatusLoad,
    Source.Store,
    Source.EmailPromotion,
    Source.Region,
    Source.ModifiedDate,
    Source.ImportedAt
INTO #LoadCustomers
FROM      Q_Source  AS Source
LEFT JOIN #DataWarehouse_DimCustomer AS Datawarehouse  ON source.CustomerCode = Datawarehouse.CustomerCode
                                                          AND Datawarehouse.[Status] = 'Current'
WHERE
    -- SC1 
    Source.Store != Datawarehouse.Store 
    OR Source.EmailPromotion != Datawarehouse.EmailPromotion
    -- SC2
    OR Source.Region != Datawarehouse.Region
    -- New Customer
    OR Datawarehouse.CustomerCode IS NULL

SELECT *
INTO #DataWarehouse_DimCustomer_Before
FROM #DataWarehouse_DimCustomer;

SELECT * FROM #DataWarehouse_DimCustomer_Before
SELECT * FROM #LoadCustomers
-- Case SC0 is excluded because it doesn't require any action

-- IF SCD 1 UPDATE Store and EmailPromotion with new values
UPDATE DataWarehouse_DimCustomer
SET Store          = Source.Store,
    EmailPromotion = Source.EmailPromotion
FROM       #DataWarehouse_DimCustomer AS DataWarehouse_DimCustomer
INNER JOIN #LoadCustomers             AS Source      ON DataWarehouse_DimCustomer.CustomerCode = Source.CustomerCode
WHERE
    Source.StatusLoad = 'SCD 1 and SCD 2'
    OR Source.StatusLoad = 'SCD 1'

SELECT * FROM #DataWarehouse_DimCustomer_Before
SELECT * FROM #LoadCustomers
SELECT * FROM #DataWarehouse_DimCustomer
-- C2 and C4 update the field Store with the new value of Store. If the field EmailPromotion would change, it would be also updated

-- IF SCD 2 UPDATE EndDate with ModifiedDate and Status with NULL where Status = 'Current'
UPDATE DataWarehouse_DimCustomer
SET EndDate        = Source.ModifiedDate,
    [Status]       = NULL
FROM       #DataWarehouse_DimCustomer AS DataWarehouse_DimCustomer
INNER JOIN #LoadCustomers             AS Source      ON DataWarehouse_DimCustomer.CustomerCode = Source.CustomerCode 
                                                        AND DataWarehouse_DimCustomer.[Status] = 'Current'
WHERE
    Source.StatusLoad = 'SCD 1 and SCD 2'
    OR Source.StatusLoad = 'SCD 2'

SELECT * FROM #DataWarehouse_DimCustomer_Before
SELECT * FROM #LoadCustomers
SELECT * FROM #DataWarehouse_DimCustomer
-- C3 and C4 must be assigned the EndDate with ModifiedDate and the status is not current any more because it must be inserted a new version

-- IF SC2 or new customer INSERT
INSERT INTO #DataWarehouse_DimCustomer(
    CustomerCode,
    AccountNumber,
    PersonType,
    Store,
    EmailPromotion,
    Region,
    StartDate,
    EndDate,
    [Status]
    )
SELECT
    Source.CustomerCode,
    Source.AccountNumber,
    Source.PersonType,
    Source.Store,
    Source.EmailPromotion,
    Source.Region,
    Source.ModifiedDate,
    NULL,
    'Current'
FROM #LoadCustomers             AS Source
WHERE
    Source.StatusLoad = 'SCD 1 and SCD 2'
    OR Source.StatusLoad = 'SCD 2'
    OR Source.StatusLoad = 'New Customer'  
    
SELECT * FROM #DataWarehouse_DimCustomer_Before
SELECT * FROM #LoadCustomers
SELECT * FROM #DataWarehouse_DimCustomer
-- The last 3 records of #DataWarehouse_DimCustomer have been inserted CustomerId 9 and 10 SCD2 because Region has changed and CustomerId 11 because it is a new customer

-- Test load real data
DROP TABLE #DataWarehouse_DimCustomerOld

SELECT * INTO #DataWarehouse_DimCustomerOld FROM DWH.DimCustomer

EXEC ETL.LoadDimCustomer

SELECT * FROM #DataWarehouse_DimCustomerOld
EXCEPT
SELECT * FROM DWH.DimCustomer
-- No rows retrieved (as long as data has not been modified)

SELECT * FROM DWH.DimCustomer
EXCEPT
SELECT * FROM #DataWarehouse_DimCustomerOld
-- No rows retrieved (as long as data has not been modified)