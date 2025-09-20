/*
- Find customers who satify these conditions:
• They place orders in each of their first 3 consecutive months since their very first order.
• The number of orders in the second month is exactly double the number of orders in the first month.
• The number of orders in the third month is exactly triple the number of orders in the first month.
• Their last order (latest by date) was placed with a coupon code (i.e., Coupon Code is not NULL)
*/

WITH base AS (
SELECT *,
DATE_TRUNC(month, order_date) AS order_month,
MIN(DATE_TRUNC(month, order_date)) OVER(PARTITION BY customer_id) AS first_order_month, 
LAST_VALUE(coupon_code) OVER(PARTITION BY customer_id ORDER BY order_date rows between unbounded preceding and unbounded following) AS latest_coupon_applied
FROM orders
),

base2 AS (
SELECT *, DATEDIFF(month, first_order_month, order_month)+1 AS month_number
FROM base
WHERE latest_coupon_applied IS NOT NULL
),

final AS (
SELECT customer_id,
SUM(CASE WHEN month_number='1' THEN 1 ELSE 0 END) AS first_month_orders,
SUM(CASE WHEN month_number='2' THEN 1 ELSE 0 END) AS second_month_orders,
SUM(CASE WHEN month_number='3' THEN 1 ELSE 0 END) AS third_month_orders
FROM base2
WHERE month_number IN ('1','2','3')
GROUP BY 1
)

SELECT *
FROM final
WHERE second_month_orders=2*first_month_orders AND third_month_orders=3*first_month_orders;