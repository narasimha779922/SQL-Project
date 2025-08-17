college admissions project

CREATE DATABASE CollegeAdmissions;
USE CollegeAdmissions;

CREATE TABLE Students (
    StudentID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Gender CHAR(1),
    DOB DATE,
    State VARCHAR(50),
    Category VARCHAR(20), 
    EntranceScore INT );
    
    CREATE TABLE Departments (
    DepartmentID INT PRIMARY KEY,
    DepartmentName VARCHAR(100),
    IntakeCapacity INT
);

CREATE TABLE Admissions (
    AdmissionID INT PRIMARY KEY,
    StudentID INT,
    DepartmentID INT,
    AdmissionDate DATE,
    Status VARCHAR(20)
);

INSERT INTO Students VALUES
(1, 'Amit', 'Sharma', 'M', '2002-05-14', 'Delhi', 'GEN', 185),
(2, 'Priya', 'Verma', 'F', '2003-03-21', 'Uttar Pradesh', 'OBC', 172),
(3, 'Rohit', 'Patel', 'M', '2001-11-09', 'Gujarat', 'GEN', 190),
(4, 'Neha', 'Reddy', 'F', '2002-12-17', 'Telangana', 'SC', 165),
(5, 'Vikram', 'Singh', 'M', '2001-07-02', 'Punjab', 'OBC', 178),
(6, 'Anjali', 'Nair', 'F', '2003-01-28', 'Kerala', 'GEN', 188),
(7, 'Suresh', 'Iyer', 'M', '2001-04-19', 'Maharashtra', 'GEN', 182),
(8, 'Kavita', 'Joshi', 'F', '2003-06-30', 'Rajasthan', 'OBC', 175),
(9, 'Manoj', 'Yadav', 'M', '2002-08-25', 'Haryana', 'OBC', 170),
(10, 'Deepa', 'Menon', 'F', '2003-02-11', 'Kerala', 'SC', 160),
(11, 'Arjun', 'Kumar', 'M', '2001-09-15', 'Tamil Nadu', 'GEN', 192),
(12, 'Pooja', 'Chopra', 'F', '2002-10-05', 'Delhi', 'GEN', 185),
(13, 'Rahul', 'Gupta', 'M', '2003-04-22', 'Uttar Pradesh', 'OBC', 168),
(14, 'Sneha', 'Pillai', 'F', '2001-08-08', 'Kerala', 'GEN', 186),
(15, 'Karan', 'Bansal', 'M', '2002-03-03', 'Punjab', 'OBC', 174),
(16, 'Meera', 'Shah', 'F', '2003-09-27', 'Gujarat', 'GEN', 180),
(17, 'Ajay', 'Dubey', 'M', '2001-05-11', 'Madhya Pradesh', 'GEN', 189),
(18, 'Shreya', 'Deshmukh', 'F', '2003-12-13', 'Maharashtra', 'OBC', 177),
(19, 'Sunil', 'Raj', 'M', '2002-06-18', 'Tamil Nadu', 'SC', 164),
(20, 'Lavanya', 'Mishra', 'F', '2003-07-15', 'Uttar Pradesh', 'GEN', 183),
(21, 'Narasimha', 'siva', 'M', '2004-08-21', 'Andhra pradesh', 'oc', 168),
(22, 'Vamsi', 'Vijay', 'M', '2004-07-09', 'Andhra pradesh', 'oc', 169),
(23, 'venkat', 'narasimha', 'M', '2004-09-21', 'Andhra pradesh', 'oc', 169);

INSERT INTO Departments VALUES
(101, 'Computer Science', 5),
(102, 'Mechanical Engineering', 5),
(103, 'Electrical Engineering', 5),
(104, 'Civil Engineering', 5);

INSERT INTO Admissions VALUES
(1, 1, 101, '2021-08-01', 'Admitted'),
(2, 2, 103, '2021-08-02', 'Admitted'),
(3, 3, 101, '2021-08-01', 'Admitted'),
(4, 4, 104, '2021-08-03', 'Waiting'),
(5, 5, 102, '2021-08-04', 'Admitted'),
(6, 6, 101, '2021-08-01', 'Admitted'),
(7, 7, 103, '2021-08-02', 'Admitted'),
(8, 8, 104, '2021-08-03', 'Waiting'),
(9, 9, 102, '2021-08-04', 'Rejected'),
(10, 10, 103, '2021-08-02', 'Rejected'),
(11, 11, 101, '2021-08-01', 'Admitted'),
(12, 12, 104, '2021-08-03', 'Admitted'),
(13, 13, 102, '2021-08-04', 'Waiting'),
(14, 14, 103, '2021-08-02', 'Admitted'),
(15, 15, 101, '2021-08-01', 'Admitted'),
(16, 16, 102, '2021-08-04', 'Admitted'),
(17, 17, 104, '2021-08-03', 'Admitted'),
(18, 18, 103, '2021-08-02', 'Waiting'),
(19, 19, 101, '2021-08-01', 'Rejected'),
(20, 20, 102, '2021-08-04', 'Admitted');

//queries//
// Show all student details//
SELECT * FROM Students;

//Display only first name, last name, and state of all students//
SELECT FirstName, LastName, State FROM Students;

 //Find students from 'Kerala'//
SELECT * FROM Students WHERE State = 'Kerala';

 //Find students from 'andhra pradesh'//
SELECT * FROM Students WHERE State = 'Andhra Pradesh';

// List all female students//
SELECT * FROM Students WHERE Gender = 'F';

//Find students with Entrance Score above 180//
SELECT * FROM Students WHERE EntranceScore > 180;

// Count the number of students from each state//
SELECT State, COUNT(*) AS TotalStudents
FROM Students
GROUP BY State;

 //Find the highest entrance score among all students//
 SELECT MAX(EntranceScore) AS HighestScore FROM Students;
 
// List students admitted to Computer Science //
SELECT S.*
FROM Students S
JOIN Admissions A ON S.StudentID = A.StudentID
JOIN Departments D ON A.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Computer Science'
AND A.Status = 'Admitted';

//Find students whose score is above the average score//
SELECT * FROM Students
WHERE EntranceScore > (SELECT AVG(EntranceScore) FROM Students);

//List departments having more than 5 admissions//
SELECT DepartmentID, COUNT(*) AS TotalAdmissions
FROM Admissions
WHERE Status = 'Admitted'
GROUP BY DepartmentID
HAVING COUNT(*) > 5;

//Show each student’s name and their admission status//
SELECT S.FirstName, S.LastName, A.Status
FROM Students S
LEFT JOIN Admissions A ON S.StudentID = A.StudentID;

//Find the number of students admitted per department//
SELECT D.DepartmentName, COUNT(*) AS AdmittedCount
FROM Departments D
JOIN Admissions A ON D.DepartmentID = A.DepartmentID
WHERE A.Status = 'Admitted'
GROUP BY D.DepartmentName;

 //List all students who were rejected//
SELECT S.FirstName, S.LastName
FROM Students S
JOIN Admissions A ON S.StudentID = A.StudentID
WHERE A.Status = 'Rejected';

//Find students who scored the same as 'Amit Sharma'//
SELECT * FROM Students
WHERE EntranceScore = (
    SELECT EntranceScore FROM Students
    WHERE FirstName = 'Amit' AND LastName = 'Sharma');
    
    //Find students in the same state as 'Priya Verma'//
    SELECT * FROM Students
WHERE State = (
    SELECT State FROM Students
    WHERE FirstName = 'Priya' AND LastName = 'Verma');
    
//Find students whose score is higher than all students from 'Delhi'//
SELECT * FROM Students
WHERE EntranceScore > ALL (
    SELECT EntranceScore FROM Students WHERE State = 'Delhi');
    
    //Find top scorer from each state//
SELECT S1.*
FROM Students S1
WHERE EntranceScore = (
    SELECT MAX(S2.EntranceScore) FROM Students S2
    WHERE S2.State = S1.State);
    
    //Find students who got admission into their top-choice department (assume highest score → best choice)//
SELECT S.StudentID, S.FirstName, S.LastName, A.DepartmentID
FROM Students S
JOIN Admissions A ON S.StudentID = A.StudentID
WHERE A.Status = 'Admitted'
AND EntranceScore = (
    SELECT MAX(EntranceScore)
    FROM Students
    JOIN Admissions ON Students.StudentID = Admissions.StudentID
    WHERE Admissions.DepartmentID = A.DepartmentID);
    
//find departments with above-average admitted scores//
SELECT DepartmentID, AVG(EntranceScore) AS AvgScore
FROM Students S
JOIN Admissions A ON S.StudentID = A.StudentID
WHERE A.Status = 'Admitted'
GROUP BY DepartmentID
HAVING AVG(EntranceScore) > (
    SELECT AVG(EntranceScore) FROM Students
    JOIN Admissions ON Students.StudentID = Admissions.StudentID
    WHERE Admissions.Status = 'Admitted');
    
//Find students with more than average score in their state//
SELECT S1.*
FROM Students S1
WHERE EntranceScore > (
    SELECT AVG(S2.EntranceScore)
    FROM Students S2
    WHERE S2.State = S1.State);
    
//Find department with the highest average score//
SELECT DepartmentID
FROM Students S
JOIN Admissions A ON S.StudentID = A.StudentID
WHERE A.Status = 'Admitted'
GROUP BY DepartmentID
ORDER BY AVG(EntranceScore) DESC
LIMIT 1;
