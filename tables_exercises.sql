SHOW DATABASES;
USE home_credit;
SELECT database();
USE chipotle;
SELECT database();
USE employees;
SHOW TABLES;
DESCRIBE departments; #dept number (char 4), dept_name varchar(40) UNI key?
DESCRIBE dept_emp; #int, char, date Primary Key included on employee & dept #s
DESCRIBE salaries; #int No Nulls, PRI on employee number and from date
DESCRIBE current_dept_emp; #int, dept number (char(4)) dates include optional Null
DESCRIBE titles; #title has varchar limit set to 50. Null on to_date. PRI for three fields.
DESCRIBE employees; #first, last, gender (enum?), hire date, and employee number
#tables with numeric type column: employee #, 
#tables with string type column: dept number
#tables with dates: starting dates, ending dates for employees 
#relationship between employees and departments tables: the employees belong to the department
#there is signicantly more information given in the employee table. 
SHOW CREATE TABLE dept_manager;