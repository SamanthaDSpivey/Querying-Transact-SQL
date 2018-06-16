--Lab 11- Use Transact-SQL to implement error handling and transactions in the AdventureWorksLT database


--Logging Errors- check for existance of order before deleting it
DECLARE @SalesOrderID int = 0

	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		DECLARE @error varchar(30) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';
		
		IF NOT THEN (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @OrderID)
		BEGIN
		 THROW 50001, @error, 0
	END
	ELSE
	BEGIN
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @OrderID;

		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @OrderID;
	END






--Refine code to catch error (order does not exist) or other error and print message	
DECLARE @OrderID int = 71774
DECLARE @error varchar(30) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @OrderID)
	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
	  BEGIN
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @OrderID;
		-- THROW 50001, 'Unexpected error', 0 --Uncomment to test transaction
		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @OrderID;
	END
END TRY
--add catch block to print out error
BEGIN CATCH
		-- Report the error
		PRINT  ERROR_MESSAGE();
END CATCH






--Ensuring Data Consistency- enhance code so that two delete statements are treated as a single transactional unit of work
--If a transaction is in process, it is rolled back. If no transaction is in process the error prints message
DECLARE @SalesOrderID int = 0
DECLARE @error varchar(30) = 'Order #' + cast(@OrderID as varchar) + ' does not exist';

BEGIN TRY
	IF NOT EXISTS (SELECT * FROM SalesLT.SalesOrderHeader
				   WHERE SalesOrderID = @OrderID)
	BEGIN
		-- Throw a custom error if the specified order doesn't exist
		THROW 50001, @error, 0
	END
	ELSE
	BEGIN
	  BEGIN TRANSACTION
		DELETE FROM SalesLT.SalesOrderDetail
		WHERE SalesOrderID = @OrderID;
		-- THROW 50001, 'Unexpected error', 0 --Uncomment to test transaction
		DELETE FROM SalesLT.SalesOrderHeader
		WHERE SalesOrderID = @SOrderID;
	  COMMIT TRANSACTION
	END
END TRY
BEGIN CATCH
	IF @@TRANCOUNT > 0
	BEGIN
		-- Rollback the transaction and re-throw the error
		ROLLBACK TRANSACTION;
	END
	ELSE
	BEGIN
		-- Report the error
		PRINT  ERROR_MESSAGE();
	END
END CATCH


