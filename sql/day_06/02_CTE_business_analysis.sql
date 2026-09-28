-- Segments customers based on their total completed orders revenue

with CustomerRevenue as (
    select
        o.CustomerID,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.Orders as o
    inner join dbo.OrderItems as oi
        on o.OrderID = oi.OrderID
    where o.OrderStatus = 'Completed'
    group by o.CustomerID
)
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    coalesce(cr.Revenue, 0) as Revenue,
    case
        when coalesce(cr.Revenue, 0) >= 1000 then 'High Value'
        when coalesce(cr.Revenue, 0) >= 500 then 'Medium Value'
        else 'Low Value'
    end as CustomerSegment
from dbo.Customers as c
left join CustomerRevenue as cr
    on c.CustomerID = cr.CustomerID
order by Revenue desc;

-- Identifies customers whose completed orders revenue is above the average customer revenue
with CustomerRevenue as (
    select
        o.CustomerID,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.Orders as o
    inner join dbo.OrderItems as oi
        on o.OrderID = oi.OrderID
    where o.OrderStatus = 'Completed'
    group by o.CustomerID
),
AverageCustomerRevenue as (
    select
        avg(Revenue) as AvgRevenue
    from CustomerRevenue
)
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    cr.Revenue,
    acr.AvgRevenue
from CustomerRevenue as cr
inner join dbo.Customers as c
    on cr.CustomerID = c.CustomerID
cross join AverageCustomerRevenue as acr
where cr.Revenue > acr.AvgRevenue
order by cr.Revenue desc;

-- Summarizes completed and cancelled order performance by country
with OrderRevenue as (
    select
        o.OrderID,
        o.CustomerID,
        o.OrderStatus,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.Orders as o
    inner join dbo.OrderItems as oi
        on o.OrderID = oi.OrderID
    group by
        o.OrderID,
        o.CustomerID,
        o.OrderStatus
),
CountryPerformance as (
    select
        c.Country,
        sum(
            case
                when ors.OrderStatus = 'Completed' then ors.Revenue
                else 0
            end
        ) as CompletedRevenue,
        sum(
            case
                when ors.OrderStatus = 'Cancelled' then ors.Revenue
                else 0
            end
        ) as CancelledRevenue,
        sum(
            case
                when ors.OrderStatus = 'Completed' then 1
                else 0
            end
        ) as CompletedOrders,
        sum(
            case
                when ors.OrderStatus = 'Cancelled' then 1
                else 0
            end
        ) as CancelledOrders
    from OrderRevenue as ors
    inner join dbo.Customers as c
        on ors.CustomerID = c.CustomerID
    group by c.Country
)
select
    Country,
    CompletedRevenue,
    CancelledRevenue,
    CompletedOrders,
    CancelledOrders
from CountryPerformance
order by CompletedRevenue desc;

-- Analyzes completed orders revenue and sales volume by product category
with ProductPerformance as (
    select
        p.ProductID,
        p.Category,
        sum(oi.Quantity) as UnitsSold,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.Products as p
    inner join dbo.OrderItems as oi
        on p.ProductID = oi.ProductID
    inner join dbo.Orders as o
        on oi.OrderID = o.OrderID
    where o.OrderStatus = 'Completed'
    group by
        p.ProductID,
        p.Category
),
CategoryPerformance as (
    select
        Category,
        count(*) as ProductsSold,
        sum(UnitsSold) as UnitsSold,
        sum(Revenue) as Revenue,
        avg(Revenue) as AverageProductRevenue
    from ProductPerformance
    group by Category
)
select
    Category,
    ProductsSold,
    UnitsSold,
    Revenue,
    AverageProductRevenue
from CategoryPerformance
order by Revenue desc;

-- Calculates each customer's share of total completed order revenue
with CustomerRevenue as (
    select
        o.CustomerID,
        sum(oi.Quantity * oi.UnitPrice) as Revenue
    from dbo.Orders as o
    inner join dbo.OrderItems as oi
        on o.OrderID = oi.OrderID
    where o.OrderStatus = 'Completed'
    group by o.CustomerID
),
TotalRevenue as (
    select
        sum(Revenue) as TotalRevenue
    from CustomerRevenue
)
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    cr.Revenue,
    round(cr.Revenue * 100.0 / tr.TotalRevenue,2) as RevenueSharePercent
from CustomerRevenue as cr
inner join dbo.Customers as c
    on cr.CustomerID = c.CustomerID
cross join TotalRevenue as tr
order by RevenueSharePercent desc;