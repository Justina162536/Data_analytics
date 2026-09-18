-- Completed orders revenue
SELECT 
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue 
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
ON oi.OrderID = o.OrderID
WHERE o. OrderStatus = 'Completed'

-- Revenue by country
SELECT
	p.Category,
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue 
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
ON oi.OrderID = o.OrderID
INNER JOIN dbo.Products AS p
ON oi.ProductID = p.ProductID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.Category
ORDER BY Revenue DESC

-- Average order value
SELECT
	SUM(oi.Quantity*oi.UnitPrice) AS total_revenue,
	COUNT(DISTINCT oi.OrderID) AS number_of_orders,
	SUM(oi.Quantity*oi.UnitPrice)/COUNT(DISTINCT oi.OrderID) AS average_order_value
FROM dbo.OrderItems as oi
INNER JOIN dbo.Orders AS o
ON oi.OrderID = o.OrderID
WHERE o.OrderStatus = 'Completed'

-- TOP 3 products by revenue
SELECT
	TOP 3
	p.ProductName,
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Products AS p
ON oi.ProductID = p.ProductID
INNER JOIN dbo.Orders as o
ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.ProductName
ORDER BY Revenue DESC

-- Total revenue in time period
SELECT
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue
FROM dbo.OrderItems AS oi
INNER JOIN dbo.Orders AS o
ON oi.OrderID = o.OrderID
WHERE o.OrderDate BETWEEN '2026-02-01' AND '2026-03-31'
AND O.OrderStatus = 'Completed'




