-- ============================================================
-- Week 3 Assignment — Section 1 (EASY)
-- Author: Muhammad Abdul Rafay Khan (rafayykhan)
-- Tool:   MySQL Workbench
--
-- This file builds the `students` table from scratch, inserts
-- 10 rows, and answers all 10 Easy queries.
-- Run top-to-bottom in MySQL Workbench (or `SOURCE section1_queries.sql;`).
-- ============================================================

-- ------------------------------------------------------------
-- STEP 1 — Create the students table
-- ------------------------------------------------------------
DROP TABLE IF EXISTS students;

CREATE TABLE students (
    id                     INT PRIMARY KEY,
    name                   VARCHAR(50),
    subject                VARCHAR(30),
    marks                  INT,          -- NULL allowed on purpose
    city                   VARCHAR(30),
    admission_date         DATE,
    attendance_percentage  INT
);

-- ------------------------------------------------------------
-- STEP 2 — Insert the 10 rows
-- ------------------------------------------------------------
INSERT INTO students
    (id, name, subject, marks, city, admission_date, attendance_percentage)
VALUES
    (1,  'Ahmed',  'Math',    78,   'Lahore',    '2023-01-15', 92),
    (2,  'Ayesha', 'Science', 65,   'Karachi',   '2023-01-18', 88),
    (3,  'Bilal',  'Math',    45,   'Lahore',    '2023-02-01', 70),
    (4,  'Sana',   'English', 89,   'Islamabad', '2023-01-20', 95),
    (5,  'Hassan', 'Science', NULL, 'Karachi',   '2023-03-05', 60),
    (6,  'Mariam', 'Math',    92,   'Lahore',    '2023-01-10', 98),
    (7,  'Usman',  'English', 55,   'Multan',    '2023-02-14', 75),
    (8,  'Zara',   'Science', 70,   'Islamabad', '2023-01-25', 85),
    (9,  'Ahsan',  'Math',    NULL, 'Karachi',   '2023-04-02', 50),
    (10, 'Nida',   'English', 60,   'Lahore',    '2023-02-20', 80);

-- STEP 3 — confirm everything loaded
SELECT * FROM students;


-- ============================================================
-- SECTION 1 — EASY (10 Queries)
-- ============================================================

-- Q1: Select all columns and all rows from the students table.
SELECT * FROM students;

-- Q2: Retrieve the name and marks of students who scored more than 70.
SELECT name, marks
FROM students
WHERE marks > 70;

-- Q3: List all distinct subjects.
SELECT DISTINCT subject
FROM students;

-- Q4: Find all students whose name starts with 'A'.
SELECT *
FROM students
WHERE name LIKE 'A%';

-- Q5: List students admitted after 20th January 2023.
SELECT *
FROM students
WHERE admission_date > '2023-01-20';

-- Q6: Find all students who do NOT have marks recorded.
SELECT *
FROM students
WHERE marks IS NULL;

-- Q7: Count the total number of students.
SELECT COUNT(*) AS total_students
FROM students;

-- Q8: Find the average marks of all students.
-- (AVG ignores NULLs automatically — averages the 8 recorded marks.)
SELECT AVG(marks) AS average_marks
FROM students;

-- Q9: Find the highest and lowest marks in the class.
SELECT MAX(marks) AS highest_marks,
       MIN(marks) AS lowest_marks
FROM students;

-- Q10: List the top 5 students by marks, sorted descending.
-- (NULL marks sort last in MySQL DESC, so the top 5 recorded scores are returned.)
SELECT *
FROM students
ORDER BY marks DESC
LIMIT 5;
