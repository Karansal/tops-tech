
-- Module 4 - Working with Database using SQL 
create database MarketCo;
use MarketCo;
show tables;

create table Company (
    CompanyID int primary key auto_increment,
    CompanyName varchar(45),
    Street varchar(45),
    City varchar(45),
    State varchar(2),
    Zip varchar(10)
);

create table Contact (
    ContactID int primary key auto_increment,
    CompanyID int,
    FirstName varchar(45),
    LastName varchar(45),
    Street varchar(45),
    City varchar(45),
    State varchar(2),
    Zip varchar(10),
    IsMain boolean,
    Email varchar(45),
    Phone varchar(12),
    foreign key (CompanyID) references Company(CompanyID)
);

create table Employee (
    EmployeeID int primary key auto_increment,
    FirstName varchar(45),
    LastName varchar(45),
    Salary decimal(10,2),
    HireDate date,
    JobTitle varchar(25),
    Email varchar(45),
    Phone varchar(12)
);

create table ContactEmployee (
    ContactEmployeeID int primary key auto_increment,
    ContactID int,
    EmployeeID int,
    ContactDate date,
    Description varchar(100),
    foreign key (ContactID) references Contact(ContactID),
    foreign key (EmployeeID) references Employee(EmployeeID)
);

insert into Company (CompanyName, Street, City, State, Zip) values
('Toll Brothers', '4000 Ridge Ave', 'Philadelphia', 'PA', '19129'),
('Urban Outfitters, Inc.', '500 Market St', 'Philadelphia', 'PA', '19106'),
('TechNova Solutions', '12 Main Street', 'Austin', 'TX', '73301'),
('BlueWave Digital', '77 Ocean Drive', 'Miami', 'FL', '33101'),
('PrimeBuild Contractors', '210 Hill Road', 'Denver', 'CO', '80201');

insert into Employee (FirstName, LastName, Salary, HireDate, JobTitle, Email, Phone) values
('Lesley', 'Bland', 65000.00, '2020-03-12', 'Sales Manager', 'lesley.bland@marketco.com', '2155559000'),
('Jack', 'Lee', 72000.00, '2019-05-20', 'Account Executive', 'jack.lee@marketco.com', '2155558800'),
('Maria', 'Gomez', 58000.00, '2021-07-10', 'Sales Rep', 'maria.gomez@marketco.com', '3055557777'),
('David', 'Chen', 80000.00, '2018-11-03', 'Senior Manager', 'david.chen@marketco.com', '5125554444'),
('Aisha', 'Khan', 54000.00, '2022-02-14', 'Coordinator', 'aisha.khan@marketco.com', '7205553333');

insert into Contact (CompanyID, FirstName, LastName, Street, City, State, Zip, IsMain, Email, Phone) values
(1, 'Dianne', 'Connor', '101 Maple Street', 'Philadelphia', 'PA', '19121', TRUE, 'dianne.connor@toll.com', '2151112222'),
(1, 'Michael', 'Stone', '55 Ridge Ave', 'Philadelphia', 'PA', '19129', FALSE, 'michael.stone@toll.com', '2153334444'),
(2, 'Sarah', 'Williams', '700 Walnut St', 'Philadelphia', 'PA', '19107', TRUE, 'sarah.w@uo.com', '2159876543'),
(3, 'Tom', 'Hardy', '200 North St', 'Austin', 'TX', '73301', TRUE, 'tom.hardy@technova.com', '5129998888'),
(4, 'Emma', 'Lopez', '909 Bay Road', 'Miami', 'FL', '33101', TRUE, 'emma.lopez@bluewave.com', '3052223333');

insert into ContactEmployee (ContactID, EmployeeID, ContactDate, Description) values
(1, 2, '2024-01-15', 'Initial meeting with Dianne Connor'),
(1, 1, '2024-02-10', 'Follow-up call with Dianne'),
(2, 3, '2024-03-05', 'Project discussion'),
(3, 4, '2024-01-22', 'Partnership inquiry'),
(4, 5, '2024-02-18', 'Technical consultation');

-- 4) In the Employee table, the statement that changes Lesley Bland’s phone number to 215-555-8800 
set sql_safe_updates = 0;
update Employee
set Phone = '215-555-8800'
where FirstName = 'Lesley' and LastName = 'Bland';

-- 5) In the Company table, the statement that changes the name of “Urban Outfitters, Inc.” to “Urban Outfitters” . 
update Company
set CompanyName = 'Urban Outfitters'
where CompanyName = 'Urban Outfitters, Inc.';

-- 6) In ContactEmployee table, the statement that removes Dianne Connor’s contact event with Jack Lee (one statement).
delete ce from ContactEmployee ce
join Contact c on ce.ContactID = c.ContactID
join Employee e on ce.EmployeeID = e.EmployeeID
where c.FirstName = 'Dianne'
and c.LastName = 'Connor'
and e.FirstName = 'Jack'
and e.LastName = 'Lee';


-- 7) Write the SQL SELECT query that displays the names of the employees that have contacted Toll Brothers (one statement). Run the SQL SELECT query in MySQL Workbench. Copy the results below as well. 
select distinct e.FirstName, e.LastName from Employee e
join ContactEmployee ce on e.EmployeeID = ce.EmployeeID
join Contact c on ce.ContactID = c.ContactID
join Company co on c.CompanyID = co.CompanyID
where co.CompanyName = 'Toll Brothers';

-- 8) What is the significance of “%” and “_” operators in the LIKE statement? 
-- % --> matches zero or more characters
-- _ --> matches exactly one characters

-- 9) Explain normalization in the context of databases. 
-- It is the process of organizing data into tables to reduce duplication, improve data integrity and improve efficiency.

-- 10) What does a join in MySQL mean?
-- A join in SQL combines rows from two or more tables based on related columns.

-- 11) What do you understand about DDL, DCL, and DML in MySQL? 
-- DDL - Data definitoin language, it is used to define/change structure of tables.
-- DCL - Data control language, it is used for permissions 
-- DML - Data manipulation language, it is used to insert, update and delete actual data.

-- 12) What is the role of the MySQL JOIN clause in a query, and what are some common types of joins? 
-- JOIN helps to combine rows from multiple tables using relationships (foreign keys). Useful when data is normalized and split into many tables.
-- some common types of joins are: 
-- 1. Inner join
-- 2. left join
-- 3. right join
-- 4. full outer join
-- 5. cross join
