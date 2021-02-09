use sakila;

drop table if exists films_2020;

-- Code to create a new table has been provided below.
CREATE TABLE `films_2020` (
  `film_id` smallint unsigned NOT NULL AUTO_INCREMENT,
  `title` varchar(128) NOT NULL,
  `description` text,
  `release_year` year DEFAULT NULL,
  `language_id` tinyint unsigned NOT NULL,
  `original_language_id` tinyint unsigned DEFAULT NULL,
  `rental_duration` varchar(255),
  `rental_rate` decimal(4,2),
  `length` smallint unsigned DEFAULT NULL,
  `replacement_cost` decimal(4,2) DEFAULT NULL,
  `rating` enum('G','PG','PG-13','R','NC-17') DEFAULT NULL,
  PRIMARY KEY (`film_id`),
  CONSTRAINT FOREIGN KEY (`original_language_id`) REFERENCES `language` (`language_id`) ON DELETE RESTRICT ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=1003 DEFAULT CHARSET=utf8;
-- Some details have been modified to avoid warnings. Characteristics from sakila.film have been copied.
-- The only warning ignored was 'CHARSET'. Utf8 has been kept instead of UTF8MB4 as suggested.
-- Despite these modifications, csv import failed by using commands.

-- Instructions
-- *   Add the new films to the database.
LOAD DATA INFILE '/ProgramData/MySQL/MySQL Server 8.0/Uploads/films_2020.csv'
INTO TABLE sakila.films_2020
FIELDS TERMINATED BY ',';
-- ERROR: repeatedly obtained the following error despite modifications
-- Error Code: 1366. Incorrect integer value: 'film_id' for column 'film_id' at row 1
-- No way to add it by typing commands, the only possible solution was the import wizard 
-- after dropping the films_2020 table and creating a new one (insertion didn't work either)

show variables like 'local_infile';
set global local_infile = 1; -- Local infile was already set to on, so the problem didn't come from here
 
show variables like 'secure_file_priv'; -- checks that infile used above was correct

set sql_safe_updates = 0;
-- 
select * from films_2020; -- checks that import wizard worked 

-- *   Update information on rental_duration, rental_rate, and replacement_cost.
UPDATE films_2020
SET rental_duration = 3;
UPDATE films_2020
SET replacement_cost = 8.99;
UPDATE films_2020
SET rental_rate = 2.99;

select * from films_2020; -- checks that columns have been updated