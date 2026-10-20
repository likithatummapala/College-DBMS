CREATE DATABASE IF NOT EXISTS college_db;
USE college_db;

DROP TABLE IF EXISTS enrollments;
DROP TABLE IF EXISTS students;
DROP TABLE IF EXISTS courses;

CREATE TABLE students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    age INT CHECK (age >= 16),
    department VARCHAR(50) NOT NULL
);

CREATE TABLE courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) UNIQUE NOT NULL,
    credits INT NOT NULL CHECK (credits > 0 AND credits <= 6),
    instructor VARCHAR(100) NOT NULL
);

CREATE TABLE enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    enrollment_date DATE NOT NULL,
    grade VARCHAR(2)
        CHECK (grade IN ('A', 'B', 'C', 'D', 'F', 'A+')),
    FOREIGN KEY (student_id)
        REFERENCES students(student_id) ON DELETE CASCADE,
    FOREIGN KEY (course_id)
        REFERENCES courses(course_id) ON DELETE CASCADE,
    UNIQUE (student_id, course_id)
);
INSERT INTO students (name, email, age, department) VALUES
('Meera Nair', 'meera.cse@example.com', 21, 'CSE'),
('Karthik Rao', 'karthik.it@example.com', 20, 'IT'),
('Pooja Sharma', 'pooja.ece@example.com', 22, 'ECE'),
('Aditya Menon', 'aditya.mech@example.com', 19, 'MECH'),
('Farah Khan', 'farah.cse@example.com', 23, 'CSE');

INSERT INTO courses (course_name, credits, instructor) VALUES
('Python for Data Science', 4, 'Prof. Iyer'),
('Cloud Computing', 3, 'Prof. Thomas'),
('Cyber Security', 4, 'Prof. Reddy'),
('Statistics for Analytics', 3, 'Prof. Das');

INSERT INTO enrollments
(student_id, course_id, enrollment_date, grade)
VALUES
(1, 1, '2025-08-12', 'A'),
(1, 2, '2025-08-14', 'B'),
(2, 3, '2025-08-15', 'A+'),
(2, 4, '2025-08-18', 'B'),
(3, 1, '2025-08-20', 'A'),
(3, 3, '2025-08-21', 'B'),
(4, 2, '2025-08-25', 'C'),
(5, 1, '2025-09-02', 'A+'),
(5, 3, '2025-09-04', 'A'),
(5, 4, '2025-09-06', 'B');

SELECT * FROM students;
SELECT * FROM courses;
SELECT * FROM enrollments;
-- 1. Display all CSE students
SELECT * FROM students
WHERE department = 'CSE';

-- 2. Sort students by age
SELECT * FROM students
ORDER BY age ASC;

-- 3. Find names starting with M
SELECT * FROM students
WHERE name LIKE 'M%';

-- 4. Courses having more than 3 credits
SELECT * FROM courses
WHERE credits > 3;

-- 5. Students from IT or ECE
SELECT * FROM students
WHERE department IN ('IT', 'ECE');

-- 1. Update a student's department
UPDATE students
SET department = 'IT'
WHERE student_id = 1;

-- 2. Update a student's grade
UPDATE enrollments
SET grade = 'A+'
WHERE student_id = 5 AND course_id = 3;

-- 3. Update course credits
UPDATE courses
SET credits = 4
WHERE course_name = 'Cloud Computing';

-- 4. Delete an enrollment
DELETE FROM enrollments
WHERE student_id = 4 AND course_id = 2;

-- 1. Display student names and course names
SELECT s.name, c.course_name
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;

-- 2. Display students with their grades
SELECT s.name, c.course_name, e.grade
FROM students s
INNER JOIN enrollments e
    ON s.student_id = e.student_id
INNER JOIN courses c
    ON e.course_id = c.course_id;

-- 3. Display all students, including those without enrollments
SELECT s.name, c.course_name, e.grade
FROM students s
LEFT JOIN enrollments e
    ON s.student_id = e.student_id
LEFT JOIN courses c
    ON e.course_id = c.course_id;

-- 4. Display all courses, including courses without enrollments
SELECT c.course_name, s.name, e.grade
FROM courses c
LEFT JOIN enrollments e
    ON c.course_id = e.course_id
LEFT JOIN students s
    ON e.student_id = s.student_id;

-- 5. Find students enrolled in Python for Data Science
SELECT s.name, s.email
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Python for Data Science';

-- 1. Total number of students
SELECT COUNT(*) AS total_students
FROM students;

-- 2. Number of students in each department
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department;

-- 3. Average student age
SELECT AVG(age) AS average_age
FROM students;

-- 4. Maximum and minimum student age
SELECT MAX(age) AS oldest, MIN(age) AS youngest
FROM students;

-- 5. Total course credits
SELECT SUM(credits) AS total_credits
FROM courses;

-- 6. Count enrollments in each course
SELECT c.course_name, COUNT(e.enrollment_id) AS total_enrollments
FROM courses c
LEFT JOIN enrollments e ON c.course_id = e.course_id
GROUP BY c.course_id, c.course_name;

-- 7. Departments with more than one student
SELECT department, COUNT(*) AS total_students
FROM students
GROUP BY department
HAVING COUNT(*) > 1;

-- 8. Number of courses taken by each student
SELECT s.name, COUNT(e.course_id) AS courses_enrolled
FROM students s
LEFT JOIN enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id, s.name;

-- 1. Students older than the average age
SELECT name, age
FROM students
WHERE age > (SELECT AVG(age) FROM students);

-- 2. Courses with no enrollments
SELECT course_name
FROM courses
WHERE course_id NOT IN (
    SELECT course_id FROM enrollments
);

-- 3. Student(s) with the maximum age
SELECT name, age
FROM students
WHERE age = (SELECT MAX(age) FROM students);

-- 4. Students enrolled in courses taught by Prof. Iyer
SELECT name
FROM students
WHERE student_id IN (
    SELECT student_id
    FROM enrollments
    WHERE course_id IN (
        SELECT course_id
        FROM courses
        WHERE instructor = 'Prof. Iyer'
    )
);

-- 5. Students who have at least one enrollment
SELECT s.name
FROM students s
WHERE EXISTS (
    SELECT 1
    FROM enrollments e
    WHERE e.student_id = s.student_id
);
-- 1. View for CSE students
CREATE OR REPLACE VIEW vw_cse_students AS
SELECT student_id, name, department
FROM students
WHERE department = 'CSE';

SELECT * FROM vw_cse_students;

-- 2. View combining all three tables
CREATE OR REPLACE VIEW vw_enrollment_details AS
SELECT
    s.student_id,
    s.name AS student_name,
    s.department,
    c.course_name,
    c.credits,
    c.instructor,
    e.enrollment_date,
    e.grade
FROM students s
JOIN enrollments e ON s.student_id = e.student_id
JOIN courses c ON e.course_id = c.course_id;

SELECT * FROM vw_enrollment_details;

-- 3. Display students with grade A
SELECT student_name, course_name, grade
FROM vw_enrollment_details
WHERE grade = 'A';

-- 4. Department statistics
CREATE OR REPLACE VIEW vw_department_stats AS
SELECT department, COUNT(*) AS total_students, AVG(age) AS avg_age
FROM students
GROUP BY department;

SELECT * FROM vw_department_stats;

-- 5. List all views
SHOW FULL TABLES IN college_db
WHERE TABLE_TYPE = 'VIEW';

CREATE INDEX idx_department
ON students(department);

CREATE INDEX idx_grade
ON enrollments(grade);

CREATE INDEX idx_name_dept
ON students(name, department);

SHOW INDEX FROM students;
SHOW INDEX FROM enrollments;

EXPLAIN
SELECT * FROM students
WHERE department = 'CSE';

-- Optional: remove an index
-- DROP INDEX idx_grade ON enrollments;


-- TRANSACTION
START TRANSACTION;

UPDATE courses
SET credits = credits - 1
WHERE course_id = 1;

UPDATE courses
SET credits = credits + 1
WHERE course_id = 2;

SELECT * FROM courses;

COMMIT;

-- ROLLBACK: undo changes before committing
START TRANSACTION;

UPDATE courses SET credits = 3 WHERE course_id = 1;
UPDATE courses SET credits = 4 WHERE course_id = 2;

SELECT * FROM courses;

ROLLBACK;

SELECT * FROM courses;

-- SAVEPOINT: undo only changes after the savepoint
START TRANSACTION;

UPDATE courses SET credits = 3 WHERE course_id = 1;

SAVEPOINT sp1;

UPDATE courses SET credits = 5 WHERE course_id = 2;

ROLLBACK TO SAVEPOINT sp1;

SELECT * FROM courses;

COMMIT;

