/*
- Due to an error in the delivery driver instructions, each item's order was swapped with the item in the subsequent row. 
Please correct this swapping error and return the proper pairing of order ID and item.
Note: If the last item has an odd order ID, it should remain as the last item in the corrected data.
Output the correct pairs of order IDs and items.
*/

-- SELECT * FROM orders;

WITH CTE AS (
SELECT *, 
LAG(ITEM,1) OVER(ORDER BY ORDER_ID) AS PREV_ITEM,
LEAD(ITEM,1) OVER(ORDER BY ORDER_ID) AS NEXT_ITEM
FROM orders)

SELECT ORDER_ID,
CASE WHEN ORDER_ID %2 = 1 AND NEXT_ITEM IS NULL THEN ITEM
WHEN ORDER_ID %2 = 1 THEN NEXT_ITEM
ELSE PREV_ITEM END AS CORRECT_ORDERS
FROM CTE;