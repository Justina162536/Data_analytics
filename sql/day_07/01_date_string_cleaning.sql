-- Task 1: Calculate completed-order revenue by year and month
select
    year(o.OrderDate) as OrderYear,
    month(o.OrderDate) as OrderMonth,
    sum(oi.Quantity * oi.UnitPrice) as Revenue
from dbo.Orders o
join dbo.OrderItems oi
    on o.OrderID = oi.OrderID
where o.OrderStatus = 'Completed'
group by
    year(o.OrderDate),
    month(o.OrderDate)
order by
    OrderYear,
    OrderMonth;

-- Task 2: Display the month name for each order
select
    o.OrderID,
    o.OrderDate,
    datename(month, o.OrderDate) as OrderMonth,
    o.OrderStatus
from dbo.Orders o
order by o.OrderDate;

-- Task 3: Calculate the number of days between customer registration and each order
select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.RegistrationDate,
    o.OrderDate,
    datediff(day, c.RegistrationDate, o.OrderDate) as DaysUntilOrder
from dbo.Customers c
join dbo.Orders o
    on c.CustomerID = o.CustomerID
order by
    c.CustomerID,
    o.OrderDate;

    -- Task 4: Standardize customer names and email addresses
select
    c.CustomerID,
    concat(upper(trim(c.FirstName)),' ', upper(trim(c.LastName))) as CustomerName,
    lower(trim(c.Email)) as CleanEmail,
    trim(c.Country) as Country
from dbo.Customers c
order by c.CustomerID;

-- Task 5: Identify customers with missing or empty email addresses
select
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.Email,
    case
        when nullif(trim(c.Email), '') is null then 'Missing Email'
        else 'Email Available'
    end as EmailStatus
from dbo.Customers c
order by c.CustomerID;

-- Task 6: Identify orders placed before the customer registration date
select
    o.OrderID,
    c.CustomerID,
    concat(c.FirstName, ' ', c.LastName) as CustomerName,
    c.RegistrationDate,
    o.OrderDate,
    case
        when o.OrderDate < c.RegistrationDate then 'Invalid Date'
        else 'Valid Date'
    end as DateStatus
from dbo.Orders o
join dbo.Customers c
    on o.CustomerID = c.CustomerID
order by o.OrderDate;

-- Task 7: Display the last day of the month for each order
select
    o.OrderID,
    o.OrderDate,
    eomonth(o.OrderDate) as MonthEnd,
    o.OrderStatus
from dbo.Orders o
order by o.OrderDate;