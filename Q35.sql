/*
- Find the best selling item for each month where the highest total invoice (unit price * quantity) was paid. 

CREATE TABLE online_retails (country VARCHAR(10),customerid FLOAT,description VARCHAR(10),invoicedate DATETIME,invoiceno VARCHAR(10),quantity BIGINT,stockcode VARCHAR(10),unitprice FLOAT);

INSERT INTO online_retails (country, customerid, description, invoicedate, invoiceno, quantity, stockcode, unitprice) VALUES ('USA', 12345, 'Product A', '2025-01-01 12:00:00', 'INV001', 5, 'A123', 10.50), ('UK', 67890, 'Product B', '2025-01-02 14:30:00', 'INV002', 2, 'B456', 20.75), ('Canada', 11223, 'Product C', '2025-01-03 16:45:00', 'INV003', 10, 'C789', 15.00);

*/

-- SELECT * FROM online_retails;

WITH CTE AS (
SELECT MONTH(invoicedate) AS inv_month, description, quantity, unitprice,
    DENSE_RANK() OVER(PARTITION BY MONTH(invoicedate) ORDER BY (quantity*unitprice) DESC) AS rnk
FROM online_retails)

SELECT inv_month, description, (quantity*unitprice) AS amount_paid
FROM CTE
WHERE rnk = 1;