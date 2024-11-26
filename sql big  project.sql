create database library;
use  library;


--  create table branch

CREATE TABLE Branch (Branch_no INT PRIMARY KEY,Manager_Id INT,Branch_address VARCHAR(50),Contact_no VARCHAR(15));
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES (1, 101, 'west bangal india', '9123456767'),(2,102,'ahmadabad gujarath','987643655'),
(3,103,'delhi india','890788999'),(4,104,'bangalore karnataka','7688898776'),
(5,105,'pune maharashtra','89897745567');

-- create table employee

CREATE TABLE Employee (Emp_Id INT PRIMARY KEY,Emp_name VARCHAR(15),Position VARCHAR(15),Salary int,Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no));
    INSERT INTO Employee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES (201, 'John Doe', 'Manager', 50000, 1),(202,'sam','HR',60000,2),(203,'peter park','system engineer',55000,3),
(204,'alby joy','project manager',99000,4),(205,'angelina joli','administration',110000,5);

-- create table books

CREATE TABLE Books (ISBN VARCHAR(13) PRIMARY KEY,Book_title VARCHAR(55),Category VARCHAR(50),Rental_Price int,
    Status VARCHAR(3) CHECK (Status IN ('yes', 'no')), Author VARCHAR(15),Publisher VARCHAR(20));
    
    INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES ('97-3-16-140', 'The Art', 'Fiction', 45, 'yes', 'John paul', 'Book Publisher'),
('76-3-19-786','aadujeevitham','biopic',20,'yes','banyamin','rainbow publisher'),
('56-2-78-877','once upon a time','story',10,'yes','eby ', 'thaya publisher'),
('99-8-09-890','half girlfriend','fiction',22,'no','mathew','indian publisher'),
('77-3-45-844','history','novel',90,'no','jsohua','mariam publisher');

-- create table customer
CREATE TABLE Customer (Customer_Id INT PRIMARY KEY,Customer_name VARCHAR(100),
Customer_address VARCHAR(255),Reg_date DATE);
INSERT INTO Customer (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES (301, 'Alice Smith', 'newyork 15 avenue', '2024-11-25'),
(302,'john paul','mangalore india','2023-10-1'),
(303,'mathew jo','USA old road','2022-12-1'),
(304,'anju shaji', 'ahmadabad taltej','2024-2-3'),
(305,'priya warrior','rajastan india','2020-7-5');

-- create table issuestatus
CREATE TABLE IssueStatus (Issue_Id INT PRIMARY KEY,Issued_cust INT,Issued_book_name VARCHAR(255),
    Issue_date DATE,ISBN_book VARCHAR(13),FOREIGN KEY (Issued_cust) REFERENCES Customer(Customer_Id),
    FOREIGN KEY (ISBN_book) REFERENCES Books(ISBN));
    INSERT INTO IssueStatus (Issue_Id, Issued_cust, Issued_book_name, Issue_date, ISBN_book)
VALUES (3001, 301, 'The Art', '2024-11-26', '97-3-16-140'),
(3002,302,'aadujeevitham','2023-10-6','76-3-19-786'),
(3003,303,'once upon a time','2023-1-2','56-2-78-877'),
(3004,304,'The art','2024-5-6','97-3-16-140');

-- create table returnstatus
CREATE TABLE ReturnStatus (Return_Id INT PRIMARY KEY,Return_cust INT,Return_book_name VARCHAR(255),
Return_date DATE,ISBN_book2 VARCHAR(13),FOREIGN KEY (Return_cust) REFERENCES Customer(Customer_Id),
FOREIGN KEY (ISBN_book2) REFERENCES Books(ISBN));
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, ISBN_book2)
VALUES (4001, 301, 'The Art', '2024-12-10', '97-3-16-140'),(4002,302,'aadujeevitham','2023-11-11','76-3-19-786'),
(4003,303,'once upon a time','2023-6-14','56-2-78-877'),(4004,304,'the art','2024-6-6','97-3-16-140');

-- 1.Retrieve the book title, category, and rental price of all available books

SELECT Book_title, Category, Rental_Price
FROM Books WHERE Status = 'yes';

--  2. List the employee names and their respective salaries in descending order of salary.
SELECT Emp_name, Salary FROM Employee
ORDER BY Salary DESC;

-- 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT Book_title, Customer_name FROM Books 
JOIN IssueStatus  ON ISBN = ISBN_book
JOIN Customer  ON Issued_cust = Customer_Id;

-- 4. Display the total count of books in each category.
SELECT Category, COUNT(*) AS Total_Books FROM Books
GROUP BY Category;


-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.
SELECT Emp_name, Position FROM Employee
WHERE Salary > 50000;

-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet.
SELECT Customer_name
FROM Customer LEFT JOIN IssueStatus ON Customer_Id = Issued_cust
WHERE Reg_date < '2022-01-01' AND Issue_Id IS NULL;


-- 7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employee GROUP BY Branch_no;


--  8. Display the names of customers who have issued books in the month of June 2023.
SELECT Customer_name FROM Customer JOIN IssueStatus  ON Customer_Id = Issued_cust
WHERE Issue_date BETWEEN '2023-06-01' AND '2023-06-30';

-- 9. Retrieve book_title from book table containing history. 
SELECT Book_title
FROM Books WHERE Book_title LIKE 'history';

-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee
GROUP BY Branch_no HAVING COUNT(*) > 5;

-- 11. Retrieve the names of employees who manage branches and their respective branch addresses. 
SELECT Emp_name, Branch_address
FROM Employee JOIN Branch  ON Branch_no =branch_no
WHERE Position = 'project Manager';

--  12.  Display the names of customers who have issued books with a rental price higher than Rs. 25.
SELECT Customer_name from
Customer JOIN IssueStatus  ON Customer_Id = Issued_cust
JOIN Books  ON ISBN_book = ISBN
WHERE Rental_Price > 25;


