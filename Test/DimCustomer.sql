-- Test 1 
-- Action:   Call stored procedure with not valid paremeter
-- Expected: Logged in the table Logging.ETL_Loading the error 'Parameter is wrong, it must be either Incremental or Full'
--           No data inserted or modified in DWH.DimCustomer
-- Result:   OK
EXEC ETL.LoadDimCustomer @TypeLoad = 'Beach'

-- Test 2:   The first time the data is loaded
-- Expected: Look some particular cases transformation and in general for weird data (eg. not acceptable a field where there are only nulls, except if it is expected to fullfill the implementation of that field in the future).
-- Result:   OK
EXEC ETL.LoadDimCustomer  -- By default it will be incremental. Inthe first load it doesn't matter
-- If load worked properly, select some different cases and compare them with the original data
SELECT 
    CONVERT(NVARCHAR(50), C.CustomerID) AS CustomerCode,
    C.AccountNumber,
    --http://www.elsasoft.com/samples/sqlserver_adventureworks/SqlServer.SPRING.KATMAI.AdventureWorks/table_PersonContact.htm
    P.PersonType AS RawPersonType,
    CASE WHEN P.PersonType = 'SC' THEN 'Store Contact'
         WHEN P.PersonType = 'IN' THEN 'Individual (retail) customer'
         WHEN P.PersonType = 'SP' THEN 'Sales person'
         WHEN P.PersonType = 'EM' THEN 'Employee (non-sales)'
         WHEN P.PersonType = 'VC' THEN 'Vendor contact'
         WHEN P.PersonType = 'GC' THEN 'General contact'
         ELSE 'Unknown'
    END AS PersonType,
    S.Name AS Store,
    P.EmailPromotion AS RawEmailPromotion,
    CASE WHEN P.EmailPromotion = 0 THEN 'No Emails'
         WHEN P.EmailPromotion = 1 THEN 'Accepted from AdventureWorks'
         WHEN P.EmailPromotion = 0 THEN 'Accepted from AdventureWorks and partners'
         ELSE 'Unknown'
    END AS EmailPromotion,
   (SELECT MAX(ModifiedDate)
    FROM (VALUES (C.ModifiedDate),(P.ModifiedDate),(S.ModifiedDate), (ST.ModifiedDate)) AS UpdateDate(ModifiedDate)) AS UpdatedDate
FROM      AdventureWorks2016CTP3.Sales.Customer       AS C
LEFT JOIN AdventureWorks2016CTP3.Person.Person        AS P  ON C.PersonID = P.BusinessEntityID
LEFT JOIN AdventureWorks2016CTP3.Sales.Store          AS S  ON C.StoreID  = S.BusinessEntityID
LEFT JOIN AdventureWorks2016CTP3.Sales.SalesTerritory AS ST ON C.TerritoryID = ST.TerritoryID
WHERE C.AccountNumber IN ('AW00000002', 
                          'AW00000391', 
                          'AW00011079',
                          'AW00030109')
GO
SELECT * 
FROM DWH.DimCustomer 
WHERE AccountNumber IN ('AW00000002', 
                       'AW00000391', 
                       'AW00011079',
                       'AW00030109')

Test 3:   Add a customer (row with new key in Source.DimCustomer) and load data in the source DimCustomer view
Expected: New Customer inserted in DWH.DimCustomer with proper data
-- Result:   OK

Test 4:   Change all the fields in the datasource database
Expected: Only change in the fields with SCD1, the other fields with SCD0 should not change
-- Result:   OK

-- The view Source.DimCustomer get modified to perform the test to modify a row and to insert a new one
-- it adds to the view
-- WHERE C.CustomerID != 11079
-- UNION ALL
-- SELECT
--     '11079'      AS CustomerCode,
--     'AW00011079' AS AccountNumber,
--     'Test'       AS PersonType,
--     'Test'       AS Store,
--     'Test'       AS EmailPromotion,
--     GetDate()    AS UpdatedDate
-- UNION ALL
-- SELECT
--     'aa'      AS CustomerCode,
--     'AW000aa' AS AccountNumber,
--     'Test'       AS PersonType,
--     'Test'       AS Store,
--     'Test'       AS EmailPromotion,
--     GetDate()    AS UpdatedDate
SELECT * 
FROM DWH.DimCustomer 
WHERE CustomerCode IN ('11079', 'aa')