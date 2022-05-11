/*
____ ____ ____ ____ ____ ____ 
||s |||e |||l |||e |||c |||t ||
||__|||__|||__|||__|||__|||__||
|/__\|/__\|/__\|/__\|/__\|/__\|
*/
--  ---  ----  -----  ------  --------  -----------  ------------  ----------------  ------------------
USE albums_db;
SHOW CREATE DATABASE albums_db;
SHOW TABLES;
DESCRIBE `albums`;
SHOW CREATE TABLE `albums`;

SELECT *
    FROM `albums`; --31 in ID, i.e. 31 rows 
    
SELECT COUNT(DISTINCT artist)
    FROM `albums`; --23 rows affected
-- 23 shows at the bottom next to no errors, but there must be a way to make it appear more directly

SELECT MIN(release_date)
    FROM `albums`; -- 1967 is the oldest release date

SELECT MAX(release_date)
    FROM `albums`; -- 2011 is FRESH

/*after exploring the structure of the albums table, 
rows in the albums table: 31  unique artist names: 23 Primary key: id "auto_increment
the oldest release date? 1967 The most recent: 2011 */
/*SELECT `Pink Floyd`
FROM `albums`; returns unknown column. Use Select Distinct
SELECT column_artist, name WHERE column_artist = `Pink Floyd` | column2 doesn't work, neither does 'artist;
SELECT `artist`, `name` FROM `albums` WHERE `artist` = `Pink Floyd`...wrong idea, start with the albums themselves;*/

SELECT name 
    FROM albums 
    WHERE artist = 'Pink Floyd'; --I need to work on understanding when to use apostrophes or ticks
--Nevertheless, the answer is The Dark Side of the Moon and The Wall

SELECT release_date 
    FROM albums 
    WHERE name = "Sgt. Pepper's Lonely Hearts Club Band"; --1967 That went much more smoothly
    
SELECT genre
    FROM albums
    WHERE name = 'Nevermind'; --Grunge, Alternative Rock
--  ---  ----  -----  ------  --------  -----------  ------------  ----------------  ------------------
-- Which albums were released in the 1990s?

SELECT * 
    FROM albums
    WHERE release_date BETWEEN 1990 AND 1999;
/*The Bodyguard, Jagged Little Pill, Come On Over, Falling Into You, Let's Talk About Love, Dangerous, The Immaculate Collection
Titanic, Metallica, Nevermind, Supernatural */

--  ---  ----  -----  ------  --------  -----------  ------------  ----------------  ------------------
-- Which albums had less than 20 million certified sales 

SELECT name
    FROM albums
    WHERE sales < 20;
/* Grease, Bad, Sgt Pepper's, Dirty Dancing, Let's Talk About Love, Dangerous, Immaculate Collection, Abbey Road, Born in the USA, Brothers in Arms
Titanic, Nevermind, The Wall */

-- alternatively the previous problem can be coded as SELECT * FROM albums WHERE sales <= 20

-- All albums with under the Rock genre
SELECT name, artist, genre
    FROM albums
    WHERE genre = 'Rock'
-- Sgt. Pepper's Lonely Hearts Club Band, 1, Abbey Road, Born in the U.S.A., Supernatural 








