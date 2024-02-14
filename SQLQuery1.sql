-- Create a new database
CREATE DATABASE School;

-- Use the School database
USE School;

-- Create a Students table
CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Age INT,
    GPA FLOAT
);

-- Insert dummy data into the Students table
INSERT INTO Students (StudentID, FirstName, LastName, Age, GPA) 
VALUES 
    (1, 'John', 'Doe', 20, 3.5),
    (2, 'Jane', 'Smith', 22, 3.8),
    (3, 'Alice', 'Johnson', 21, 3.9);

-- Select all records from the Students table
SELECT * FROM Students;

--update GPA
UPDATE Students
SET GPA = 4.0
WHERE StudentID = 2

-- select all records
SELECT * FROM Students;

--DELETE
DELETE FROM Students
WHERE StudentID = 3;

-- select all records
SELECT * FROM Students;

-- Select students with a GPA greater than 3.5
SELECT * FROM Students
WHERE GPA > 3.5;

-- Select students ordered by GPA in descending order
SELECT * FROM Students
ORDER BY GPA DESC;

-- Create a new table with constraints
CREATE TABLE Employees (
    EmployeeID INT PRIMARY KEY,
    FisrtName VARCHAR(50) NOT NULL,
    LastName VARCHAR(50) NOT NULL,
    Depatment VARCHAR(50),
    Salary DECIMAL(10, 2) CHECK (Salary >= 0)
);


INSERT INTO Employees(EmployeeID, FisrtName, lastName,Depatment, Salary)
VALUES
	(1, 'Brian', 'Mwangi', 'English', 50000.00),
	(2, 'Vee', 'Gladys', 'Math', 61000.00),
	(3, 'Faith', 'Samoei', 'Business', 70000.00);

SELECT * FROM Employees;

-- Grouping and Aggregating Data with GROUP BY
SELECT Depatment, AVG(Salary) AS AvgSalary
FROM Employees
GROUP BY Depatment;

-- Filtering Groups with HAVING Clause
SELECT Depatment, COUNT(*) AS NumEmployees
FROM Employees
GROUP BY Depatment
HAVING COUNT(*) > 5;


-- Advanced Filtering with WHERE Clause and Subqueries
SELECT * FROM Students
WHERE Age > (SELECT AVG(Age) FROM Students);

-- Using CASE Statement for Conditional Logic
SELECT FirstName, LastName,
    CASE
        WHEN GPA >= 3.5 THEN 'Excellent'
        WHEN GPA >= 3.0 THEN 'Good'
        ELSE 'Needs Improvement'
    END AS Performance
FROM Students;


CREATE TABLE Orders (
	OrderID INT PRIMARY KEY,
	OrderDate DATE,
	EmployeeID INT,

	FOREIGN KEY (EmployeeID)   REFERENCES Employees(EmployeeID)
);

CREATE TABLE Customers (
	CustomerID INT PRIMARY KEY,
	CustomerName VARCHAR(100),
);

INSERT INTO Orders(OrderID, EmployeeID, OrderDate)
VALUES
	(1, 1, '2024-01-10'),
	(2, 2, '2024-01-15'),
	(3, 3, '2024-01-20');


-- Performing INNER JOIN
SELECT Orders.OrderID, Customers.CustomerName
FROM Orders
INNER JOIN Customers ON Orders.EmployeeID = Customers.CustomerID;

-- Using Correlated Subquery
SELECT EmployeeID, FisrtName, LastName
FROM Employees e
WHERE NOT EXISTS (
    SELECT 1
    FROM Orders o
    WHERE o.EmployeeID = e.EmployeeID
);


SELECT Orders.EmployeeID , Employees.EmployeeID
FROM Orders
CROSS JOIN Employees


-- Create a new table 'Courses'
CREATE TABLE Courses (
    CourseID INT PRIMARY KEY,
    CourseName VARCHAR(100),
    Instructor VARCHAR(100)
);

-- Insert dummy data into the 'Courses' table
INSERT INTO Courses (CourseID, CourseName, Instructor)
VALUES 
    (1, 'Mathematics', 'Mr. Smith'),
    (2, 'Physics', 'Dr. Johnson'),
    (3, 'History', 'Ms. Williams');

-- Perform a CROSS JOIN to retrieve all combinations of students and courses
SELECT Students.FirstName, Students.LastName, Courses.CourseName
FROM Students
CROSS JOIN Courses;


