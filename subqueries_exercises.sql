-- Create a file named subqueries_exercises.sql and craft
--   queries to return the results for the following criteria:

USE employees;

-- 1. Find all the current employees with the same hire date
--   as employee 101010 using a sub-query.

SELECT CONCAT (e.first_name, ' ', e.last_name)
	   'Name', e.hire_date
  FROM employees e
	JOIN dept_emp de
      ON e.emp_no = de.emp_no
  WHERE de.to_date > NOW() 
    AND hire_date = (
   					   SELECT hire_date
    				     FROM employees
    				   WHERE emp_no = '101010'
); # 55
					

-- 2. Find all the titles ever held by all current employees
--   with the first name Aamod.

SELECT t.title
   FROM titles t
   WHERE t.emp_no IN(
        			SELECT emp_no
        				FROM employees
        	  			WHERE first_name = 'Aamod')
       AND emp_no IN (SELECT emp_no
        	           FROM dept_emp
        	           WHERE to_date > NOW()
						); #251

-- 3. How many people in the employees table are no longer working
--  for the company? Give the answer in a comment in your code.

SELECT COUNT(emp_no)
  FROM employees 
  WHERE emp_no NOT IN(
  			       SELECT emp_no
  			          FROM dept_emp
  			            WHERE to_date LIKE '9%'
  			            ); # 59,990


-- 4. Find all the current department managers that are female.
--   List their names in a comment in your code.

SELECT d.dept_name 'Department Name', 
	   CONCAT(e.first_name, ' ', e.last_name) 'Full Name'
  FROM departments d
	JOIN dept_manager dm
	  ON dm.dept_no = d.dept_no
	JOIN employees e
	  ON e.emp_no = dm.emp_no
  WHERE e.gender = 'F'AND dm.to_date LIKE '9%'; # Isamu Legleitner
  # Karsten Sigstam, Leon DasSarma, Hilary Kambil 
  
  -- alternatively
  SELECT first_name, last_name, gender
    FROM employees
  WHERE emp_no IN (
  				 SELECT emp_no
 				   FROM dept_manager
  				 WHERE gender = 'F' 
  				  AND to_date LIKE '9%'
  				  );
  

-- 5. Find all the employees who currently have a higher salary 
--   than the companies overall, historical average salary.

SELECT CONCAT(first_name, ' ', last_name) "Full Name",
              s.salary
  FROM employees
	JOIN salaries s 
	 USING (emp_no)
  WHERE s.salary > (
					  SELECT AVG(salary) 
						FROM salaries
					  )
    AND s.to_date > CURDATE()
ORDER BY s.salary asc; 

# 154,543

-- 6. How many current salaries are within 1 standard deviation of
--   the current highest salary? (Hint: you can use a built in function
--   to calculate the standard deviation.) What percentage of all salaries is this?
--  Hint #1 You will likely use a combination of different kinds of subqueries.
--  Hint #2 Consider that the following code will produce the z score for current salaries.

SELECT COUNT(salary) 'Within a Standard Deviation of Highest Salary'
  FROM salaries 
 WHERE to_date LIKE '9%'
   AND salary >
		   (SELECT MAX(salary) FROM salaries WHERE to_date LIKE '9%')
		   - (SELECT STDDEV(salary) FROM salaries WHERE to_date LIKE '9%'); # Salaries within 1 standard deviation: 83
		   
SELECT(
	   (SELECT COUNT(*)
		FROM salaries
		WHERE to_date LIKE '9%'
     AND salary > (
	   (SELECT MAX(salary) FROM salaries WHERE to_date LIKE '9%')
		   - (SELECT STDDEV(salary) FROM salaries WHERE to_date LIKE '9%')
             )
             )
           /(SELECT COUNT(*)
           FROM salaries
           WHERE to_date > now())) * 100 AS 'percentage within a standard deviation of highest salary'
           ;
           #0.0346%
           
# WHY IS IT SAYING SALARY IS AN UNKNOWN COLUMN IN FIELD LIST? I HAVE USED IT A MILLION TIMES. 

-- Bonus 1. Find all the department names that currently have female managers.

SELECT d.dept_name 'Department Name', 
	   CONCAT(e.first_name, ' ', e.last_name) 'Full Name',
	    gender
  FROM departments d
	JOIN dept_manager dm
	  ON dm.dept_no = d.dept_no
	JOIN employees e
	  ON e.emp_no = dm.emp_no
  WHERE e.gender = 'F'AND dm.to_date LIKE '9%';

-- Bonus 2. Find the first and last name of the employee with the highest salary.

SELECT CONCAT(first_name, ' ', last_name) 'Full Name'
  FROM employees
	JOIN dept_emp USING(emp_no)
	JOIN departments USING(dept_no)
  WHERE emp_no IN(
					SELECT emp_no
					FROM salaries
					WHERE salary IN
									(SELECT MAX(salary)
									   FROM salaries)
);