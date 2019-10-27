USE ShopDB;
GO

CREATE VIEW Products.Categories
WITH ENCRYPTION
AS
	SELECT CategoryID AS Category_ID, Category AS Category_Name, Description AS Description_Examples 
	FROM Products.Category;
