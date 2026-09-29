-- Task 1. Create a view containing completed sales transactions

create or alter view dbo.vw_CompletedSales
as
select
    o.OrderID,
    o.OrderDate,
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.Country,
    p.ProductID,
    p.ProductName,
    p.Category,
    oi.Quantity,
    oi.UnitPrice,
    oi.Quantity * oi.UnitPrice as Revenue
from dbo.Orders o
join dbo.Customers c
    on o.CustomerID = c.CustomerID
join dbo.OrderItems oi
    on o.OrderID = oi.OrderID
join dbo.Products p
    on oi.ProductID = p.ProductID
where o.OrderStatus = 'Completed';

go

-- Task 2. Analyze completed revenue by country using the view
select
    Country,
    sum(Revenue) as Revenue
from dbo.vw_CompletedSales
group by Country
order by Revenue desc;
go

-- Task 3. Create a reusable customer revenue view
create or alter view dbo.vw_CustomerRevenue
as

select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.Country,
    count(distinct o.OrderID) as CompletedOrders,
    coalesce(sum(oi.Quantity * oi.UnitPrice), 0) as Revenue
from dbo.Customers c
left join dbo.Orders o
    on c.CustomerID = o.CustomerID
    and o.OrderStatus = 'Completed'
left join dbo.OrderItems oi
    on o.OrderID = oi.OrderID
group by
    c.CustomerID,
    c.FirstName,
    c.LastName,
    c.Country;
go

-- Task 4. Segment customers using the customer revenue view
select
    CustomerID,
    CustomerName,
    Country,
    CompletedOrders,
    Revenue,
    case
        when Revenue >= 1000 then 'High Value'
        when Revenue >= 500 then 'Medium Value'
        else 'Low Value'
    end as CustomerSegment
from dbo.vw_CustomerRevenue
order by Revenue desc;

-- Task 6. Create an index to improve OrderItems joins
create nonclustered index IX_OrderItems_OrderID_ProductID
on dbo.OrderItems (OrderID, ProductID)
include (Quantity, UnitPrice);

-- Task 7. Inspect indexes created on the main tables
select
    t.name as TableName,
    i.name as IndexName,
    i.type_desc as IndexType,
    i.is_primary_key as IsPrimaryKey,
    i.is_unique as IsUnique
from sys.indexes i
join sys.tables t
    on i.object_id = t.object_id
where t.name in (
    'Customers',
    'Products',
    'Orders',
    'OrderItems'
)
and i.name is not null
order by
    t.name,
    i.name;