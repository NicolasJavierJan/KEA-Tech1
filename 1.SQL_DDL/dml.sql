SELECT * FROM movies;
INSERT INTO movies (title) VALUES ('Batman');
#Adding new row.
SELECT * FROM movies WHERE title = 'Spiderman';
#Selects from the database only the titles that are "Spiderman"
SELECT * FROM movies WHERE title = 'spiderman';
#Is case insensitive!!!
SELECT * FROM movies WHERE BINARY title = 'spiderman';
#Binary makes it case sensitive
INSERT INTO movies VALUES ('Interstellar');
#We have only one column, so it will add it there.
DELETE FROM movies WHERE title = 'Batman';
#Deletes every row with the title 'Batman';
DELETE FROM movies WHERE title = 'Batman' LIMIT 5;
#This deletes only five instances of that movie, in case you may have 6 and want to keep 1
SELECT * FROM movies WHERE title = 'Batman' LIMIT 1;
#Show me the first one that appears
UPDATE movies SET title = "Godzilla vs King Kong" WHERE title = "King Kong";



#CRUD
#Creation
#Read
#Update
#Delete