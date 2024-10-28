-- DBMS 2 CW on Library Management DB

-- Creating Book table
CREATE TABLE Book(
    book_id VARCHAR2(12) PRIMARY KEY CHECK (book_id LIKE 'ISBN-%'),
    book_name VARCHAR2(100) NOT NULL,
    author VARCHAR2(100) NOT NULL,
    quantity NUMBER
);

-- Creating Student table
CREATE TABLE Student(
    student_id VARCHAR2(12) PRIMARY KEY CHECK (student_id LIKE 'STD-%'),
    student_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(100) NOT NULL,
    email VARCHAR2(100),
    book_status VARCHAR2(20),
    book VARCHAR2(100) REFERENCES Book(book_id)
);

-- Creating Librarian table
CREATE TABLE Librarian(
    lib_id VARCHAR2(12) PRIMARY KEY CHECK (lib_id LIKE 'lib-%'),
    lib_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(100),
    contact VARCHAR2(15) NOT NULL,
    salary NUMBER NOT NULL
);

-- Creating Employee table
CREATE TABLE employee(
    emp_id VARCHAR2(12) PRIMARY KEY CHECK (emp_id LIKE 'emp-%'),
    emp_name VARCHAR2(100) NOT NULL,
    city VARCHAR2(100),
    contact VARCHAR2(15) NOT NULL,
    salary NUMBER NOT NULL
);




-- Procedure to insert records into "Book" table
CREATE OR REPLACE PROCEDURE insertBooks(bookId varchar2, bookName varchar2, author varchar2, quantity number)
IS
BEGIN
    INSERT INTO Book(book_id, book_name, author, quantity) VALUES (bookId, bookName, author, quantity);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value doesn’t match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "Book" table
EXECUTE insertBooks('ISBN-0001', 'Gamperaliya', 'Martin Wikkramasinghe', 20);
EXECUTE insertBooks('ISBN-0002', 'Kaliyugaya', 'Martin Wikkramasinghe', 17);
EXECUTE insertBooks('ISBN-0003', 'Kavya Dasa', 'Ananda Samarakoon', 10);
EXECUTE insertBooks('ISBN-0004', 'Punaruththaya', 'Martin Wikkramasinghe', 5);
EXECUTE insertBooks('ISBN-0005', 'Madol Doova', 'Martin Wikkramasinghe', 30);





-- Procedure to insert records into "Student" table
CREATE OR REPLACE PROCEDURE insertStudents(stdId varchar2, stdName varchar2, city varchar2, email varchar2, bookStatus varchar2, book varchar2)
IS
BEGIN
    INSERT INTO Student(student_id, student_name, city, email, book_status, book) VALUES (stdId, stdName, city, email, bookStatus, book);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value doesn’t match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "Student" table
EXECUTE insertStudents('STD-0001', 'Yasas Lekamge', 'Kegalle', 'yasas@gmail.com', 'Borrowed', 'ISBN-0005');
EXECUTE insertStudents('STD-0002', 'Kavishka Madhuranga', 'Gampola', 'kavishka@gmail.com', 'Borrowed', 'ISBN-0002');
EXECUTE insertStudents('STD-0003', 'Hasitha Rathnayake', 'Welimada', 'hasitha@gmail.com', 'Returned', 'ISBN-0001');
EXECUTE insertStudents('STD-0004', 'Thushani', 'Gampola', 'thushani@gmail.com', 'Returned', 'ISBN-0003');
EXECUTE insertStudents('STD-0005', 'Kevin', 'Rathnapura', 'kevin@gmail.com', 'Borrowed', 'ISBN-0005');





-- Procedure to insert records into "Librarian" table
CREATE OR REPLACE PROCEDURE insertLibrarian(libId varchar2, libName varchar2, city varchar2, contact varchar2, salary number)
IS
BEGIN
    INSERT INTO Librarian(lib_id, lib_name, city, contact, salary) VALUES (libId, libName, city, contact, salary);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value doesn’t match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

EXECUTE insertLibrarian('lib-0001', 'Yasas Lekamge', 'Kegalle', '1234567890', 50000.00);
EXECUTE insertLibrarian('lib-0002', 'Kavishka Madhuranga', 'Gampola', '0987654321', 40000.00);
EXECUTE insertLibrarian('lib-0003', 'Hasitha Rathnayake', 'Welimada', '4567893210', 60000.00);





-- Procedure to insert records into "Employee" table
CREATE OR REPLACE PROCEDURE insertEmployee(empId varchar2, empName varchar2, city varchar2, contact varchar2, salary number)
IS
BEGIN
    INSERT INTO employee(emp_id, emp_name, city, contact, salary) VALUES (empId, empName, city, contact, salary);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value doesn’t match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

EXECUTE insertEmployee('emp-0001', 'Yasas Lekamge', 'Kegalle', '1234567890', 50000.00);
EXECUTE insertEmployee('emp-0002', 'Kavishka Madhuranga', 'Gampola', '0987654321', 40000.00);
EXECUTE insertEmployee('emp-0003', 'Hasitha Rathnayake', 'Welimada', '4567893210', 60000.00);
EXECUTE insertEmployee('emp-0004', 'Thushani', 'Welimada', '4567893210', 60000.00);





-- Retrieve data from the "Employee" table using a cursor
SET SERVEROUTPUT ON;
ACCEPT empId char PROMPT 'Enter Employee Id: '
DECLARE
    e_name varchar2(100);
    e_city varchar2(100);
    e_contact varchar2(15);
    e_salary number;
    e_id varchar2(15);
BEGIN
    e_id := '&empId';
    SELECT emp_name, city, contact, salary INTO e_name, e_city, e_contact, e_salary
    FROM employee
    WHERE emp_id = e_id;

    dbms_output.put_line('Employee Information');
    dbms_output.put_line('ID: ' || e_id);
    dbms_output.put_line('Name: ' || e_name);
    dbms_output.put_line('City: ' || e_city);
    dbms_output.put_line('Contact: ' || e_contact);
    dbms_output.put_line('Salary: ' || e_salary);
END;




-- Update book status of the "Student" table
SET SERVEROUTPUT ON;
ACCEPT stdId char PROMPT 'Enter Student Id: '
ACCEPT status char PROMPT 'Enter Book Status: '
DECLARE
    std_id varchar2(100);
    status varchar2(100);
BEGIN
    std_id := '&stdId';
    status := '&status';
    UPDATE student SET book_status=status WHERE student_id=std_id;
    
    dbms_output.put_line('Status Successfully Updated!');
END;


-- Update Book quantity
SET SERVEROUTPUT ON;
ACCEPT bookId CHAR PROMPT 'Enter Book Id: ';
ACCEPT quantity NUMBER PROMPT 'Enter Book quantity to be added: ';

DECLARE
    bookid VARCHAR2(100);
    added_quantity NUMBER;
    current_quantity NUMBER;
BEGIN
    bookid := '&bookId';
    added_quantity := '&quantity';
    
    SELECT quantity INTO current_quantity
    FROM Book
    WHERE book_id = bookid
    AND ROWNUM = 1;    

    UPDATE Book
    SET quantity = current_quantity + added_quantity
    WHERE book_id = bookid;

    dbms_output.put_line('Quantity successfully updated! New quantity: ' || (current_quantity + added_quantity));
END;




-- Deleting an employee by giving the employee ID
SET SERVEROUTPUT ON;
ACCEPT empId char PROMPT 'Enter Employee Id: '
DECLARE
    empid varchar2(100);
BEGIN
    empid := '&empId';
    DELETE FROM employee WHERE emp_id = empid;
    
    dbms_output.put_line('Employee Successfully Deleted!');
END;