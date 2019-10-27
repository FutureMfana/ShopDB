USE ShopDB;
GO

--Adding description column for Products table
ALTER TABLE Products.Category
ADD Description varchar(100);
GO

--Mistakenly forgot to add Salary column when creating employee table
ALTER TABLE Staff.Employees
ADD Salary decimal(18, 2) NOT NULL;

--Just view currently available columns
SELECT * FROM Products.Manufacturer

--Column forgotten when creating Manufacturer table
ALTER TABLE Products.Manufacturer
ADD City varchar(30) NOT NULL;

ALTER TABLE Products.Manufacturer
ADD Country varchar(30) NOT NULL;

ALTER TABLE Products.Manufacturer
ADD PostalCode varchar(10) NOT NULL;

ALTER TABLE Products.Manufacturer
ADD Tel char(10) NOT NULL;

--Changing datatype to accommodate national charaters (UNICODE)
ALTER TABLE Products.Manufacturer
ALTER COLUMN Manufacturer nvarchar(50) NOT NULL;
