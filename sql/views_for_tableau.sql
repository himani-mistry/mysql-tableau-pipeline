-- Business-question views for AdventureWorksDW2017 star schema
-- Each view answers one specific question a stakeholder would ask.
-- These are what Tableau connects to — not the raw fact/dim tables.


USE adventureworks_dw;

-- View 1: Sales by Category over time
-- Question: "How is revenue trending by product category/subcategory, month over month?"

DROP VIEW IF EXISTS vw_sales_by_category_month;
CREATE VIEW vw_sales_by_category_month AS
SELECT
    d.CalendarYear,
    d.MonthNumberOfYear,
    d.EnglishMonthName,
    pc.EnglishProductCategoryName AS ProductCategory,
    psc.EnglishProductSubcategoryName AS ProductSubcategory,
    COUNT(DISTINCT f.SalesOrderNumber) AS OrderCount,
    SUM(f.OrderQuantity) AS TotalUnitsSold,
    SUM(f.SalesAmount) AS TotalSalesAmount,
    ROUND(AVG(f.SalesAmount), 2) AS AvgLineAmount
FROM factinternetsales f
JOIN dimdate d ON f.OrderDateKey = d.DateKey
JOIN dimproduct p ON f.ProductKey = p.ProductKey
JOIN dimproductsubcategory psc ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
JOIN dimproductcategory pc ON psc.ProductCategoryKey = pc.ProductCategoryKey
GROUP BY d.CalendarYear, d.MonthNumberOfYear, d.EnglishMonthName,
         pc.EnglishProductCategoryName, psc.EnglishProductSubcategoryName;


-- View 2: Sales by Territory
-- Question: "Which regions/countries drive the most revenue and orders?"

DROP VIEW IF EXISTS vw_sales_by_territory;
CREATE VIEW vw_sales_by_territory AS
SELECT
    t.SalesTerritoryGroup,
    t.SalesTerritoryCountry,
    t.SalesTerritoryRegion,
    COUNT(DISTINCT f.SalesOrderNumber) AS OrderCount,
    SUM(f.OrderQuantity) AS TotalUnitsSold,
    SUM(f.SalesAmount) AS TotalSalesAmount,
    ROUND(AVG(f.SalesAmount), 2) AS AvgLineAmount
FROM factinternetsales f
JOIN dimsalesterritory t ON f.SalesTerritoryKey = t.SalesTerritoryKey
GROUP BY t.SalesTerritoryGroup, t.SalesTerritoryCountry, t.SalesTerritoryRegion;



-- View 3: Customer Segments
-- Question: "Who are our customers, and how much do different segments spend?"

DROP VIEW IF EXISTS vw_customer_segments;
CREATE VIEW vw_customer_segments AS
SELECT
    c.CustomerKey,
    c.FirstName,
    c.LastName,
    c.EnglishEducation AS Education,
    c.EnglishOccupation AS Occupation,
    c.Gender,
    c.MaritalStatus,
    c.YearlyIncome,
    c.TotalChildren,
    g.City,
    g.StateProvinceName,
    g.EnglishCountryRegionName AS Country,
    COUNT(DISTINCT f.SalesOrderNumber) AS OrderCount,
    SUM(f.SalesAmount) AS TotalSpent,
    ROUND(AVG(f.SalesAmount), 2) AS AvgOrderValue,
    MIN(d.FullDateAlternateKey) AS FirstPurchaseDate,
    MAX(d.FullDateAlternateKey) AS LastPurchaseDate
FROM factinternetsales f
JOIN dimcustomer c ON f.CustomerKey = c.CustomerKey
JOIN dimgeography g ON c.GeographyKey = g.GeographyKey
JOIN dimdate d ON f.OrderDateKey = d.DateKey
GROUP BY c.CustomerKey, c.FirstName, c.LastName, c.EnglishEducation, c.EnglishOccupation,
         c.Gender, c.MaritalStatus, c.YearlyIncome, c.TotalChildren,
         g.City, g.StateProvinceName, g.EnglishCountryRegionName;


-- View 4: Promotion Effectiveness
-- Question: "Do promotions actually move sales? Which types work best?"

DROP VIEW IF EXISTS vw_promotion_effectiveness;
CREATE VIEW vw_promotion_effectiveness AS
SELECT
    promo.EnglishPromotionName AS PromotionName,
    promo.EnglishPromotionType AS PromotionType,
    promo.EnglishPromotionCategory AS PromotionCategory,
    promo.DiscountPct,
    COUNT(DISTINCT f.SalesOrderNumber) AS OrderCount,
    SUM(f.OrderQuantity) AS TotalUnitsSold,
    SUM(f.SalesAmount) AS TotalSalesAmount,
    SUM(f.DiscountAmount) AS TotalDiscountAmount,
    ROUND(AVG(f.SalesAmount), 2) AS AvgOrderValue
FROM factinternetsales f
JOIN dimpromotion promo ON f.PromotionKey = promo.PromotionKey
GROUP BY promo.EnglishPromotionName, promo.EnglishPromotionType,
         promo.EnglishPromotionCategory, promo.DiscountPct;


-- Verification — confirm all 4 views exist and return data

SELECT 'vw_sales_by_category_month' AS view_name, COUNT(*) AS row_count FROM vw_sales_by_category_month
UNION ALL SELECT 'vw_sales_by_territory', COUNT(*) FROM vw_sales_by_territory
UNION ALL SELECT 'vw_customer_segments', COUNT(*) FROM vw_customer_segments
UNION ALL SELECT 'vw_promotion_effectiveness', COUNT(*) FROM vw_promotion_effectiveness;

SELECT * FROM dimsalesterritory;

SELECT DISTINCT PromotionKey FROM factinternetsales;

SELECT PromotionKey, EnglishPromotionName, EnglishPromotionType, DiscountPct
FROM dimpromotion
WHERE PromotionKey IN (1, 2, 13, 14);

SHOW FULL TABLES;

