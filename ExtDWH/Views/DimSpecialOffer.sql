IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES 
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimSpecialOffer')
DROP VIEW ExtDWH.DimSpecialOffer
GO
CREATE VIEW ExtDWH.DimSpecialOffer
AS
SELECT 
    SpecialOfferId
    , SpecialOfferCode
    , SpecialOffer
    , DiscountPct
    , [Type]
    , Category
    , MinQty
    , MaxQty
FROM
    DWH.DimSpecialOffer
GO


