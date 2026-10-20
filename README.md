# College Database Management System using MySQL

## 📌 Project Overview

The College Database Management System is a SQL-based project designed to store, manage, and retrieve college-related information. It uses MySQL to organize student details, course information, and student enrollments in a structured database.

This project demonstrates fundamental and intermediate SQL concepts useful for database management and data analytics.

## 🎯 Objectives

- Create and manage a college database using MySQL.
- Store student, course, and enrollment information.
- Retrieve data using SQL queries.
- Combine tables using JOIN operations.
- Analyze data using aggregate functions and subqueries.
- Practice views, indexes, and transaction management.

## 🛠️ Technologies Used

- **Database:** MySQL
- **Query Language:** SQL
- **Tools:** MySQL Workbench / MySQL Command Line Client

## 🗂️ Database Structure

The project contains three main tables:

### 1. Students
Stores student information, such as student ID, name, and other student details.

### 2. Courses
Stores course information, including course ID, course name, and instructor details.

### 3. Enrollments
Connects students with the courses they enroll in.

## 💡 SQL Concepts Covered

- CREATE DATABASE and CREATE TABLE
- INSERT, UPDATE, and DELETE
- SELECT and WHERE
- ORDER BY and LIMIT
- PRIMARY KEY and FOREIGN KEY
- INNER JOIN and LEFT JOIN
- GROUP BY and HAVING
- Aggregate functions: COUNT(), SUM(), AVG(), MIN(), MAX()
- Subqueries
- Views
- Indexes
- Transactions, COMMIT, ROLLBACK, and SAVEPOINT
- Window functions such as ROW_NUMBER() and RANK()

## ⚙️ How to Run the Project

1. Install MySQL Server and MySQL Workbench.
2. Open MySQL Workbench or your MySQL command-line client.
3. Create a new SQL script.
4. Copy the SQL code into the script, or open the project's `.sql` file.
5. Execute the script to create the database, tables, and sample records.
6. Run the SELECT queries to view the results.

Example:

```sql
USE college_db;

SELECT * FROM students;

SELECT * FROM courses;

SELECT * FROM enrollments;
```

## 📊 Example Analysis

You can use this database to answer questions such as:

- Which students are enrolled in each course?
- How many students are enrolled in each course?
- Which courses have no enrollments?
- How can student and course details be combined using JOINs?
- How can records be ranked using SQL window functions?

## 📁 Project Files

- `CollegeDB_Alternate_Data.sql` — SQL script containing database creation, sample data, and practice queries.
- `README.md` — Project documentation.

## 🚀 Learning Outcomes

By completing this project, you can gain practical experience in relational database design, SQL query writing, data retrieval, and data analysis. It is suitable for beginners learning SQL and students preparing for entry-level data analyst roles.

## 👩‍💻 Author

**Your Name**

## 📄 License

This project is intended for educational and learning purposes.
