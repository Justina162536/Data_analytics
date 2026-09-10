-- row counts
SELECT COUNT(*) AS CustomerRows
FROM dbo.Customers;

SELECT COUNT(*) AS ProductRows
FROM dbo.Products;

SELECT COUNT(*) AS OrderRows
FROM dbo.Orders;

SELECT COUNT(*) AS OrderItemRows
FROM dbo.OrderItems;

-- null values
SELECT *
FROM dbo.Customers
WHERE Email IS NULL;

-- checking for duplicates
SELECT
    CustomerID,
    COUNT(*) AS Row_count
FROM dbo.Customers
GROUP BY CustomerID
HAVING COUNT(*) > 1;

-- negative prices/quantities
SELECT *
FROM dbo.Products
WHERE UnitPrice <= 0;

SELECT *
FROM dbo.OrderItems
WHERE Quantity <= 0;

-- Orders date range
SELECT
    MIN(OrderDate) AS FirstOrderDate,
    MAX(OrderDate) AS LastOrderDate
FROM dbo.Orders;

-- check categories of products
SELECT DISTINCT Category
FROM dbo.Products;

-- adding new row with already existing ID to get error
INSERT INTO dbo.Products
    (ProductID, ProductName, Category, UnitPrice)
VALUES
    (101, 'Monitor', 'Electronics', 300.00);



