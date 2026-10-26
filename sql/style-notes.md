ORDER OF EXECUTION
    FROM / JOIN → WHERE → GROUP BY → HAVING → SELECT → ORDER BY → LIMIT
    - don't use aliases in GROUP BY even though some servers allow it.

Table Aliases - as with variable aliases, use a simple, descriptive alias for readability

NULLIF(variable, 0) - protects against 0 in the denominator

Use Date Range filters in the WHERE clause to find items pertaining to a specific month or year

Use CTE for readability.  For a detailed calcuation, define the variables in the CTE, then do the calculation in your final query.

