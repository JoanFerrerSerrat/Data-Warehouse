IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'Source'
      AND TABLE_NAME = 'DimSpecialOffer')
DROP VIEW Source.DimSpecialOffer
GO
CREATE VIEW Source.DimSpecialOffer AS
SELECT 
    SpecialOfferID    AS SpecialOfferCode,
    [Description]     AS SpecialOffer,
    DiscountPct,
    [Type],
    Category,
    StartDate,
    EndDate,
    MinQty,
    ISNULL(MaxQty, 0) AS MaxQty,
    ModifiedDate
FROM 
    AdventureWorks2016_EXT.Sales.SpecialOffer
GO
