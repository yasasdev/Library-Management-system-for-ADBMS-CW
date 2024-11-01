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





-- PL / SQL block to update the return date of the books borrowed.
SET SERVEROUTPUT ON;
ACCEPT studentId CHAR PROMPT 'Enter Student ID: ';
ACCEPT bookId CHAR PROMPT 'Enter Book ID: ';
ACCEPT returnDate CHAR PROMPT 'Enter Return Date (YYYY-MM-DD): ';

DECLARE
    v_student_id VARCHAR2(12) := '&studentId';
    v_book_id VARCHAR2(12) := '&bookId';
    v_return_date DATE;
BEGIN
    -- Convert the input string to a DATE type
    v_return_date := TO_DATE('&returnDate', 'YYYY-MM-DD');

    UPDATE Student_Book
    SET return_date = v_return_date
    WHERE student_id = v_student_id AND book_id = v_book_id;

    IF SQL%ROWCOUNT > 0 THEN
        dbms_output.put_line('Return date updated successfully for Student ID: ' || v_student_id || ' and Book ID: ' || v_book_id);
    ELSE
        dbms_output.put_line('No records found for Student ID: ' || v_student_id || ' and Book ID: ' || v_book_id);
    END IF;

EXCEPTION
    WHEN OTHERS THEN
        dbms_output.put_line('An error occurred: ' || SQLERRM);
END;






-- Procedure to display unique books that are issued to Students
CREATE OR REPLACE PROCEDURE list_unique_issued_books
IS
BEGIN
    FOR record IN (
        SELECT sb.book_id, b.title AS book_title, sb.student_id, sb.issue_date
        FROM Student_Book sb
        INNER JOIN Books b ON sb.book_id = b.book_id
        GROUP BY sb.book_id, b.title, sb.student_id, sb.issue_date
        ORDER BY sb.issue_date
    )
    LOOP
        dbms_output.put_line('Book ID: ' || record.book_id || 
                             ', Title: ' || record.book_title || 
                             ', Student ID: ' || record.student_id || 
                             ', Issue Date: ' || TO_CHAR(record.issue_date, 'YYYY-MM-DD'));
    END LOOP;
END;

-- Execute the procedure "list_unique_issued_books"
BEGIN
    list_unique_issued_books;
END;





-- Procedure to display the students have overdue books
CREATE OR REPLACE PROCEDURE display_overdue_students
IS
    CURSOR overdue_books_cursor IS
        SELECT s.student_id, s.first_name, s.last_name, sb.book_id, b.title AS book_title, sb.issue_date, sb.due_date
        FROM Student s
        JOIN Student_Book sb ON s.student_id = sb.student_id
        JOIN Books b ON sb.book_id = b.book_id
        WHERE sb.due_date < SYSDATE AND (sb.return_date IS NULL OR sb.return_date > sb.due_date)
        ORDER BY s.student_id;

    -- Variables to hold individual column values from the cursor
    v_student_id Student.student_id%TYPE;
    v_first_name Student.first_name%TYPE;
    v_last_name Student.last_name%TYPE;
    v_book_id Student_Book.book_id%TYPE;
    v_book_title Books.title%TYPE;
    v_issue_date Student_Book.issue_date%TYPE;
    v_due_date Student_Book.due_date%TYPE;
    
BEGIN
    OPEN overdue_books_cursor;
    LOOP
        FETCH overdue_books_cursor INTO v_student_id, v_first_name, v_last_name, v_book_id, v_book_title, v_issue_date, v_due_date;
        EXIT WHEN overdue_books_cursor%NOTFOUND;
        
        dbms_output.put_line('Student ID: ' || v_student_id || 
                             ', Name: ' || v_first_name || ' ' || v_last_name || 
                             ', Book ID: ' || v_book_id || 
                             ', Book Title: ' || v_book_title || 
                             ', Issue Date: ' || TO_CHAR(v_issue_date, 'YYYY-MM-DD') || 
                             ', Due Date: ' || TO_CHAR(v_due_date, 'YYYY-MM-DD'));
    END LOOP;
    CLOSE overdue_books_cursor;
END;


-- Execute the procedure "display_overdue_students;"
BEGIN
    display_overdue_students;
END;





-- Cursor to retrieve authors and their published books in the last 10 years
CREATE OR REPLACE PROCEDURE author_publications
IS
    CURSOR author_books_cursor IS
        SELECT a.first_name, a.last_name, COUNT(b.book_id) AS total_books,LISTAGG(b.title, ', ') 
        WITHIN GROUP (ORDER BY b.title) AS book_titles
        FROM author a
        JOIN Books b ON a.author_id = b.author_id
        WHERE b.publication_year >= ADD_MONTHS(SYSDATE, -120) -- Last 10 years
        GROUP BY a.author_id, a.first_name, a.last_name
        HAVING COUNT(b.book_id) > 0; 

    v_first_name author.first_name%TYPE;
    v_last_name author.last_name%TYPE;
    v_total_books NUMBER;
    v_book_titles VARCHAR2(100);

BEGIN
    OPEN author_books_cursor;
    LOOP
        FETCH author_books_cursor INTO 
            v_first_name, v_last_name, v_total_books, v_book_titles;
        
        EXIT WHEN author_books_cursor%NOTFOUND;

        dbms_output.put_line('Author: ' || v_first_name || ' ' || v_last_name || 
                             ', Total Books Published: ' || v_total_books || 
                             ', Titles: ' || v_book_titles);
    END LOOP;

    CLOSE author_books_cursor;
END;

-- Executing the procedure "analyze_author_publications"
BEGIN
    author_publications;
END;





-- Getting the details of the students who borrow books and the librarian who issued books.
SELECT s.student_id, s.first_name AS student_name, l.lib_id, l.first_name AS librarian_name, sb.issue_date, sb.return_date
FROM Student s
JOIN transaction t 
ON s.student_id = t.student_id
JOIN Librarian l 
ON t.lib_id = l.lib_id
JOIN Student_Book sb 
ON s.student_id = sb.student_id AND t.book_id = sb.book_id;
