-- Create the database
CREATE DATABASE library;
-- Use the database
USE library;
-- Create Branch table
CREATE TABLE Branch (
    Branch_no INT PRIMARY KEY,
    Manager_Id INT,
    Branch_address VARCHAR(255),
    Contact_no VARCHAR(20)
);
-- Create Employee table
CREATE TABLE Employeee (
    Emp_Id INT PRIMARY KEY,
    Emp_name VARCHAR(100),
    Position VARCHAR(50),
    Salary DECIMAL(10, 2),
    Branch_no INT,
    FOREIGN KEY (Branch_no) REFERENCES Branch(Branch_no)
);
-- Create Books table
CREATE TABLE Books (
    ISBN VARCHAR(20) PRIMARY KEY,
    Book_title VARCHAR(255),
    Category VARCHAR(100),
    Rental_Price DECIMAL(10, 2),
    Status VARCHAR(3), -- Use 'yes' for available and 'no' for not available
    Author VARCHAR(100),
    Publisher VARCHAR(100)
);
-- Create Customer table
CREATE TABLE Customers (
    Customer_Id INT PRIMARY KEY,
    Customer_name VARCHAR(100),
    Customer_address VARCHAR(255),
    Reg_date DATE
);
-- Create IssueStatus table
CREATE TABLE IssueStatus (
    Issue_Id INT PRIMARY KEY,
    Issued_cust_id INT,
    Issued_book_name VARCHAR(255),
    Issue_date DATE,
    Isbn_book VARCHAR(20),
    FOREIGN KEY (Issued_cust_id) REFERENCES Customers(Customer_Id),
    FOREIGN KEY (Isbn_book) REFERENCES Books(ISBN)
);
-- Create ReturnStatus table
CREATE TABLE ReturnStatus (
    Return_Id INT PRIMARY KEY,
    Return_cust INT,
    Return_book_name VARCHAR(255),
    Return_date DATE,
    Isbn_book2 VARCHAR(20),
    FOREIGN KEY (Return_cust) REFERENCES Customers(Customer_Id),
    FOREIGN KEY (Isbn_book2) REFERENCES Books(ISBN)
);
-- Insert data into Branch table
INSERT INTO Branch (Branch_no, Manager_Id, Branch_address, Contact_no)
VALUES
(1, 101, '123 Main St, Springfield', '123-456-7890'),
(2, 102, '456 Elm St, Shelbyville', '987-654-3210');
-- Insert data into Employee table
INSERT INTO Employeee (Emp_Id, Emp_name, Position, Salary, Branch_no)
VALUES
(1, 'Alice Johnson', 'Librarian', 54000.00, 1),
(2, 'Bob Smith', 'Assistant Librarian', 35000.00, 1),
(3, 'Charlie Brown', 'Librarian', 47000.00, 2);

-- Insert data into Books table
INSERT INTO Books (ISBN, Book_title, Category, Rental_Price, Status, Author, Publisher)
VALUES
('978-3-16-148410-0', 'The Great Gatsby', 'Fiction', 35.99, 'yes', 'F. Scott Fitzgerald', 'Scribner'),
('978-1-61-729414-3', 'Clean Code', 'Programming', 8.99, 'yes', 'Robert C. Martin', 'Prentice Hall'),
('978-0-452-28423-4', '1984', 'Dystopian', 6.99, 'no', 'George Orwell', 'Penguin');
SELECT * FROM Books;
-- Insert data into Customer table
INSERT INTO Customers (Customer_Id, Customer_name, Customer_address, Reg_date)
VALUES
(1, 'John Doe', '789 Maple St, Springfield', '2022-01-01'),
(2, 'Jane Smith', '101 Oak St, Shelbyville', '2022-02-15');

-- Insert data into IssueStatus table
INSERT INTO IssueStatus (Issue_Id, Issued_cust_id, Issued_book_name, Issue_date, Isbn_book)
VALUES
(1, 1, '1984', '2023-06-05', '978-0-452-28423-4'),
(2, 2, 'Clean Code', '2022-03-10', '978-1-61-729414-3');
-- Insert data into ReturnStatus table
INSERT INTO ReturnStatus (Return_Id, Return_cust, Return_book_name, Return_date, Isbn_book2)
VALUES
(1, 1, '1984', '2023-06-25', '978-0-452-28423-4'),
(2, 2, 'Clean Code', '2022-03-20', '978-1-61-729414-3');

-- 1. Retrieve the book title, category, and rental price of all available books. 
SELECT Book_title, Category, Rental_Price
FROM Books
WHERE Status = 'yes';
-- 2. List the employee names and their respective salaries in descending order of salary. 
SELECT Emp_name, Salary
FROM Employeee
ORDER BY Salary DESC;
-- 3. Retrieve the book titles and the corresponding customers who have issued those books. 
SELECT Books.Book_title, Customers.Customer_name
FROM IssueStatus
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
JOIN Customers ON IssueStatus.Issued_cust_id = Customers.Customer_Id;
-- 4. Display the total count of books in each category. 
SELECT Category, COUNT(*) AS Total_Books
FROM Books
GROUP BY Category;
-- 5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000. 
SELECT Emp_name, Position
FROM Employeee
WHERE Salary > 50000;
-- 6. List the customer names who registered before 2022-01-01 and have not issued any books yet. 
SELECT Customers.Customer_name
FROM Customers
LEFT JOIN IssueStatus ON Customers.Customer_Id = IssueStatus.Issued_cust_id
WHERE Customers.Reg_date < '2022-01-01'
AND IssueStatus.Issue_Id IS NULL;
  -- 7. Display the branch numbers and the total count of employees in each branch. 
SELECT Branch_no, COUNT(*) AS Total_Employees
FROM Employeee
GROUP BY Branch_no;
-- 8. Display the names of customers who have issued books in the month of June 2023.
SELECT DISTINCT Customers.Customer_name
FROM IssueStatus
JOIN Customers ON IssueStatus.Issued_cust_id = Customers.Customer_Id
WHERE IssueStatus.Issue_date BETWEEN '2023-06-01' AND '2023-06-30';
-- 9. Retrieve book_title from book table containing history. 
SELECT Book_title
FROM Books
WHERE Category = 'History';
-- 10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees
SELECT Branch_no, COUNT(*) AS Employee_Count
FROM Employeee
GROUP BY Branch_no
HAVING COUNT(*) > 1;
-- 11. Retrieve the names of employees who manage branches and their respective branch addresses.
SELECT Employeee.Emp_name, Branch.Branch_address
FROM Employeee
JOIN Branch ON Employeee.Position = Branch.Manager_Id;
-- 12.  Display the names of customers who have issued books with a rental price higher than Rs. 5.

SELECT DISTINCT Customers.Customer_name
FROM Customers
JOIN IssueStatus ON Customers.Customer_Id = IssueStatus.Issued_cust_id
JOIN Books ON IssueStatus.Isbn_book = Books.ISBN
WHERE Books.Rental_Price > 5;




