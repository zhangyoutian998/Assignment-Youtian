--1
SELECT COUNT(*) AS TotalProductNumber
FROM Production.Product

--2
SELECT COUNT(Name) AS NumberofSub
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL;

--3
SELECT ProductSubcategoryID, COUNT(ProductSubcategoryID) AS CountedProducts
FROM Production.Product
WHERE ProductSubcategoryID IS NOT NULL
GROUP BY ProductSubcategoryID

--4
SELECT COUNT(Name) AS NumberofNotSub
FROM Production.Product
WHERE ProductSubcategoryID IS NULL;

--5
SELECT SUM(Quantity) AS SumOfQuant
FROM Production.ProductInventory

--6
SELECT ProductID, SUM(Quantity) AS SumOfQuant
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID
Having SUM(Quantity) < 100;

--7
SELECT Shelf, ProductID, SUM(Quantity) AS SumOfQuant
FROM Production.ProductInventory
WHERE LocationID = 40
GROUP BY ProductID, Shelf
Having SUM(Quantity) < 100;

--8
SELECT AVG(Quantity) AS AvgQuant
FROM Production.ProductInventory
WHERE LocationID = 10;

--9
SELECT ProductID, Shelf, AVG(Quantity) AS AvgQuant
FROM Production.ProductInventory
GROUP BY Shelf, ProductID

--10
SELECT ProductID, Shelf, AVG(Quantity) AS AvgQuant
FROM Production.ProductInventory
WHERE Shelf != 'N/A'
GROUP BY Shelf, ProductID;

--11
SELECT Color, Class, COUNT(*) AS TheCount, AVG(ListPrice) AS AvgPrice
FROM Production.Product
WHERE Color IS NOT NULL AND Class IS NOT NULL
GROUP BY Color, Class;

--12
SELECT c.name AS Country, s.name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode

--13
SELECT c.name AS Country, s.name AS Province
FROM Person.CountryRegion c JOIN Person.StateProvince s ON c.CountryRegionCode = s.CountryRegionCode
WHERE c.name IN ('Germany','Canada')

--14 
SELECT ProductID
FROM dbo.OrderDetails od JOIN dbo.Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())

--15
SELECT TOP 5 ShipPostalCode
FROM dbo.OrderDetails od JOIN dbo.Orders o ON od.OrderID = o.OrderID
GROUP BY ShipPostalCode
ORDER BY COUNT(ShipPostalCode) DESC

--16
SELECT TOP 5 ShipPostalCode
FROM dbo.OrderDetails od JOIN dbo.Orders o ON od.OrderID = o.OrderID
WHERE o.OrderDate >= DATEADD(YEAR, -27, GETDATE())
GROUP BY ShipPostalCode
ORDER BY COUNT(ShipPostalCode) DESC

--17 
SELECT City, COUNT(CustomerID) AS NumofCustomer
FROM dbo.Customers
GROUP BY City

--18
SELECT City, COUNT(CustomerID) AS NumofCustomer
FROM dbo.Customers
GROUP BY City
Having COUNT(CustomerID) > 2

--19
SELECT CompanyName
FROM dbo.Orders o Join dbo.Customers c ON o.CustomerID = c.CustomerID
WHERE OrderDate > '1998-01-01'
GROUP BY CompanyName

--20
SELECT CompanyName, MAX(OrderDate) AS LatestDate
FROM dbo.Orders o Join dbo.Customers c ON o.CustomerID = c.CustomerID
GROUP BY CompanyName

--21
SELECT CompanyName, COUNT(ProductID) AS CountofProducts
FROM dbo.Orders o Join dbo.Customers c ON o.CustomerID = c.CustomerID JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY CompanyName

--22
SELECT o.CustomerID, COUNT(ProductID) AS CountofProducts
FROM dbo.Orders o Join dbo.Customers c ON o.CustomerID = c.CustomerID JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID
GROUP BY o.CustomerID
Having COUNT(ProductID) > 100

--23
SELECT s.CompanyName AS SupplierCompanyName, sh.CompanyName AS ShippingCompanyName
FROM dbo.Suppliers s CROSS JOIN dbo.Shippers sh


--24
SELECT OrderDate, ProductName
FROM dbo.Orders o JOIN dbo.OrderDetails od ON o.OrderID = od.OrderID JOIN dbo.Products p ON od.ProductID = p.ProductID
GROUP BY OrderDate, ProductName


--25
SELECT e1.LastName + ' ' + e1.FirstName AS EmployeeName1, e2.LastName + ' '+ e2.FirstName AS EmployeeName2
FROM dbo.Employees e1 JOIN dbo.Employees e2 ON e1.Title = e2.Title
WHERE e1.EmployeeID < e2.EmployeeID

--26
SELECT LastName + ' ' + FirstName AS ManagerName 
FROM dbo.Employees
WHERE EmployeeID IN (
SELECT ReportsTo
FROM dbo.Employees
GROUP BY ReportsTo
Having COUNT(EmployeeID) > 2)

--27
SELECT City, CompanyName AS Name, ContactName, 'Customer' AS Type
FROM dbo.Customers
UNION
SELECT City, CompanyName AS Name, ContactName, 'Supplier' AS Type
FROM dbo.Suppliers
ORDER BY City
