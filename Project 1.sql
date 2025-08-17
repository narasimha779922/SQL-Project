CREATE DATABASE ecommerce_db;
USE ecommerce_db;

CREATE TABLE Customers (
    customer_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50),
    last_name VARCHAR(50),
    email VARCHAR(100),
    phone VARCHAR(15),
    city VARCHAR(50),
    state VARCHAR(50),
    country VARCHAR(50)
);

CREATE TABLE Products (
    product_id INT PRIMARY KEY AUTO_INCREMENT,
    product_name VARCHAR(100),
    category VARCHAR(50),
    price DECIMAL(10,2),
    stock INT
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES Customers(customer_id)
);

CREATE TABLE Order_Details (
    order_detail_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id),
    FOREIGN KEY (product_id) REFERENCES Products(product_id)
);


INSERT INTO Customers (first_name, last_name, email, phone, city, state, country)
VALUES
('John', 'Doe', 'john@example.com', '9876543210', 'Mumbai', 'Maharashtra', 'India'),
('Priya', 'Sharma', 'priya@example.com', '9898989898', 'Delhi', 'Delhi', 'India'),
('Rahul', 'Kumar', 'rahul@example.com', '9811111111', 'Bangalore', 'Karnataka', 'India');

INSERT INTO Products (product_name, category, price, stock)
VALUES
('Laptop', 'Electronics', 55000.00, 10),
('Smartphone', 'Electronics', 25000.00, 20),
('Headphones', 'Accessories', 2000.00, 50),
('Keyboard', 'Accessories', 1500.00, 40);

INSERT INTO Orders (customer_id, order_date, total_amount)
VALUES
(1, '2025-07-01', 57000.00),
(2, '2025-07-02', 25000.00),
(3, '2025-07-03', 21500.00);


INSERT INTO Order_Details (order_id, product_id, quantity, price)
VALUES
(1, 1, 1, 55000.00),
(1, 3, 1, 2000.00),
(2, 2, 1, 25000.00),
(3, 4, 1, 1500.00),
(3, 3, 1, 2000.00);

//Quries//
SELECT * FROM Customers;

SELECT * FROM Products;

SELECT * FROM Orders;

SELECT SUM(total_amount) AS total_revenue FROM Orders;

SELECT COUNT(*) AS total_orders FROM Orders;

SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name
ORDER BY total_sold DESC;

SELECT p.category, SUM(od.price * od.quantity) AS revenue
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.category
ORDER BY revenue DESC;

SELECT c.first_name, c.last_name, o.order_id, o.order_date, o.total_amount
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
ORDER BY o.order_date;

SELECT DATE_FORMAT(order_date, '%Y-%m') AS month, SUM(total_amount) AS monthly_sales
FROM Orders
GROUP BY month
ORDER BY month;

SELECT c.first_name, c.last_name, SUM(o.total_amount) AS total_spent
FROM Orders o
JOIN Customers c ON o.customer_id = c.customer_id
GROUP BY c.customer_id
ORDER BY total_spent DESC;

SELECT product_name, stock
FROM Products
WHERE stock < 5;

CREATE VIEW sales_summary AS
SELECT p.product_name, p.category, SUM(od.quantity) AS total_sold, SUM(od.price * od.quantity) AS revenue
FROM Order_Details od
JOIN Products p ON od.product_id = p.product_id
GROUP BY p.product_name, p.category;

SELECT * FROM sales_summary;


SELECT p.product_name, SUM(od.quantity) AS total_sold
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.product_id, p.product_name
HAVING total_sold > ALL (
    SELECT SUM(od2.quantity)
    FROM Order_Details od2
    GROUP BY od2.product_id
    HAVING SUM(od2.quantity) < 10
);

SELECT p.category, SUM(od.price * od.quantity) AS category_revenue
FROM Products p
JOIN Order_Details od ON p.product_id = od.product_id
GROUP BY p.category
HAVING category_revenue > (
    SELECT AVG(cat_rev)
    FROM (
        SELECT SUM(od2.price * od2.quantity) AS cat_rev
        FROM Products p2
        JOIN Order_Details od2 ON p2.product_id = od2.product_id
        GROUP BY p2.category
    ) AS category_totals
);