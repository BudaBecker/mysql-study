-- Q.1 Liste os cursos e suas ofertas que têm data de início entre 2023-01-01 e 2023-06-30.
SELECT
	curso.nome AS curso,
    oferta.id_oferta AS id_oferta,
    oferta.data_inicio AS inicio_oferta,
    oferta.data_fim AS fim_oferta
FROM
	curso
JOIN
	oferta ON curso.id_curso = oferta.id_curso
WHERE
	oferta.data_inicio >= '2023-01-01' AND oferta.data_fim <= '2023-06-30';

-- Q.2 Qual é o total de inscrições por tipo de público  alvo?    
SELECT
	oferta.publico_alvo AS publico_alvo,
    COUNT(oferta.publico_alvo) AS qnt_inscricoes
FROM
	oferta
JOIN 
	inscricao ON inscricao.id_oferta = oferta.id_oferta
GROUP BY
	publico_alvo;
    
-- Q.3 Quantas inscrições existem por curso?
SELECT
	curso.nome AS curso,
    COUNT(inscricao.id_inscricao) AS qnt_inscricoes
FROM
	curso
JOIN
	oferta ON oferta.id_curso = curso.id_curso
JOIN
	inscricao ON inscricao.id_oferta = oferta.id_oferta
GROUP BY curso
ORDER BY qnt_inscricoes;

-- Q.4 Liste os 10 usuários mais recentes que se inscreveram em ofertas.      
SELECT DISTINCT
	usuario
FROM(
	SELECT DISTINCT
		usuario.nome AS usuario,
		inscricao.data_inscricao
	FROM
		usuario
	JOIN 
		inscricao ON usuario.id_usuario = inscricao.id_usuario
	ORDER BY
		inscricao.data_inscricao DESC
)AS nomes
LIMIT 10;

-- Q.5 Liste os cursos que têm ofertas com inscrições de usuários que
-- nasceram entre 1980 e 2000, e calcule a média de carga horária desses cursos.
-- Além disso, ordene os resultados pela média de carga horária em
-- ordem decrescente e limite a lista aos 5 primeiros cursos.
SELECT DISTINCT
	curso.nome AS curso,
    curso.carga_horaria AS carga_horaria
FROM 
	curso
JOIN 
	oferta ON oferta.id_curso = curso.id_curso
JOIN
	inscricao ON inscricao.id_oferta = oferta.id_oferta
JOIN
	usuario ON usuario.id_usuario = inscricao.id_usuario
WHERE
	usuario.data_nascimento BETWEEN '1980-01-01' AND '2000-12-31'
ORDER BY
	carga_horaria DESC
LIMIT 5;

-- Q.6 Gere o CROSS JOIN das tabelas cursos e ofertas.
SELECT
	*
FROM
	curso
CROSS JOIN 
	oferta ON oferta.id_curso = curso.id_curso;