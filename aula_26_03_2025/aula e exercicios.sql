-- INNER JOIN
SELECT * FROM directors as d INNER JOIN movies as m ON d.id = m.director_id;

-- LEFT JOIN
SELECT * FROM movies as m LEFT JOIN directors as d ON m.director_id = d.id;

-- RIGHT JOIN
SELECT * FROM movies as m RIGHT JOIN directors as d ON m.director_id = d.id;

-- Exercicios:
-- 1) Liste todos os diretores e os filmes que eles dirigiram
SELECT
    d.name,
    m.name
FROM
    directors AS d
LEFT JOIN
    movies AS m ON d.id = m.director_id;

-- 2) Liste todos os filmes e seus tickets vendidos
SELECT 
	movies.name AS filme,
    COUNT(tickets.movie_id) AS qnt_ticket
FROM 
	movies 
LEFT JOIN tickets ON movies.id = tickets.movie_id
GROUP BY
	movies.id, movies.name;


-- 3) Liste todos os filmes, seus diretores e os tickets vendidos
SELECT
    movies.name AS filme,
    directors.name AS diretor,
    COUNT(tickets.id) AS tickets_vendidos
FROM
    movies
LEFT JOIN
    directors ON movies.director_id = directors.id
LEFT JOIN
    tickets ON tickets.movie_id = movies.id
GROUP BY
	movies.id, directors.name;


-- 4) Liste todos os diretores, incluindo aqueles que não dirigiram nenhum filme
SELECT 
	directors.name
FROM 
	directors;

-- 5) Liste todos os filmes, incluindo aqueles que não têm um diretor associado
SELECT 
	movies.name 
FROM 
	movies;

-- 6) Liste todos os filmes que têm tickets e seus diretores, incluindo os filmes sem tickets
SELECT 
	movies.name AS filme,
    directors.name AS diretor
FROM 
	movies 
LEFT JOIN 
	directors ON movies.director_id = directors.id;

-- 7) Liste todos os filmes que têm tickets e seus diretores, incluindo os diretores sem filmes
SELECT
    movies.name AS filme,
    directors.name AS diretor
FROM
    movies
JOIN
    tickets ON movies.id = tickets.movie_id
RIGHT JOIN
    directors ON movies.director_id = directors.id;

-- 8) Liste todos os filmes que não têm tickets e seus diretores
SELECT 
	movies.name AS filme,
    directors.name AS diretor
FROM 
	movies 
LEFT JOIN 
	tickets ON tickets.movie_id = movies.id 
LEFT JOIN 
	directors ON directors.id = movies.director_id
WHERE 
	tickets.id IS NULL;

-- 9) Liste todos os diretores, incluindo aqueles que não dirigiram nenhum filme, e os filmes que têm tickets
SELECT
    directors.name AS diretor,
    movies.name AS filme
FROM
    directors
LEFT JOIN
    movies ON directors.id = movies.director_id
WHERE
    movies.id IN (SELECT DISTINCT movie_id FROM tickets)
    OR movies.id IS NULL;


-- 10) Liste todos os filmes que têm tickets e seus diretores
SELECT DISTINCT
	movies.name AS filme,
    directors.name AS diretor
FROM 
	movies
JOIN 
	tickets ON movies.id = tickets.movie_id
JOIN 
	directors ON directors.id = movies.director_id;

-- 11) Liste todos os filmes e seus diretores, incluindo os filmes sem diretores
SELECT
	movies.name,
    directors.name
FROM 
	movies
LEFT JOIN
	directors ON movies.director_id = directors.id;