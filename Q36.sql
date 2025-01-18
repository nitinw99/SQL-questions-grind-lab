/*
- Find the total number of interactions and the total number of contents created for each customer.

CREATE TABLE user_contents (content_id BIGINT, content_text VARCHAR(255), content_type VARCHAR(50), customer_id BIGINT);
INSERT INTO user_contents (content_id, content_text, content_type, customer_id) VALUES (201, 'Welcome Post', 'Blog', 1), (202, 'Product Review', 'Review', 2), (203, 'Event Photos', 'Photo', 3), (204, 'Tutorial Video', 'Video', 3), (205, 'Survey Response', 'Survey', 4);

CREATE TABLE customer_interactions (customer_id BIGINT, interaction_date DATETIME, interaction_id BIGINT, interaction_type VARCHAR(50));
INSERT INTO customer_interactions (customer_id, interaction_date, interaction_id, interaction_type) VALUES (1, '2023-01-15 10:30:00', 101, 'Click'), (1, '2023-01-16 11:00:00', 102, 'Purchase'), (2, '2023-01-17 14:45:00', 103, 'View'), (3, '2023-01-18 09:20:00', 104, 'Share'), (3, '2023-01-18 09:25:00', 105, 'Like'), (4, '2023-01-19 12:10:00', 106, 'Comment');
*/

-- SELECT * FROM customer_interactions;
-- SELECT * FROM user_contents;

SELECT i.CUSTOMER_ID AS CUSTOMER_ID,
    COUNT(DISTINCT INTERACTION_ID) AS TOTAL_INTERACTIONS,
    COUNT(DISTINCT CONTENT_ID) AS TOTAL_CONTENT_CREATED
FROM (SELECT CUSTOMER_ID, INTERACTION_ID FROM customer_interactions) i
FULL OUTER JOIN (SELECT CUSTOMER_ID, CONTENT_ID FROM user_contents) c
ON i.CUSTOMER_ID = c.CUSTOMER_ID
GROUP BY 1;