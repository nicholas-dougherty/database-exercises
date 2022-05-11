-- '/¯¯¯¯/\¯¯¯¯\  |¯¯¯¯|\¯¯¯¯\‚ ‚/¯¯¯¯/\¯¯¯¯\‚ |¯¯¯¯|'  |¯¯¯¯| |¯¯¯¯|\¯¯¯¯\‚             |¯¯¯¯|\¯¯¯¯\‚ |¯¯¯¯| '|¯¯¯¯| 
-- |:·.·.·:|_|____|‚ |:·.·.·:|/____/| |:·.·.·:'|::|:·.·.·:| |:·.·.·:|'  |:·.·.·:| |:·.·.·:|/____/|             |:·.·.·:|/____/| |\__.·:\/:·.__/| 
-- |:·.·.·:|‚|_¯¯¯¯| |:·.·.·:|\¯¯¯¯\| |:·.·.·:'|/\|:·.·.·:| |:·.·.·:|'  |:·.·.·:| |:·.·.·:||'¯`·v´|:|             |:·.·.·:|\¯¯¯¯\| |:|‚v'|:·.·.·:|‚v'|:| 
-- |\____\/____/| |____|·|____|'‚|\____\/____/| |\____\/____/| |____||L,__'|/'             |____|/____/| '\|L,|____|_,|/' 
-- |:|'¯`·v´||'¯`·v´|:| |¯`·v·´|\|'¯`v.´’|'‚|:|'¯`·v´||'¯`·v´|:| |:|'¯`·v´||'¯`·v´|:| |'¯`·v´'|‚                      |'¯`·v´·||'¯`·v´|'|      |¯`·v·´|      
-- '\|L,__'||L,__'|/' |L,__'| |L,__,|'‚'\|L,__'||L,__'|/' '\|L,__'||L,__'|/' |L,__,|'                      |L,__,||L,__'|/'‚     |L,__,|‚     
-- 

USE employees;
-- Create a new file named group_by_exercises.sql
-- 2. In your script, use DISTINCT to find the unique titles in the 
--   titles table. How many UNIQUE titles have there ever been? Answer 
--   that IN a COMMENT IN your SQL file.

SELECT COUNT(DISTINCT title)
  FROM titles; 
   #7 unique titles. 
-- -------------------------------------------------------------------------------------------------------

-- 3. Write a query to to find a list of all unique last names of 
--   ALL employees that START AND END WITH 'E' USING GROUP BY.

SELECT last_name 
  FROM employees 
	WHERE last_name LIKE '%E' 
	 AND last_name LIKE 'E%'
GROUP BY last_name; 
   #Erde, Eldridge, Etalle, Erie, Erbe 
-- -------------------------------------------------------------------------------------------------------
  
-- 4. Write a query to to find all unique combinations of first and 
--   LAST NAMES of ALL employees whose LAST NAMES START AND END WITH 'E'.
SELECT first_name, 
	   last_name
  FROM employees 
	WHERE last_name LIKE '%E' 
	 AND last_name LIKE 'E%'
GROUP BY first_name, last_name; 
    #846
-- -------------------------------------------------------------------------------------------------------
    
-- 5. Write a query to find the unique last names with a 'q' but not 'qu'. 
--    Include those NAMES IN a COMMENT IN your SQL code.

SELECT DISTINCT(last_name)
  FROM employees
WHERE last_name LIKE '%Q%' 
	AND last_name NOT LIKE '%qu%'; 
	#3: Chleq, Lindqvist, Qiwen
-- -------------------------------------------------------------------------------------------------------
	
-- 6. Add a COUNT() to your results (the query above) to find the number
--   of employees WITH the same LAST name.

SELECT last_name, 
	   COUNT(*)
  FROM employees
GROUP BY last_name
       HAVING last_name LIKE '%Q%' 
	 AND last_name NOT LIKE '%qu%'; 
   # Chleq = 189, Lindqvist = 190, Qiwen = 168
-- -------------------------------------------------------------------------------------------------------
   
-- 7. Find all employees with first names 'Irena', 'Vidya', or 'Maya'. Use COUNT(*) and GROUP BY to find the number of employees for each gender with those names.

SELECT first_name, 
	   gender, 
	    COUNT(*)
FROM employees
GROUP BY first_name, gender 
HAVING first_name IN('Irena', 'Vidya', 'Maya')
ORDER BY gender DESC, first_name ASC; # Females: Irena 97, Maya 90, Vidya 81. MALES: Irena 144, Maya 146, Vidya 151
-- -------------------------------------------------------------------------------------------------------

-- 8. Using your query that generates a username for all of the employees, generate a count employees for each unique username. Are there any duplicate usernames? BONUS: How many duplicate usernames are there?
SELECT LOWER(
			CONCAT(
			SUBSTR(first_name, 1, 1),
			SUBSTR(last_name, 1, 4),
			'_',
			SUBSTR(birth_date, 6, 2),
			SUBSTR(birth_date, 3, 2)))
	AS username,
       COUNT(emp_no)
  FROM employees
GROUP BY username --this shows there are duplicates, but doesn't narrow it down 
HAVING COUNT(emp_no) >= 2;

-- -------------------------------------------------------------------------------------------------------

-- 9a. Determine the historic average salary for each employee. When you hear, read, or think "for each" with regard to SQL, you'll probably be grouping by that exact column.
SELECT AVG(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- 9b. Using the dept_emp table, count how many current employees work in each department. The query result should show 9 rows, one for each department and the employee count. DESCRIBE dept_emp; #current workers seem to work with the to_date as year 9999
SELECT dept_no, COUNT(emp_no)
FROM dept_emp
WHERE to_date LIKE '9%'
GROUP BY dept_no; 

-- 9c. Determine how many different salaries each employee has had. This includes both historic and current.
-- Historic First
SELECT AVG(salary), emp_no
FROM salaries
GROUP BY emp_no;

-- Current Averages
SELECT emp_no, COUNT(emp_no), AVG(salary)
FROM salaries
WHERE to_date LIKE '9%'
GROUP BY emp_no; 

-- 9d. Find the maximum salary for each employee.
SELECT MAX(salary)
FROM salaries
GROUP BY emp_no;

-- 9e. Find the minimum salary for each employee.
SELECT MIN(salary)
FROM salaries
GROUP BY emp_no;

-- 9f. Find the standard deviation of salaries for each employee.
SELECT emp_no, STD(salary)
FROM salaries
GROUP BY emp_no;

-- 9g. Now find the max salary for each employee where that max salary is greater than $150,000.
SELECT MAX(salary)
FROM salaries
GROUP BY emp_no
HAVING MAX(salary) >= 150000
ORDER BY MAX(salary) ASC;
 
-- 9h. Find the average salary for each employee where that average salary is between $80k and $90k.
SELECT emp_no, AVG(salary)
FROM salaries
GROUP BY emp_no
HAVING AVG(salary) BETWEEN 80000 AND 90000
ORDER BY AVG(salary) ASC;
