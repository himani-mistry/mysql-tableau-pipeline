CREATE DATABASE IF NOT EXISTS adventureworks_dw;
USE adventureworks_dw;
-- AdventureWorksDW2017 — direct load via LOAD DATA LOCAL INFILE
-- Reads original UTF-16 tab-delimited files directly, no preprocessing needed
-- SET GLOBAL local_infile = 1;


-- 1. DimDate

DROP TABLE IF EXISTS dimdate;
CREATE TABLE dimdate (
    CalendarQuarter TINYINT,
    CalendarYear SMALLINT,
    DateKey INT PRIMARY KEY,
    DayNumberOfMonth TINYINT,
    DayNumberOfWeek TINYINT,
    DayNumberOfYear SMALLINT,
    EnglishDayNameOfWeek VARCHAR(15),
    EnglishMonthName VARCHAR(15),
    FiscalQuarter TINYINT,
    FiscalYear SMALLINT,
    FrenchDayNameOfWeek VARCHAR(15),
    FrenchMonthName VARCHAR(15),
    FullDateAlternateKey VARCHAR(30),
    MonthNumberOfYear TINYINT,
    SpanishDayNameOfWeek VARCHAR(15),
    SpanishMonthName VARCHAR(15),
    WeekNumberOfYear TINYINT,
    CalendarSemester TINYINT,
    FiscalSemester TINYINT
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimDate (AdventureWorksDW2017)_DimDate.csv'
INTO TABLE dimdate
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(CalendarQuarter, CalendarYear, DateKey, DayNumberOfMonth, DayNumberOfWeek, DayNumberOfYear,
 EnglishDayNameOfWeek, EnglishMonthName, FiscalQuarter, FiscalYear, FrenchDayNameOfWeek,
 FrenchMonthName, FullDateAlternateKey, MonthNumberOfYear, SpanishDayNameOfWeek,
 SpanishMonthName, WeekNumberOfYear, CalendarSemester, FiscalSemester);


-- 2. DimProductCategory

DROP TABLE IF EXISTS dimproductcategory;
CREATE TABLE dimproductcategory (
    EnglishProductCategoryName VARCHAR(50),
    FrenchProductCategoryName VARCHAR(50),
    ProductCategoryAlternateKey INT,
    ProductCategoryKey INT PRIMARY KEY,
    SpanishProductCategoryName VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimProductCategory (AdventureWorksDW2017)_DimProductCategory.csv'
INTO TABLE dimproductcategory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EnglishProductCategoryName, FrenchProductCategoryName, ProductCategoryAlternateKey,
 ProductCategoryKey, SpanishProductCategoryName);


-- 3. DimProductSubcategory

DROP TABLE IF EXISTS dimproductsubcategory;
CREATE TABLE dimproductsubcategory (
    EnglishProductSubcategoryName VARCHAR(50),
    FrenchProductSubcategoryName VARCHAR(50),
    ProductCategoryKey INT,
    ProductSubcategoryAlternateKey INT,
    ProductSubcategoryKey INT PRIMARY KEY,
    SpanishProductSubcategoryName VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimProductSubcategory (AdventureWorksDW2017)_DimProductSubcategory.csv'
INTO TABLE dimproductsubcategory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EnglishProductSubcategoryName, FrenchProductSubcategoryName, ProductCategoryKey,
 ProductSubcategoryAlternateKey, ProductSubcategoryKey, SpanishProductSubcategoryName);


-- 4. DimSalesTerritory

DROP TABLE IF EXISTS dimsalesterritory;
CREATE TABLE dimsalesterritory (
    SalesTerritoryAlternateKey INT,
    SalesTerritoryCountry VARCHAR(50),
    SalesTerritoryGroup VARCHAR(50),
    SalesTerritoryImage TEXT,
    SalesTerritoryKey INT PRIMARY KEY,
    SalesTerritoryRegion VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimSalesTerritory (AdventureWorksDW2017)_DimSalesTerritory.csv'
INTO TABLE dimsalesterritory
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(SalesTerritoryAlternateKey, SalesTerritoryCountry, SalesTerritoryGroup, SalesTerritoryImage,
 SalesTerritoryKey, SalesTerritoryRegion);


-- 5. DimProduct (translation/photo columns skipped via @dummy)

DROP TABLE IF EXISTS dimproduct;
CREATE TABLE dimproduct (
    Class VARCHAR(5),
    Color VARCHAR(20),
    EndDate VARCHAR(30),
    EnglishDescription TEXT,
    EnglishProductName VARCHAR(100),
    FinishedGoodsFlag VARCHAR(10),
    ModelName VARCHAR(100),
    ProductAlternateKey VARCHAR(20),
    ProductKey INT PRIMARY KEY,
    ProductLine VARCHAR(5),
    ProductSubcategoryKey INT,
    Size VARCHAR(10),
    SizeRange VARCHAR(20),
    SizeUnitMeasureCode VARCHAR(10),
    StartDate VARCHAR(30),
    Status VARCHAR(20),
    Style VARCHAR(5),
    WeightUnitMeasureCode VARCHAR(10),
    DaysToManufacture INT,
    DealerPrice DECIMAL(10,4),
    ListPrice DECIMAL(10,4),
    ReorderPoint INT,
    SafetyStockLevel INT,
    StandardCost DECIMAL(10,4),
    Weight DECIMAL(10,2)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimProduct (AdventureWorksDW2017)_DimProduct.csv'
INTO TABLE dimproduct
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@ArabicDescription, @ChineseDescription, Class, Color, EndDate, EnglishDescription,
 EnglishProductName, FinishedGoodsFlag, @FrenchDescription, @FrenchProductName,
 @GermanDescription, @HebrewDescription, @JapaneseDescription, @LargePhoto, ModelName,
 ProductAlternateKey, ProductKey, ProductLine, ProductSubcategoryKey, Size, SizeRange,
 SizeUnitMeasureCode, @SpanishProductName, StartDate, Status, Style, @ThaiDescription,
 @TurkishDescription, WeightUnitMeasureCode, DaysToManufacture, DealerPrice, ListPrice,
 ReorderPoint, SafetyStockLevel, StandardCost, Weight);


-- 6. DimGeography (French/Spanish names + IP locator skipped)

DROP TABLE IF EXISTS dimgeography;
CREATE TABLE dimgeography (
    City VARCHAR(50),
    CountryRegionCode VARCHAR(10),
    EnglishCountryRegionName VARCHAR(50),
    GeographyKey INT PRIMARY KEY,
    PostalCode VARCHAR(20),
    SalesTerritoryKey INT,
    StateProvinceCode VARCHAR(10),
    StateProvinceName VARCHAR(50)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimGeography (AdventureWorksDW2017)_DimGeography.csv'
INTO TABLE dimgeography
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(City, CountryRegionCode, EnglishCountryRegionName, @FrenchCountryRegionName, GeographyKey,
 @IpAddressLocator, PostalCode, SalesTerritoryKey, @SpanishCountryRegionName,
 StateProvinceCode, StateProvinceName);


-- 7. DimPromotion (French/Spanish columns skipped)

DROP TABLE IF EXISTS dimpromotion;
CREATE TABLE dimpromotion (
    EndDate VARCHAR(30),
    EnglishPromotionCategory VARCHAR(50),
    EnglishPromotionName VARCHAR(50),
    EnglishPromotionType VARCHAR(50),
    PromotionAlternateKey INT,
    PromotionKey INT PRIMARY KEY,
    StartDate VARCHAR(30),
    DiscountPct DECIMAL(6,4),
    MaxQty INT,
    MinQty INT
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimPromotion (AdventureWorksDW2017)_DimPromotion.csv'
INTO TABLE dimpromotion
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(EndDate, EnglishPromotionCategory, EnglishPromotionName, EnglishPromotionType,
 @FrenchPromotionCategory, @FrenchPromotionName, @FrenchPromotionType, PromotionAlternateKey,
 PromotionKey, @SpanishPromotionCategory, @SpanishPromotionName, @SpanishPromotionType,
 StartDate, DiscountPct, MaxQty, MinQty);


-- 8. DimCustomer (French/Spanish education/occupation skipped)

DROP TABLE IF EXISTS dimcustomer;
CREATE TABLE dimcustomer (
    AddressLine1 VARCHAR(120),
    AddressLine2 VARCHAR(120),
    BirthDate VARCHAR(20),
    CommuteDistance VARCHAR(20),
    CustomerAlternateKey VARCHAR(20),
    CustomerKey INT PRIMARY KEY,
    DateFirstPurchase VARCHAR(20),
    EmailAddress VARCHAR(100),
    EnglishEducation VARCHAR(50),
    EnglishOccupation VARCHAR(50),
    FirstName VARCHAR(50),
    Gender VARCHAR(5),
    GeographyKey INT,
    HouseOwnerFlag VARCHAR(5),
    LastName VARCHAR(50),
    MaritalStatus VARCHAR(5),
    MiddleName VARCHAR(50),
    NameStyle VARCHAR(5),
    Phone VARCHAR(30),
    Suffix VARCHAR(20),
    Title VARCHAR(20),
    NumberCarsOwned INT,
    NumberChildrenAtHome INT,
    TotalChildren INT,
    YearlyIncome DECIMAL(12,2)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_DimCustomer (AdventureWorksDW2017)_DimCustomer.csv'
INTO TABLE dimcustomer
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(AddressLine1, AddressLine2, BirthDate, CommuteDistance, CustomerAlternateKey, CustomerKey,
 DateFirstPurchase, EmailAddress, EnglishEducation, EnglishOccupation, FirstName,
 @FrenchEducation, @FrenchOccupation, Gender, GeographyKey, HouseOwnerFlag, LastName,
 MaritalStatus, MiddleName, NameStyle, Phone, @SpanishEducation, @SpanishOccupation,
 Suffix, Title, NumberCarsOwned, NumberChildrenAtHome, TotalChildren, YearlyIncome);


-- 9. FactInternetSales (tracking number + PO number skipped)

DROP TABLE IF EXISTS factinternetsales;
CREATE TABLE factinternetsales (
    CurrencyKey INT,
    CustomerKey INT,
    DueDate VARCHAR(30),
    DueDateKey INT,
    OrderDate VARCHAR(30),
    OrderDateKey INT,
    ProductKey INT,
    PromotionKey INT,
    RevisionNumber INT,
    SalesOrderLineNumber INT,
    SalesOrderNumber VARCHAR(30),
    SalesTerritoryKey INT,
    ShipDate VARCHAR(30),
    ShipDateKey INT,
    DiscountAmount DECIMAL(10,2),
    ExtendedAmount DECIMAL(12,2),
    Freight DECIMAL(10,2),
    OrderQuantity INT,
    ProductStandardCost DECIMAL(10,4),
    SalesAmount DECIMAL(12,2),
    TaxAmt DECIMAL(10,2),
    TotalProductCost DECIMAL(10,4),
    UnitPrice DECIMAL(10,4),
    UnitPriceDiscountPct DECIMAL(6,4),
    PRIMARY KEY (SalesOrderNumber, SalesOrderLineNumber)
);

LOAD DATA LOCAL INFILE '/Users/himanimistry/Documents/DW_DataSets/clean_FactInternetSales (AdventureWorksDW2017)_FactInternetSales.csv'
INTO TABLE factinternetsales
CHARACTER SET utf8mb4
FIELDS TERMINATED BY '\t'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS
(@CarrierTrackingNumber, CurrencyKey, CustomerKey, @CustomerPONumber, DueDate, DueDateKey,
 OrderDate, OrderDateKey, ProductKey, PromotionKey, RevisionNumber, SalesOrderLineNumber,
 SalesOrderNumber, SalesTerritoryKey, ShipDate, ShipDateKey, DiscountAmount, ExtendedAmount,
 Freight, OrderQuantity, ProductStandardCost, SalesAmount, TaxAmt, TotalProductCost,
 UnitPrice, UnitPriceDiscountPct);


-- Verification — row counts for every table
SELECT 'dimdate' AS tbl, COUNT(*) AS row_count FROM dimdate
UNION ALL SELECT 'dimproductcategory', COUNT(*) FROM dimproductcategory
UNION ALL SELECT 'dimproductsubcategory', COUNT(*) FROM dimproductsubcategory
UNION ALL SELECT 'dimsalesterritory', COUNT(*) FROM dimsalesterritory
UNION ALL SELECT 'dimproduct', COUNT(*) FROM dimproduct
UNION ALL SELECT 'dimgeography', COUNT(*) FROM dimgeography
UNION ALL SELECT 'dimpromotion', COUNT(*) FROM dimpromotion
UNION ALL SELECT 'dimcustomer', COUNT(*) FROM dimcustomer
UNION ALL SELECT 'factinternetsales', COUNT(*) FROM factinternetsales;

SELECT * FROM dimdate LIMIT 5;
SELECT * FROM dimproductcategory LIMIT 5;
SELECT * FROM dimproductsubcategory LIMIT 5;
SELECT * FROM dimsalesterritory LIMIT 5;
SELECT * FROM dimproduct LIMIT 5;
SELECT * FROM dimgeography LIMIT 5;
SELECT * FROM dimpromotion LIMIT 5;
SELECT * FROM dimcustomer LIMIT 5;
SELECT * FROM factinternetsales LIMIT 5;

SELECT 
    f.SalesOrderNumber,
    d.FullDateAlternateKey AS OrderDate,
    p.EnglishProductName,
    c.FirstName,
    c.LastName,
    t.SalesTerritoryRegion,
    f.SalesAmount
FROM factinternetsales f
JOIN dimdate d ON f.OrderDateKey = d.DateKey
JOIN dimproduct p ON f.ProductKey = p.ProductKey
JOIN dimcustomer c ON f.CustomerKey = c.CustomerKey
JOIN dimsalesterritory t ON f.SalesTerritoryKey = t.SalesTerritoryKey
LIMIT 10;


ALTER TABLE dimsalesterritory DROP COLUMN SalesTerritoryImage;



