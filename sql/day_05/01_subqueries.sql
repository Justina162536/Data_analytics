-- Shows products priced above the average product price

select
    p.ProductName,
    p.Category,
    p.UnitPrice
from dbo.Products as p
where p.UnitPrice > (
    select avg(UnitPrice)
    from dbo.Products
)
order by p.UnitPrice desc;

-- Identifies customers who have placed at least one completed order

select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.Country
from dbo.Customers as c
where c.CustomerID in (
    select o.CustomerID
    from dbo.Orders as o
    where o.OrderStatus = 'Completed'
)
order by CustomerName;

-- Identifies customers who have never placed a completed order

select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName
from dbo.Customers as c
where not exists (
    select 1
    from dbo.Orders as o
    where o.CustomerID = c.CustomerID
      and o.OrderStatus = 'Completed'
)
order by CustomerName;

-- Compares each product price with the overall average product price

select
    p.ProductName,
    p.UnitPrice,
    (
        select avg(UnitPrice)
        from dbo.Products
    ) as AverageProductPrice,
    p.UnitPrice - (
        select avg(UnitPrice)
        from dbo.Products
    ) as DifferenceFromAverage
from dbo.Products as p
order by DifferenceFromAverage desc;

-- Identifies products with completed-order revenue above the average product revenue

select
    p.ProductName,
    sum(oi.Quantity * oi.UnitPrice) as Revenue
from dbo.Products as p
inner join dbo.OrderItems as oi
    on p.ProductID = oi.ProductID
inner join dbo.Orders as o
    on oi.OrderID = o.OrderID
where o.OrderStatus = 'Completed'
group by
    p.ProductID,
    p.ProductName
having sum(oi.Quantity * oi.UnitPrice) > (
    select avg(ProductRevenue)
    from (
        select
            oi2.ProductID,
            sum(oi2.Quantity * oi2.UnitPrice) as ProductRevenue
        from dbo.OrderItems as oi2
        inner join dbo.Orders as o2
            on oi2.OrderID = o2.OrderID
        where o2.OrderStatus = 'Completed'
        group by oi2.ProductID
    ) as ProductRevenueSummary)
order by Revenue desc;