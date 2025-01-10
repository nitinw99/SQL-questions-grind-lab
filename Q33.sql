/*
- Given a table of tennis players and their matches that they could either win (W) or lose (L).
Find the longest streak of wins. A streak is a set of consecutive won matches of one player.
The streak ends once a player loses their next match. Output the ID of the player or players and the length of their streak.

CREATE TABLE players_results ( match_date DATETIME, match_result VARCHAR(1), player_id BIGINT);

INSERT INTO players_results (match_date, match_result, player_id) VALUES ('2023-01-01', 'W', 1), ('2023-01-02', 'W', 1), ('2023-01-03', 'L', 1), ('2023-01-04', 'W', 1), ('2023-01-01', 'L', 2), ('2023-01-02', 'W', 2), ('2023-01-03', 'W', 2), ('2023-01-04', 'W', 2), ('2023-01-05', 'L', 2), ('2023-01-01', 'W', 3), ('2023-01-02', 'W', 3), ('2023-01-03', 'W', 3), ('2023-01-04', 'W', 3), ('2023-01-05', 'L', 3);

*/

-- SELECT * FROM players_results;

WITH cte1 AS (
SELECT player_id, match_date, match_result,
-- ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_date) col1,
-- ROW_NUMBER() OVER(PARTITION BY player_id, match_result ORDER BY match_date) col2,
ROW_NUMBER() OVER(PARTITION BY player_id ORDER BY match_date) -
ROW_NUMBER() OVER(PARTITION BY player_id, match_result ORDER BY match_date) AS grp
FROM players_results
),

cte2 AS (
SELECT player_id, COUNT(*) AS streak
FROM cte1
WHERE match_result='W'
GROUP BY player_id, grp
)
,
cte3 AS (
SELECT player_id, MAX(streak) AS longest_streak
FROM cte2
GROUP BY 1
)
SELECT * FROM cte3
ORDER BY longest_streak DESC;