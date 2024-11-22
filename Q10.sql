/*

- For each experience level, count the total number of candidates and count of candidates who got a perfect score in each category corresponding to them
- a NULL means that candidate was not assigned to solve that assessment.
- a perfect score is 100


create or replace table assessments
(
id int,
experience int,
sql_t int,
algo int,
bug_fixing int
);
delete from assessments;
insert into assessments values 
(1,3,100,null,50),
(2,5,null,100,100),
(3,1,100,100,100),
(4,5,100,50,null),
(5,5,100,100,100);

delete from assessments;
insert into assessments values 
(1,2,null,null,null),
(2,20,null,null,20),
(3,7,100,null,100),
(4,3,100,50,null),
(5,2,40,100,100);
*/

-- SELECT * FROM assessments;

SELECT experience,
    SUM(CASE WHEN (CASE WHEN sql_t IS NULL OR sql_t = 100 THEN 1 ELSE 0 END +
    CASE WHEN algo IS NULL OR algo = 100 THEN 1 ELSE 0 END +
    CASE WHEN bug_fixing IS NULL OR bug_fixing = 100 THEN 1 ELSE 0 END) = 3 THEN 1 ELSE 0
        END) AS total_cleared,
    count(id) AS total_attempted
FROM assessments
GROUP BY 1;