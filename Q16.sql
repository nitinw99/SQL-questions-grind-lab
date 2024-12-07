/*
- Identify any payments made at the same merchant with the same credit card for the same amount within 10 minutes of each other.
Count such repeated payments.

CREATE TABLE transactions ( transaction_id INT PRIMARY KEY, merchant_id INT NOT NULL, credit_card_id INT NOT NULL, amount DECIMAL(10, 2) NOT NULL, transaction_timestamp DATETIME NOT NULL ); 

INSERT INTO transactions (transaction_id, merchant_id, credit_card_id, amount, transaction_timestamp)
VALUES
(1, 101, 1, 100.00, '2022-09-25 12:00:00'),
(2, 101, 1, 100.00, '2022-09-25 12:08:00'),
(3, 101, 1, 100.00, '2022-09-25 12:28:00'),
(4, 102, 2, 300.00, '2022-09-25 12:00:00'),
(6, 102, 2, 400.00, '2022-09-25 14:00:00');
*/

-- SELECT * FROM transactions;

WITH CTE AS (
SELECT t1.transaction_id,
        t1.merchant_id,
        t1.credit_card_id,
        t1.amount,
        t2.transaction_timestamp AS second_tmst,
        t1.transaction_timestamp AS first_tmst
FROM transactions t1
JOIN transactions t2
ON t1.merchant_id = t2.merchant_id
    AND t1.credit_card_id = t2.credit_card_id
    AND t1.amount = t2.amount
    AND t1.transaction_id < t2.transaction_id
    AND TIMESTAMPDIFF(MINUTE, t1.transaction_timestamp, t2.transaction_timestamp) <= 10
)

SELECT COUNT(transaction_id) AS repeat_payment_count
FROM CTE;