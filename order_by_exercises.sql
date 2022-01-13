-- 1. Create a new file named order_by_exercises.sql and copy in the
--   contents of your exercise FROM the previous lesson.
                        # WILCO
-- -------------------------------------------------------------------------------------------------------
                        
-- 2. Find all employees with first names 'Irena', 'Vidya', or 'Maya', 
--   AND order your results returned BY FIRST name. IN your comments, 
--   answer: What was the FIRST AND LAST NAME IN the FIRST ROW of the results? 
--   What was the FIRST AND LAST NAME of the LAST person IN the TABLE?

SELECT *
  FROM employees 
    WHERE first_name 
        IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name; # 709. 

/*ALSO I'm an IDI0T 
                   who didn't log IN TO a DATABASE BEFORE beginning. 
DERP. 					Irena Reutenauer. Vidya Simmen.
*/
-- -------------------------------------------------------------------------------------------------------

-- 3. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results
--    returned BY FIRST NAME AND THEN LAST name. IN your comments, answer: What was the FIRST 
--   AND LAST NAME IN the FIRST ROW of the results? What was the FIRST AND LAST NAME of the LAST person IN the TABLE?

SELECT *
   FROM employees 
  WHERE first_name 
   IN ('Irena', 'Vidya', 'Maya')
ORDER BY first_name, last_name; #Irena Acton for first row. Vidya Zweizig as the last row. 
-- -------------------------------------------------------------------------------------------------------

-- 4. Find all employees with first names 'Irena', 'Vidya', or 'Maya', and order your results 
--   returned BY LAST NAME AND THEN FIRST name. IN your comments, answer: What was the FIRST 
--   AND LAST NAME IN the FIRST ROW of the results? What was the FIRST AND LAST NAME of the 
--   LAST person IN the TABLE?

SELECT *
    FROM employees 
    WHERE first_name 
    IN ('Irena', 'Vidya', 'Maya')
ORDER BY last_name, first_name; # Row 1 = Irena Acton ; Final Row (709) = Maya Zyda
-- -------------------------------------------------------------------------------------------------------

-- 5. Write a query to to find all employees whose last name starts and ends with 'E'. 
--   Sort the results BY their employee number. Enter a COMMENT WITH the number of employees returned,
--    the FIRST employee number AND their FIRST AND LAST NAME, AND the LAST employee number WITH their 
--    FIRST AND LAST name.

SELECT * 
   FROM employees
     WHERE last_name LIKE '%E' 
         AND last_name LIKE 'E%'
ORDER BY emp_no DESC; # 899 results. 
-- ROW 1: 499648 Tadahiro Erde ; ROW 899: 10021 Ramzi Erde
-- -------------------------------------------------------------------------------------------------------

-- 6. Write a query to  find all employees whose last name starts and ends with 'E'. Sort the results
--    BY their hire DATE, so that the newest employees are listed first. Enter a COMMENT WITH the number 
--    of employees returned, the NAME of the newest employee, AND the NAME of the oldest employee.

SELECT * 
  FROM employees
	WHERE last_name LIKE '%E'
	 AND last_name LIKE 'E%'
ORDER BY hire_date DESC; # 899 results.
--   Newest: Teiji Eldridge ; Oldest: Sergi Erde
-- -------------------------------------------------------------------------------------------------------

-- 7. Find all employees hired in the 90s and born on Christmas. Sort the results so that the oldest employee
--   who was hired LAST IS the FIRST result. Enter a COMMENT WITH the number of employees returned, the NAME 
--   of the oldest employee who was hired LAST, AND the NAME of the youngest employee who was hired first.

SELECT * 
  FROM employees 
	WHERE birth_date LIKE '%-12-25'
		  AND hire_date LIKE '199%'
ORDER BY birth_date ASC, hire_date DESC; #362 
# Oldest person, most recent hire: Khun Bernini Youngest person, older hire: Douadi Pettis