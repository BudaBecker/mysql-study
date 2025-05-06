CREATE DATABASE emp_db;
USE emp_db;

CREATE TABLE employees (
    emp_no INT PRIMARY KEY AUTO_INCREMENT,
    department VARCHAR(20),
    salary INT
);
INSERT INTO employees (department, salary)
VALUES
	('engineering', 80000),
	('engineering', 69000),
	('engineering', 70000),
	('engineering', 103000),
	('engineering', 67000),
	('engineering', 89000),
	('engineering', 91000),
	('sales', 59000),
	('sales', 70000),
	('sales', 159000),
	('sales', 72000),
	('sales', 60000),
	('sales', 61000),
	('sales', 61000),
	('customer service', 38000),
	('customer service', 45000),
	('customer service', 61000),
	('customer service', 40000),
	('customer service', 31000),
	('customer service', 56000),
	('customer service', 55000);
 
-- WINDOW FUNCTIONS
SELECT 
	emp_no, 
    department, 
    salary, 
    AVG(salary) OVER() AS avg_salary, 
    salary - AVG(salary) OVER() AS detla_avg
FROM employees;
 
SELECT 
    emp_no, 
    department, 
    salary, 
    MIN(salary) OVER(),
    MAX(salary) OVER()
FROM employees;

SELECT 
	emp_no, 
    department, 
    salary, 
    AVG(salary) OVER(PARTITION BY department) AS avg_depart_salary, 
    salary - AVG(salary) OVER(PARTITION BY department) AS detla_depart_avg
FROM employees
-- WHERE department = 'sales'
ORDER BY department, salary DESC;