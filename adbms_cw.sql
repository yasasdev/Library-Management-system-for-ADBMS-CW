-- DBMS 2 CW on Library Management DB

-- Creating Book table
CREATE TABLE Books(
    book_id VARCHAR2(12) PRIMARY KEY CHECK (book_id LIKE 'BOOK-%'),
    title VARCHAR2(100) NOT NULL,
    isbn VARCHAR(100) CHECK (isbn LIKE 'ISBN-%'),
    publisher VARCHAR2(100) NOT NULL,
    publication_year DATE,
    language VARCHAR2(100) NOT NULL,
    quantity NUMBER,
    added_date DATE,
    genre_id INT,
    author_id VARCHAR2(12),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id),
    FOREIGN KEY (author_id) REFERENCES Author(author_id)
);


-- Procedure to insert records into "Book" table
CREATE OR REPLACE PROCEDURE insert_book(
    p_book_id VARCHAR2,
    p_title VARCHAR2,
    p_isbn VARCHAR2,
    p_publisher VARCHAR2,
    p_publication_year DATE,
    p_language VARCHAR2,
    p_quantity NUMBER,
    p_added_date DATE,
    p_genre_id INT,
    p_author_id VARCHAR2
)
IS
BEGIN
    INSERT INTO Books(book_id, title, isbn, publisher, publication_year, language, quantity, added_date, genre_id, author_id) VALUES 
    (p_book_id, p_title, p_isbn, p_publisher, p_publication_year, p_language, p_quantity, p_added_date, p_genre_id, p_author_id);

EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;


-- Inserting data to the "Book" table
EXECUTE insert_book('BOOK-0001', 'To Kill a Mockingbird', 'ISBN-0001', 'Harper Lee', TO_DATE('10-FEB-02', 'YYYY-MM-DD'), 'English', 8, TO_DATE('31-OCT-24', 'YYYY-MM-DD'), 1, 'AUTH-001');
EXECUTE insert_book('BOOK-0002', 'The Great Gatsby', 'ISBN-0002', 'Scribner', TO_DATE('15-OCT-02', 'YYYY-MM-DD'), 'English', 10, TO_DATE('31-OCT-24', 'DD-MM-YYYY'), 2, 'AUTH-002');






-- Creating Student table
CREATE TABLE Student(
    student_id VARCHAR2(12) PRIMARY KEY CHECK (student_id LIKE 'STD-%'),
    First_name VARCHAR2(100) NOT NULL,
    Last_name VARCHAR2(100),
    email VARCHAR2(100),
    contact VARCHAR2(100),
    city VARCHAR2(100) NOT NULL,
    register_date DATE DEFAULT CURRENT_DATE
);

-- Procedure to insert records into "Student" table
CREATE OR REPLACE PROCEDURE insertStudent(
    student_id VARCHAR2,
    first_name VARCHAR2,
    last_name VARCHAR2,
    email VARCHAR2,
    contact VARCHAR2,
    city VARCHAR2
)
IS
BEGIN
    INSERT INTO Student(student_id, First_name, Last_name, email, contact, city)
    VALUES (student_id, first_name, last_name, email, contact, city);

EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "Student" table
EXECUTE insertStudent('STD-0001', 'Yasas', 'Lekamge', 'yasas@gmail.com', '1234567890', 'Kegalle');
EXECUTE insertStudent('STD-0002', 'Kavishka', 'Madhuranga', 'kavishka@gmail.com', '1237137890', 'Gampola');
EXECUTE insertStudent('STD-0003', 'Hasitha', 'Lakshan', 'hasitha@gmail.com', '1234567349', 'Welimada');
EXECUTE insertStudent('STD-0004', 'Thushani', 'Bandara', 'thushani@gmail.com', '7839567890', 'Yatiwala');






-- Creating Librarian table
CREATE TABLE Librarian(
    lib_id VARCHAR2(12) PRIMARY KEY CHECK (lib_id LIKE 'LIB-%'),
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100),
    email VARCHAR2(100),
    contact VARCHAR2(15) NOT NULL,
    city VARCHAR2(100),    
    salary NUMBER NOT NULL,
    lib_reg_date DATE
); 

-- Procedure to insert records into "Librarian" table
CREATE OR REPLACE PROCEDURE insertLibrarian(
    lib_id VARCHAR2,
    first_name VARCHAR2,
    last_name VARCHAR2,
    email VARCHAR2,
    contact VARCHAR2,
    city VARCHAR2,
    salary NUMBER
)
IS
BEGIN
    INSERT INTO Librarian(lib_id, first_name, last_name, email, contact, city, salary)
    VALUES (lib_id, first_name, last_name, email, contact, city, salary);
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "Librarian" table
EXECUTE insertLibrarian('LIB-0001', 'Kasun', 'Bandara', 'kasun@gmail.com', '9876543210', 'Warakapola', 50000);
EXECUTE insertLibrarian('LIB-0002', 'Kasun', 'Silva', 'kasunsil@gmail.com', '9876587210', 'Rambukkana', 60000);






-- Creating Student_book table
CREATE TABLE Student_Book (
    student_id varchar(12), --(FK) student table
    book_id varchar(12), -- (FK) Book table
    issue_date DATE NOT NULL,
    due_date DATE NOT NULL,
    return_date DATE,
    fine DECIMAL(10, 2) DEFAULT 0.00,
    PRIMARY KEY (student_id, book_id), -- Composite primary key
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);


-- Procedure to insert records into "Student_Book" table
CREATE OR REPLACE PROCEDURE insertStudentBook(
    student_id VARCHAR2,
    book_id VARCHAR2,
    issue_date DATE,
    due_date DATE,
    return_date DATE DEFAULT NULL, 
    fine DECIMAL DEFAULT 0.00 
)
IS
BEGIN
    INSERT INTO Student_Book(student_id, book_id, issue_date, due_date, return_date, fine)
    VALUES (student_id, book_id, issue_date, due_date, return_date, fine);

EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "Student_Book" table
EXECUTE insertStudentBook('STD-0001', 'BOOK-0001', TO_DATE('2024-10-01', 'YYYY-MM-DD'), TO_DATE('2024-10-15', 'YYYY-MM-DD'));
EXECUTE insertStudentBook('STD-0001', 'BOOK-0002', TO_DATE('2024-11-01', 'YYYY-MM-DD'), TO_DATE('2024-11-15', 'YYYY-MM-DD'));
EXECUTE insertStudentBook('STD-0002', 'BOOK-0003', TO_DATE('2024-12-01', 'YYYY-MM-DD'), TO_DATE('2024-12-15', 'YYYY-MM-DD'));






-- Creating Author table
CREATE TABLE author(
    author_id VARCHAR2(12) PRIMARY KEY CHECK (author_id LIKE 'AUTH-%'),
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100),
    contact VARCHAR2(15) NOT NULL
);

-- Procedure to insert records into "Genre" table
CREATE OR REPLACE PROCEDURE insertAuthor(aId varchar2, fName varchar2, lName varchar2, contact varchar2)
IS
BEGIN
    INSERT INTO author(author_id, first_name, last_name, contact) VALUES (aId, fName, lName, contact);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "author" table
EXECUTE insertAuthor('AUTH-001', 'Harper', 'Lee', '1234567890');
EXECUTE insertAuthor('AUTH-002', 'George', 'Orwell', '1784567890');
EXECUTE insertAuthor('AUTH-003', 'F. Scott', 'Fitzgerald', '12332587890');






-- Creating genre table
CREATE TABLE genre(
    genre_id int generated always as identity (start with 1 increment by 1) PRIMARY KEY,
    genre_name VARCHAR2(100) NOT NULL
);

-- Procedure to insert records into "Genre" table
CREATE OR REPLACE PROCEDURE insertGenre(genreName varchar2)
IS
BEGIN
    INSERT INTO genre(genre_name) VALUES (genreName);
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "genre" table
EXECUTE insertGenre('Fiction');
EXECUTE insertGenre('Dystopian');
EXECUTE insertGenre('Science');












-- Creating Transaction table
CREATE TABLE transaction(
    transaction_id int generated always as identity (start with 1 increment by 1) PRIMARY KEY,
    student_id VARCHAR2(12),
    lib_id VARCHAR2(12),
    book_id VARCHAR2(12),
    FOREIGN KEY (student_id) REFERENCES Student(student_id),
    FOREIGN KEY (lib_id) REFERENCES Librarian(lib_id),
    FOREIGN KEY (book_id) REFERENCES Book(book_id)
);

-- Procedure to insert records into "transaction" table
CREATE OR REPLACE PROCEDURE insertTransaction(
    student_id VARCHAR2,
    lib_id VARCHAR2,
    book_id VARCHAR2
)
IS
BEGIN
    INSERT INTO transaction(student_id, lib_id, book_id)
    VALUES (student_id, lib_id, book_id); 
    
EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "transaction" table
EXECUTE insertTransaction('STD-0001', 'LIB-0001', 'BOOK-0001');
EXECUTE insertTransaction('STD-0002', 'LIB-0002', 'BOOK-0002');
EXECUTE insertTransaction('STD-0003', 'LIB-0002', 'BOOK-0003');






-- Creating fine table
CREATE TABLE fine(
    fine_id int generated always as identity (start with 1 increment by 1) PRIMARY KEY,
    student_id VARCHAR2(12),
    amount DECIMAL(10, 2) DEFAULT 0.00,
    fine_date date,
    reason VARCHAR2(100), --late return, lost book
    paid VARCHAR2(6), -- (Paid, Unpaid)
    FOREIGN KEY (student_id) REFERENCES Student(student_id)
);

-- Procedure to insert records into "fine" table
CREATE OR REPLACE PROCEDURE insertFine(
    student_id VARCHAR2,
    amount DECIMAL,
    fine_date DATE,
    reason VARCHAR2,
    paid VARCHAR2
)
IS
BEGIN
    INSERT INTO fine(student_id, amount, fine_date, reason, paid)
    VALUES (student_id, amount, fine_date, reason, paid);

EXCEPTION
    WHEN VALUE_ERROR THEN
        dbms_output.put_line('Error: The value does not match the expected data type or size.');
    WHEN OTHERS THEN
        dbms_output.put_line('An exception occurred: ' || SQLERRM);
END;

-- Inserting data to the "fine" table
EXECUTE insertFine('STD-0001', 50.00, TO_DATE('2024-10-31', 'YYYY-MM-DD'), 'Late return', 'Unpaid');
EXECUTE insertFine('STD-0003', 50.00, TO_DATE('2024-11-15', 'YYYY-MM-DD'), 'Late return', 'Paid');
EXECUTE insertFine('STD-0004', 50.00, TO_DATE('2024-12-31', 'YYYY-MM-DD'), 'Late return', 'Unpaid');
