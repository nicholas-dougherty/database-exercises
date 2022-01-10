USE employees;
-- Create a new file named group_by_exercises.sql
-- 2. In your script, use DISTINCT to find the unique titles in the titles table. How many unique titles have there ever been? Answer that in a comment in your SQL file.
SELECT COUNT(DISTINCT title)
FROM titles; #7 unique titles. 

-- 3. Write a query to to find a list of all unique last names of all employees that start and end with 'E' using GROUP BY.
SELECT last_name 
FROM employees 
WHERE last_name LIKE '%E' AND last_name LIKE 'E%'
GROUP BY last_name; #Erde, Eldridge, Etalle, Erie, Erbe 
-- 4. Write a query to to find all unique combinations of first and last names of all employees whose last names start and end with 'E'.
SELECT first_name, last_name
FROM employees 
WHERE last_name LIKE '%E' AND last_name LIKE 'E%'
GROUP BY first_name, last_name; 
#the answer is 846 but I need to figure out how to use count in this 
-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. Include those names in a comment in your sql code.
SELECT DISTINCT(last_name)
FROM employees
WHERE last_name LIKE '%Q%' 
	AND last_name NOT LIKE '%qu%'; #3: Chleq, Lindqvist, Qiwen
-- 6. Add a COUNT() to your results (the query above) to find the number of employees with the same last name.
SELECT DISTINCT(last_name)
FROM employees
WHERE last_name LIKE '%Q%' 
	AND last_name NOT LIKE '%qu%';
-- 7. Find all all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?

-- 9a. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.

-- 9b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count.

-- 9c. Determine how many different salaries each employee has had. This includes both historic and current.

-- 9d. Find the maximum salary for each employee.

-- 9e. Find the minimum salary for each employee.

-- 9f. Find the standard deviation of salaries for each employee.

-- 9g. Now find the max salary for each employee where that max salary is greater than $150,000.

-- 9h. Find the average salary for each employee where that average salary is between $80k and $90k.
