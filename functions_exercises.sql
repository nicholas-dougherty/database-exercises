
-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; # 709. ALSO I'm an IDI0T and didn't log in to a database before beginning. DERP. Irena Reutenauer. Vidya Simmen. 

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by first name and then last name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name; #Irena Acton for first row. Vidya Zweizig as the last row. 

-- Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results returned by last name and then first name. In your comments, answer: What was the first and last name in the first row of the results? What was the first and last name of the last person in the table?

SELECT *
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name; # Row 1 = Irena Acton ; Final Row (709) = Maya Zyda

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their employee number. Enter a comment with the number of employees returned, the first employee number and their first and last name, and the last employee number with their first and last name.

SELECT * FROM employees
WHERE last_name LIKE '%E' AND last_name LIKE 'E%'
ORDER BY emp_no DESC; # 899 results. Row 1: 499648 Tadahiro Erde ; Row 899: 10021 Ramzi Erde

-- Write a query to to find all employees whose last name starts and ends with 'E'. Sort the results by their hire date, so that the newest employees are listed first. Enter a comment with the number of employees returned, the name of the newest employee, and the name of the oldest employee.

SELECT * FROM employees
WHERE last_name LIKE '%E' AND last_name LIKE 'E%'
ORDER BY hire_date DESC; # 899 results. Newest: Teiji Eldridge ; Oldest: Sergi Erde

-- Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee who was hired last is the first result. Enter a comment with the number of employees returned, the name of the oldest employee who was hired last, and the name of the youngest employee who was hired first.

SELECT * FROM employees 
WHERE birth_date LIKE '%-12-25'
		AND hire_date LIKE '199%'
ORDER BY birth_date ASC, hire_date DESC; #362 Oldest person, most recent hire: Khun Bernini Youngest person, older hire: Douadi Pettis

-- Copy the order by exercise and save it as functions_exercises.sql.

-- 2. Write a query to to find all employees whose last name starts and ends with 'E'. Use concat() to combine their first and last name together as a single column named full_name.

SELECT CONCAT(first_name, " ", last_name) AS full_name
FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';

-- 3. Convert the names produced in your last query to all uppercase.

SELECT UPPER(CONCAT(first_name, " ", last_name)) AS full_name
FROM employees WHERE last_name LIKE '%E' AND last_name LIKE 'E%';


-- 4. Find all employees hired in the 90s and born on Christmas. Use datediff() function to find how many days they have been working at the company (Hint: You will also need to use NOW() or CURDATE()),

SELECT DATEDIFF(NOW(), hire_date)
FROM employees
#AS days_at_company
WHERE birth_date LIKE '%-12-25'
AND hire_date LIKE '199%';

-- 5. Find the smallest and largest current salary from the salaries table.
DESCRIBE salaries;
SELECT MIN(salary) FROM salaries; # $36, 623
SELECT MAX(salary) FROM salaries; # $158, 220

-- 6. Use your knowledge of built in SQL functions to generate a username for all of the employees. A username should be all lowercase, and consist of the first character of the employees first name, the first 4 characters of the employees last name, an underscore, the month the employee was born, and the last two digits of the year that they were born. Below is an example of what the first 10 rows will look like:

#SELECT SUBSTR(first_name, 1, 1)
#FROM employees ; this works for the first name

#SELECT SUBSTR(last_name, 1, 4)
#FROM employees; works for last name

#SELECT SUBSTR(birth_date, 3, 2)
#FROM employees; this works for the birthday year

#SELECT SUBSTR(birth_date, 6, 2)
#FROM employees; successful for month, now to bring it all together

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),
	SUBSTR(last_name, 1, 4),
	'_',
	SUBSTR(birth_date, 6, 2),
	SUBSTR(birth_date, 3, 2)))
		AS username
		FROM employees;
	
/* generating a username will require the CONCAT function. LOWER will make the case. SUBST 1? for first name, SUBST 4 for last name. underscores
birth_date, Sub 3,4? */



