-- creating the database
Create Database EMS;

-- Select this Ems database to create tables
use EMS ;

--CREATING TABLES--

--Creating Department Table--

CREATE TABLE Department(
    DepartmentID INT PRIMARY KEY,          
    DepartmentName VARCHAR(100) NOT NULL
);

--Creating Job Title Table--
CREATE TABLE JobTitle(
     JobTitleID INT PRIMARY KEY,
	 JobTitleName VARCHAR(100) NOT NULL UNIQUE
);

-- Creating Employee Table (self referencing foreign key)--
CREATE TABLE Employee(
    EmployeeID INT PRIMARY KEY,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    DateOfBirth DATE,
    Gender VARCHAR(10),
    PhoneNumber VARCHAR(15) UNIQUE,
    Email VARCHAR(100) UNIQUE,
    HireDate DATE NOT NULL,
    DepartmentID int FOREIGN KEY (DepartmentID) REFERENCES Department (DepartmentID),
    JobTitleID int FOREIGN KEY (JobTitleID) REFERENCES JobTitle (JobTitleID),
    ManagerID int FOREIGN KEY (ManagerID) REFERENCES Employee (EmployeeID)
    
);

-- Creating Attendance Table --
CREATE TABLE Attendance(
    AttendanceID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    Date DATE NOT NULL,
    Status VARCHAR(10) CHECK (Status in ('Present', 'Absent', 'Leave')),
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

-- Creating Salary Table --
CREATE TABLE Salary(
    SalaryID INT PRIMARY KEY,
    EmployeeID INT NOT NULL,
    BaseSalary DECIMAL(10, 2) NOT NULL,
    Bonus DECIMAL(10, 2) DEFAULT 0.00,
    Deductions DECIMAL(10, 2) DEFAULT 0.00,
    PaymentDate DATE NOT NULL,
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID)
);

-- Creating Project Table--
CREATE TABLE Project(
    ProjectID INT PRIMARY KEY,
    ProjectName VARCHAR(100) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    ProjectManagerID INT,
    FOREIGN KEY (ProjectManagerID) REFERENCES Employee (EmployeeID)
);

-- Creating Project Allocation Table--
CREATE TABLE ProjectAllocation (
    AllocationID INT PRIMARY KEY,
    EmployeeID  INT,
    ProjectID INT,
    AllocationDate Date,
    FOREIGN KEY (EmployeeID) REFERENCES Employee (EmployeeID),
    FOREIGN KEY (ProjectID) REFERENCES Project (ProjectID),
    CONSTRAINT UC_Employee_Project UNIQUE(EmployeeID, ProjectID)
);

---- INSERT DATA INTO THE TABLE ----

-- Insert Data into Department Table --
INSERT INTO Department (DepartmentID, DepartmentName)
VALUES
(1, 'Human Resources'),
(2, 'Engineering'),
(3, 'Sales'),
(4, 'Marketing'),
(5, 'Finance');
 
 select * from department

-- Insert Data into Job Title Table
INSERT INTO JobTitle (JobTitleID, JobTitleName)
VALUES
(1, 'HR Manager'),
(2, 'Software Engineer'),
(3, 'Sales Executive'),
(4, 'Marketing Manager'),
(5, 'Finance Analyst'),
(6, 'Project Manager'),
(7, 'Software Developer'),
(8, 'Accountant'),
(9, 'Data Scientist'),
(10, 'Marketing Executive');

select * from JobTitle

-- Insert Data into Employee Table (New Schema)
INSERT INTO Employee (EmployeeID, FirstName, LastName, DateOfBirth, Gender, PhoneNumber, Email, HireDate, DepartmentID, JobTitleID, ManagerID)
VALUES
(1, 'John', 'Doe', '1980-01-15', 'M', '123-456-7890', 'john.doe@example.com', '2015-06-01', 1, 1, NULL),
(2, 'Jane', 'Smith', '1985-03-20', 'F', '234-567-8901', 'jane.smith@example.com', '2016-07-10', 2, 2, NULL),
(3, 'Michael', 'Johnson', '1978-11-30', 'M', '345-678-9012', 'michael.johnson@example.com', '2014-08-15', 3, 3, NULL),
(4, 'Emily', 'Davis', '1990-05-25', 'F', '456-789-0123', 'emily.davis@example.com', '2017-09-01', 4, 4, 1),
(5, 'David', 'Martinez', '1982-07-18', 'M', '567-890-1234', 'david.martinez@example.com', '2015-10-21', 5, 5, 2),
(6, 'Sarah', 'Miller', '1992-02-10', 'F', '678-901-2345', 'sarah.miller@example.com', '2018-01-15', 1, 2, 3),
(7, 'James', 'Wilson', '1988-09-05', 'M', '789-012-3456', 'james.wilson@example.com', '2016-03-12', 2, 3, 4),
(8, 'Olivia', 'Moore', '1991-10-25', 'F', '890-123-4567', 'olivia.moore@example.com', '2017-12-10', 3, 4, 5),
(9, 'William', 'Taylor', '1983-04-13', 'M', '901-234-5678', 'william.taylor@example.com', '2016-11-30', 4, 1, 3),
(10, 'Sophia', 'Anderson', '1993-06-27', 'F', '123-456-7891', 'sophia.anderson@example.com', '2018-02-22', 5, 5, 2),
(11, 'Benjamin', 'Thomas', '1981-12-09', 'M', '234-567-8902', 'benjamin.thomas@example.com', '2014-05-18', 1, 2, 3),
(12, 'Isabella', 'Jackson', '1987-03-15', 'F', '345-678-9013', 'isabella.jackson@example.com', '2017-06-05', 2, 3, 4),
(13, 'Lucas', 'White', '1984-08-28', 'M', '456-789-0124', 'lucas.white@example.com', '2015-07-09', 3, 4, 5),
(14, 'Mia', 'Harris', '1994-01-19', 'F', '567-890-1235', 'mia.harris@example.com', '2018-03-17', 4, 1, 1),
(15, 'Alexander', 'Clark', '1986-12-21', 'M', '678-901-2346', 'alexander.clark@example.com', '2016-04-25', 5, 5, 2),
(16, 'Ethan', 'Lewis', '1990-09-11', 'M', '789-012-3457', 'ethan.lewis@example.com', '2017-09-11', 1, 1, 3),
(17, 'Ava', 'Walker', '1988-02-03', 'F', '890-123-4568', 'ava.walker@example.com', '2016-10-07', 2, 2, 4),
(18, 'Charlotte', 'Hall', '1985-05-29', 'F', '901-234-5679', 'charlotte.hall@example.com', '2015-12-15', 3, 3, 5),
(19, 'Jackson', 'Allen', '1981-11-03', 'M', '123-456-7892', 'jackson.allen@example.com', '2014-06-21', 4, 4, 1),
(20, 'Amelia', 'Young', '1989-08-17', 'F', '234-567-8903', 'amelia.young@example.com', '2016-01-25', 5, 5, 2),
(21, 'Sebastian', 'King', '1984-02-20', 'M', '345-678-9014', 'sebastian.king@example.com', '2014-11-28', 1, 2, 3),
(22, 'Liam', 'Wright', '1987-07-08', 'M', '456-789-0125', 'liam.wright@example.com', '2016-09-19', 2, 3, 4),
(23, 'Aiden', 'Scott', '1983-12-22', 'M', '567-890-1236', 'aiden.scott@example.com', '2015-04-02', 3, 4, 5),
(24, 'Harper', 'Green', '1991-01-30', 'F', '678-901-2347', 'harper.green@example.com', '2017-05-12', 4, 1, 1),
(25, 'Jack', 'Adams', '1986-09-14', 'M', '789-012-3458', 'jack.adams@example.com', '2016-12-01', 5, 5, 2),
(26, 'Ella', 'Baker', '1989-03-11', 'F', '890-123-4569', 'ella.baker@example.com', '2015-07-23', 1, 2, 3),
(27, 'Henry', 'Gonzalez', '1993-10-07', 'M', '901-234-5680', 'henry.gonzalez@example.com', '2018-01-03', 2, 3, 4),
(28, 'Lily', 'Nelson', '1992-06-05', 'F', '123-456-7893', 'lily.nelson@example.com', '2018-03-01', 3, 4, 5),
(29, 'Matthew', 'Carter', '1985-11-18', 'M', '234-567-8904', 'matthew.carter@example.com', '2016-02-14', 4, 1, 3),
(30, 'Scarlett', 'Mitchell', '1988-07-26', 'F', '345-678-9015', 'scarlett.mitchell@example.com', '2017-06-23', 5, 5, 2),
(31, 'Charlotte', 'Perez', '1981-12-15', 'F', '456-789-0126', 'charlotte.perez@example.com', '2014-08-19', 1, 2, 3),
(32, 'James', 'Roberts', '1984-04-21', 'M', '567-890-1237', 'james.roberts@example.com', '2015-09-09', 2, 3, 4),
(33, 'Oliver', 'Murphy', '1990-12-01', 'M', '678-901-2348', 'oliver.murphy@example.com', '2016-04-18', 3, 4, 5),
(34, 'Avery', 'Evans', '1992-09-13', 'F', '789-012-3459', 'avery.evans@example.com', '2017-10-02', 4, 1, 1),
(35, 'Mason', 'Walker', '1989-05-08', 'M', '890-123-4570', 'mason.walker@example.com', '2015-03-20', 5, 5, 2),
(36, 'Sophia', 'Wood', '1991-11-09', 'F', '901-234-5681', 'sophia.wood@example.com', '2016-08-17', 1, 2, 3),
(37, 'Jacob', 'Green', '1987-06-03', 'M', '123-456-7894', 'jacob.green@example.com', '2016-12-07', 2, 3, 4),
(38, 'Samuel', 'Baker', '1994-08-19', 'M', '234-567-8905', 'samuel.baker@example.com', '2017-01-15', 3, 4, 5),
(39, 'Zoe', 'Lopez', '1983-03-27', 'F', '345-678-9016', 'zoe.lopez@example.com', '2015-10-31', 4, 1, 1),
(40, 'Gabriel', 'Hill', '1986-07-12', 'M', '456-789-0127', 'gabriel.hill@example.com', '2016-05-20', 5, 5, 2),
(41, 'Elijah', 'Graham', '1992-04-15', 'M', '567-890-1238', 'elijah.graham@example.com', '2018-02-03', 1, 2, 3),
(42, 'Lucy', 'Rivera', '1989-09-09', 'F', '678-901-2349', 'lucy.rivera@example.com', '2016-09-29', 2, 3, 4),
(43, 'Isaac', 'Cooper', '1990-01-25', 'M', '789-012-3460', 'isaac.cooper@example.com', '2017-03-15', 3, 4, 5),
(44, 'Chloe', 'James', '1993-11-18', 'F', '890-123-4571', 'chloe.james@example.com', '2018-05-10', 4, 1, 1),
(45, 'Liam', 'Lee', '1987-02-27', 'M', '901-234-5682', 'liam.lee@example.com', '2016-07-25', 5, 5, 2),
(46, 'Benjamin', 'Lopez', '1985-10-12', 'M', '123-456-7895', 'benjamin.lopez@example.com', '2015-02-28', 1, 2, 3),
(47, 'Aiden', 'Harris', '1990-07-23', 'M', '234-567-8906', 'aiden.harris@example.com', '2016-11-12', 2, 3, 4),
(48, 'Layla', 'Thompson', '1991-05-05', 'F', '345-678-9017', 'layla.thompson@example.com', '2017-07-08', 3, 4, 5),
(49, 'Jackson', 'Johnson', '1988-08-13', 'M', '456-789-0128', 'jackson.johnson@example.com', '2015-04-25', 4, 1, 1),
(50, 'Grace', 'White', '1982-09-22', 'F', '567-890-1239', 'grace.white@example.com', '2015-01-13', 5, 5, 2);

select * from employee
-- Insert Data into Attendance Table
INSERT INTO Attendance (AttendanceID, EmployeeID, [Date], [Status])
VALUES
(1, 1, '2024-10-01', 'Present'),
(2, 2, '2024-10-01', 'Absent'),
(3, 3, '2024-10-01', 'Leave'),
(4, 4, '2024-10-01', 'Present'),
(5, 5, '2024-10-01', 'Absent'),
(6, 6, '2024-10-01', 'Present'),
(7, 7, '2024-10-01', 'Leave'),
(8, 8, '2024-10-01', 'Present'),
(9, 9, '2024-10-01', 'Absent'),
(10, 10, '2024-10-01', 'Present'),
(11, 11, '2024-10-01', 'Present'),
(12, 12, '2024-10-01', 'Absent'),
(13, 13, '2024-10-01', 'Leave'),
(14, 14, '2024-10-01', 'Present'),
(15, 15, '2024-10-01', 'Absent'),
(16, 16, '2024-10-01', 'Leave'),
(17, 17, '2024-10-01', 'Present'),
(18, 18, '2024-10-01', 'Absent'),
(19, 19, '2024-10-01', 'Present'),
(20, 20, '2024-10-01', 'Present'),
(21, 21, '2024-10-01', 'Absent'),
(22, 22, '2024-10-01', 'Leave'),
(23, 23, '2024-10-01', 'Present'),
(24, 24, '2024-10-01', 'Absent'),
(25, 25, '2024-10-01', 'Present'),
(26, 26, '2024-10-01', 'Leave'),
(27, 27, '2024-10-01', 'Present'),
(28, 28, '2024-10-01', 'Absent'),
(29, 29, '2024-10-01', 'Leave'),
(30, 30, '2024-10-01', 'Present'),
(31, 31, '2024-10-01', 'Absent'),
(32, 32, '2024-10-01', 'Present'),
(33, 33, '2024-10-01', 'Leave'),
(34, 34, '2024-10-01', 'Present'),
(35, 35, '2024-10-01', 'Absent'),
(36, 36, '2024-10-01', 'Leave'),
(37, 37, '2024-10-01', 'Present'),
(38, 38, '2024-10-01', 'Absent'),
(39, 39, '2024-10-01', 'Present'),
(40, 40, '2024-10-01', 'Leave'),
(41, 41, '2024-10-01', 'Present'),
(42, 42, '2024-10-01', 'Absent'),
(43, 43, '2024-10-01', 'Present'),
(44, 44, '2024-10-01', 'Leave'),
(45, 45, '2024-10-01', 'Absent'),
(46, 46, '2024-10-01', 'Present'),
(47, 47, '2024-10-01', 'Leave'),
(48, 48, '2024-10-01', 'Present'),
(49, 49, '2024-10-01', 'Absent'),
(50, 50, '2024-10-01', 'Present');

select * from Attendance

-- Insert Data into Salary Table
INSERT INTO Salary (SalaryID, EmployeeID, BaseSalary, Bonus, Deductions, PaymentDate)
VALUES
(1, 1, 60000, 5000, 1000, '2024-10-30'),
(2, 2, 70000, 6000, 1200, '2024-10-30'),
(3, 3, 65000, 5500, 1100, '2024-10-30'),
(4, 4, 75000, 6500, 1300, '2024-10-30'),
(5, 5, 68000, 6200, 1250, '2024-10-30'),
(6, 6, 72000, 6300, 1400, '2024-10-30'),
(7, 7, 66000, 5400, 1150, '2024-10-30'),
(8, 8, 71000, 5900, 1300, '2024-10-30'),
(9, 9, 67000, 6100, 1200, '2024-10-30'),
(10, 10, 69000, 6000, 1300, '2024-10-30'),
(11, 11, 72000, 5500, 1250, '2024-10-30'),
(12, 12, 70000, 5800, 1200, '2024-10-30'),
(13, 13, 74000, 6100, 1350, '2024-10-30'),
(14, 14, 69000, 5900, 1250, '2024-10-30'),
(15, 15, 67000, 5500, 1100, '2024-10-30'),
(16, 16, 72000, 5400, 1200, '2024-10-30'),
(17, 17, 70000, 5900, 1300, '2024-10-30'),
(18, 18, 68000, 5700, 1250, '2024-10-30'),
(19, 19, 71000, 6200, 1200, '2024-10-30'),
(20, 20, 69000, 5400, 1350, '2024-10-30'),
(21, 21, 73000, 5600, 1200, '2024-10-30'),
(22, 22, 68000, 5800, 1250, '2024-10-30'),
(23, 23, 71000, 6000, 1300, '2024-10-30'),
(24, 24, 65000, 5400, 1150, '2024-10-30'),
(25, 25, 68000, 5900, 1200, '2024-10-30'),
(26, 26, 70000, 6200, 1250, '2024-10-30'),
(27, 27, 71000, 6300, 1350, '2024-10-30'),
(28, 28, 68000, 5900, 1200, '2024-10-30'),
(29, 29, 72000, 6000, 1250, '2024-10-30'),
(30, 30, 75000, 6500, 1300, '2024-10-30'),
(31, 31, 70000, 5800, 1200, '2024-10-30'),
(32, 32, 69000, 6100, 1250, '2024-10-30'),
(33, 33, 67000, 5600, 1150, '2024-10-30'),
(34, 34, 72000, 5900, 1300, '2024-10-30'),
(35, 35, 74000, 6100, 1350, '2024-10-30'),
(36, 36, 68000, 5400, 1200, '2024-10-30'),
(37, 37, 69000, 5800, 1250, '2024-10-30'),
(38, 38, 71000, 5900, 1300, '2024-10-30'),
(39, 39, 75000, 6000, 1350, '2024-10-30'),
(40, 40, 67000, 5500, 1100, '2024-10-30'),
(41, 41, 72000, 5900, 1250, '2024-10-30'),
(42, 42, 74000, 6200, 1300, '2024-10-30'),
(43, 43, 71000, 5800, 1250, '2024-10-30'),
(44, 44, 68000, 5400, 1200, '2024-10-30'),
(45, 45, 69000, 6000, 1250, '2024-10-30'),
(46, 46, 73000, 5500, 1300, '2024-10-30'),
(47, 47, 71000, 5900, 1200, '2024-10-30'),
(48, 48, 75000, 6500, 1350, '2024-10-30'),
(49, 49, 68000, 5700, 1250, '2024-10-30'),
(50, 50, 70000, 6000, 1300, '2024-10-30');

select * from Salary
-- Insert Data into Project Table
INSERT INTO Project (ProjectID, ProjectName, StartDate,EndDate, ProjectManagerID)
VALUES
(1, 'Project Alpha', '2024-01-01', '2024-12-31', 1),
(2, 'Project Beta', '2024-02-01', '2024-12-31', 2),
(3, 'Project Gamma', '2024-03-01', '2024-12-31', 3),
(4, 'Project Delta', '2024-04-01', '2024-12-31', 4),
(5, 'Project Epsilon', '2024-05-01', '2024-12-31', 5);

select * from Project
-- Insert Data into Project Allocation Table
INSERT INTO ProjectAllocation (AllocationID, EmployeeID, ProjectID, AllocationDate)
VALUES
(1, 1, 1, '2024-01-01'),
(2, 2, 1, '2024-01-02'),
(3, 3, 1, '2024-01-03'),
(4, 4, 2, '2024-02-01'),
(5, 5, 2, '2024-02-05'),
(6, 6, 2, '2024-02-10'),
(7, 7, 3, '2024-03-01'),
(8, 8, 3, '2024-03-02'),
(9, 9, 3, '2024-03-05'),
(10, 10, 4, '2024-04-01'),
(11, 11, 4, '2024-04-05'),
(12, 12, 4, '2024-04-10'),
(13, 13, 5, '2024-05-01'),
(14, 14, 5, '2024-05-03'),
(15, 15, 5, '2024-05-07'),
(16, 16, 1, '2024-06-01'),
(17, 17, 1, '2024-06-02'),
(18, 18, 2, '2024-07-01'),
(19, 19, 2, '2024-07-02'),
(20, 20, 3, '2024-08-01'),
(21, 21, 3, '2024-08-02'),
(22, 22, 4, '2024-09-01'),
(23, 23, 4, '2024-09-05'),
(24, 24, 5, '2024-10-01'),
(25, 25, 5, '2024-10-02'),
(26, 26, 1, '2024-11-01'),
(27, 27, 2, '2024-11-03'),
(28, 28, 3, '2024-12-01'),
(29, 29, 4, '2024-12-05'),
(30, 30, 5, '2024-12-10');

select * from ProjectAllocation


-- 1. Question: Retrieve the first and last names of all employees.
SELECT FirstName, LastName FROM Employee ;

-- 2. Retrieve the first and last names of employees who work as 'Software Engineer'.
SELECT FirstName, LastName 
FROM Employee 
WHERE JobTitleID = (SELECT JobTitleID FROM JobTitle  WHERE JobTitleName = 'Software Engineer');


-- 3. Question: Retrieve first names and last names of last 7 hires
SELECT Top 7 FirstName, LastName  from employee
order by HireDate Desc;

-- 4. Question: Get the count of employees in each job title.

SELECT JobTitleName, COUNT(EmployeeID) employee_count
FROM Employee E
INNER JOIN JobTitle J 
ON E.JobTitleID = J.JobTitleID 
GROUP BY J.JobTitleName;

-- 5. Question: Retrieve the full name & other personal info of employees who work in the 'Engineering' department.
--1.Easy Way 
SELECT FirstName,LastName, DateOfBirth, Gender, PhoneNumber  FROM Employee 
WHERE DepartmentID = (SELECT DepartmentID FROM Department  WHERE DepartmentName = 'Engineering');
--2.Best Way
SELECT CONCAT(FirstName,' ',LastName) as FullName, 
        DateOfBirth, Gender, PhoneNumber
FROM Employee E 
INNER JOIN Department D 
ON E.DepartmentID = D.DepartmentID
WHERE D.DepartmentName = 'Engineering' ;

-- 6. Question: List job titles that have more than 3 employees.
SELECT JobTitleName, COUNT(EmployeeID) employee_count
FROM Employee E
INNER JOIN JobTitle J 
ON E.JobTitleID = J.JobTitleID 
GROUP BY J.JobTitleName
HAVING COUNT(EmployeeID) > 3;


-- 7. Question: Retrieve all employee names along with their department names. 

SELECT FirstName, LastName, DepartmentName
FROM Employee E 
INNER JOIN Department D 
ON E.DepartmentID = D.DepartmentID;

-- 8. Question: Retrieve the first names of employees and the projects they are working on, along with their role in the project.

Select FirstName, ProjectName, JobtitleName as 'Role' from Employee E inner join ProjectAllocation PA 
ON E.EmployeeID = PA.EmployeeID Inner Join Project P  ON 
P.ProjectID = PA.projectid 
Inner Join 
Jobtitle J ON E.JobtitleID = J.jobtitleID ;


-- 9. Question: Get the count of employees in each department

Select DepartmentName , count(EmployeeID) as  ' Employee_count '
from Employee E inner join Department D ON E.DepartmentID = D.DepartmentID 
group by DepartmentName ;


-- 10. Question: List all departments with more than 5 employees.

Select DepartmentName , count(EmployeeID) as  ' Employee_count '
from Employee E inner join Department D ON E.DepartmentID = D.DepartmentID 
group by DepartmentName  having count(EmployeeID) >5 ;

-- 11. Question: Retrieve the full names of employees and their managers.

SELECT CONCAT(E.FirstName, ' ', E.LastName) as 'Employee Name',
        CONCAT(M.FirstName, ' ', M.LastName) as 'Manager Name'
FROM Employee E 
INNER JOIN EMPLOYEE M
ON E.ManagerID = M.EmployeeID;


-- 12. Question: Which manager is managing more employees and how many
SELECT Top 1 CONCAT(M.FirstName, ' ', M.LastName) as 'Manager Name',
COUNT(E.EmployeeID) AS NumberOfEmployees
FROM Employee E 
INNER JOIN EMPLOYEE M
ON E.ManagerID = M.EmployeeID
GROUP BY M.EmployeeID, M.FirstName, M.LastName
ORDER BY 2 DESC;

-- 13. Show all Managers who are managing how many employees individually 
SELECT CONCAT(M.FirstName, ' ', M.LastName) as 'Manager Name',
COUNT(E.EmployeeID) AS NumberOfEmployees
FROM Employee E 
INNER JOIN EMPLOYEE M
ON E.ManagerID = M.EmployeeID
GROUP BY M.EmployeeID, M.FirstName, M.LastName
ORDER BY 2 DESC;

-- 14. Question: Retrieve names of employees working on projects as 'Software Engineer', ordered by project start date


SELECT FirstName, LastName, ProjectName, StartDate
FROM Employee E 
INNER JOIN ProjectAllocation PA 
ON E.EmployeeID = PA.EmployeeID 
INNER JOIN Project P 
ON PA.ProjectID = P.ProjectID
INNER JOIN JobTitle J 
ON J.JobTitleID = E.JobTitleID 
WHERE JobTitleName = 'Software Engineer' 
ORDER BY 4;

-- 15. Question: Retrieve the names of employees who are working on 'Project Delta'.

SELECT FirstName, LastName FROM Employee
WHERE EmployeeID IN (SELECT EmployeeID FROM ProjectAllocation
                    WHERE ProjectID = (SELECT ProjectID FROM PROJECT 
                                        WHERE ProjectName = 'Project Delta')) ;

-- 16. Question: Retrieve the names of employees, department name, and total salary, ordered by total salary in descending order

SELECT FirstName, LastName, DepartmentName,
 (BaseSalary + Bonus - Deductions) AS TotalSalary
FROM Employee E 
INNER JOIN Department D 
ON E.DepartmentID = D.DepartmentID
INNER JOIN Salary S 
ON S.EmployeeID = E.EmployeeID
ORDER BY 4 DESC ;

-- 17. Question: Create a function to find employees with a birthday in the given month and calculate their age

CREATE FUNCTION fn_GetBirthday(@Month INT)
RETURNS TABLE
AS
RETURN
(
    SELECT FirstName, LastName, DateOfBirth,
        YEAR(GETDATE()) - YEAR(DateOfBirth) Age
    FROM Employee
    WHERE MONTH(DateOfBirth) = @Month
);

-- *  Find employees who have a birthday in November and their age
SELECT * FROM DBO.fn_GetBirthday(11);

-- *  Find employees who have a birthday in March and their age
SELECT * FROM DBO.fn_GetBirthday(3);


