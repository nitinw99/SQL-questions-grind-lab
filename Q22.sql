/*
Market penetration is an important metric for Spotify's growth in different regions. 
Calculate the active user penetration rate in different countries.
Active Users must meet these criteria:
a. Interacted with Spotify within the last 30 days (last_active_date >= 2024-01-01).
b. At least 5 sessions. 
c. At least 10 listening hours.
Active User Penetration Rate = (Number of Active Spotify Users in the Country / Total Users in the Country)

CREATE TABLE penetration_analysis ( country VARCHAR(20), last_active_date DATETIME, listening_hours BIGINT, sessions BIGINT, user_id BIGINT);

INSERT INTO penetration_analysis (country, last_active_date, listening_hours, sessions, user_id) VALUES ('USA', '2024-01-25', 15, 7, 101), ('USA', '2023-12-20', 5, 3, 102), ('USA', '2024-01-20', 25, 10, 103), ('India', '2024-01-28', 12, 6, 201), ('India', '2023-12-15', 8, 4, 202), ('India', '2024-01-15', 20, 7, 203), ('UK', '2024-01-29', 18, 9, 301), ('UK', '2023-12-30', 9, 4, 302), ('UK', '2024-01-22', 30, 12, 303), ('Canada', '2024-01-01', 11, 6, 401), ('Canada', '2023-11-15', 3, 2, 402), ('Canada', '2024-01-15', 22, 8, 403), ('Germany', '2024-01-10', 14, 7, 501), ('Germany', '2024-01-30', 10, 5, 502), ('Germany', '2024-01-01', 5, 3, 503);
*/

-- SELECT * FROM penetration_analysis;

SELECT country, 
    ROUND(COUNT(DISTINCT CASE WHEN TO_DATE(last_active_date)>= '2024-01-01' AND SESSIONS>=5 AND LISTENING_HOURS>=10 THEN USER_ID END)*100/(COUNT(DISTINCT USER_ID)),2) AS active_user_penetration_rate
FROM penetration_analysis
GROUP BY 1
ORDER BY 1;