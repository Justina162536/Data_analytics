-- Shows all customers and their number of orders, including customers with no orders
select
	concat(c.FirstName, ' ', c.LastName) as CustomerName,
	count(o.OrderID) as OrderCount
from dbo.Customers as c
left join dbo.Orders as o
on c.CustomerID = o.CustomerID
group by 
	c.CustomerID,
	c.FirstName, 
	c.LastName
order by OrderCount desc;

-- Identifies customers who have never placed an order
select
	concat(c.FirstName, ' ', c.LastName) as CustomerName
from dbo.Customers as c
left join dbo.Orders as o
on c.CustomerID = o.CustomerID
where o.OrderID is null;

-- Shows all customers and their completed-order revenue, including customers with zero revenue
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    sum(
        case
            when o.OrderStatus = 'Completed'
                then oi.Quantity * oi.UnitPrice
            else 0
        end
    ) as CompletedRevenue
from dbo.Customers as c
left join dbo.Orders as o
    on c.CustomerID = o.CustomerID
left join dbo.OrderItems as oi
    on o.OrderID = oi.OrderID
group by
    c.CustomerID,
    c.FirstName,
    c.LastName
order by CompletedRevenue desc;

