/*
- A query that returns the company (customer id column) with highest number of users that use desktop only.

CREATE TABLE fact_events (id INT PRIMARY KEY, time_id DATETIME, user_id VARCHAR(50), customer_id VARCHAR(50), client_id VARCHAR(50), event_type VARCHAR(50), event_id INT);

INSERT INTO fact_events (id, time_id, user_id, customer_id, client_id, event_type, event_id) VALUES  (1, '2024-12-01 10:00:00', 'U1', 'C1', 'desktop', 'click', 101), (2, '2024-12-01 11:00:00', 'U2', 'C1', 'mobile', 'view', 102), (3, '2024-12-01 12:00:00', 'U3', 'C2', 'desktop', 'click', 103), (4, '2024-12-01 13:00:00', 'U1', 'C1', 'desktop', 'click', 104), (5, '2024-12-01 14:00:00', 'U2', 'C1', 'tablet', 'view', 105), (6, '2024-12-01 15:00:00', 'U4', 'C3', 'desktop', 'click', 106), (7, '2024-12-01 16:00:00', 'U3', 'C2', 'desktop', 'click', 107), (8, '2024-12-01 17:00:00', 'U5', 'C4', 'desktop', 'click', 108), (9, '2024-12-01 18:00:00', 'U6', 'C4', 'mobile', 'view', 109), (10, '2024-12-01 19:00:00', 'U7', 'C5', 'desktop', 'click', 110);
*/

-- SELECT * FROM fact_events;

WITH filtered_companies AS (
SELECT CUSTOMER_ID
FROM fact_events
GROUP BY 1
HAVING COUNT(DISTINCT client_id)=1 AND MIN(client_id)='desktop'
)

SELECT f.CUSTOMER_ID, COUNT(distinct user_id) AS total_user
FROM filtered_companies f
JOIN
fact_events fe
ON f.CUSTOMER_ID=fe.CUSTOMER_ID
GROUP BY 1
LIMIT 1;