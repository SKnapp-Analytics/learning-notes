ORDER OF EXECUTION
    FROM / JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
    - don't use aliases in GROUP BY even though some servers allow it.

Table Aliases - as with variable aliases, use a simple, descriptive alias for readability

NULLIF(variable, 0) - protects against 0 in the denominator

Use Date Range filters in the WHERE clause to find items pertaining to a specific month or year

Use CTE for readability.  For a detailed calcuation, define the variables in the CTE, then do the calculation in your final query.

See datalemur.sql - Spotify top 5 artists, for a detailed example of how to use Group By and Rankings to count then rank.
 - Here are some real world examples for that:
RANK() OVER (ORDER BY SUM(price) DESC)        -- customers by total spend
RANK() OVER (ORDER BY AVG(review_score) DESC) -- sellers by average rating
RANK() OVER (ORDER BY MAX(order_date) DESC)   -- customers by most recent order
-Below in the code, you would include a GROUP BY customers - RANK() can look inside the collapsed GROUP to sum price.

