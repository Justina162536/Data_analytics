-- Shows products priced above the average product price using a CTE
with AveragePrice as (
    select
        avg(UnitPrice) as AvgPrice
    from dbo.Products
)
select
    p.ProductName,
    p.Category,
    p.UnitPrice,
    a.AvgPrice
from dbo.Products as p
cross join AveragePrice as a
where p.UnitPrice > a.AvgPrice
order by p.UnitPrice desc;

-- Identifies customers who have placed at least one completed order using a CTE
with CompletedCustomers as (
    select distinct
        CustomerID
    from dbo.Orders
    where OrderStatus = 'Completed'
)
select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.Country
from dbo.Customers as c
inner join CompletedCustomers as cc
    on c.CustomerID = cc.CustomerID
order by CustomerName;

-- Shows all customers and their total number of orders using a CTE
with CustomerOrderCounts as (
    select
        CustomerID,
        count(*) as OrderCount
    from dbo.Orders
    group by CustomerID
)
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    coalesce(coc.OrderCount, 0) as OrderCount
from dbo.Customers as c
left join CustomerOrderCounts as coc
    on c.CustomerID = coc.CustomerID
order by OrderCount desc;

-- Calculates completed-order revenue for each product using a CTE
with ProductRevenue as (
    select
        oi.ProductID,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.OrderItems as oi
    inner join dbo.Orders as o
        on oi.OrderID = o.OrderID
    where o.OrderStatus = 'Completed'
    group by oi.ProductID
)
select
    p.ProductName,
    p.Category,
    pr.Revenue
from ProductRevenue as pr
inner join dbo.Products as p
    on pr.ProductID = p.ProductID
order by pr.Revenue desc;

-- Identifies products with completed-order revenue above the average product revenue
with ProductRevenue as (
    select
        oi.ProductID,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.OrderItems as oi
    inner join dbo.Orders as o
        on oi.OrderID = o.OrderID
    where o.OrderStatus = 'Completed'
    group by oi.ProductID
),
AverageProductRevenue as (
    select
        avg(Revenue) as AvgRevenue
    from ProductRevenue
)
select
    p.ProductName,
    pr.Revenue,
    apr.AvgRevenue
from ProductRevenue as pr
inner join dbo.Products as p
    on pr.ProductID = p.ProductID
cross join AverageProductRevenue as apr
where pr.Revenue > apr.AvgRevenue
order by pr.Revenue desc;