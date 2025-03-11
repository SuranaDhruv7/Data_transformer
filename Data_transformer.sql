-- 1 Customers Table
-- Fields:
-- - CustomerID
-- - FirstName
-- - LastName
-- - Email
-- - RegistrationDate

CREATE TABLE customers (
    CustomerID INT AUTO_INCREMENT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Email VARCHAR(100) UNIQUE,
    RegistrationDate DATE
);

INSERT INTO Customers (FirstName, LastName, Email, RegistrationDate) VALUES
('John', 'Doe', 'john.doe@example.com', '2024-01-15'),
('Jane', 'Smith', 'jane.smith@example.com', '2024-02-10'),
('John', 'Doe', 'john.different@example.com', '2024-03-05'),
('Alice', 'Johnson', 'alice.johnson@example.com', '2024-01-20'),
('Bob', 'Brown', 'bob.brown@example.com', '2024-03-01');


-- 2 Orders Table
-- Fields:
-- - OrderID
-- - CustomerID
-- - OrderDate
-- - TotalAmount

-- Create Orders Table
CREATE TABLE orders (
    OrderID INT AUTO_INCREMENT PRIMARY KEY ,
    CustomerID INT,
    OrderDate DATE,
    TotalAmount DECIMAL(10,2)
);

-- Insert Sample Data into Orders Table
INSERT INTO Orders (CustomerID, OrderDate, TotalAmount) VALUES
(1, '2024-03-01', 150.75),
(2, '2024-03-05', 200.00),
(3, '2024-03-10', 99.99),
(1, '2024-03-15', 300.50),  -- Same CustomerID as Order 1
(4, '2024-03-20', 250.00);

-- 3 Employees Table
-- Fields:
-- - EmployeeID
-- - FirstName
-- - LastName
-- - Department
-- - HireDate
-- - Salary
-- Create Employees Table

CREATE TABLE employees (
    EmployeeID INT PRIMARY KEY AUTO_INCREMENT,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    Department VARCHAR(50),
    HireDate DATE,
    Salary DECIMAL(10,2)
);

-- Insert Sample Data into Employees Table
INSERT INTO Employees (FirstName, LastName, Department, HireDate, Salary) VALUES
('Michael', 'Scott', 'Sales', '2010-04-15', 75000.00),
('Dwight', 'Schrute', 'Sales', '2012-06-01', 65000.00),
('Jim', 'Halpert', 'Sales', '2013-09-20', 67000.00),
('Pam', 'Beesly', 'Reception', '2011-03-25', 40000.00),
('Michael', 'Scott', 'Management', '2005-01-10', 90000.00); -- Same First & Last Name, different department

-- Quries to perform :-

-- 1. INNER JOIN: Retrieve all orders and customer details where orders exist.

SELECT *
FROM orders
JOIN customers ON orders.CustomerID = customers.CustomerID;

-- 2. LEFT JOIN: Retrieve all customers and their corresponding orders (if any).

SELECT *
FROM customers 
LEFT JOIN orders ON customers.CustomerID = orders.CustomerID; 

-- 3. RIGHT JOIN: Retrieve all orders and their corresponding customers (if any).

SELECT *
FROM orders
RIGHT JOIN customers ON orders.CustomerID = customers.CustomerID;

-- 4. FULL OUTER JOIN: Retrieve all customers and all orders, regardless of matching.

SELECT *
FROM customers
LEFT JOIN orders ON customers.CustomerID = orders.CustomerID
UNION
SELECT *
FROM customers
RIGHT JOIN orders ON customers.CustomerID = orders.CustomerID;

-- 5. Subquery to find customers who have placed orders worth more than the average amount.
-- 6. Subquery to find employees with salaries above the average salary.
-- 7. Extract the year and month from the OrderDate.

SELECT OrderDate,
YEAR (OrderDate) AS OrderYear,
MONTH(OrderDate) AS OrderMonth
FROM orders;

-- 8. Calculate the difference in days between two dates (order date and current date).

SELECT OrderDate,
DATEDIFF(CURDATE(), OrderDate) AS Date_diff
FROM orders;

-- 9. Format the OrderDate to a more readable format (e.g., 'DD-MMM-YYYY').

SELECT OrderDate,
DATE_FORMAT(OrderDate, '%d-%m-%Y') AS Formatted_Date
FROM orders;

-- 10. Concatenate FirstName and LastName to form a full name:

SELECT FirstName, LastName,
CONCAT(FirstName, ' ', LastName) AS FullName
FROM customers;

-- 11. Replace part of a string (e.g., replace 'John' with 'Jonathan'):

SELECT REPLACE (FirstName, 'John', 'Jonathan') AS NewFirstName
FROM customers;

-- 12. Convert FirstName to uppercase and LastName to lowercase:

SELECT UPPER(FirstName) AS Upeercase_FirstName,
LOWER(LastName) AS Lowercase_LastName
FROM customers;

-- 13. Trim extra spaces from the Email field:

SELECT TRIM(Email) AS Trimmed_Email
FROM customers;

-- 14. Calculate the running total of TotalAmount for each order.
-- 15. Rank orders based on TotalAmount using the RANK() function:
-- 16. Assign a discount based on TotalAmount in orders (e.g., > 1000: 10% off, > 500: 5% off).
-- 17. Categorize employees salaries as high, medium. or low.

SELECT EmployeeID, FirstName, LastName, Salary,
CASE 
    WHEN Salary > 80000 THEN 'High'
    WHEN Salary > 60000 then 'Medium'
    ELSE 'Low'
END AS Salary_Category
FROM employees;