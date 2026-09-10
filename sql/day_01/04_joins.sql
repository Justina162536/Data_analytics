-- joining orders and customers tables
SELECT 
	o.OrderID,
	o.OrderDate,
	o.OrderStatus,
	c.FirstName,
	c.LastName,
	c.Country
	FROM dbo.Orders AS o
	INNER JOIN dbo.Customers AS c
	ON o.CustomerID = c.CustomerID;

-- joining order items and products tables
SELECT oi.OrderID,
	p.ProductName,
	p.Category,
	oi.Quantity,
	oi.UnitPrice
FROM dbo.Products as p
INNER JOIN dbo.OrderItems as oi
on p. ProductID = oi.ProductID;

-- joining all four tables
SELECT
    o.OrderID,
    o.OrderDate,
    c.FirstName,
    c.Country,
    p.ProductName,
    p.Category,
    oi.Quantity,
    oi.UnitPrice,
	oi.Quantity * oi.UnitPrice AS Revenue
FROM dbo.Orders AS o
INNER JOIN dbo.Customers AS c
    ON o.CustomerID = c.CustomerID
INNER JOIN dbo.OrderItems AS oi
    ON o.OrderID = oi.OrderID
INNER JOIN dbo.Products AS p
    ON oi.ProductID = p.ProductID;