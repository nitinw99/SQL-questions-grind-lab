/*
- Questions on users and their bookings.
*/

-- SELECT * FROM booking_table;
-- SELECT * FROM user_table;


-- Q1
SELECT u.segment AS segment, COUNT(DISTINCT u.user_id) AS total_users,
COUNT(DISTINCT CASE WHEN b.booking_date BETWEEN '2022-04-01' AND '2022-04-30' THEN u.user_id ELSE NULL END) AS total_user_booked_flight_in_2022
FROM booking_table b
RIGHT JOIN user_table u
ON b.user_id = u.user_id
GROUP BY 1;

-- Q2. Find for each segment, the user who made the earliest booking in April 2022, and also
--- Also return how many total bookings that user made in April 2022.

WITH cte AS (
SELECT b.*, u.segment,
ROW_NUMBER() OVER(PARTITION BY u.segment ORDER BY b.booking_date) AS rn,
COUNT(*) OVER(PARTITION BY u.segment,u.user_id) AS total_user_bookings
FROM user_table u
JOIN booking_table b
ON u.user_id = b.user_id
WHERE TO_CHAR(b.booking_date, 'YYYY-MM')='2022-04'
)

SELECT segment, user_id, booking_date AS first_booking_date, total_user_bookings AS total_bookings
FROM cte WHERE rn=1;

-- Q3
SELECT user_id FROM (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY user_id ORDER BY booking_date) AS rn
FROM booking_table)
WHERE rn=1 AND line_of_business='Hotel';

-- Q4
SELECT DATEDIFF(day, MIN(booking_date), MAX(booking_date))
FROM booking_table
WHERE user_id = 'u1';

-- Q5. Count the no. of flight and hotel bookings in each of the user segments for the year 2022
SELECT u.segment,
COUNT(CASE WHEN line_of_business = 'Flight' THEN booking_id END) AS total_flight_bookings,
COUNT(CASE WHEN line_of_business = 'Hotel' THEN booking_id END) AS total_hotel_bookings
FROM user_table u
LEFT JOIN booking_table b
ON u.user_id = b.user_id AND YEAR(b.booking_date)=2022
GROUP BY 1;


