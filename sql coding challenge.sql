use db2;
/*Creation of the Customers Table*/
create table customers(customer_id int primary key, 
	name varchar(255), 
    email varchar(255), 
    password varchar(255));

/*Creation of the Products Table*/
create table products(product_id int primary key, 
	name varchar(255), price int,
    description varchar(255), 
    stockQuantity int);

/*Creation of the Cart Table*/
create table cart(cart_id int primary key, 
	customer_id int, 
    foreign key(customer_id) references customers(customer_id), 
    product_id int, 
    foreign key(product_id) references products(product_id),
    quantity int);

/*Creation of the Orders Table*/
create table orders(order_id int primary key, 
	customer_id int, 
    foreign key(customer_id) references customers(customer_id), 
    order_date date, total_price int,
    shipping_address varchar(255));

/*Creation of the Order Items Table*/
create table order_items(order_item_id int primary key,
	order_id int,
    foreign key(order_id) references orders(order_id), 
    product_id int, 
    foreign key(product_id) references products(product_id), 
    quantity int);

/*Inserting values to the Products Table*/
insert into products values(1, 'Laptop', 800, 'Higt-performance laptop', 10), (2, 'Smartphone', 600, 'Latest smartphone', 15), (3, 'Tablet', 300, 'Portable Tablet', 20), (4, 'Headphones', 150, 'Noise-canceling', 30),(5, 'TV', 900, '4K Smart TV', 5), 
(6,'Coffee Maker', 50, 'Automatic coffee maker', 25), (7, 'Refrigerator', 700, 'Energy-efficient', 10), (8, 'Microwav Oven', 80, 'Countertop microwave', 15), (9, 'Blender', 70, 'High-speed blender', 20), (10, 'Vacuum Cleaner', 120, 'Bagless vacuum cleaner', 10);

/*Inserting values to the Customers Table*/
insert into customers values(1, 'JohnDoe', 'johndoe@example.com', '123'), (2, 'JaneSmith', 'janesmith@example.com', '456'), (3, 'RobertJohnson', 'robert@example.com', '789'), (4, 'SarahBrown', 'sarah@example.com', '012'), (5, 'DavidLee', 'david@example.com', '345'),
 (6, 'LauraHall', 'laura@example.com', '678'), (7, 'MichaelDavis', 'michael@example.com', '901'), (8, 'EmmaWilson', 'emma@example.com', '234'), (9, 'WilliamTaylor', 'william@example.com', '567'), (10,'OliviaAdams', 'olivia@example.com','890');

/*Inserting values to the Cart Table*/
insert into cart values(1, 1, 1, 2), (2, 1, 3, 1), (3, 2, 2, 3), (4, 3, 4, 4), (5, 3, 5, 2), (6, 4, 6, 1), (7, 5, 1, 1), (8, 6, 10, 2), (9, 6, 9, 3), (10, 7, 7, 2);

/*Inserting values to the Orders Table*/
insert into orders values (1, 1, '2023-01-05', 1200, '123 Main St, City'), (2, 2, '2023-02-10', 900, '456 Elm St, Town'), (3, 3, '2023-03-15', 300, '789 Oak St, Village'), (4, 4, '2023-04-20', 150, '101 Pine St, Suburb'), (5, 5, '2023-05-25', 1800, '234 Cedar St, District'),
 (6, 6, '2023-06-30', 400, '567 Birch St, County'), (7, 7, '2023-07-05', 700, '890 Maple St, State'), (8, 8, '2023-08-10', 160, '321 Redwood St, Country'), (9, 9, '2023-09-15', 140, '432 Spruce St, Province'), (10, 10, '2023-10-20', 1400, '765 Fir St, Territory');

/*Inserting values to the Order_items Table*/
insert into order_items values(1, 1, 1, 2), (2, 1, 3, 1), (3, 2, 2, 3), (4, 3, 5, 2), (5, 4, 4, 4), 
(6, 4, 6, 1), (7, 5, 1, 1), (8, 5, 2, 2), (9, 6, 10, 2), (10, 6, 9, 3);

/* 1. Update refrigerator product price to 800*/
update products set price = 800 where name = 'Refrigerator';

/* 2. Remove all cart items for a specific customer*/
delete from cart where customer_id = 1;

/* 3. Retrieve Products Priced Below $100 */
select * from products where price < 100;

/* 4. Find Products with Stock Quantity Greater Than 5*/
select * from products where stockQuantity > 5;

/* 5. Retrieve Orders with Total Amount Between $500 and $1000*/
select * from orders where total_price between 500 and 1000;

/* 6. Find Products which name end with letter ‘r’*/
select * from products where name like '%r';

/* 7. Retrieve Cart Items for Customer 5*/
select * from cart where customer_id = 5;

/* 8. Find Customers Who Placed Orders in 2023*/
SELECT DISTINCT c.* FROM customers c JOIN orders o ON c.customer_id = o.customer_id WHERE YEAR(o.order_date) = 2023;

/* 9. Determine the Minimum Stock Quantity for Each Product Category*/
SELECT product_id, MIN(stockQuantity) AS min_stock FROM products GROUP BY product_id;

/* 10. Calculate the Total Amount Spent by Each Customer*/
select sum(total_price) as total_price from orders group by customer_id;

/* 11. Find the Average Order Amount for Each Customer*/
select avg(total_price) as average_amount from orders group by customer_id;

/*12. Count the Number of Orders Placed by Each Customer*/
select customer_id, count(order_id) as order_count from orders group by customer_id;

/* 13. Find the Maximum Order Amount for Each Customer*/
SELECT customer_id, MAX(total_price) AS max_order_amount FROM orders GROUP BY customer_id;

/* 14. Get Customers Who Placed Orders Totaling Over $1000*/
select name from customers where customer_id in (select customer_id from orders where total_price >= 1000);

/* 15. Subquery to Find Products Not in the Cart*/
select * from products where product_id not in (select product_id from cart);

/* 16. Subquery to Find Customers Who Haven't Placed Orders*/
select * from customers where customer_id not in (select customer_id from cart);

/* 17. Subquery to Calculate the Percentage of Total Revenue for a Product*/
SELECT product_id, name, (total_price / (SELECT SUM(total_price) FROM orders)) * 100 AS revenue_percentage
FROM products;

/* 18. Subquery to Find Products with Low Stock*/
SELECT * FROM products WHERE stockQuantity < (SELECT AVG(stockQuantity) FROM products);

/* 19. Subquery to Find Customers Who Placed High-Value Orders*/
select * from customers where customer_id in (select customer_id from orders where total_price > 1000);
