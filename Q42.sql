/*
- Find all the returning active users.
Note: A returning active user is a user that has made a second purchase within 7 days of any other of their purchases.
Output should include User ID of the user.
*/

-- SELECT * FROM amazon_transactions;

SELECT t1.user_id AS user_id
FROM amazon_transactions t1
JOIN amazon_transactions t2
ON t1.user_id = t2.user_id
AND t2.created_at > t1.created_at
AND DATEDIFF(day, t1.created_at, t2.created_at) <= 7;