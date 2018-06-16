--Lab 06 - Use subqueries and the APPLY operator to retrieve data from the AdventureWorksLT database


--Retrieve Product Price Info- Products whose list price is higher than the average unit price in the 
--SalesOrderDetail table
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE ListPrice >
   (SELECT AVG(UnitPrice) FROM SalesLT.SalesOrderDetail)
ORDER BY ProductID;

--Retrieve products that are priced $100 or more
-- but have sold for a unit price of less than $100
SELECT ProductID, Name, ListPrice 
FROM SalesLT.Product
WHERE ProductID IN
   (SELECT ProductID from SalesLT.SalesOrderDetail
   WHERE UnitPrice < 100.00)
AND ListPrice >= 100.00
ORDER BY ProductID;

--Retrieve cost, list price, and average selling price for each product
SELECT ProductID, Name, StandardCost, ListPrice,
   (SELECT AVG(UnitPrice)
   FROM SalesLT.SalesOrderDetail AS SOD
   WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
ORDER BY P.ProductID;

--Find products where the average selling price is less than cost
SELECT ProductID, Name, StandardCost, ListPrice,
   (SELECT AVG(UnitPrice)
   FROM SalesLT.SalesOrderDetail AS SOD
   WHERE P.ProductID = SOD.ProductID) AS AvgSellingPrice
FROM SalesLT.Product AS P
WHERE StandardCost >
   (SELECT AVG(UnitPrice)
   FROM SalesLT.SalesOrderDetail AS SOD
   WHERE P.ProductID = SOD.ProductID)
ORDER BY P.ProductID;

--Retrieve Customer Info- Sales order data with customer information from a function
SELECT SOH.SalesOrderID, SOH.CustomerID, CI.FirstName, CI.LastName, SOH.TotalDue
FROM SalesLT.SalesOrderHeader AS SOH
CROSS APPLY dbo.ufnGetCustomerInformation(SOH.CustomerID) AS CI
ORDER BY SOH.SalesOrderID;

--Retrieve addresses with customer information from a function
SELECT CA.CustomerID, CI.FirstName, CI.LastName, A.AddressLine1, A.City
FROM SalesLT.Address AS A
JOIN SalesLT.CustomerAddress AS CA
ON A.AddressID = CA.AddressID
CROSS APPLY dbo.ufnGetCustomerInformation(CA.CustomerID) AS CI
ORDER BY CA.CustomerID;
