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
			VALUES (@Product, @CategoryID, @ManufucturerID);
			SELECT TOP 10 *
			FROM Products.Products
			ORDER BY ProductID DESC;
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
		FROM Products.Category
		ORDER BY ManufacturerID DESC;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		ROLLBACK TRAN;
	END CATCH
END

--Stored Procedure for adding employee entity instance
CREATE PROC spInsertEmployees
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@IDNumber char(13),
	@DOB date,
	@Gender bit,
	@Position nvarchar(30),
	@ManagerID int,
	@Salary decimal(18,2)
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Staff.Employees (FirstName, LastName, IDNumber, DOB, Gender, Position, ManagerID, Salary)
			VALUES (@FirstName, @LastName, @IDNumber, @DOB, @Gender, @Position, @ManagerID, @Salary);
		COMMIT TRAN
		SELECT TOP 10 *
		FROM Staff.Employees
		ORDER BY EmpID DESC;
	END TRY
	BEGIN CATCH
		PRINT ERROR_MESSAGE();
		ROLLBACK TRAN;
	END CATCH
END
