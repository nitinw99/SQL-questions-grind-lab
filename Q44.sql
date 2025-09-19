/*
- Finding Names of best employee and best client in each department.
*/

-- SELECT * FROM department;
-- SELECT * FROM empdetails;
-- SELECT * FROM client;
-- SELECT * FROM empsales;


WITH cte AS (
SELECT s.*, e.dep_id
FROM empsales s
JOIN empdetails e
ON s.emp_id = e.emp_id
),

emp_client_cte AS (
SELECT dep_id, emp_id AS id, 'emp' AS sale_type, SUM(sales) AS total_sales
FROM cte
GROUP BY 1,2
UNION ALL
SELECT dep_id, client_id AS id, 'client' AS sale_type, SUM(sales) AS total_sales
FROM cte
GROUP BY 1,2
)
,
final_cte AS (
SELECT dep_id,
MAX(CASE WHEN sale_type = 'emp' THEN id END) AS best_emp_id,
MAX(CASE WHEN sale_type = 'client' THEN id END) AS best_client_id
FROM (
SELECT *, ROW_NUMBER() OVER(PARTITION BY dep_id, sale_type ORDER BY total_sales DESC) AS rn
FROM emp_client_cte)
WHERE rn=1
GROUP BY 1
)

SELECT f.dep_id, e.first_name, c.client_name
FROM final_cte f
JOIN empdetails e
ON f.best_emp_id = e.emp_id
JOIN client c
ON f.best_client_id = c.client_id
ORDER BY 1;