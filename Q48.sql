/*
- Compare rolling 30-day amount with previous 30-day window.
*/

-- SELECT * FROM transactions;

WITH base AS (
SELECT txn_date, SUM(amount) AS daily_rev
FROM transactions
GROUP BY 1
ORDER BY 1
),

final AS (
SELECT txn_date, daily_rev,
SUM(daily_rev) OVER(ORDER BY txn_date ROWS BETWEEN 29 PRECEDING AND CURRENT ROW) AS revenue_30_days
FROM base
)

SELECT txn_date, daily_rev,revenue_30_days, 
ROUND((CASE WHEN prev_30_days_val IS NULL THEN 0
ELSE (revenue_30_days-prev_30_days_val)*100.0/prev_30_days_val END
), 2) AS percent_change

FROM (
SELECT *, LAG(revenue_30_days,1) OVER(ORDER BY txn_date) AS prev_30_days_val
FROM final);