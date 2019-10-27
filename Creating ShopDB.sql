CREATE DATABASE ShopDB;
GO
USE ShopDB;
GO

CREATE SCHEMA Staff;
GO

CREATE TABLE Staff.Employees(
	EmpID int IDENTITY(1000,1) PRIMARY KEY,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	IDNumber char(13) UNIQUE NOT NULL,
	DOB date NOT NULL,
	Gender bit NOT NULL,
	Position varchar(20) NOT NULL,
	ManagerID int, 
	CONSTRAINT FK_EMP_CustID FOREIGN KEY (EmpID) REFERENCES Staff.Employees(EmpID)
);
GO

CREATE TABLE Staff.Dependents(
	DependentID int IDENTITY(3000,1) PRIMARY KEY,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	IDNumber char(13) NOT NULL,
	Gender bit NOT NULL,
	EmpID int NOT NULL,
	CONSTRAINT FK_EMP_EmpID FOREIGN KEY (EmpID) REFERENCES Staff.Employees(EmpID)
);
GO

CREATE SCHEMA Customer;
GO

CREATE TABLE Customer.Customers(
	CustID int IDENTITY(5000,1) PRIMARY KEY,
	FirstName varchar(20) NOT NULL,
	LastName varchar(20) NOT NULL,
	IDNumber char(13) NOT NULL,
	Gender bit NOT NULL,
	EmailAddress varchar(30) NOT NULL,
	ResidentialAddres varchar(max) NOT NULL
);
GO

CREATE SCHEMA Sales;
GO

CREATE TABLE Sales.Orders(
	OrderID int IDENTITY(10000, 1) PRIMARY KEY,
	OrderDate date DEFAULT GETDATE(),
	TotalPrice decimal(18,2) NOT NULL,
	Vat AS TotalPrice * 0.15,
	EmpID int NOT NULL,
	CustID int NOT NULL,
	CONSTRAINT FK_EMP_EMPID FOREIGN KEY (EmpID) REFERENCES Staff.Employees(EmpID),
	CONSTRAINT FK_CUST_CUSTID FOREIGN KEY (CustID) REFERENCES Customer.Customers(CustID)
);
GO

CREATE SCHEMA Products;
GO

CREATE TABLE Products.Products(
	ProductID int IDENTITY(12000,1) PRIMARY KEY,
	ProductName varchar(30) NOT NULL,
	CategoryID int NOT NULL,
	ManufacturerID int NOT NULL,
);
CREATE TABLE Products.Category(
	CategoryID int IDENTITY(1, 1) PRIMARY KEY,
	Category varchar(30) NOT NULL
);
CREATE TABLE Products.Manufacturer(
	ManufacturerID int IDENTITY(101, 1) PRIMARY KEY,
	Manufacturer varchar(30) NOT NULL,
	PhysicalAddress nvarchar(max) NOT NULL
);
GO

ALTER TABLE Products.Products
ADD CONSTRAINT FK_CAT_CATID FOREIGN KEY (CategoryID) REFERENCES Products.Category(CategoryID);

ALTER TABLE Products.Products
ADD CONSTRAINT FK_MAN_MANID FOREIGN KEY (ManufacturerID) REFERENCES Products.Manufacturer(ManufacturerID);
GO

CREATE TABLE Sales.OrderDetials(
	OrderID int NOT NULL,
	ProductID int NOT NULL,
	QTY int NOT NULL,
	TotalPrice decimal(18, 2) NOT NULL,
	Vat AS TotalPrice * 0.15,
	CategoryID int NOT NULL,
	CONSTRAINT FK_ORDER_ORDERID FOREIGN KEY (OrderID) REFERENCES Sales.Orders(OrderID),
	CONSTRAINT FK_PROD_PRODID FOREIGN KEY (ProductID) REFERENCES Products.Products(ProductID),
	CONSTRAINT FK_CATEGORY_CAT FOREIGN KEY (CategoryID) REFERENCES Products.Category(CategoryID)
);
GO
