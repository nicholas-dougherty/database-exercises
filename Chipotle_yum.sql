USE chipotle;
-- What's in there?
SHOW TABLES;
DESCRIBE orders;
-- Let's talk about WHERE
USE albums_db; 
SELECT * FROM albums WHERE genre = 'Rock';

-- LIKE will allow us flexibility
/* this will help us find additional subsets of the rock genre */
SELECT * FROM albums WHERE genre LIKE '%ROCK%'; 
-- this will also includes other genres lumped with it, like with Thriller involving Pop + R&B
-- We can use the % wildcare to pad out characters that we want to ignore

SELECT 
name AS album_name,
artist AS band
FROM albums
WHERE release_date
BETWEEN 1990 and 1999;

-- Chaining boolean statements with WHERE
USE chipotle;
SELECT * FROM orders;

-- Or
SELECT * FROM orders
WHERE choice_description LIKE '%Beans%'
OR order_id = 5; 

-- AND 
SELECT * FROM orders
WHERE choice_description LIKE '%Beans%'
AND order_id = 5;

SELECT * FROM orders WHERE choice_description IS NULL; 

USE world;
SELECT * FROM city;

USE albums_db; 
SELECT * FROM albums WHERE genre IN ('Rock', 'Hard Rock');

SELECT * FROM albums WHERE genre LIKE '%Rock%' OR (genre LIKE '%Pop%' AND genre LIKE '%Soul%');

-- ORDER BY 

SELECT name FROM albums 
ORDER BY name DESC;

SELECT * FROM albums
ORDER BY artist DESC, name DESC;

-- LIMIT and OFFSET
SELECT artist AS band, genre AS style FROM albums LIMIT 20;

SELECT artist AS band, genre AS style FROM albums LIMIT 20 OFFSET 10;
-- gives the limit of 20 but offsets 10. 