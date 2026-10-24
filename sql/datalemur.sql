-- Twitter - Histogram of Tweets

WITH summary AS (
  SELECT user_id, count(*) AS tweet_bucket
  FROM tweets
  WHERE EXTRACT(YEAR from tweet_date) = 2022
  GROUP BY user_id
)
SELECT tweet_bucket, count(*) AS users_num
FROM summary
GROUP BY tweet_bucket
ORDER BY tweet_bucket ASC;

  -- Aggregate of Aggregates
  -- Use the WITH clause to create a new table with the first aggregate.
  -- Then create the second query on that new table
  -- EXTRACT allows you to pull data out of a date

-- Linkedin - Data Science Skills

SELECT candidate_id
FROM candidates
WHERE skill IN ('Python', 'Tableau', 'PostgreSQL')
GROUP BY candidate_id
HAVING COUNT(skill) = 3
ORDER BY candidate_id;

-- Tesla - Unfinished Parts

SELECT part, assembly_step
FROM parts_assembly
WHERE finish_date IS NULL;

-- Facebook - Pages with no likes
SELECT DISTINCT pages.page_id 
FROM pages
FULL JOIN page_likes
  ON pages.page_id = page_likes.page_id
WHERE liked_date IS NULL
ORDER BY page_id ASC;

-- NY Times - Mobile vs Laptop Viewership

SELECT 
  COUNT(
    CASE WHEN device_type = 'laptop' 
      THEN user_id 
      END) AS laptop_views,
  COUNT(
    CASE WHEN device_type IN ('tablet', 'phone') 
    THEN user_id 
    END) AS mobile_views
FROM viewership;