/*

- Write a query that returns the number of calls between each unique pair of individuals (both directions counted as one)

CREATE TABLE calls (
 call_id INT PRIMARY KEY,
 caller_id INT,
 receiver_id INT,
 call_timestamp TIMESTAMP
);

INSERT INTO calls (call_id, caller_id, receiver_id, call_timestamp) VALUES
(1, 101, 102, '2024-10-01 08:00:00'),
(2, 102, 101, '2024-10-01 08:05:00'),
(3, 101, 103, '2024-10-01 09:00:00'),
(4, 102, 103, '2024-10-01 09:30:00'),
(5, 101, 102, '2024-10-01 10:00:00');

*/

-- SELECT * FROM calls;

SELECT LEAST(caller_id, receiver_id) AS p1, GREATEST(caller_id, receiver_id) AS p2, COUNT(*) AS total_calls
FROM calls
GROUP BY 1,2;