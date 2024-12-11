/*
- We have a student table with data in the format shown below.

Name Subject Marks
Person 1 Eng 96
Person 1 Hindi 76
Person 1 Maths 89
Person 2 Eng 78
Person 2 Hindi 88
Person 2 Maths 98
Person 3 Eng 67
Person 3 Hindi 65
Person 3 Maths 78

Write an SQL query to achieve the desired output without using the UNPIVOT() function.

create table student(name varchar(50), Eng int, Hindi int, Maths int);
Insert into Student values('person1', 96, 76, 89),
 ('person2', 78, 88, 98),
 ('person3', 67, 65, 79);
*/

-- SELECT * FROM student;

SELECT NAME, 'Eng' AS Subject, ENG AS Marks
FROM student
UNION ALL
SELECT NAME, 'Hindi' AS Subject, HINDI AS Marks
FROM student
UNION ALL
SELECT NAME, 'Maths' AS Subject, MATHS AS Marks
FROM student
ORDER BY 1,2;