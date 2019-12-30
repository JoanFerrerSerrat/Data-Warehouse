IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimProduct')
DROP VIEW Source.DimProduct
GO
CREATE VIEW Source.DimProduct AS
SELECT
    DM.ProductID                                              AS ProductCode,
    DM.ProductNumber,
    DM.Name                                                   AS ProductName,
    CASE WHEN DM.MakeFlag=1 THEN 'Yes' ELSE 'No' END          AS MakeIntern,
    CASE WHEN DM.FinishedGoodsFlag=1 THEN 'Yes' ELSE 'No' END AS FinishedGood,                             
    COALESCE(DM.Color, 'Unknown')                             AS Color,
    DM.SafetyStockLevel,                      
    DM.ReorderPoint,                          
    DM.StandardCost,                          
    DM.ListPrice                                              AS SalesPrice,
    DM.Size,
    COALESCE(DM.SizeUnitMeasureCode, 'N/A')                   AS SizeUnitMeasureCode,
    COALESCE(DM.WeightUnitMeasureCode, 'N/A')                 AS WeightUnitMeasureCode,
    DM.[Weight],
    DM.DaysToManufacture,
    PLM.[Name]                                                AS ProductLine,
    PCM.[Name]                                                AS Class,
    PSM.[Name]                                                AS Style,
    COALESCE(PS.[Name], 'Unknown')                            AS ProductSubcategory,
    COALESCE(PC.[Name], 'Unknown')                            AS ProductCategory,
    COALESCE(PM.[Name], 'Unknown')                            AS ProductModel,
    DM.SellStartDate,
    DM.SellEndDate,
   (SELECT MAX(ModifiedDate)
    FROM (VALUES (DM.ModifiedDate),(PS.ModifiedDate),(PC.ModifiedDate), (PM.ModifiedDate)) AS UpdateDate(ModifiedDate)) AS ModifiedDate,
    GETDATE() AS ImportedAt
FROM       AdventureWorks2016CTP3.Production.Product                AS DM
INNER JOIN [ETL].[ProductLineMapping]                               AS PLM ON DM.ProductLine          = PLM.Code
INNER JOIN [ETL].[ProductClassMapping]                              AS PCM ON DM.Class                = PCM.Code
INNER JOIN [ETL].[ProductStyleMapping]                              AS PSM ON DM.Style                = PSM.Code
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductSubcategory] AS PS  ON DM.ProductSubcategoryID = PS.ProductSubcategoryID
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductCategory]    AS PC  ON PS.ProductCategoryID    = PC.ProductCategoryID
LEFT JOIN  AdventureWorks2016_EXT.[Production].[ProductModel]       AS PM  ON DM.ProductModelID       = PM.ProductModelID
GO
