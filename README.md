# Data Analytics Learning

My practical data analytics learning journey.

## Technologies

- Microsoft SQL Server 2025
- SQL Server Management Studio
- T-SQL
- Power BI
- Git and GitHub

## Goals

- Improve SQL skills
- Learn Microsoft SQL Server
- Learn Power BI
- Practice real-world data analytics workflows
- Build end-to-end data analytics projects

## Progress

### Day 1
- Installed SQL Server and SSMS
- Created first SQL Server database
- Created relational tables
- Practiced primary and foreign keys
- Practiced basic SQL queries
- Practiced JOINs
- Performed basic data quality checks

## Day 2

- Practiced selecting specific columns instead of using `select *`
- Used column aliases with `as`
- Practiced `top` and sorting results with `order by`
- Used `distinct` to find unique values
- Practiced filtering data with `where`
- Used comparison operators such as `=`, `<>`, `>`, `<`, `>=`, and `<=`
- Analyzed completed-order revenue
- Calculated revenue by country and product category
- Calculated Average Order Value (AOV)
- Identified top products by revenue
- Practiced filtering by date ranges with `between`
- Practiced `group by`, aggregate functions, and multi-table joins

## Day 3

- Used `having` to filter aggregated results
- Practiced conditional logic with `case when`
- Segmented products into price categories
- Grouped order statuses into business-friendly categories
- Practiced conditional aggregation using `sum(case when ...)`
- Calculated total, completed, and cancelled order counts
- Compared completed and cancelled revenue by country
- Combined `case`, `sum`, `group by`, and multiple joins in analytical queries
- Segmented customers by total completed-order revenue
- Practiced customer value segmentation into Low, Medium, and High Value groups
- Improved query structure, formatting, aliases, and analytical SQL logic

 ## Day 4

- Practiced `left join` to keep all records from the left table
- Identified customers with no matching orders
- Practiced finding unmatched records using `is null`
- Calculated order counts while keeping customers with zero orders
- Calculated completed-order revenue while preserving customers with no completed orders
- Practiced conditional aggregation with `sum(case when ...)`
- Used `coalesce()` to replace `null` values with `0`
- Calculated total revenue for all customers, including customers with no purchases
- Identified customers with no completed orders using `having` and conditional aggregation

## Day 5

- Identified products priced above the average product price
- Used `in` with a subquery to find customers with completed orders
- Used `not exists` to identify customers with no completed orders
- Used subqueries inside the `select` clause
- Compared individual product prices with the overall average product price
- Calculated average revenue across products
- Identified products with completed-order revenue above the average product revenue
- Combined subqueries with `join`, `sum`, `avg`, `group by`, `having`, and `order by`
- Improved understanding of when a subquery returns a single value, a list of values, or a temporary result set

## Day 6

- Learned the basics of Common Table Expressions (CTEs)
- Rewrote subquery logic using CTEs
- Used single and multiple CTEs in one query
- Calculated product and customer revenue with CTEs
- Compared individual values with overall averages
- Segmented customers by completed-order revenue
- Identified customers with revenue above the customer average
- Analyzed completed and cancelled performance by country
- Analyzed product category revenue and sales volume
- Calculated each customer's share of total completed revenue
- Combined CTEs with `join`, `left join`, `cross join`, `case`, `sum`, `avg`, `group by`, and `order by`
- Improved complex query readability by separating calculations into logical CTE steps

  ## Day 7

- Practiced working with dates using `year()`, `month()`, `datename()`, `datediff()`, and `eomonth()`
- Calculated the time between customer registration and order dates
- Cleaned text data using `trim()`, `upper()`, and `lower()`
- Identified missing or empty email values
- Used `nullif()` and `case` for data quality checks
- Improved understanding of basic data cleaning and validation in SQL Server
- Created reusable SQL views for sales and customer analysis
- Learned the difference between clustered and nonclustered indexes
- Created nonclustered indexes for commonly used join and filter columns
