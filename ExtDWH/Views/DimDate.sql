IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.TABLES
    WHERE TABLE_SCHEMA = 'ExtDWH'
          AND TABLE_NAME = 'DimDate')
DROP VIEW ExtDWH.DimDate
GO
CREATE VIEW ExtDWH.DimDate
AS
SELECT 
    [Date]
    , [DayOfMonth]
    , DaySuffix
    , [DayCharacter]
    , [DayOfWeek]
    , [DayOfYear]
    , WeekOfYear
    , WeekOfYearName
    , [Month]
    , [MonthName]
    , MonthOfQuarter
    , [Quarter]
    , QuarterName
    , [DateName]
    , [Year]
    , YearName
    , MonthYear
    , IsWeekday
    , ImportedAt
FROM 
    DWH.DimDate
GO
