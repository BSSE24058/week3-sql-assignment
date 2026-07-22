

-- ============================================================
-- SECTION 2 — MEDIUM (10 Queries)
-- ============================================================

-- Q1: Average salary for each department.
SELECT department,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department;

-- Q2: Departments whose average salary is above 60,000.
SELECT department,
       AVG(salary) AS avg_salary
FROM employees
GROUP BY department
HAVING AVG(salary) > 60000;

-- Q3: Count how many employees work in each department.
SELECT department,
       COUNT(*) AS employee_count
FROM employees
GROUP BY department;

-- Q4: Each employee's name + department name + location (INNER JOIN).
SELECT e.name,
       d.department_name,
       d.location
FROM employees e
INNER JOIN departments d ON e.dept_id = d.id;

-- Q5: All employees + their department name, keeping employees
--     even if their department doesn't match a departments row (LEFT JOIN).
SELECT e.name,
       d.department_name
FROM employees e
LEFT JOIN departments d ON e.dept_id = d.id;

-- Q6: Employees who earn more than the company's overall average salary (subquery).
SELECT name,
       salary
FROM employees
WHERE salary > (SELECT AVG(salary) FROM employees);

-- Q7: Departments that have at least one employee assigned (EXISTS).
SELECT d.department_name
FROM departments d
WHERE EXISTS (
    SELECT 1
    FROM employees e
    WHERE e.dept_id = d.id
);

-- Q8: Each employee's name next to their manager's name (SELF JOIN).
-- LEFT JOIN keeps top-level managers (manager_id IS NULL) with a NULL manager.
SELECT e.name       AS employee,
       m.name       AS manager
FROM employees e
LEFT JOIN employees m ON e.manager_id = m.id
ORDER BY e.id;

-- Q9: Name, salary, bonus, and total pay (salary + bonus), missing bonus = 0.
SELECT name,
       salary,
       bonus,
       salary + COALESCE(bonus, 0) AS total_pay
FROM employees;

-- Q10: All employees hired during the year 2021.
SELECT *
FROM employees
WHERE YEAR(hire_date) = 2021;


-- ============================================================
-- SECTION 3 — HARD (8 Queries)
-- ============================================================

-- Q1: Rank employees by salary within their own department
--     (highest salary in a department = rank 1).
SELECT name,
       department,
       salary,
       RANK() OVER (PARTITION BY department ORDER BY salary DESC) AS dept_salary_rank
FROM employees
ORDER BY department, dept_salary_rank;

-- Q2: Top 2 highest-paid employees in every department (ROW_NUMBER).
WITH ranked_employees AS (
    SELECT name,
           department,
           salary,
           ROW_NUMBER() OVER (PARTITION BY department ORDER BY salary DESC) AS rn
    FROM employees
)
SELECT name,
       department,
       salary
FROM ranked_employees
WHERE rn <= 2
ORDER BY department, salary DESC;

-- Q3: For employees sorted by salary, show each salary next to the salary
--     of the employee just below them (the next-lower salary).
SELECT name,
       salary,
       LEAD(salary) OVER (ORDER BY salary DESC) AS next_lower_salary
FROM employees
ORDER BY salary DESC;

-- Q4: Using a CTE, find employees earning above 60,000,
--     then count how many such employees exist per department.
WITH high_earners AS (
    SELECT name, department, salary
    FROM employees
    WHERE salary > 60000
)
SELECT department,
       COUNT(*) AS high_earner_count
FROM high_earners
GROUP BY department
ORDER BY high_earner_count DESC;

-- Q5: Combine the names of all IT and Sales employees into one list, no duplicates.
SELECT name FROM employees WHERE department = 'IT'
UNION
SELECT name FROM employees WHERE department = 'Sales';

-- Q6: Per department: name, location, employee count, avg salary —
--     only where average salary exceeds 55,000.
SELECT d.department_name,
       d.location,
       COUNT(e.id)     AS employee_count,
       AVG(e.salary)   AS avg_salary
FROM departments d
INNER JOIN employees e ON e.dept_id = d.id
GROUP BY d.department_name, d.location
HAVING AVG(e.salary) > 55000
ORDER BY avg_salary DESC;

-- Q7: Every employee whose salary is greater than the average salary
--     of their OWN department (correlated subquery).
SELECT name,
       department,
       salary
FROM employees e
WHERE salary > (
    SELECT AVG(e2.salary)
    FROM employees e2
    WHERE e2.dept_id = e.dept_id
)
ORDER BY department, salary DESC;

-- Q8: All employees who manage at least one other employee
--     (someone else's manager_id points at them).
SELECT name
FROM employees e
WHERE EXISTS (
    SELECT 1
    FROM employees sub
    WHERE sub.manager_id = e.id
)
ORDER BY id;
