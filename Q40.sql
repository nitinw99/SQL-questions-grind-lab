/*
- Extract the third transaction of every user, displaying user ID, spend, and transaction date.
*/

-- SELECT * FROM Transactions;

WITH CTE AS (
SELECT *,
ROW_NUMBER() OVER(PARTITION BY UserID ORDER BY TransactionDate) AS rn
FROM Transactions)

SELECT UserID, Spend, TransactionDate
FROM CTE
WHERE rn = 3;


/*
- Find the average ratings for each driver across different cities using data from rides and ratings tables.
*/

-- SELECT * FROM Rides;
-- SELECT * FROM Ratings;

SELECT DriverID, City, AVG(Rating) AS avg_rating
FROM Rides r
LEFT JOIN Ratings rt
ON r.RideID = rt.RideID
GROUP BY 1,2;

/*
- Analyze the click-through conversion rates using data from ad_clicks and cab_bookings tables.
*/

-- SELECT * FROM ad_clicks;
-- SELECT * FROM cab_bookings;

WITH CTE AS (
SELECT a.AdID,
COUNT(DISTINCT b.UserID) AS total_bookings,
COUNT(DISTINCT a.UserID) AS total_clicks
FROM ad_clicks a
LEFT JOIN cab_bookings b
ON a.UserID = b.UserID AND b.BookingDate>=a.ClickDate
GROUP BY 1
)

SELECT AdID, total_clicks, total_bookings,
ROUND(((total_bookings*1.0)/(total_clicks))*100,2) AS conversion_rate
FROM CTE;