# Week 3 — SQL Fundamentals Assignment

**Data Science Internship Program**
**Author:** Muhammad Abdul Rafay Khan ([@rafayykhan](https://github.com/rafayykhan))
**Tool used:** MySQL Workbench (MySQL 8 / MariaDB-compatible)

A fully hands-on SQL week — no Pandas, no Colab. Schema built and queried on a
local database engine across three difficulty tiers: **Easy → Medium → Hard**.

---

## Repository contents

| File | What's inside |
| --- | --- |
| `section1_queries.sql` | `CREATE TABLE students` + `INSERT` (10 rows) + all **10 Easy** queries |
| `section2_3_queries.sql` | All **10 Medium** + **8 Hard** queries against the `employees` / `departments` schema |
| `README.md` | This file |

> The `employees` / `departments` schema comes from the mentor's provided
> `Section2_3_Schema.sql`. Run that file **once** first, then run
> `section2_3_queries.sql`.

---

## How to run

**Section 1**
```sql
SOURCE section1_queries.sql;   -- builds students table, inserts rows, runs 10 easy queries
```

**Sections 2 & 3**
```sql
SOURCE Section2_3_Schema.sql;   -- mentor-provided; creates employees + departments
SOURCE section2_3_queries.sql;  -- runs 10 medium + 8 hard queries
```

Every query is numbered with a `-- Qn` comment matching the assignment brief.

---

## What was tricky to set up

The **XAMPP MySQL service wouldn't start on port 3306** at first — an old process
was already holding the port, so Apache/MySQL kept flapping in the XAMPP control
panel. Freeing the port (stopping the conflicting service, then restarting the
MySQL module) fixed it. Second gotcha: the **Section 3 window functions and CTEs
(`RANK()`, `ROW_NUMBER()`, `LEAD()`, `WITH ...`) require MySQL 8.0+** — they throw
a syntax error on MySQL 5.7, so make sure the bundled engine is 8.x before running
the Hard section.

---

## Concepts covered

**Section 1 (Easy):** `SELECT *`, `WHERE`, `DISTINCT`, `LIKE`, date filtering,
`IS NULL`, `COUNT`, `AVG`, `MAX`/`MIN`, `ORDER BY` + `LIMIT`.

**Section 2 (Medium):** `GROUP BY`, `HAVING`, `INNER JOIN`, `LEFT JOIN`,
scalar subquery, `EXISTS`, self-join, `COALESCE`, `YEAR()`.

**Section 3 (Hard):** `RANK() OVER (PARTITION BY ...)`, `ROW_NUMBER()`,
`LEAD()`, CTEs (`WITH`), `UNION`, join + group + having, correlated subquery,
`EXISTS` on a self-referential `manager_id`.

---

## Sample outputs (Medium + Hard)

All queries were executed against the live database. Five representative results
below.

### Section 2 — Q4: Employees with department name + location (INNER JOIN)
```
+---------+-----------------+-----------+
| name    | department_name | location  |
+---------+-----------------+-----------+
| Ali     | IT              | Lahore    |
| Sara    | IT              | Lahore    |
| Hamza   | Sales           | Karachi   |
| Zainab  | HR              | Islamabad |
| Kamran  | Finance         | Lahore    |
| Tariq   | Marketing       | Karachi   |
| ...     | ...             | ...       |
+---------+-----------------+-----------+
(20 rows)
```

### Section 2 — Q9: Total pay with missing bonus treated as 0 (COALESCE)
```
+---------+----------+---------+-----------+
| name    | salary   | bonus   | total_pay |
+---------+----------+---------+-----------+
| Ali     | 95000.00 | 5000.00 | 100000.00 |
| Usman   | 68000.00 |    NULL |  68000.00 |
| Kamran  | 88000.00 | 6000.00 |  94000.00 |
| Iqra    | 73000.00 | 2500.00 |  75500.00 |
| ...     | ...      | ...     | ...       |
+---------+----------+---------+-----------+
(20 rows)
```

### Section 3 — Q1: Salary rank within each department (RANK + PARTITION BY)
```
+---------+------------+----------+------------------+
| name    | department | salary   | dept_salary_rank |
+---------+------------+----------+------------------+
| Kamran  | Finance    | 88000.00 |                1 |
| Iqra    | Finance    | 73000.00 |                2 |
| Ali     | IT         | 95000.00 |                1 |
| Sara    | IT         | 72000.00 |                2 |
| Ayesha  | Sales      | 62000.00 |                1 |
| Mariam  | Sales      | 59000.00 |                2 |
| ...     | ...        | ...      | ...              |
+---------+------------+----------+------------------+
```

### Section 3 — Q3: Each salary next to the next-lower salary (LEAD)
```
+---------+----------+-------------------+
| name    | salary   | next_lower_salary |
+---------+----------+-------------------+
| Ali     | 95000.00 |          88000.00 |
| Kamran  | 88000.00 |          73000.00 |
| Iqra    | 73000.00 |          72000.00 |
| ...     | ...      | ...               |
| Hassan  | 48000.00 |              NULL |
+---------+----------+-------------------+
```

### Section 3 — Q7: Employees earning above their own department's average (correlated subquery)
```
+--------+------------+----------+
| name   | department | salary   |
+--------+------------+----------+
| Kamran | Finance    | 88000.00 |
| Sana   | HR         | 52000.00 |
| Ali    | IT         | 95000.00 |
| Rabia  | Marketing  | 60000.00 |
| Ayesha | Sales      | 62000.00 |
| Mariam | Sales      | 59000.00 |
+--------+------------+----------+
```

---

## Submission checklist

- [x] `students` table created + 10 rows inserted + all 10 Easy queries
- [x] Schema loaded, all 10 Medium + 8 Hard queries written & tested
- [x] Both `.sql` files, each query numbered with `-- Qn` comments
- [x] README with name, tool used, and one setup challenge
- [ ] Repository set to **Public** and link submitted to the mentor
