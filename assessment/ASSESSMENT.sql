
drop database if exists try;
create database try;
use try;

-- employees table
create table employees (
    employee_id int auto_increment primary key,
    name varchar(100),
    position varchar(100),
    salary decimal(10, 2),
    hire_date date
);

-- employee_audit table
create table employee_audit (
    audit_id int auto_increment primary key,
    employee_id int,
    name varchar(100),
    position varchar(100),
    salary decimal(10, 2),
    hire_date date,
    action_date timestamp default current_timestamp
);

insert into employees (name, position, salary, hire_date) values
('John Doe', 'Software Engineer', 80000.00, '2022-01-15'),
('Jane Smith', 'Project Manager', 90000.00, '2021-05-22'),
('Alice Johnson', 'UX Designer', 75000.00, '2023-03-01');

-- trigger to log new employees in employee_audit
delimiter $$

create trigger trg_employees_after_insert
after insert on employees
for each row
begin
    insert into employee_audit (employee_id, name, position, salary, hire_date)
    values (new.employee_id, new.name, new.position, new.salary, new.hire_date);
end$$

delimiter ;

-- stored procedure to add a new employee
delimiter $$

create procedure add_employee(
    in p_name varchar(100),
    in p_position varchar(100),
    in p_salary decimal(10, 2),
    in p_hire_date date
)
begin
    insert into employees (name, position, salary, hire_date)
    values (p_name, p_position, p_salary, p_hire_date);
    -- trigger will automatically insert a row into employee_audit
end$$

delimiter ;

call add_employee('Bob Brown', 'QA Engineer', 65000.00, '2024-01-10');

select * from employees;

select * from employee_audit;

