/*
          _____                            _____                            _____                            _____                  
         /\    \                          /\    \                          /\    \                          /\    \                 
        /::\    \                        /::\    \                        /::\    \                        /::\    \                
       /::::\    \                      /::::\    \                      /::::\    \                      /::::\    \               
      /::::::\    \                    /::::::\    \                    /::::::\    \                    /::::::\    \              
     /:::/\:::\    \                  /:::/\:::\    \                  /:::/\:::\    \                  /:::/\:::\    \             
    /:::/  \:::\    \                /:::/__\:::\    \                /:::/__\:::\    \                /:::/__\:::\    \            
   /:::/    \:::\    \              /::::\   \:::\    \               \:::\   \:::\    \              /::::\   \:::\    \           
  /:::/    / \:::\    \            /::::::\   \:::\    \            ___\:::\   \:::\    \            /::::::\   \:::\    \          
 /:::/    /   \:::\    \          /:::/\:::\   \:::\    \          /\   \:::\   \:::\    \          /:::/\:::\   \:::\    \         
/:::/____/     \:::\____\        /:::/  \:::\   \:::\____\        /::\   \:::\   \:::\____\        /:::/__\:::\   \:::\____\        
\:::\    \      \::/    /        \::/    \:::\  /:::/    /        \:::\   \:::\   \::/    /        \:::\   \:::\   \::/    /        
 \:::\    \      \/____/          \/____/ \:::\/:::/    /          \:::\   \:::\   \/____/          \:::\   \:::\   \/____/         
  \:::\    \                               \::::::/    /            \:::\   \:::\    \               \:::\   \:::\    \             
   \:::\    \                               \::::/    /              \:::\   \:::\____\               \:::\   \:::\____\            
    \:::\    \                              /:::/    /                \:::\  /:::/    /                \:::\   \::/    /            
     \:::\    \                            /:::/    /                  \:::\/:::/    /                  \:::\   \/____/             
      \:::\    \                          /:::/    /                    \::::::/    /                    \:::\    \                 
       \:::\____\                        /:::/    /                      \::::/    /                      \:::\____\                
        \::/    /                        \::/    /                        \::/    /                        \::/    /                
         \/____/                          \/____/                          \/____/                          \/____/                 
                                                                                                                                    */
-- 1. Write a query that returns all employees, their department number, their start date, their end date,
--   and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

# JOIN dept_emp USING (emp.no) may possibly need this, may just need to use dept_emp, not employees

SELECT de.emp_no, de.dept_no, de.from_date, de.to_date,
	CASE
	  WHEN to_date LIKE '9%' THEN 1
	   ELSE 0
    END AS is_current_employee
FROM dept_emp de
   LIMIT 10;

/* listed below is Zach's solution from the lecture 
SELECT
	e.emp_no,
	de.dept_no,
	de.from_date AS start_date,
	de.to_date AS end_date,
	de.to_date > NOW() AS is_current_employee
  FROM employees e
    JOIN dept_emp de USING (emp_no)
  LIMIT 10;  */
-- -------------------------------------------------------------------------------------------------------

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' 
--  that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT CONCAT(e.first_name, ' ', e.last_name) 'Full Name',
	CASE 
	  WHEN SUBSTR(e.last_name, 1) < 'I' THEN 'ALPHA (A-H)'
	   WHEN SUBSTR(e.last_name, 1) >= 'I' AND e.last_name < 'R' THEN 'INDIA (I-Q)' 
	     ELSE 'ROMEO (R-Z)'
    END AS alpha_group 
  FROM employees e
ORDER BY e.last_name;

SELECT CONCAT(e.first_name, ' ', e.last_name) 'Full Name',
	CASE 
	  WHEN e.last_name < 'I' THEN 'ALPHA (A-H)'
	   WHEN e.last_name >= 'I' AND e.last_name < 'R' THEN 'INDIA (I-Q)' 
	     ELSE 'ROMEO (R-Z)'
    END AS alpha_group 
  FROM employees e
ORDER BY e.last_name;

-- SELECT SUBSTR(e.last_name, 1, 1)
-- It seems the substring itself might be unnecessary here. 

-- FROM employees e; used to retrieve first letter of last name. 
-- -------------------------------------------------------------------------------------------------------

-- 3. How many employees (current or previous) were born in each decade?

SELECT COUNT(*),
	CASE 
	 WHEN e.birth_date < '1960-01-01' THEN 'Fifties Baby'
	 WHEN e.birth_date >= '1960-01-01' THEN 'Sixties Baby'
    END AS birth_decade 
    FROM employees e
    GROUP BY birth_decade;

SELECT 
	CONCAT(SUBSTR(birth_date, 1, 3), '0') AS decade,
	COUNT(*)
	FROM employees
	GROUP BY decade;
	
SELECT birth_date FROM employees;
-- -------------------------------------------------------------------------------------------------------

-- 4. What is the current average salary for each of the following department groups:
--   R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(s.salary),
	CASE 
	  WHEN dept_no IN ( 'd008', 'd005') THEN 'Research & Development'
	   WHEN dept_no IN ('d007', 'd001') THEN 'Sales & Marketing'
	   WHEN dept_no IN ('d004', 'd006') THEN 'Production & Quality Management'
	   WHEN dept_no IN ('d002', 'd003') THEN 'Finance & Human Resources'
	   WHEN dept_no = 'd009' THEN 'Customer Service'
    END AS combined_departments
  FROM departments d
    JOIN dept_emp de USING(dept_no)
    JOIN salaries s USING(emp_no)
    GROUP BY combined_departments;
    
#FROM salaries s
#JOIN departments d USING(dept_no)
;
