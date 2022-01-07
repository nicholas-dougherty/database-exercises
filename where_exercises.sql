-- Create a file named where_exercises.sql. Make sure to use the employees database.
USE employees;
-- 2 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya' using IN. Enter a comment with the number of records returned.
SELECT emp_no, first_name, last_name
FROM employees 
WHERE first_name IN ('Irena', 'Vidya', 'Maya');
-- Commas as separators are essential for this to run. 709 total rows indicate 709 employees have one of these three names. 

-- 3 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', as in Q2, but use OR instead of IN. Enter a comment with the number of records returned. Does it match number of rows from Q2?
SELECT *
FROM employees
WHERE first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya'; 
-- like last time, this returns 709 rows, indicating a match with the previous question 
#WHERE first_name = 'Irena' OR ('Vidya', 'Maya');

-- 4 Find all current or previous employees with first names 'Irena', 'Vidya', or 'Maya', using OR, and who is male. Enter a comment with the number of records returned.
SELECT *
FROM employees
WHERE (first_name = 'Irena'
OR first_name = 'Vidya'
OR first_name = 'Maya')
AND gender = 'M'; # 441 male employees meet these conditions 

-- 5 Find all current or previous employees whose last name starts with 'E'. Enter a comment with the number of employees whose last name starts with E.
SELECT emp_no, first_name, last_name FROM employees
WHERE last_name LIKE 'E%'; #7330

-- 6 Find all current or previous employees whose last name starts or ends with 'E'. Enter a comment with the number of employees whose last name starts or ends with E. How many employees have a last name that ends with E, but does not start with E?
SELECT * FROM employees
WHERE last_name LIKE 'E%' OR last_name LIKE '%E'; #Starts or Ends with 'e' = 30723

SELECT * FROM employees
WHERE last_name LIKE '%E' AND last_name NOT LIKE 'E%'; #Ends with E but doesn't Start with E = 23393 

-- 7 Find all current or previous employees employees whose last name starts and ends with 'E'. Enter a comment with the number of employees whose last name starts and ends with E. How many employees' last names end with E, regardless of whether they start with E?

SELECT * FROM employees
WHERE last_name LIKE '%E' AND last_name LIKE 'E%'; # 899 start and end with e. 
SELECT * FROM employees
WHERE last_name LIKE '%E'; # 24,292 end with an e, and in some cases start with an e but all other 25 letters are considered as well. 

-- 8 Find all current or previous employees hired in the 90s. Enter a comment with the number of employees returned.
SELECT * FROM employees 
WHERE hire_date BETWEEN '1990-01-01' AND '1999-12-31'; #135,214 employees hired in the 90s 
#SELECT * FROM employees 
#WHERE hire_date LIKE '199%'; just for fun, this returns the same result and is more succinct 

-- 9 Find all current or previous employees born on Christmas. Enter a comment with the number of employees returned.
SELECT * FROM employees 
WHERE hire_date LIKE '%-12-25'; # 789 employees were born on Christmas 
-- 10 Find all current or previous employees hired in the 90s and born on Christmas. Enter a comment with the number of employees returned.
SELECT * FROM employees 
WHERE hire_date LIKE '199%-12-25'; #346 employees born on Christmas as nineties babies. 
-- 11 Find all current or previous employees with a 'q' in their last name. Enter a comment with the number of records returned.
SELECT * FROM employees
WHERE last_name LIKE '%Q%'; #1873 employees have a 'q' somewhere in their name.

-- 12 Find all current or previous employees with a 'q' in their last name but not 'qu'. How many employees are found?
SELECT * FROM employees
WHERE last_name LIKE '%Q%' 
AND last_name NOT LIKE '%qu%'; # 547 meet these conditions
