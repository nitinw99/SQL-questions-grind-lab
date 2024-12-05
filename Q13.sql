/*
- Pivot the data


create table players_location
(
name varchar(20),
city varchar(20)
);

insert into players_location
values ('Sachin','Mumbai'),('Virat','Delhi') , ('Rahul','Bangalore'),('Rohit','Mumbai'),('Mayank','Bangalore');

*/

-- SELECT * FROM players_location;

WITH cte AS (
SELECT *,
row_number() OVER(PARTITION BY CITY ORDER BY NAME) AS rn
FROM players_location
)

SELECT MAX(CASE WHEN CITY='Bangalore' THEN NAME END) AS Bangalore,
MAX(CASE WHEN CITY='Mumbai' THEN NAME END) AS Mumbai,
MAX(CASE WHEN CITY='Delhi' THEN NAME END) AS Delhi
FROM cte
GROUP BY rn;