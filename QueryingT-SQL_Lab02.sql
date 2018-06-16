--Lab 02- UseSELECT queries to retrieve, sort, and filter data from the AdventureWorksLT database

--Retrieve Transportation Report Data- City List w/out duplicates
SELECT DISTINCT City, StateProvince
FROM SalesLT.Address

--Retrieve Heaviest Products (top 10% products by weight)
SELECT TOP 10 PERCENT Name 
FROM SalesLT.Product 
ORDER BY Weight DESC;

--Retrieve the Heaviest 100 Products Not Including the Heaviest Ten
SELECT Name 
FROM SalesLT.Product 
ORDER BY Weight DESC
OFFSET 10 ROWS FETCH NEXT 100 ROWS ONLY;

--Retrieve Product Details w/ Product Model ID of 1
SELECT Name, Color, Size
FROM SalesLT.Product
WHERE ProductModelID = 1;

--Retrieve Products by Color and Size
SELECT ProductNumber, Name
FROM SalesLT.Product
WHERE Color IN ('Black','Red','White') and Size IN ('S','M');

--Retrieve Products by Product Number beginning w/ 'BK-'
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK-%';

--Retrieve Specific Products by Product Number beginning w/ 'BK-' followed by any other character 
--other than 'R' & ending w/ '-' followed by any two numerals
SELECT ProductNumber, Name, ListPrice
FROM SalesLT.Product 
WHERE ProductNumber LIKE 'BK-[^R]%-[0-9][0-9]';
