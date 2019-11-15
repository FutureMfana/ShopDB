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

--Stored procedure for inserting Dependents entity instance
CREATE PROC spInsertCategory
	@Category nvarchar(30),
	@Description nvarchar(100) = Null
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Products.Category (Category, Description)
			VALUES (@Category, @Description)
		COMMIT TRAN
		SELECT TOP 10 *
		FROM Products.Category
		ORDER BY CategoryID DESC;
	END TRY
	BEGIN CATCH
	END CATCH
END
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

--Altering spInsertEmployees procedure to add default value for ManagerID field
ALTER PROC spInsertEmployees
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@IDNumber char(13),
	@DOB date,
	@Gender bit,
	@Position nvarchar(30),
	@ManagerID int = Null,
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
GO

--Demonstration on invoking spsInsertEmployees
EXEC spInsertEmployees 
	@FirstName = 'Davolio',
	@LastName = 'Nancy',
	@IDNumber = '6812085553086',
	@DOB = '1968-12-08',
	@Gender = 1,
	@Position = 'Director',
	@Salary = 450000
GO

--Stored procedure for inserting Dependents entity instance
CREATE PROC spInsertDependents
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@IDNumber char(13),
	@Gender bit,
	@EmpID int
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Staff.Dependents (FirstName, LastName, IDNumber, Gender, EmpID)
			VALUES (@FirstName, @LastName, @IDNumber, @Gender, @EmpID)
		COMMIT TRAN
		SElECT TOP 10 *
		FROM Staff.Dependents
		ORDER BY DependentID DESC;
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN;
		PRINT ERROR_MESSAGE();
	END CATCH
END
GO

--Invoking spDepents stored procedure
EXEC spInsertDependents
	@FirstName = 'Andrew',
	@LastName = 'Nancy',
	@IDNumber = '1502120135082',
	@Gender = 1,
	@EmpID = 1000
GO

CREATE PROC spInsertCustomers
	@FirstName nvarchar(30),
	@LastName nvarchar(30),
	@IDNumber char(13),
	@Gender bit,
	@EmailAddress nvarchar(30),
	@ResidentialAddres nvarchar(max)
WITH ENCRYPTION
AS
BEGIN
	BEGIN TRY
		BEGIN TRAN
			INSERT INTO Customer.Customers (FirstName, LastName, IDNumber, Gender, EmailAddress, ResidentialAddres)
			VALUES (@FirstName, @LastName, @IDNumber, @Gender, @EmailAddress, @ResidentialAddres)
		COMMIT TRAN
		SELECT TOP 10 *
		FROM Customer.Customers
		ORDER BY CustID DESC;
	END TRY
	BEGIN CATCH
		ROLLBACK TRAN;
		PRINT ERROR_MESSAGE();
	END CATCH
END
GO
