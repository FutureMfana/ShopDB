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
