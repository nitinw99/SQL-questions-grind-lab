/*
- Find the 3-month rolling average of total revenue from purchases given a table with users, their purchase amount, and date purchased.
Exclude the rows with negative purchase values. 
Output the year-month (YYYY-MM) and 3-month rolling average of revenue, sorted from earliest month to latest month.

CREATE TABLE amazon_purchases ( created_at DATETIME, purchase_amt BIGINT, user_id BIGINT);

INSERT INTO amazon_purchases (created_at, purchase_amt, user_id) VALUES ('2023-01-05', 1500, 101), ('2023-01-15', -200, 102), ('2023-02-10', 2000, 103), ('2023-02-20', 1200, 101), ('2023-03-01', 1800, 104), ('2023-03-15', -100, 102), ('2023-04-05', 2200, 105), ('2023-04-10', 1400, 103), ('2023-05-01', 2500, 106), ('2023-05-15', 1700, 107), ('2023-06-05', 1300, 108), ('2023-06-15', 1900, 109);
*/

-- SELECT * FROM amazon_purchases;

WITH MONTHLY_REVENUE AS (
SELECT TO_VARCHAR(CREATED_AT, 'YYYY-MM') AS YEAR_MONTH, 
SUM(CASE WHEN PURCHASE_AMT>0 THEN PURCHASE_AMT ELSE 0 END) AS TOTAL_REVENUE
FROM amazon_purchases
GROUP BY 1
)

SELECT YEAR_MONTH, 
ROUND(AVG(TOTAL_REVENUE) OVER(ORDER BY YEAR_MONTH ROWS BETWEEN 2 PRECEDING AND CURRENT ROW),2) AVG_REVENUE
FROM MONTHLY_REVENUE
ORDER BY YEAR_MONTH;