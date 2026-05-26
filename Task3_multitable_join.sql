-- Task 3: Multi-Table Operations & Joins
-- 1. INNER JOIN
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS name, d.dept_name
FROM employees e INNER JOIN dept_emp de ON e.emp_no = de.emp_no 
INNER JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' LIMIT 5;

-- 2. LEFT JOIN  
SELECT e.emp_no, CONCAT(e.first_name, ' ', e.last_name) AS employee,
CONCAT(m.first_name, ' ', m.last_name) AS manager FROM employees e
LEFT JOIN dept_manager dm ON dm.dept_no = (SELECT dept_no FROM dept_emp WHERE emp_no = e.emp_no AND to_date = '9999-01-01')
LEFT JOIN employees m ON dm.emp_no = m.emp_no
WHERE dm.to_date = '9999-01-01' LIMIT 5;

-- 3. UNION
SELECT emp_no, 'Active' AS status, dept_name FROM dept_emp de JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date = '9999-01-01' AND d.dept_name = 'Sales'
UNION ALL
SELECT emp_no, 'Former' AS status, dept_name FROM dept_emp de JOIN departments d ON de.dept_no = d.dept_no
WHERE de.to_date < '9999-01-01' AND d.dept_name = 'Sales' LIMIT 5;

-- 4. Subquery
SELECT e.emp_no, e.first_name, (SELECT salary FROM salaries s WHERE s.emp_no = e.emp_no AND s.to_date = '9999-01-01') AS current_salary
FROM employees e WHERE e.emp_no IN (10001, 10002, 10003);

-- 5. Gender Ratio
SELECT d.dept_name, ROUND(100 * SUM(IF(e.gender='F', 1, 0)) / COUNT(*), 1) AS female_pct
FROM departments d JOIN dept_emp de ON d.dept_no = de.dept_no JOIN employees e ON de.emp_no = e.emp_no
WHERE de.to_date = '9999-01-01' GROUP BY d.dept_name;
