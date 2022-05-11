--  _____      __ __      ____          __      ______      ____       ___       ____        _____
-- |     |    |  |  |    |    \        /  ]    |      |    |    |     /   \     |    \      / ___/
-- |   __|    |  |  |    |  _  |      /  /     |      |     |  |     |     |    |  _  |    (   \_ 
-- |  |_      |  |  |    |  |  |     /  /      |_|  |_|     |  |     |  O  |    |  |  |     \__  |
-- |   _]     |  :  |    |  |  |    /   \_       |  |       |  |     |     |    |  |  |     /  \ |
-- |  |       |     |    |  |  |    \     |      |  |       |  |     |     |    |  |  |     \    |
-- |__|        \__,_|    |__|__|     \____|      |__|      |____|     \___/     |__|__|      \___|
--                                                                                                
-- 

-- Copy the order by exercise and save it as functions_exercises.sql.
-- Originally had the copies listed above, but it took up too much space. 
-- Erased as of Jan 13 while I reformat these problems. 
-- -------------------------------------------------------------------------------------------------------

-- 2. Write a query to to find all employees whose last name starts and ends
--   WITH 'E'. USE concat() TO combine their FIRST AND LAST NAME together AS a single COLUMN named full_name.  */

SELECT CONCAT(first_name, " ", last_name) 'Full Name'
  FROM employees 
     WHERE last_name LIKE 'e%e';
-- -------------------------------------------------------------------------------------------------------

-- 3. Convert the names produced in your last query to all uppercase.

SELECT 
  UPPER(
        CONCAT(first_name, " ", last_name)
   	    ) 'Full Name'
   FROM employees 
   WHERE last_name LIKE 'e%e';

-- -------------------------------------------------------------------------------------------------------

-- 4. Find all employees hired in the 90s and born on Christmas. Use datediff() function
--   TO find how many days they have been working AT the company (Hint: You will also need TO USE NOW() OR CURDATE()),

SELECT first_name, last_name, 
       DATEDIFF(NOW(), hire_date) 
             'Days with the Firm'
  FROM employees
   WHERE birth_date LIKE '%-12-25'
    AND hire_date LIKE '199%';
-- -------------------------------------------------------------------------------------------------------

-- 5. Find the smallest and largest current salary from the salaries table.
DESCRIBE salaries;

SELECT MIN(salary) 
   FROM salaries; # $38, 623
   
SELECT MAX(salary) 
   FROM salaries; # $158, 220

SELECT MIN(salary), MAX(salary) FROM salaries;
#using AND instead of simply a separating comma returns an error. 
-- -------------------------------------------------------------------------------------------------------

-- 6. Use your knowledge of built in SQL functions to generate a username 
--   FOR ALL of the employees. A username should be ALL lowercase, AND consist
--   of the FIRST CHARACTER of the employees FIRST NAME, the FIRST 4 characters 
--   of the employees LAST NAME, an underscore, the MONTH the employee was born,
--   AND the LAST two digits of the YEAR that they were born. Below IS an example 
--   of what the FIRST 10 ROWS will look LIKE:

SELECT LOWER(CONCAT(SUBSTR(first_name, 1, 1),
	SUBSTR(last_name, 1, 4),
	   '_',
	      SUBSTR(birth_date, 6, 2),
	         SUBSTR(birth_date, 3, 2)))
	AS username
FROM employees;

/*#SELECT SUBSTR(first_name, 1, 1)
#FROM employees ; this works for the first name
       #SELECT SUBSTR(last_name, 1, 4)
       #FROM employees; works for last name
#SELECT SUBSTR(birth_date, 3, 2)
#FROM employees; this works for the birthday year
       #SELECT SUBSTR(birth_date, 6, 2)
       #FROM employees; successful for month, now to bring it all together
*/
