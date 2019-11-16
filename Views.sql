USE ShopDB;
GO

CREATE VIEW Products.AllCategories
WITH ENCRYPTION
AS
	SELECT CategoryID AS Category_ID, Category AS Category_Name, Description AS Description_Examples 
	FROM Products.Category;

SELECT * FROM Products.Categories;
GO

CREATE VIEW Customer.AllCustomers
WITH ENCRYPTION
AS
	SELECT CustID AS CustomerID, FirstName + ' ' + LastName AS FullName, IIF(Gender = 1, 'Male', 'Female') AS Gender, EmailAddress, ResidentialAddres
	FROM Customer.Customers;
GO

CREATE VIEW Products.AllManufacturers
WITH ENCRYPTION
AS
	SELECT ManufacturerID, Manufacturer, PhysicalAddress AS StreetAddress, City, Country, PostalCode AS Code, Tel AS TelephoneNumber
	FROM Products.Manufacturer;
GO

CREATE VIEW Products.AllProducts
WITH ENCRYPTION
AS
	SELECT PP.ProductID AS ID, PP.ProductName AS Product, PC.Category, PM.Manufacturer
	FROM Products.Products PP
	INNER JOIN Products.Category PC
	ON PP.CategoryID = PC.CategoryID
	INNER JOIN Products.Manufacturer PM
	ON PM.ManufacturerID = PP.ManufacturerID;
GO

CREATE VIEW Staff.AllDependents
WITH ENCRYPTION
AS
	SELECT DEP.DependentID AS DepID, DEP.FirstName + ' ' + DEP.LastName AS FullName, IIF(DEP.Gender > 0, 'Male','Female') AS Gender,
			EMP.FirstName + ' ' + EMP.LastName AS Parent
	FROM Staff.Dependents DEP
	INNER JOIN Staff.Employees EMP
	ON DEP.EmpID = EMP.EmpID;
GO

CREATE VIEW Staff.AllEmployees
WITH ENCRYPTION
AS
	SELECT E.EmpID, E.FirstName + ' ' + E.LastName AS FullName, E.DOB AS DateOfBirth, IIF(E.Gender = 1, 'Male', 'Female') AS Gender,
	E.Position AS Role, COALESCE(EMP.FirstName + ' ' + EMP.LastName, '') AS Manager
	FROM Staff.Employees E
	LEFT OUTER JOIN Staff.Employees EMP
	ON EMP.EmpID = E.ManagerID;
GO

CREATE VIEW Sales.DetailedOrders
WITH ENCRYPTION
AS
	SELECT SOD.OrderID, SO.OrderDate AS Date, PP.ProductName, PM.Manufacturer, PC.Category, SUM(SOD.QTY) AS QTY ,SUM(SO.TotalPrice) AS TotalPrice,
			SUM(SOD.Vat) AS TotalVat, EMP.FirstName + ' ' + EMP.LastName AS SoldBy, CC.FirstName + ' ' + CC.LastName AS Customer
	FROM Sales.Orders SO
	INNER JOIN Sales.OrderDetials SOD
	ON SO.OrderID = SOD.OrderID
	INNER JOIN Products.Products PP
	ON PP.ProductID = SOD.ProductID
	INNER JOIN Products.Category PC
	ON SOD.CategoryID = PC.CategoryID
	INNER JOIN Staff.Employees EMP
	ON EMP.EmpID = SO.EmpID
	INNER JOIN Customer.Customers CC
	ON CC.CustID = SO.CustID
	INNER JOIN Products.Manufacturer PM
	ON PP.ManufacturerID = PM.ManufacturerID
	GROUP BY SOD.OrderID, SO.OrderDate, PP.ProductName, PM.Manufacturer, PC.Category, EMP.FirstName, EMP.LastName, CC.FirstName, CC.LastName;
GO
