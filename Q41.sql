/*
- Find the most profitable location and find the ration as well.
*/

-- SELECT * FROM cust_signups;
-- SELECT * FROM cust_transactions;

SELECT s.location, AVG(DATEDIFF('day', s.signup_start_date, s.signup_stop_date)) AS avg_duration,
    AVG(t.amt) AS avg_transaction_amt,
    CASE WHEN AVG(DATEDIFF('day', s.signup_start_date, s.signup_stop_date))>0 
        THEN AVG(t.amt)/AVG(DATEDIFF('day', s.signup_start_date, s.signup_stop_date))
        ELSE 0
    END AS ratio
FROM cust_signups s
JOIN cust_transactions t
ON s.signup_id = t.signup_id
GROUP BY 1
ORDER BY ratio DESC;