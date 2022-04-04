SELECT directors.name, movies.title, movies.year FROM directors JOIN movies
    ON directors.movie_id = movies.id WHERE movies.id = 1;

SELECT name, title, year FROM directors INNER JOIN movies ON directors.movie_id = movies.id;

SELECT name, title, year FROM directors LEFT JOIN movies ON directors.movie_id = movies.id;

SELECT * FROM (directors, movies) WHERE directors.movie_id = movies.id;

# Neo4j Homework
# Sign up
# Learn in sandbox
# MOVIES, STACK OVERFLOW AND +1 CHOICE
# NEXT FRIDAY