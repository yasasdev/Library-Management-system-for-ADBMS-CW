-- DBMS 2 CW on Library Management DB

-- Creating Book table
CREATE TABLE Book(
    book_id VARCHAR2(12) PRIMARY KEY CHECK (book_id LIKE 'BOOK-%'),
    title VARCHAR2(100) NOT NULL,
    isbn VARCHAR(100) CHECK (isbn LIKE 'ISBN-%'),
    publisher VARCHAR2(100) NOT NULL,
    publication_year date,
    language VARCHAR2(100) NOT NULL,
    quantity NUMBER,
    added_date DATE DEFAULT CURRENT_DATE,
    genre_id REFERENCES Genre(genre_id),
    author_id REFERENCES Author(author_id)    
);

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

-- Creating Author table
CREATE TABLE author(
    author_id VARCHAR2(12) PRIMARY KEY CHECK (author_id LIKE 'AUTH-%'),
    first_name VARCHAR2(100) NOT NULL,
    last_name VARCHAR2(100),
    contact VARCHAR2(15) NOT NULL
);

-- Creating genre table
CREATE TABLE genre(
    genre_id int generated always as identity (start with 1 increment by 1) PRIMARY KEY,
    genre_name VARCHAR2(100) NOT NULL
);

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
