SELECT year FROM movies;
SELECT title, year FROM movies;
SELECT * FROM movies WHERE year = 2000;
SELECT * FROM movies WHERE year < 2010;
SELECT * FROM movies WHERE year < NOW();
SELECT * FROM movies WHERE 1 = 1;
#This always comes back as true
SELECT * FROM movies WHERE year IS NOT NULL;

SELECT * FROM movies ORDER BY year;
SELECT * FROM movies ORDER BY year ASC;
SELECT * FROM movies ORDER BY year DESC;

INSERT INTO movies (title, year) VALUES ("The Godfather", 1998);
INSERT INTO movies VALUES ("The Godfather", 1998);
INSERT INTO movies (title) VALUES ("The Godfather II");
INSERT INTO movies (year) VALUES (2000);
#Won't work. Title is not null.