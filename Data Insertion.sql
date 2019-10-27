--Inserting data (as bulk) to Category table
SET NOCOUNT ON;
BEGIN TRY
	BEGIN TRANSACTION
		INSERT INTO Products.Category (Category, Description)
		VALUES ('Bevarages','Soft drinks, Coffees, Teas, Bears, and Ales'),
			   ('Condiments','Sweet and Savory sauces, Relishes, Spreads, and Seasonings'),
			   ('Confections', 'Desserts, Candies, and Sweet breads'),
			   ('Dairy Products', 'Cheese, Milk, Cream, Custard, and Ice Cream'),
			   ('Grains/Cereals', 'Breads, Crackers, Pasta, and Cereal'),
			   ('Meat/Poultry', 'Prepared meats'),
			   ('Produce', 'Dried fruit and Bean curd'),
			   ('Seafood', 'Seaweed and Fish');
	COMMIT TRANSACTION
	SELECT * FROM Products.Category;
END TRY
BEGIN CATCH
	PRINT ERROR_NUMBER();
	ROLLBACK TRANSACTION;
END CATCH
GO

--Procedure for inserting data into Products table
CREATE PROC spInsertProducts
	@Product varchar(50),
	@CategoryID int,
	@ManufucturerID int
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Products.Products (ProductName, CategoryID, ManufacturerID)
			VALUES (@Product, @CategoryID, @ManufucturerID)
			SELECT TOP 10 *
			FROM Products.Products
		COMMIT TRAN
	END TRY
	BEGIN CATCH
		SELECT ERROR_MESSAGE();
		ROLLBACK TRAN;
	END CATCH
END
GO

--Inserting data to Manufacture table
CREATE PROC spInsertManufacturer
	@Manufacturer nvarchar(50),
	@Address varchar(30),
	@Country varchar(30),
	@City varchar(30),
	@PostalCode varchar(30),
	@Tel char(10)
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Products.Manufacturer (Manufacturer, PhysicalAddress, City, Country, PostalCode, Tel)
			VALUES (@Manufacturer, @Address, @City, @Country, @PostalCode, @Tel);
		COMMIT TRAN
		SELECT TOP 10 * 
		FROM Products.Category ;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		ROLLBACK TRAN;
	END CATCH
END
