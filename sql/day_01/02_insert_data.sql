--Loading AI generated data into my tables;
INSERT INTO dbo.Customers
    (CustomerID, FirstName, LastName, Email, Country, RegistrationDate)
VALUES
    (1, 'Anna', 'Smith', 'anna@example.com', 'Lithuania', '2025-01-15'),
    (2, 'John', 'Brown', 'john@example.com', 'Germany', '2025-03-10'),
    (3, 'Maria', 'Garcia', 'maria@example.com', 'Spain', '2025-06-05'),
    (4, 'Lukas', 'Muller', 'lukas@example.com', 'Germany', '2025-08-12'),
    (5, N'Živilė', N'Petrauskaitė', NULL, 'Lithuania', '2026-01-20');

SELECT *
FROM dbo.Customers;

INSERT INTO dbo.Products
    (ProductID, ProductName, Category, UnitPrice)
VALUES
    (101, 'Laptop', 'Electronics', 1200.00),
    (102, 'Mouse', 'Electronics', 25.00),
    (103, 'Keyboard', 'Electronics', 60.00),
    (104, 'Desk', 'Furniture', 300.00),
    (105, 'Chair', 'Furniture', 180.00);

SELECT *
FROM dbo.Products;

INSERT INTO dbo.Orders
    (OrderID, CustomerID, OrderDate, OrderStatus)
VALUES
    (1001, 1, '2026-01-10', 'Completed'),
    (1002, 2, '2026-01-15', 'Completed'),
    (1003, 1, '2026-02-03', 'Completed'),
    (1004, 3, '2026-02-12', 'Cancelled'),
    (1005, 4, '2026-03-01', 'Completed'),
    (1006, 2, '2026-03-15', 'Completed');

INSERT INTO dbo.OrderItems
    (OrderItemID, OrderID, ProductID, Quantity, UnitPrice)
VALUES
    (1, 1001, 101, 1, 1200.00),
    (2, 1001, 102, 2, 25.00),
    (3, 1002, 103, 1, 60.00),
    (4, 1002, 105, 2, 180.00),
    (5, 1003, 104, 1, 300.00),
    (6, 1003, 102, 1, 25.00),
    (7, 1004, 101, 1, 1200.00),
    (8, 1005, 105, 4, 180.00),
    (9, 1006, 102, 3, 25.00),
    (10, 1006, 103, 2, 60.00);