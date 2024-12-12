/*
- Determine the price of each product as of '2024-08-16'. 
If no price change occurred on or before this date, assign a default price of 10.

CREATE TABLE ProductPriceChanges (
    ProductID INT NOT NULL,       -- Product identifier
    NewPrice INT NOT NULL, -- Price with two decimal places
    ChangeDate DATE NOT NULL      -- Date when the price changed
);
INSERT INTO ProductPriceChanges (ProductID, NewPrice, ChangeDate)
VALUES
(1, 10, '2024-08-11'),
(1, 20, '2024-08-12'),
(2, 20, '2024-08-14'),
(1, 40, '2024-08-16'),
(2, 50, '2024-08-15'),
(3, 90, '2024-08-18');
*/

-- SELECT * FROM ProductPriceChanges;

WITH cte AS (
SELECT *,
row_number() OVER(PARTITION BY ProductID ORDER BY CHANGEDATE DESC) AS rn
FROM ProductPriceChanges
WHERE CHANGEDATE<='2024-08-16'
)

SELECT p.ProductID AS ProductID, COALESCE(NEWPRICE, 10) AS NEWPRICE
FROM (SELECT DISTINCT ProductID FROM ProductPriceChanges) p
LEFT JOIN cte c
ON p.ProductID=c.ProductID AND rn=1;