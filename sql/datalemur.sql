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

-- LinkedIn - Duplicate job listings

WITH dup_listings AS (
  SELECT company_id, title, description, count(*)
  FROM job_listings
  GROUP BY company_id, title, description
  HAVING count(*) > 1
)
  SELECT count(DISTINCT company_id) AS duplicate_companies
  FROM dup_listings;

-- RobinHood - Cities with Completed Trades

SELECT city, count(*) AS total_orders
FROM trades AS t
JOIN users AS u
  ON t.user_id = u.user_id
WHERE t.status = 'Completed'
GROUP BY u.city
ORDER BY total_orders DESC
LIMIT 3;

-- Amazon: Average Review Ratings

SELECT 
  EXTRACT(MONTH FROM submit_date) AS mth,
  product_id AS product,
  ROUND(AVG(stars), 2) AS avg_stars
FROM reviews
GROUP BY EXTRACT(MONTH FROM submit_date), product_id
ORDER BY mth, product;

-- GROUP BY occurs before SELECT in the order of execution.  Some SQL servers follow it strictly
-- some allow aliases in GROUP BY, but safer to use full syntax

-- FROM / JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT

-- Microsoft Teams Power Users

SELECT sender_id, count(*) AS message_count 
FROM messages
WHERE sent_date >= '2022-08-01'
  AND sent_date < '2022-09-01'
GROUP BY sender_id
ORDER BY message_count DESC
LIMIT 2;

-- Facebook Click through rate

WITH app_counts AS (
  SELECT app_id,
    COUNT(CASE WHEN event_type = 'click' THEN 1 END) AS clicks,
    COUNT(CASE WHEN event_type = 'impression' THEN 1 END) AS impressions
  FROM events
  WHERE timestamp >= '2022-01-01'
    AND timestamp < '2023-01-01'
  GROUP BY app_id
)
  SELECT
    app_id,
    ROUND(100.0 * clicks / NULLIF(impressions, 0), 2) AS ctr
  FROM app_counts

-- Twitter Tweets' Rolling Averages

SELECT 
  user_id,
  tweet_date,
  ROUND(AVG(tweet_count) OVER(
    PARTITION BY user_id
    ORDER BY tweet_date
    RANGE BETWEEN INTERVAL '2 days' PRECEDING AND CURRENT ROW), 2) AS rolling_avg_3d
FROM tweets
ORDER BY user_id, tweet_date;

-- JP Morgan Card Launch Success

WITH launch_data AS (
  SELECT
    card_name,
    ROW_NUMBER() OVER(
      PARTITION BY card_name
      ORDER BY issue_year, issue_month
      ) AS rn, 
    issued_amount
  FROM monthly_cards_issued
)
SELECT 
  card_name,
  issued_amount
FROM launch_data
WHERE rn = 1 
ORDER BY issued_amount DESC;

--Spotify Top 5 Artists

WITH artist_ranked AS (
  SELECT 
    a.artist_name,
    DENSE_RANK() OVER(
    ORDER BY count(*) DESC) AS artist_rank
  FROM artists AS a
  INNER JOIN songs AS s ON
    a.artist_id = s.artist_id
  INNER JOIN global_song_rank AS gsr ON
    s.song_id = gsr.song_id
  WHERE gsr.rank <= 10
  GROUP BY a.artist_name
)
SELECT
  artist_name,
  artist_rank
FROM artist_ranked
WHERE artist_rank <= 5
ORDER BY artist_rank;