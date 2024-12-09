/*
- A product sales has sale_id, product_id, sale_date, quantity, price.
Find the rolling sum of sales for each product order by sales_date desc

CREATE TABLE sales_table (
    sale_id INT,
    product_id VARCHAR(10),
    sale_date DATE,
    quantity INT,
    price DECIMAL(10, 2)
);


INSERT INTO sales_table (sale_id, product_id, sale_date, quantity, price)
VALUES 
    (1, 'A', '2023-12-01', 2, 50.00),
    (2, 'A', '2023-11-30', 3, 50.00),
    (3, 'B', '2023-12-01', 1, 30.00),
    (4, 'A', '2023-11-29', 5, 50.00),
    (5, 'B', '2023-11-30', 4, 30.00);
*/

-- SELECT * FROM sales_table;

SELECT *, SUM(QUANTITY*PRICE) OVER(PARTITION BY PRODUCT_ID ORDER BY SALE_DATE desc) AS TOTAL
FROM sales_table
order by product_id;