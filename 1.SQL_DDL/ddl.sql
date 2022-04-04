SHOW TABLES;
#Shows the tables in the database.


CREATE TABLE IF NOT EXISTS movies(
    # We can use BIGINT if the Integer is expected to be long.
    # NOT NULL is not necessary because PRIMARY KEY always takes unique numbers
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(3000) NOT NULL,
    year YEAR
);
#Creates a new file called "movies" into the "movies" database.

DROP TABLE movies;
#Deletes the table.

ALTER TABLE movies ADD year YEAR NOT NULL;
#ALTER TABLE movies ADD COLUMN year INT NOT NULL AFTER title;
ALTER TABLE movies DROP COLUMN year;
ALTER TABLE movies MODIFY year INT(4);
#This alters a column without first having to drop it.

# There is hard delete and soft delete
# Soft delete is having an extra column called "deleted" that is a boolean
# and only shows stuff that has deleted as false.
# in the database the user and their info still exists.


CREATE TABLE IF NOT EXISTS directors (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(255) NOT NULL,
    movie_id INT,
    FOREIGN KEY (movie_id) REFERENCES movies(id)
);



