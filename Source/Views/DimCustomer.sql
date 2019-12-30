IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimCustomer')
DROP VIEW Source.DimCustomer
GO
CREATE VIEW Source.DimCustomer AS
SELECT 
    CONVERT(NVARCHAR(50), C.CustomerID) AS CustomerCode,
    C.AccountNumber,
    --http://www.elsasoft.com/samples/sqlserver_adventureworks/SqlServer.SPRING.KATMAI.AdventureWorks/table_PersonContact.htm
    CASE WHEN P.PersonType = 'SC' THEN 'Store Contact'
         WHEN P.PersonType = 'IN' THEN 'Individual (retail) customer'
         WHEN P.PersonType = 'SP' THEN 'Sales person'
         WHEN P.PersonType = 'EM' THEN 'Employee (non-sales)'
         WHEN P.PersonType = 'VC' THEN 'Vendor contact'
         WHEN P.PersonType = 'GC' THEN 'General contact'
         ELSE 'Unknown'
    END AS PersonType,
    COALESCE(S.Name, 'Unknown ' + CASE WHEN ST.CountryRegionCode = 'US' THEN ST.[Name] + ' USA' ELSE ST.[Name] END) AS Store,
    CASE WHEN P.EmailPromotion = 0 THEN 'No Emails'
         WHEN P.EmailPromotion = 1 THEN 'Accepted from AdventureWorks'
         WHEN P.EmailPromotion = 2 THEN 'Accepted from AdventureWorks and partners'
         ELSE 'Unknown'
    END AS EmailPromotion,
    CASE WHEN ST.CountryRegionCode = 'US' THEN ST.[Name] + ' USA'
         ELSE                                  ST.[Name]
    END AS Region,
    C.ModifiedDate,
   (SELECT MAX(ModifiedDate)
    FROM (VALUES (C.ModifiedDate),(P.ModifiedDate),(S.ModifiedDate), (ST.ModifiedDate)) AS UpdateDate(ModifiedDate)) AS UpdatedDate,
    GetDate() AS ImportedAt
FROM      AdventureWorks2016_EXT.Sales.Customer       AS C
LEFT JOIN AdventureWorks2016_EXT.Person.Person        AS P  ON C.PersonID = P.BusinessEntityID
LEFT JOIN AdventureWorks2016_EXT.Sales.Store          AS S  ON C.StoreID  = S.BusinessEntityID
LEFT JOIN AdventureWorks2016_EXT.Sales.SalesTerritory AS ST ON C.TerritoryID = ST.TerritoryID
GO 

