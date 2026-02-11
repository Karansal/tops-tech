create database swiigy;

USE swiggy ;

create table customers (
	customer_id int auto_increment primary key,
    name varchar(100) NOT NULL,
    email varchar(100) not null unique,
    phone varchar(13) unique not null, 
    address text not null,
    registered_date timestamp default current_timestamp
    );

select * from customers;
select name, phone from customers;

insert into customers(name, email, phone, address)
values 
("Nevin Patel", "nevsljjkbhjvbgeepy.p@gmail.com", "9123835461", "B805, Nehrunagar, Ahmedabad"),
("Krunal Shukla", "k.shukla@gmail.com", "+917990657277", "Sector -48, Isckon Rasta, Gandhinagar"),
("Dev Patel", "dev.p@gmail.com", "8320834561", "A805, satellite, Ahmedabad");


-- Categories (category_id, name)
-- Orders (order_id, customer_id........)
-- stores (store_id, store_name, address, city , phone)
-- products (product_id, product_name, brand,category,  price)
-- stocks (stock_id, product_id,product_name, order_id, quantity)
-- riders (rider_id, name, phone, vehicle_type, status {default:"available"}, )
-- deliveries (delivery_id, order_id, rider_id, assigned_at {timestamp},  status, distance)
-- review (review_id, product_id, customer_id, rating {1 to 5}, comment, time )


create table orders (
	order_id int auto_increment primary key,
    customer_id int,
    order_status varchar(100) not null,
    payment_status varchar(100) not null,
    total_amount int not null,
    order_date datetime default current_timestamp,
    foreign key (customer_id) references customers(customer_id) on delete set null
    );
    
insert into orders(customer_id, order_status, payment_status, total_amount)
values(2, "Pending", "Paid", 329),
(3,"pending","unpaid",234),
(4,"complete","paid",456),
(5,"running","paid",643),
(6,"pending","unpaid",678),
(7,"complete","paid",367),
(8,"pending","paid",578),
(9,"complete","paid",507),
(10,"pending","unpaid",320);


SET FOREIGN_KEY_CHECKS = 0;

select *from orders
SELECT customer_id,
    MAX(total_amount) AS highest_order
FROM orders
GROUP BY customer_id
HAVING highest_order > 200;



select  order_status,sum(total_amount)as total_amount 
from orders
group by order_status 
having total_amount > 300;




create table categories(
	category_id int auto_increment primary key,
    name varchar(100) not null unique
    );
insert into categories (name) values ("Beverages"),
("North Indian"),
("South Indian"),
("Chinese"),
("Fast food"),
("Desserts"),
("Pizzas"),
("Healthy food"),
("Biryani"),
("Thali");

select * from categories

create table  stores (
    store_id int auto_increment primary key,
    store_name Varchar(100) NOT NULL,
    address TEXT NOT NULL,
    price int not null,
    city varchar(50) NOT NULL,
    phone varchar(13) UNIQUE
);
drop table stores;
insert stores (store_name, address, price, city, phone)
VALUES
('Burger Hub', 'SG Highway, Ahmedabad','200', 'Ahmedabad', '9876543210'),
('Pizza Point', 'Sector 21, Gandhinagar', '250', 'Gandhinagar', '9998887771'),
('Cake World', 'Maninagar Main Road, Ahmedabad','140', 'Ahmedabad', '9123456789'),
('Coffee Corner', 'Infocity Avenue, Gandhinagar', '150', 'Gandhinagar', '9000090000'),
('Biryani House', 'Vastrapur Lake Road, Ahmedabad', '460', 'Ahmedabad', '9090909090');

select * from stores
where price between 100 and 400;


create table products (
    product_id int auto_increment primary key,
    product_name varchar(100) NOT NULL,
    brand varchar(100),
    category varchar(100),
    price decimal(10,2) NOT NULL
);


insert into products (product_name, brand, category, price)
VALUES
('Veg Burger', 'Burger Hub', 'Snacks', 120.00),
('Cheese Pizza', 'Pizza Point', 'Main Course', 250.00),
('Cold Coffee', 'Coffee Corner', 'Beverages', 90.00),
('Chocolate Brownie', 'Cake World', 'Desserts', 150.00),
('Chicken Biryani', 'Biryani House', 'Main Course', 220.00);


SELECT * FROM products;


create table stocks (
    stock_id int auto_increment primary key,
    product_id int,
    product_name varchar(100)not null ,
    order_id int,
    quantity int not null
);
insert into stocks (product_id, product_name, order_id, quantity)
values
(1, 'veg burger', 1, 2),
(2, 'cheese pizza', 1, 1),
(3, 'cold coffee', 2, 1),
(4, 'chocolate brownie', 3, 1);

select * from stocks;

create table riders (
    rider_id int auto_increment primary key,
    name varchar(100) not null,
    phone varchar(13) not null unique,
    vehicle_type varchar(50),
    status varchar(20) default 'available'
    );


insert into riders (name, phone, vehicle_type, status)
values
('karaa dhai', '9863456780', 'bike', 'available'),
('abob patel', '9898986798', 'scooter', 'busy'),
('dev patel', '9876501454', 'bike', 'available'),
('amit shah', '9812272312', 'bicycle', 'available');

select * from riders;


create table deliveries (
    delivery_id int auto_increment primary key,
    order_id int,
    rider_id int,
    assigned_at timestamp default current_timestamp,
    status varchar(50) default "out for delivery",
    distance float
	);
     

insert into deliveries (order_id, rider_id, status, distance)
values
(1, 1, 'delivered', 4.5),
(2, 2, 'out for delivery', 6.2),
(3, 3, 'cancelled', 0.0);

select * from deliveries;


create table review (
    review_id int auto_increment primary key,
    product_id int not null,
    customer_id int not null,
    rating tinyint not null check (rating between 1 and 5),
    comment text,
    time timestamp default current_timestamp
);

insert into review (product_id, customer_id, rating, comment)
values
(1, 1, 5, 'excellent taste and packaging'),
(2, 2, 4, 'good pizza but could be hotter'),
(3, 3, 3, 'average cold coffee'),
(4, 1, 5, 'amazing brownie! fresh and soft'),
(5, 2, 4, 'nice biryani with good flavor');

SET FOREIGN_KEY_CHECKS = 0;

select * from review;



--  Use functions like COUNT(), SUM(), AVG(), MIN(), and MAX() on your tables.

-- -- Find the total number of customers registered on Blinkit.

 -- -- Calculate the total revenue earned from all orders.

-- -- Find the average total amount of all delivered orders.

-- -- Display the minimum and maximum total amount from the orders table.

-- -- Find the total number of reviews submitted for each product.



SELECT COUNT(customer_id) AS total_customers
FROM customers;

SELECT SUM(total_amount) AS total_revenue
FROM orders;

SELECT AVG(total_amount) AS average_delivered_order_value
FROM orders
WHERE status = 'delivered';


SELECT MIN(total_amount) AS minimum_order_amount
SELECT MAX(total_amount) AS maximum_order_amount
FROM orders;




-- tigger
select * from orders;
delimiter //
create trigger before_order_insert
before insert on orders
for each row 
begin 
	if NEW.total_amount <0 then
	    SET NEW.total_amount = 0;
   end if;
end //
delimiter ;


delimiter //
create trigger before_products_insert 
before insert on products
for each row
begin 
    if NEW.price < 0 then
          set NEW.price =0;
	end if;
end //
delimiter ;
    
insert into priduct(product_name, brand,category,price)
value ('Chicken Biryani','Biryani House','Main Course',-767)

select * from products;


    
select customer_id, sum(total_amount) as total_spend,
rank() over (order by sum(total_amount)desc)as spend_rank
from orders
group by customer_id;

select customer_id, sum(total_amount) as total_spend,
dense_rank() over (order by sum(total_amount) desc) as spend_rank
from orders
group by customer_id;
