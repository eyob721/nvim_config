-- Build a university database for practice
-- Delete the database if it exists, to start from scratch
DROP DATABASE IF EXISTS university;


-- Create the database
CREATE DATABASE IF NOT EXISTS university;


-- Use the database
USE university;


-- Create student table
CREATE TABLE IF NOT EXISTS student (
  roll_no INT auto_increment,
  name VARCHAR(100) NOT NULL,
  city VARCHAR(100) NOT NULL,
  dept_no INT NOT NULL,
  PRIMARY KEY (roll_no)
);


-- Create department table
CREATE TABLE IF NOT EXISTS department (
  dept_no INT NOT NULL,
  name VARCHAR(255) NOT NULL,
  PRIMARY KEY (dept_no)
);


-- Add a foreign key to the student table
ALTER TABLE student
ADD FOREIGN KEY (dept_no) REFERENCES department (dept_no);


-- Insert data into the department table
INSERT INTO
  department (dept_no, name)
VALUES
  (10, 'Computer Science'),
  (20, "Electrical Engineering"),
  (30, 'Civil Engineering'),
  (40, "Mechanical Engineering");


-- Insert data into the student table
INSERT INTO
  student (name, city, dept_no)
VALUES
  ("Ajay", "Delihi", 10),
  ("Vijay", "Kolkata", 10),
  ("Ajay", "Mumbai", 20),
  ("Ramesh", "Delihi", 30),
  ("Suneeta", "Lucknow", 40),
  ("Anita", "Kolkata", 30),
  ("Raj", "Jaipur", 10),
  ("Ali", "Lucknow", 10),
  ("Michael", "Cochin", 30),
  ("Pavan", "Vijaywada", 20),
  ("Suraj", "Hyderabad", 10),
  ("Altaf", "Bangaluru", 40),
  ("Ravi", "Indore", 20),
  ("Verma", "Delihi", 40),
  ("Sherma", "Vizag", 10);
