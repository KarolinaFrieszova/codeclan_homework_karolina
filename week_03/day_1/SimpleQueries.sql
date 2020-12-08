/* Find all the employees who work in the ‘Human Resources’ department. */

SELECT *
FROM employees
WHERE department = 'Human Resources';

/* Get the first_name, last_name, and country of the employees who work in the ‘Legal’ department. */

SELECT first_name, last_name, country
FROM employees
WHERE department = 'Legal';

/* Count the number of employees based in Portugal. */

SELECT COUNT(id) AS num_of_employees_in_portugal
FROM employees
WHERE country = 'Portugal';

/* Count the number of employees based in either Portugal or Spain. */

SELECT COUNT(id) AS emp_spain_potugal
FROM employees
WHERE country IN ('Portugal', 'Spain');

/* Count the number of pay_details records lacking a local_account_no. */

SELECT COUNT(id) AS num_pay_details_no_local_acct
FROM pay_details
WHERE local_account_no IS NULL

/* Get a table with employees first_name and last_name ordered alphabetically by last_name (put any NULLs last). */

SELECT first_name, last_name
FROM employees
ORDER BY last_name ASC NULLS LAST;

/* How many employees have a first_name beginning with ‘F’? */

SELECT COUNT(id) AS first_name_with_f
FROM employees
WHERE first_name LIKE 'F%';

/* Count the number of pension enrolled employees not based in either France or Germany. */

SELECT COUNT(id) AS num_pension_not_france_germany
FROM employees
WHERE pension_enrol IS TRUE AND country NOT IN ('France', 'Germany');

/* Obtain a count by department of the employees who started work with the corporation in 2003. */

SELECT department, COUNT(id) AS num_employees_started_2003
FROM employees
WHERE start_date BETWEEN '2003-01-01' AND '2003-12-31'
GROUP BY department;

/* Obtain a table showing department, fte_hours and the number of employees in each department 
 * who work each fte_hours pattern. Order the table alphabetically by department, 
 * and then in ascending order of fte_hours.
 */

SELECT department, fte_hours, COUNT(id) AS number_of_emp_per_dep
FROM employees
GROUP BY department, fte_hours
ORDER BY department ASC NULLS LAST, fte_hours ASC NULLS LAST;

/*
 * Obtain a table showing any departments in which there are two or more employees lacking a stored first name.
 * Order the table in descending order of the number of employees lacking a first name, 
 * and then in alphabetical order by department.
 */

SELECT department, COUNT(id) AS num_emp_no_first_name
FROM employees 
WHERE first_name IS NULL 
GROUP BY department 
HAVING COUNT(id) >= 2
ORDER BY COUNT(id) DESC NULLS LAST, department ASC NULLS LAST;

/* Find the proportion of employees in each department who are grade 1. */

SELECT
	department,
	SUM(CAST(grade = '1' AS INT)) / CAST(COUNT(*) AS REAL) AS prop_grade_1
FROM employees
GROUP BY department;

/* Do a count by year of the start_date of all employees, ordered most recent year last. */

SELECT
	EXTRACT(YEAR FROM start_date) AS year,
	COUNT(id) AS num_employees_started
FROM employees
GROUP BY EXTRACT(YEAR FROM start_date)
ORDER BY year ASC NULLS LAST;

/* Return the first_name, last_name and salary of all employees together with a new column 
 * called salary_class with a value 'low' where salary is less than 40,000 
 * and value 'high' where salary is greater than or equal to 40,000. */

SELECT
	first_name,
	last_name,
	CASE
		WHEN salary < 40000 THEN 'low'
		WHEN salary IS NULL THEN NULL
	ELSE 'high'
	END AS salary_class
FROM employees;



