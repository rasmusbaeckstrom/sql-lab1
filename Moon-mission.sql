USE laboration1;

-- [MOON MISSIONS]
-- Uses database laboration1

-- 1
CREATE TABLE successful_mission AS SELECT * FROM moon_mission WHERE outcome = 'Successful';

-- 2
ALTER TABLE successful_mission
MODIFY mission_id INT AUTO_INCREMENT PRIMARY KEY;

-- 3
UPDATE successful_mission SET operator = REPLACE(operator, ' ', '')
WHERE operator LIKE '% %';

UPDATE moon_mission SET operator = REPLACE(operator, ' ', '')
WHERE operator LIKE '% %';

-- 4
DELETE FROM successful_mission WHERE launch_date >= '2010-01-01';

-- 5
SELECT *,
       CONCAT(first_name, ' ', last_name) AS name,
       CASE
           WHEN SUBSTRING(ssn, -2, 1) % 2 = 0 THEN 'female'
           ELSE 'male'
           END AS gender
FROM account;

-- 6
DELETE FROM account
WHERE SUBSTRING(ssn, -2, 1) % 2 = 0
  AND (1900 + SUBSTRING(ssn, 1, 2)) < 1970;

-- 7
SELECT
    CASE
        WHEN SUBSTRING(ssn, -2, 1) % 2 = 0 THEN 'female'
        ELSE 'male'
        END AS gender,
    AVG(YEAR(CURDATE()) - (1900 + SUBSTRING(ssn, 1, 2))) AS average_age
FROM account
GROUP BY gender;
