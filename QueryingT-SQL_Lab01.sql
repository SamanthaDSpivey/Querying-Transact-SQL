--Lab 01- Use some basic SELECT queries to retrieve data from the AdventureWorksLT database 


-- Retrieve CUstomer Data- all columns for all customers
SELECT * 
FROM SalesLT.Customer;

-- Create List of Customer Contacts- Display customer name fields
SELECT Title, FirstName, MiddleName, LastName, Suffix
FROM SalesLT.Customer;

-- Display Salesperson and customer's title and last name  with phone number
SELECT Salesperson, Title + ' ' + LastName AS CustomerName, Phone
FROM SalesLT.Customer;

-- Retrieve Customer and Sales Data- List of all Customer Companies
SELECT CAST(CustomerID AS varchar) + ': ' + CompanyName AS CustomerCompany
FROM SalesLT.Customer;

--Sales Order Revisions and Dates
SELECT SalesOrderNumber + ' (' + STR(RevisionNumber, 1) + ')' AS OrderRevision,
	   CONVERT(nvarchar(30), OrderDate, 102) AS OrderDate
FROM SalesLT.SalesOrderHeader;

-- Retrieve Customer Contact Names and include middle names if known
SELECT FirstName + ' ' + ISNULL(MiddleName + ' ', '') + LastName AS CustomerName
FROM SalesLT.Customer;

-- Retrieve primary contact details
UPDATE SalesLT.Customer
SET EmailAddress = NULL
WHERE CustomerID % 7 = 1;

SELECT CustomerID, COALESCE(EmailAddress, Phone) AS PrimaryContact
FROM SalesLT.Customer;

-- Retrieve shipping status
UPDATE SalesLT.SalesOrderHeader
SET ShipDate = NULL
WHERE SalesOrderID > 71899;

SELECT SalesOrderID, OrderDate,
    CASE
      WHEN ShipDate IS NULL THEN 'Awaiting Shipment'
      ELSE 'Shipped'
    END AS ShippingStatus
FROM SalesLT.SalesOrderHeader;

