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

-- Review

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
 LIMIT 2 OFFSET 2