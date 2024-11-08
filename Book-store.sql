-- [BOOK STORE]

-- Create database book_store
CREATE DATABASE IF NOT EXISTS book_store;

-- Use database book_store
USE book_store;

-- Create table author
CREATE TABLE IF NOT EXISTS author (
    id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    birth_date DATE NOT NULL
);

-- Create table language
CREATE TABLE IF NOT EXISTS language (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Create table book
CREATE TABLE IF NOT EXISTS book (
    isbn CHAR(13) PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    language INT NOT NULL,
    price DECIMAL(10, 2) NOT NULL,
    publication_date DATE NOT NULL,
    author_id INT NOT NULL,
    FOREIGN KEY (author_id) REFERENCES author(id),
    FOREIGN KEY (language) REFERENCES language(id)
);

-- Create table bookstore
CREATE TABLE IF NOT EXISTS bookstore (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    city VARCHAR(255) NOT NULL
);

-- Create table inventory
CREATE TABLE IF NOT EXISTS inventory (
    store_id INT,
    isbn CHAR(13),
    amount INT NOT NULL,
    PRIMARY KEY (store_id, isbn),
    FOREIGN KEY (store_id) REFERENCES bookstore(id),
    FOREIGN KEY (isbn) REFERENCES book(isbn)
);

-- Insert authors
INSERT INTO author (first_name, last_name, birth_date) VALUES
    ('J.K.', 'Rowling', '1965-07-31'),
    ('George', 'Orwell', '1903-06-25'),
    ('J.R.R.', 'Tolkien', '1892-01-03');

-- Insert languages
INSERT INTO language (name) VALUES
    ('English'),
    ('Swedish'),
    ('Spanish');

-- Insert books
INSERT INTO book (isbn, title, language, price, publication_date, author_id) VALUES
    ('9780747532743', 'Harry Potter and the Philosopher\'s Stone', 1, 19.99, '1997-06-26', 1),
    ('9780451524935', '1984', 2, 14.99, '1949-06-08', 2),
    ('9780544003415', 'The Hobbit', 3, 25.99, '1937-09-21', 3);

-- Insert bookstores
INSERT INTO bookstore (name, city) VALUES
    ('Stockholms bokhandel', 'Stockholm'),
    ('Göteborgs böcker', 'Gothenburg');

-- Insert inventory
INSERT INTO inventory (store_id, isbn, amount) VALUES
    (1, '9780747532743', 10),
    (1, '9780451524935', 5),
    (2, '9780544003415', 7),
    (2, '9780747532743', 3);

-- Create view total_author_book_value
CREATE VIEW total_author_book_value AS
SELECT
    CONCAT(a.first_name, ' ', a.last_name) AS name,
    YEAR(CURDATE()) - YEAR(a.birth_date) AS age,
    COUNT(DISTINCT b.isbn) AS book_title_count,
    SUM(b.price * i.amount) AS inventory_value
FROM
    author a
    JOIN book b ON a.id = b.author_id
    JOIN inventory i ON b.isbn = i.isbn
GROUP BY
    a.id;

-- Drop user if exists
DROP USER IF EXISTS 'developer'@'%';
DROP USER IF EXISTS 'webserver'@'%';

-- Create developer user
CREATE USER 'developer'@'%' IDENTIFIED BY 'developer_password';
GRANT SELECT, INSERT, UPDATE, DELETE, CREATE, DROP, ALTER ON book_store.* TO 'developer'@'%';
FLUSH PRIVILEGES;

-- Create webserver user
CREATE USER 'webserver'@'%' IDENTIFIED BY 'webserver_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON book_store.* TO 'webserver'@'%';
FLUSH PRIVILEGES;