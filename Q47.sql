/*
- [Easy] Find each customer’s latest order amount along with the amount of the second latest order. 
*/

WITH base AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY customer_id ORDER BY order_date DESC) AS rn
FROM orders_tbl
)

SELECT customer_id,
MAX(CASE WHEN rn = 1 THEN order_amount END) AS latest_order,
MAX(CASE WHEN rn = 2 THEN order_amount END) AS second_latest_order
FROM base
GROUP BY 1;