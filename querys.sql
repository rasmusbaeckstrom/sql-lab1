-- This code is only to test user developer and webserver

USE book_store;
CREATE TABLE test_table (id INT);
INSERT INTO test_table (id) VALUES (1);
SELECT * FROM test_table;
UPDATE test_table SET id = 2 WHERE id = 1;
DELETE FROM test_table WHERE id = 2;
DROP TABLE test_table;

USE book_store;
SELECT * FROM author;
INSERT INTO author (first_name, last_name, birth_date) VALUES ('Test', 'User', '2000-01-01');
UPDATE author SET first_name = 'Updated' WHERE first_name = 'Test';
DELETE FROM author WHERE first_name = 'Updated';

CREATE TABLE test_table (id INT);
DROP TABLE test_table;
