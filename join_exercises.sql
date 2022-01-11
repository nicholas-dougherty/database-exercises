-- Use the join_example_db. Select all the records from both the users and roles tables.
SELECT * FROM users;
SELECT * FROM roles;
-- Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.
SELECT * FROM users JOIN roles ON users.role_id = roles.id; #Just bunching these lines up to save space so I don't exceed my 100 line history limit. 
SELECT * FROM users LEFT JOIN roles ON users.role_id = roles.id;
SELECT * FROM users RIGHT JOIN roles ON users.role_id = roles.id;
-- Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.
SELECT COUNT(roles.id), roles.name FROM roles LEFT JOIN users ON roles.id = users.role_id GROUP BY roles.id;
-- Use the Employees Database
USE employees;
-- departments: dept_no, dept_name | dept_manager: emp_no, dept_no, from_date, to_date | employees: employee_no, first_name, last_name
-- Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.
SELECT d.dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) 'Full Name'
FROM departments d
JOIN dept_manager dm 
ON dm.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9%';
# GROUP BY departments.dept_name, employees.first_name, employees.last_name; this needs to be cleaned
-- Find the name of all departments currently managed by women
SELECT d.dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) 'Full Name'
FROM departments d
JOIN dept_manager dm
ON dm.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no
WHERE e.gender = 'F'AND dm.to_date LIKE '9%';
-- ??? Find the current titles of employees currently working in the Customer Service department.
SELECT t.title, COUNT(d.dept_no = 'd009')
FROM dept_emp de
JOIN departments d
ON d.dept_no = de.dept_no
JOIN titles t
ON t.emp_no = de.emp_no
WHERE de.to_date LIKE '9%' AND de.dept_no = 'd009' AND d.dept_no = 'd009' AND t.to_date LIKE '9%'
GROUP BY t.title
ORDER BY t.title;
# needs to be organized and counted
-- Find the current salary of all current managers.
SELECT d.dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) 'Full Name', s.salary 'Current Salary'
FROM departments d
JOIN dept_manager dm 
ON dm.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no
JOIN salaries s
ON s.emp_no = dm.emp_no
WHERE dm.to_date LIKE '9%' AND s.to_date LIKE '9%';
-- Find the number of current employees in each department.
SELECT d.dept_no, d.dept_name, COUNT(e.emp_no) 'num_employees'
FROM employees e
JOIN dept_emp de
ON de.emp_no = e.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE de.to_date LIKE '9%'  
GROUP BY d.dept_no
ORDER BY dept_no; 
-- Which department has the highest average salary? 
SELECT d.dept_name, AVG(s.salary)
FROM employees e
JOIN dept_emp de
ON de.emp_no = e.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
JOIN salaries s
ON s.emp_no = e.emp_no
WHERE s.to_date LIKE '9%' AND de.to_date LIKE '9%'
GROUP BY d.dept_name
ORDER BY d.dept_name DESC LIMIT 1;
-- Who is the highest paid employee in the Marketing department?
SELECT e.first_name, e.last_name
FROM dept_emp de
JOIN salaries s
ON s.emp_no = de.emp_no
JOIN employees e
ON e.emp_no = s.emp_no
WHERE s.to_date LIKE '9%' AND de.to_date LIKE '9%' AND de.dept_no = 'd001'
ORDER BY s.salary DESC LIMIT 1;
-- Which current department manager has the highest salary? 
SELECT CONCAT(e.first_name, ' ', e.last_name) "Baller", s.salary, d.dept_name
FROM dept_manager dm
JOIN salaries s
ON s.emp_no = dm.emp_no
JOIN employees e
on e.emp_no = dm.emp_no
JOIN departments d
ON d.dept_no = dm.dept_no
WHERE s.to_date LIKE '9%' AND dm.to_date LIKE '9%'
ORDER BY s.salary DESC LIMIT 1;
-- Determine the average salary for each department. Use all salary information and round your results.
SELECT d.dept_name, ROUND(AVG(s.salary), 0) 'Average Salary'
FROM employees e
JOIN dept_emp de
ON de.emp_no = e.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
JOIN salaries s
ON s.emp_no = e.emp_no
GROUP BY d.dept_name
ORDER BY AVG(s.salary) DESC;
-- Bonus Find the names of all current employees, their department name, and their current manager's name. 
SELECT CONCAT(e.first_name, ' ', e.last_name) 'Employee Name', d.dept_name 'Department Name', CONCAT(e.first_name, ' ', e.last_name) 'Employee Name'
FROM departments d
JOIN dept_manager dm 
ON dm.dept_no = d.dept_no
JOIN employees e
ON e.emp_no = dm.emp_no
JOIN dept_emp de
ON de.emp_no = e.emp_no
WHERE dm.to_date LIKE '9%' AND de.to_date LIKE '9%';
