-- LESSON 1: Select queries 101

SELECT column, another_column, ...
FROM mytable;

SELECT *
FROM mytable
    --selects all columns

-- LESSON 2: Queries with constraints (Pt. 1)

SELECT column, another_column,
FROM mytable
WHERE condition
    AND/OR another_condition
    AND/OR ...;

-- Other operators (=, !=, <>, <, <=, >, >=)
-- Other operators (BETWEEN -- AND, NOT BETWEEN -- AND)
-- Other operators (IN, NOT IN)

-- LESSON 3: Queries with constraints (Pt. 2)

-- LIKE, NOT LIKE (case insensitive)
-- % (wild card - 0+characters)
-- _ (wild card - specific # of characters)

SELECT * FROM movies
WHERE title
    LIKE "Toy Story%"

-- Lesson 4: Filtering and sorting Query results

SELECT DISTINCT column
FROM mytable
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;

-- DISTINCT eliminates duplicates
-- ORDER_BY sorts rows alpha-numerically
-- LIMIT reduces the number of rows to return
-- OFFSET specifies where to begin counting LIMIT

-- SQL Review: Simple SELECT queries

-- 1. List all the Canadian cities and their populations
SELECT City, Population
FROM north_american_cities
WHERE Country = 'Canada';

-- 2. Order all the cities in the United States
--    by their latitude from north to south
 SELECT City
 FROM north_american_cities
 WHERE country = "United States"
 ORDER BY Latitude DESC;

 -- 3. List all the cities west of Chicago,
 --    ordered from west to east
 SELECT City
 FROM north_american_cities
 WHERE Longitude < -87.629798
 ORDER BY Longitude ASC;

 -- 4. Lost the two largest cities in Mexico
 --    (by population)
 SELECT City
 FROM north_american_cities
 WHERE Country = 'Mexico'
 ORDER BY Population DESC
 LIMIT 2;

 -- 5. List the thrid and fourth largest cities
 --    (by population) in the United States
 --    and their population

 SELECT City, Population
 FROM north_american_cities
 WHERE Country = "United States"
 ORDER BY Population DESC
 LIMIT 2 OFFSET 2;

 -- LESSON 6: Multi-table queries with JOINs

-- INNER JOIN matches rows from 1st table and 2nd table which have the same key (ON) combining
--    columns from both tables

SELECT column, another_column
FROM mytable
INNER JOIN another_table
    ON mytable.id = another_table.id
WHERE condition(s)
ORDER BY column ASC/DESC
LIMIT num_limit OFFSET num_offset;

-- LESSON 7: OUTER JOINs

-- LEFT JOIN includes rows from A regardless of whether there is a matching row in B
-- RIGHT JOIN keeps rows from B regardless of A
-- FULL JOIN keeps rows from both regardless of other

-- LESSON 8: A short note on NULLS

-- If possible, try to avoid NULLS in your database, but sometimees it's unavoidable.

SELECT column, another_column
    FROM mytable
WHERE column IS / IS NOT NULL
    AND / OR another_condition
    AND / OR ...;

-- LESSON 9: Queries with expressions

-- Mathmatical expressions can be used to transform data

SELECT col_expression AS expr_description
FROM mytable;

SELECT column AS better_column_name
FROM a_long_widgets_table AS mywidgets
INNER JOIN widget_sales
    ON widget_sales.id = mywidgets.id;

-- LESSON 10: Queries with aggregates (Pt 1)

-- Can use aggregate functions to summarize information
-- Common: (COUNT, MIN, MAX, AVG, SUM)

SELECT AGG_FUNC(column or expression) AS AGG_description
    FROM mytable
    WHERE constraints;

-- To summarize in DISTINCT groups use GROUP BY
SELECT AGG_FUNC(column or expression) AS AGG_description
    FROM mytable
    WHERE constraints
    GROUP BY column;

-- LESSON 11: Queries with aggregates (Pt 2)

-- GROUP BY is used after WHERE chooses which filters the rows to be grouped.  
-- HAVING filters the groups

SELECT group_by column, AGG_FUNC(column_expression) AS AGG_result_alias
FROM mytable
WHERE condition
GROUP BY column
HAVING group_condition

-- LESSON 12: Order of execution in a query

SELECT DISTINCT column, another_column, ...
FROM mytable
    JOIN another_table
        ON mytable.id = another_table.id
WHERE constraints
GROUP BY column
HAVING constriant_expression
ORDER BY column ASC / DESC
LIMIT num_limit OFFSET num_offset

