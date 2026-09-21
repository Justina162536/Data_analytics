-- Shows completed orders revenue by customer, keeping only customers with revenue above 500
SELECT 
	CONCAT(c.FirstName, ' ', c.LastName) AS CustomerName,
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue
FROM dbo.Customers AS c
INNER JOIN dbo.Orders AS o
ON c.CustomerID = o.CustomerID
INNER JOIN dbo.OrderItems AS oi
ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY 
	c.CustomerID,
	c.FirstName,
	c.LastName
HAVING SUM(oi.Quantity*oi.UnitPrice) > 500
ORDER BY Revenue DESC;

-- Identifies products that generated more than 200 in completed-order revenue
SELECT
	p.ProductName,
	SUM(oi.Quantity*oi.UnitPrice) AS Revenue
FROM dbo.Products AS p
INNER JOIN dbo.OrderItems AS oi
ON p.ProductID = oi.ProductID
INNER JOIN dbo.Orders AS o
ON o.OrderID = oi.OrderID
WHERE o.OrderStatus = 'Completed'
GROUP BY p.ProductName
HAVING SUM(oi.Quantity*oi.UnitPrice) > 200
ORDER BY Revenue DESC;

-- Using case when
select 
	p.ProductName,
	p.Category,
	p.UnitPrice,
	case	
		when p.UnitPrice <= 100 then 'Budget'
		when p.UnitPrice <= 300 then 'Mid-range'
		else 'Premium'
	end as PriseSegment
from dbo.Products as p
order by p.UnitPrice desc

-- Groups order statuses into business-friendly categories
select 
	o.OrderID,
	o.OrderDate,
	o.OrderStatus,
	case
	when o.OrderStatus = 'Completed' then 'Successful'
	when o.OrderStatus = 'Cancelled' then 'Unsuccessful'
	else 'Other'
	end as StatusGroup
from dbo.Orders as o
order by o.OrderDate desc;

-- Summarizes total, completed, and cancelled orders using conditional aggregation
select
    count(*) as TotalOrders,

    sum(
        case
            when OrderStatus = 'Completed' then 1
            else 0
        end
    ) as CompletedOrders,

    sum(
        case
            when OrderStatus = 'Cancelled' then 1
            else 0
        end
    ) as CancelledOrders

from dbo.Orders;

-- Compares completed and cancelled revenue by customer country
select 
	c.Country,
	sum(oi.Quantity*oi.UnitPrice) as TotalRevenue,
	sum(
		case 
			when o.OrderStatus = 'Completed' 
				then oi.Quantity*oi.UnitPrice
			else 0
		end
		) as CompletedRevenue,
		 

	sum(
		case 
			when o.OrderStatus = 'Cancelled' 
				then oi.Quantity*oi.UnitPrice
			else 0
		end
		) as CancelledRevenue
		 

from dbo.Customers as c
inner join dbo.Orders as o
on c.CustomerID = o.CustomerID
inner join dbo.OrderItems as oi
on oi.OrderID = o.OrderID
group by c.Country
order by TotalRevenue desc;

-- Segments customers by total completed-order revenue
select
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    sum(oi.Quantity * oi.UnitPrice) as Revenue,
    case
        when sum(oi.Quantity * oi.UnitPrice) < 500
            then 'Low Value'

        when sum(oi.Quantity * oi.UnitPrice) < 1000
            then 'Medium Value'

        else 'High Value'
    end as CustomerSegment

from dbo.Customers as c
inner join dbo.Orders as o
    on c.CustomerID = o.CustomerID
inner join dbo.OrderItems as oi
    on o.OrderID = oi.OrderID
where o.OrderStatus = 'Completed'
group by
    c.CustomerID,
    c.FirstName,
    c.LastName
order by Revenue desc;