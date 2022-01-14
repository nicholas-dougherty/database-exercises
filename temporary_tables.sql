-- TEMPORARY TABLE Exercises
-- CREATE a FILE named temporary_tables.sql TO DO your WORK FOR this exercise.
-- -------------------------------------------------------------------------------------------------------
-- 1. USING the example FROM the lesson, CREATE a TEMPORARY TABLE called employees_with_departments
--  that CONTAINS first_name, last_name, AND dept_name FOR employees currently WITH that department. 
--  Be absolutely sure TO CREATE this TABLE ON your own database. IF you see "Access denied for user ...",
--  it means that the QUERY was attempting TO WRITE a NEW TABLE TO a DATABASE that you can only read.
USE employees;

CREATE TEMPORARY TABLE innis_1661.employees_with_departments AS
SELECT e.first_name, e.last_name, d.dept_name
  FROM employees e
	JOIN dept_emp de 
	 USING(emp_no)
	JOIN departments d 
	 USING(dept_no)
   WHERE de.to_date LIKE '9%'
LIMIT 100;

SELECT * FROM innis_1661.employees_with_departments; #Good to Go
-- -------------------------------------------------------------------------------------------------------

-- 1a. ADD a COLUMN named full_name TO this table. It should be a VARCHAR 
--    whose length IS the sum of the lengths of the FIRST NAME AND LAST NAME COLUMNS

ALTER TABLE innis_1661.employees_with_departments
	ADD full_name VARCHAR(30);

DESCRIBE employees;
SELECT * FROM innis_1661.employees_with_departments;
# first_name has 14 and last_name has 16. 14 + 16 = 30 so thirty will go in the previous code. 

-- 1b. UPDATE the TABLE so that FULL NAME COLUMN CONTAINS the correct DATA
#USE innis_1661; 

# INSERT INTO innis_1661.employees_with_departments(full_name)
# CONCAT(e.first_name, ' ', e.last_name);
#WRONG, the update is listed in the textbook 
/* -- a simple example where we want the email address to be just the first name
UPDATE employees_with_departments
SET email = CONCAT(first_name, '@company.com'); */

UPDATE innis_1661.employees_with_departments
   SET full_name = CONCAT(first_name, ' ', last_name);
    
SELECT * FROM innis_1661.employees_with_departments; 
# success. 

-- 1c. Remove the first_name AND last_name COLUMNS FROM the table.

ALTER TABLE innis_1661.employees_with_departments
DROP COLUMN first_name,
DROP COLUMN last_name;

SELECT * FROM innis_1661.employees_with_departments; 
# Groovy
-- 1d. What IS another way you could have ended up WITH this same TABLE?

USE employees;

CREATE TEMPORARY TABLE innis_1661.employees_with_departments_alternative AS
SELECT d.dept_name, CONCAT(first_name, ' ', last_name)
  FROM employees e
	JOIN dept_emp de 
	 USING(emp_no)
	JOIN departments d 
	 USING(dept_no)
   WHERE de.to_date LIKE '9%'
;

SELECT * FROM innis_1661.employees_with_departments; 
# YEP, the code listed above would yield the same results without the extra steps. 

-- -------------------------------------------------------------------------------------------------------
-- 2. CREATE a TEMPORARY TABLE based ON the payment TABLE FROM the sakila database.
--   WRITE the SQL necessary TO transform the amount COLUMN such that it IS stored 
--   AS an INTEGER representing the number of cents of the payment. 
--   FOR example, 1.99 should become 199.

USE sakila;

CREATE TEMPORARY TABLE innis_1661.payment_knockoff AS
SELECT *
  FROM payment
LIMIT 100;

SELECT * FROM innis_1661.payment_knockoff;
# amount is what needs to be modified. 
DESCRIBE innis_1661.payment_knockoff;
# amount: decimal(5,2) 
# Not sure how to approach it yet, gonna do clean up

ALTER TABLE innis_1661.payment_knockoff DROP COLUMN payment_id;
ALTER TABLE innis_1661.payment_knockoff DROP COLUMN customer_id;
ALTER TABLE innis_1661.payment_knockoff DROP COLUMN staff_id;
ALTER TABLE innis_1661.payment_knockoff DROP COLUMN payment_date;
ALTER TABLE innis_1661.payment_knockoff DROP COLUMN last_update;

SELECT * FROM innis_1661.payment_knockoff;
# Converting to an integer off the bat would delete anything beneath 1.00
# plenty of fields hit that criteria, so that's a no go
# multiplying by ten wouldn't be enough, see .99 * 10 = 9.9
# * 100 would bring it to 99, showing 99 cents was spent
# DECIMAL(5, 2) shows two decimal points and allows five total characters
# The highest amount value is 10.99. 10.99 * 100 = 1099
# So this shouldn't break the limitations of the index values as is. 

#UPDATE innis_1661.payment_knockoff
#SET amount = (amount * 100)

-- I was wrong. It seems 5 slots isn't enough. Maybe the dollar sign gets included
-- I'll just modify the decimal amount

ALTER TABLE innis_1661.payment_knockoff
MODIFY amount DECIMAL(9, 2);

UPDATE innis_1661.payment_knockoff
SET amount = (amount * 100);

ALTER TABLE innis_1661.payment_knockoff
MODIFY amount INT;

SELECT * FROM innis_1661.payment_knockoff;
# Solid. I still don't understand why 5 doesn't work though. 
;
-- -------------------------------------------------------------------------------------------------------
-- 3. Find OUT how the current average pay IN EACH department compares TO the overall,
--   historical average pay. IN order TO make the comparison easier, you should USE the
--   Z-score FOR salaries. IN terms of salary, what IS the best department RIGHT now TO 
--   WORK FOR? The worst?

USE employees;

CREATE TEMPORARY TABLE innis_1661.department_desirability AS
    SELECT d.dept_name AS 'Department',
           AVG(s.salary) AS 'Current Average Salary'
      FROM departments d
        JOIN dept_emp de USING (dept_no)
            JOIN employees e USING (emp_no)
        JOIN salaries s USING (emp_no) 
      WHERE s.to_date LIKE '9%'
        AND de.to_date LIKE '9%'
      GROUP BY d.dept_name
      ORDER BY AVG(s.salary) DESC;
      
DESCRIBE innis_1661.department_desirability;

SELECT 'Department',
	   'Current Average Salary' # lost in the sauce on how to calculate this.

/* MADELEINE's solution from the review 
CREATE TEMPORARY TABLE historic_aggregates AS (SELECT AVG(salary) AS avg_salary, std(salary) AS std_salary FROM employees.salaries
);

CREATE TEMPORARY TABLE current_info AS (
SELECT dept_name, AVG(salary AS department_current_average
FROM employees.salaries
JOIN employees.dept_emp USING(emp_no)
JOIN employees.departments USING(dept_no)
WHERE employees.salaries.to_date > curdate()
AND employees.salaries.to_date ? now(0)
GROUP BY dept_name
);

SELECT * FROM current_info;

ALTER TABLE current_info ADD historic_avg FLOAT(10, 2);
ALTER TABLE current_info ADD historic_std FLOAT(10, 2);
ALTER TABLE current_info ADD zscore FLOAT(10, 2);

UPDATE current_info SET historic_avg = (SELECT avg_salary FROM historic_avg);
UPDATE current_info SET historic_std = (SELECT std_salary FROM historic_avg);

SELECT * FROM current_info; 

UPDATE current_info 
SET zscore = (department_current_average - historic_avg) / historic_std;

SELECT * FROM current_info
ORDER BY zscore DESC; /*

