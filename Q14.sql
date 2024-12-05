/*
- There is a Business City table from the day when the company started its operations.
Identify the Year wise count of new cities where the company started its business.

create table business_city (
business_date date,
city_id int
);

insert into business_city
values(cast('2020-01-02' as date),3),(cast('2020-07-01' as date),7),(cast('2021-01-01' as date),3),(cast('2021-02-03' as date),19)
,(cast('2022-12-01' as date),3),(cast('2022-12-15' as date),3),(cast('2022-02-28' as date),12);

*/

-- SELECT * FROM business_city;

WITH main_cte AS (
SELECT CITY_ID, YEAR(BUSINESS_DATE) AS BUSINESS_YEAR
FROM business_city

)

,first_b_city AS (
SELECT CITY_ID, MIN(BUSINESS_YEAR) AS first_b_year
FROM main_cte
GROUP BY 1
)

SELECT BUSINESS_YEAR, COUNT(b.CITY_ID) AS CITIES
from
main_cte b
 JOIN
 first_b_city f
ON BUSINESS_YEAR=first_b_year AND b.city_id=f.city_id
GROUP BY 1;