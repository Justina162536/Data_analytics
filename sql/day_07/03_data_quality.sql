-- Task 1. Create a staging table for raw imported customer data
create table dbo.stg_Customers (
    CustomerID nvarchar(50),
    FirstName nvarchar(100),
    LastName nvarchar(100),
    Email nvarchar(150),
    Country nvarchar(100),
    RegistrationDate nvarchar(50)
);

-- Task 2. Insert raw data containing data quality problems
insert into dbo.stg_Customers
    (CustomerID, FirstName, LastName, Email, Country, RegistrationDate)
values
    ('101', ' Jonas ', 'Jonaitis', 'JONAS@EMAIL.COM', ' Lithuania ', '2026-01-10'),
    ('102', 'Anna', 'Smith', '', 'Germany', '2026-02-15'),
    ('103', 'Peter', 'Brown', 'peter@email.com', 'Germany', 'invalid-date'),
    ('104', 'Maria', 'Garcia', 'maria@email.com', 'Spain', '2026-03-05'),
    ('104', 'Maria', 'Garcia', 'maria@email.com', 'Spain', '2026-03-05'),
    ('ABC', 'Lukas', 'Muller', null, 'Germany', '2026-04-01');

-- Task 3. Identify records with missing email addresses
select *
from dbo.stg_Customers
where nullif(trim(Email), '') is null;

-- Task 4. Identify duplicate CustomerID values
select
    CustomerID,
    count(*) as RecordCount
from dbo.stg_Customers
group by CustomerID
having count(*) > 1;

-- Task 5. Identify invalid customer IDs and registration dates
select
    CustomerID,
    RegistrationDate,
    case
        when try_convert(int, CustomerID) is null
            then 'Invalid CustomerID'
        else 'Valid CustomerID'
    end as CustomerIDStatus,
    case
        when try_convert(date, RegistrationDate) is null
            then 'Invalid Date'
        else 'Valid Date'
    end as DateStatus
from dbo.stg_Customers;

-- Task 6: Clean and convert valid staging data
select
    try_convert(int, CustomerID) as CustomerID,
    trim(FirstName) as FirstName,
    trim(LastName) as LastName,
    lower(nullif(trim(Email), '')) as Email,
    trim(Country) as Country,
    try_convert(date, RegistrationDate) as RegistrationDate
from dbo.stg_Customers
where
    try_convert(int, CustomerID) is not null
    and try_convert(date, RegistrationDate) is not null;

-- Task 7. Create a simple data quality summary
select
    count(*) as TotalRows,
    sum(
        case
            when nullif(trim(Email), '') is null then 1
            else 0
        end
    ) as MissingEmails,
    sum(
        case
            when try_convert(int, CustomerID) is null then 1
            else 0
        end
    ) as InvalidCustomerIDs,
    sum(
        case
            when try_convert(date, RegistrationDate) is null then 1
            else 0
        end
    ) as InvalidDates
from dbo.stg_Customers;