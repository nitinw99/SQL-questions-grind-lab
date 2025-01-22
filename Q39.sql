/*
- Find the number of employees who received the bonus and who did not.
Output a column as a flag representing an employee received bonus or not and number of employees corresponding to it.

CREATE TABLE employee_details (id BIGINT PRIMARY KEY, first_name VARCHAR(50), last_name VARCHAR(50), age BIGINT, sex VARCHAR(10), email VARCHAR(100), address VARCHAR(100), city VARCHAR(50), department VARCHAR(50), employee_title VARCHAR(50), manager_id BIGINT, salary BIGINT, target BIGINT, bonus BIGINT);
INSERT INTO employee_details (id, first_name, last_name, age, sex, email, address, city, department, employee_title, manager_id, salary, target, bonus)VALUES (1, 'John', 'Doe', 30, 'Male', 'john.doe@example.com', '123 Elm St', 'New York', 'IT', 'Engineer', 101, 70000, 80000, 5000),(2, 'Jane', 'Smith', 28, 'Female', 'jane.smith@example.com', '456 Oak St', 'Los Angeles', 'HR', 'Manager', 102, 75000, 90000, NULL),(3, 'Alice', 'Johnson', 35, 'Female', 'alice.johnson@example.com', '789 Pine St', 'Chicago', 'Finance', 'Analyst', 103, 80000, 95000, NULL),(4, 'Bob', 'Brown', 40, 'Male', 'bob.brown@example.com', '321 Maple St', 'Boston', 'IT', 'Director', 104, 120000, 130000, NULL),(5, 'Charlie', 'Davis', 25, 'Male', 'charlie.davis@example.com', '654 Cedar St', 'Seattle', 'Marketing', 'Specialist', 105, 50000, 60000, NULL);

CREATE TABLE bonus (worker_ref_id BIGINT, bonus_amount BIGINT, bonus_date DATETIME);
INSERT INTO bonus (worker_ref_id, bonus_amount, bonus_date) VALUES (1, 5000, '2024-01-15'),(1, 3000, '2024-02-20'),(3, 2000, '2024-03-10'),(5, 1000, '2024-04-05');
*/

-- SELECT * FROM employee_details;
-- SELECT * FROM bonus;

SELECT CASE WHEN BONUS_AMOUNT IS NOT NULL THEN 1 ELSE 0 END AS bonus_flag,  COUNT(DISTINCT e.id) AS total_employees
FROM employee_details e
LEFT JOIN bonus b
ON e.id = b.worker_ref_id
GROUP BY 1;