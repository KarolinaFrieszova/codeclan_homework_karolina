/* 1. Get a table of all employees details, together with their local_account_no and local_sort_code, if they have them. */
SELECT
	e.*,
	pd.local_account_no,
	pd.local_sort_code
FROM employees AS e LEFT JOIN pay_details AS pd
ON e.id = pd.id;

/* 2. Amend your query from question 1 above to also return the name of the team that each employee belongs to. */

SELECT
	e.*,
	pd.local_account_no,
	pd.local_sort_code,
	t.name
FROM (employees AS e LEFT JOIN pay_details AS pd ON e.id = pd.id)
LEFT JOIN teams AS t
ON e.team_id = t.id;

/* 3. Find the first name, last name and team name of employees who are members of teams for which the charge 
 * cost is greater than 80. Order the employees alphabetically by last name. */

SELECT
	e.first_name,
	e.last_name,
	t.name,
	t.charge_cost > '80' AS charge_cost_greater_than_80
FROM employees AS e INNER JOIN teams AS t
ON e.team_id = t.id
ORDER BY e.last_name;

/* 4. Breakdown the number of employees in each of the teams, including any teams without members. 
 * Order the table by increasing size of team. */

SELECT
	e.id,
	e.first_name,
	e.last_name,
	t.name,
	COUNT(e.id) AS num_of_emp_per_team
FROM employees AS e RIGHT JOIN teams AS t
ON e.team_id = t.id
GROUP BY t.name, e.id
ORDER BY COUNT(e.id);

/* 5. The effective_salary of an employee is defined as their fte_hours multiplied by their salary. 
 * Get a table for each employee showing their id, first_name, last_name, fte_hours, salary and effective_salary, 
 * along with a running total of effective_salary with employees placed in ascending order of effective_salary. */
------?
SELECT
	id,
	first_name,
	last_name,
	fte_hours,
	salary,
	fte_hours * salary OVER (PARTITION BY id) AS effective_salary
FROM employees
ORDER BY effective_salary;

/* 6. The total_day_charge of a team is defined as the charge_cost of the team multiplied 
 * by the number of employees in the team. Calculate the total_day_charge for each team.
 * If you GROUP BY teams.id, because it’s the primary key, you can SELECT any other column of teams that you want
 * (this is an exception to the rule that normally you can only SELECT a column that you GROUP BY).
 * You can also tackle this efficiently using a CTE. */
--- ?
SELECT
FROM


/* How many of the employees serve on one or more committees? */
/* how many employees serve per committees, if employee serves in one or more count
 */
---?
SELECT DISTINCT(COUNT(employee_id))
FROM employees_committees
GROUP BY committee_id






