IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimProduct')
DROP VIEW ExtDWH.DimProduct
GO
CREATE VIEW ExtDWH.DimProduct
AS
SELECT 
    ProductId
    , ProductCode
    , ProductNumber
    , ProductName
    , MakeIntern
    , FinishedGood
    , Color
    , SafetyStockLevel
    , ReorderPoint
    , StandardCost
    , SalesPrice
    , Size
    , SizeUnitMeasureCode
    , WeightUnitMeasureCode
    , [Weight]
    , DaysToManufacture
    , ProductLine
    , Class
    , Style
    , ProductSubcategory
    , ProductCategory
    , ProductModel
FROM
    DWH.DimProduct
GO
