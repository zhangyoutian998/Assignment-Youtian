--1
SELECT c.City
FROM dbo.Employees e JOIN dbo.Customers c ON c.City = e.City
GROUP BY c.City

--2a
SELECT City
FROM dbo.Customers
WHERE City NOT IN
(SELECT City 
FROM dbo.Employees)


--2b
SELECT c.City
FROM dbo.Customers c LEFT JOIN dbo.Employees e ON c.City = e.City
WHERE e.City IS NULL

--3
SELECT ProductName, Quantity
FROM dbo.Products p JOIN dbo.OrderDetails od ON p.ProductID = od.ProductID

--4



