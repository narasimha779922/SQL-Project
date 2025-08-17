CREATE DATABASE college_db;
USE college_db;

CREATE TABLE Departments (
    dept_id INT PRIMARY KEY AUTO_INCREMENT,
    dept_name VARCHAR(100)
);

CREATE TABLE Students (
    student_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    gender CHAR(1),
    dob DATE,
    dept_id INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100),
    dept_id INT,
    credits INT,
    FOREIGN KEY (dept_id) REFERENCES Departments(dept_id)
);

CREATE TABLE Enrollments (
    enroll_id INT PRIMARY KEY AUTO_INCREMENT,
    student_id INT,
    course_id INT,
    semester VARCHAR(10),
    marks INT,
    FOREIGN KEY (student_id) REFERENCES Students(student_id),
    FOREIGN KEY (course_id) REFERENCES Courses(course_id)
);

INSERT INTO Departments (dept_name) VALUES
('Computer Science'),
('Mechanical Engineering'),
('Electrical Engineering');


INSERT INTO Students (first_name, last_name, gender, dob, dept_id) VALUES
('Amit', 'Kumar', 'M', '2001-05-10', 1),
('Priya', 'Sharma', 'F', '2000-08-15', 1),
('Rahul', 'Verma', 'M', '2002-01-20', 2),
('Neha', 'Singh', 'F', '2001-03-12', 3),
('Vikas', 'Patel', 'M', '2000-12-25', 1);


INSERT INTO Courses (course_name, dept_id, credits) VALUES
('Database Systems', 1, 4),
('Operating Systems', 1, 4),
('Thermodynamics', 2, 3),
('Circuit Theory', 3, 3);


INSERT INTO Enrollments (student_id, course_id, semester, marks) VALUES
(1, 1, 'Sem1', 85),
(1, 2, 'Sem1', 78),
(2, 1, 'Sem1', 92),
(3, 3, 'Sem1', 65),
(4, 4, 'Sem1', 88),
(5, 1, 'Sem1', 75);

//	Quries//

SELECT * FROM Students;

SELECT * FROM Courses;

SELECT * FROM Enrollments;

SELECT student_id, marks
FROM Enrollments
WHERE course_id = 1
AND marks > (
    SELECT AVG(marks)
    FROM Enrollments
    WHERE course_id = 1
);

SELECT student_id, marks
FROM Enrollments
WHERE course_id = 2
AND marks = (
    SELECT MAX(marks)
    FROM Enrollments
    WHERE course_id = 2
);

SELECT student_id, marks
FROM Enrollments
WHERE marks IN (
    SELECT marks
    FROM Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    WHERE s.first_name = 'Priya' AND s.last_name = 'Sharma'
);

SELECT DISTINCT student_id
FROM Enrollments
WHERE course_id IN (
    SELECT course_id
    FROM Enrollments e
    JOIN Students s ON e.student_id = s.student_id
    WHERE s.first_name = 'Amit' AND s.last_name = 'Kumar'
);

SELECT e.student_id, e.course_id, e.marks
FROM Enrollments e
WHERE e.marks > (
    SELECT AVG(marks)
    FROM Enrollments
    WHERE course_id = e.course_id
);

SELECT d.dept_name, AVG(e.marks) AS avg_marks
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Departments d ON s.dept_id = d.dept_id
GROUP BY d.dept_name;

SELECT s.first_name, s.last_name, SUM(e.marks) AS total_marks
FROM Students s
JOIN Enrollments e ON s.student_id = e.student_id
GROUP BY s.student_id
ORDER BY total_marks DESC
LIMIT 3;

SELECT * FROM Students WHERE DOB > '2000-01-01'; 

SELECT * FROM Students WHERE Gender = 'M';

SELECT * FROM Students WHERE DepartmentID = 101;


