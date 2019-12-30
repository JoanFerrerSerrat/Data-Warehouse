IF EXISTS(
    SELECT 1
    FROM INFORMATION_SCHEMA.tables 
    WHERE TABLE_SCHEMA = 'DWH'
          AND TABLE_NAME ='DimDate')
DROP TABLE DWH.DimDate
GO
CREATE TABLE DWH.DimDate(
    [Date]           DATE          NOT NULL PRIMARY KEY,
    [DateName]       NVARCHAR(10)  NOT NULL,
    [DayOfMonth]     INTEGER       NOT NULL,
    DaySuffix        NVARCHAR(8)   NOT NULL,
    [DayCharacter]   NVARCHAR(15)  NOT NULL,
    [DayOfWeek]      INTEGER       NOT NULL,
    [DayOfYear]      INTEGER       NOT NULL,
    WeekOfYear       INTEGER       NOT NULL,
    WeekOfYearName   NVARCHAR(7)   NULL,
    MonthId          INT           NOT NULL,
    [Month]          INTEGER       NOT NULL,
    [MonthName]      NVARCHAR(20)  NOT NULL,
    MonthOfQuarter   INTEGER       NOT NULL,
    QuarterId        INTEGER       NOT NULL,
    [Quarter]        INTEGER       NOT NULL,
    QuarterName      NVARCHAR(7)   NOT NULL,
    [Year]           INTEGER       NOT NULL,
    YearName         NVARCHAR(4)   NOT NULL,
    MonthYear        NVARCHAR(8)   NOT NULL,
    IsWeekday        INTEGER       NOT NULL,
    ImportedAt       DATETIME      DEFAULT GETDATE()
)
GO
