/*

- There are polls with users selecting their options for the polls. We have a table with correct options of the polls.
We need to find the amount won for the user who selected the right answer for the given poll.
The amount these winners will get should be proportional to the amounts they invested and as per the total of losers amount.


create table polls
(
user_id varchar(4),
poll_id varchar(3),
poll_option_id varchar(3),
amount int,
created_date date
);
INSERT INTO polls (user_id, poll_id, poll_option_id, amount, created_date) VALUES
('id1', 'p1', 'A', 200, '2021-12-01'),
('id2', 'p1', 'C', 250, '2021-12-01'),
('id3', 'p1', 'A', 200, '2021-12-01'),
('id4', 'p1', 'B', 500, '2021-12-01'),
('id5', 'p1', 'C', 50, '2021-12-01'),
('id6', 'p1', 'D', 500, '2021-12-01'),
('id7', 'p1', 'C', 200, '2021-12-01'),
('id8', 'p1', 'A', 100, '2021-12-01'),
('id9', 'p2', 'A', 300, '2023-01-10'),
('id10', 'p2', 'C', 400, '2023-01-11'),
('id11', 'p2', 'B', 250, '2023-01-12'),
('id12', 'p2', 'D', 600, '2023-01-13'),
('id13', 'p2', 'C', 150, '2023-01-14'),
('id14', 'p2', 'A', 100, '2023-01-15'),
('id15', 'p2', 'C', 200, '2023-01-16');
create table poll_answers
(
poll_id varchar(3),
correct_option_id varchar(3)
);
INSERT INTO poll_answers (poll_id, correct_option_id) VALUES
('p1', 'C'),('p2', 'A');
*/

-- SELECT * FROM polls;
-- SELECT * FROM poll_answers;

WITH losers_cte AS (
SELECT p.poll_id, SUM(amount) AS losers_amount
FROM polls p
JOIN poll_answers a
ON p.poll_id = a.poll_id
WHERE poll_option_id!=correct_option_id
GROUP BY 1
),

winners_cte AS (
SELECT p.user_id, p.poll_id, amount*1.0/
    (SUM(amount) OVER(PARTITION BY p.POLL_ID)) AS ratio_of_total
FROM polls p
JOIN poll_answers a
ON p.poll_id = a.poll_id
WHERE poll_option_id=correct_option_id
)

select w.poll_id, user_id, ROUND(ratio_of_total*losers_amount,2) AS AMOUNT_WON
from winners_cte w
JOIN losers_cte l
ON w.poll_id = l.poll_id;