--Lab 05- Write queries that use functions to retrieve, aggregate, and group data from the AdventureWorksLT database


--Retrieve Product Info- the name and approximate weight of each product
SELECT	ProductID,
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight
FROM SalesLT.Product;

--Retrieve the month and year products were first sold
SELECT	ProductID,
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) as SellStartYear,
		DATENAME(m, SellStartDate) as SellStartMonth
FROM SalesLT.Product;

-- Extract type from product number
SELECT	ProductID,
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) as SellStartYear,
		DATENAME(m, SellStartDate) as SellStartMonth,
		LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product;

-- Filter to include only products with numeric sizes
SELECT	ProductID,
		UPPER(Name) AS ProductName,
		ROUND(Weight, 0) AS ApproxWeight,
		YEAR(SellStartDate) as SellStartYear,
		DATENAME(m, SellStartDate) as SellStartMonth,
		LEFT(ProductNumber, 2) AS ProductType
FROM SalesLT.Product
WHERE ISNUMERIC(Size) = 1;

--Ranking Customers by Revenue- Retrieve Companies Ranked by Revenue
SELECT	C.CompanyName,
		SOH.TotalDue AS Revenue,
		RANK() OVER (ORDER BY SOH.TotalDue DESC) AS RankByRevenue
FROM SalesLT.SalesOrderHeader AS SOH
JOIN SalesLT.Customer AS C
ON SOH.CustomerID = C.CustomerID;

--Aggregate Product Sales- Retrieve Total Sales by Product in descending order
SELECT P.Name, SUM(SOD.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P 
ON SOD.ProductID = P.ProductID
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

-- Retrieve Total Sales for only products that cost over $1,000
SELECT P.Name, SUM(SOD.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P 
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
ORDER BY TotalRevenue DESC;

--Retrieve Total Sales for only groupings with sales totals over $20,000
SELECT P.Name, SUM(SOD.LineTotal) AS TotalRevenue
FROM SalesLT.SalesOrderDetail AS SOD
JOIN SalesLT.Product AS P 
ON SOD.ProductID = P.ProductID
WHERE P.ListPrice > 1000
GROUP BY P.Name
HAVING SUM(SOD.LineTotal) > 20000
ORDER BY TotalRevenue DESC;
