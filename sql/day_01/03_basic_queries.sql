SELECT*
FROM dbo.Customers
WHERE Country = 'Lithuania'

SELECT* 
FROM dbo.Products
WHERE UnitPrice > 100
ORDER BY UnitPrice 

-- distinct
SELECT DISTINCT Country
FROM dbo.Customers

SELECT COUNT(*) AS CustomerCount
FROM dbo.Customers

-- group by
SELECT
	Country,
	COUNT(*) AS CustomerCount
FROM dbo.Customers
GROUP BY Country

--min, max, avg
SELECT
	AVG(UnitPrice) AS avg_price,
	MIN(UnitPrice) AS cheapest_product,
	MAX(UnitPrice) AS most_expensive_product
FROM dbo.Products

