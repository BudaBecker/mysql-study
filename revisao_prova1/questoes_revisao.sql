--  Ex1. Contar o número total de clientes
SELECT
	COUNT(clientes.id) AS total_de_clientes
FROM
	clientes;

-- Ex2. Contar o número total de pedidos
SELECT
	COUNT(pedidos.id) AS total_de_pedidos
FROM
	pedidos;

--  Ex3. Calcular o valor total de todos os pedidos
SELECT
	SUM(produtos.preco*pedidos.quantidade) AS preco_total_pedidos
FROM
	pedidos
JOIN
	produtos ON pedidos.produto_id = produtos.id;

--  Ex4. Calcular a média de preço dos produtos
SELECT
	AVG(preco) AS media_de_preco
FROM
	produtos;

--  Ex5. Listar todos os clientes e seus pedidos
SELECT
	clientes.nome AS cliente,
    pedidos.id AS id_pedido,
    produtos.nome AS produto
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
LEFT JOIN
	produtos ON produtos.id = pedidos.produto_id;

--  Ex6. Listar todos os pedidos e seus produtos, incluindo pedidos sem produtos
SELECT
	pedidos.id AS pedido_id,
    produtos.nome AS produto
FROM
	pedidos
LEFT JOIN
	produtos ON produtos.id = pedidos.produto_id;

--  Ex7. Listar os produtos mais caros primeiro
SELECT
	produtos.nome,
    produtos.preco
FROM
	produtos
ORDER BY preco DESC;

--  Ex8. Listar os produtos com menor estoque
SELECT
	produtos.nome,
    produtos.estoque
FROM
	produtos
ORDER BY estoque;

--  Ex9. Contar quantos pedidos foram feitos por cliente
SELECT
	clientes.nome AS cliente,
    COUNT(pedidos.cliente_id) AS total_pedidos
FROM
	clientes
LEFT JOIN
	pedidos ON clientes.id = pedidos.cliente_id
GROUP BY
	clientes.id, clientes.nome;


--  Ex10. Contar quantos produtos diferentes foram vendidos
SELECT
	COUNT(pedidos_diferentes) AS qnt_produtos_diferentes
FROM (	
    SELECT DISTINCT
		pedidos.produto_id AS pedidos_diferentes
	FROM
		pedidos
)AS pedidos;

--  Ex11. Mostrar os clientes que não realizaram pedidos
SELECT
	clientes.nome AS cliente_sem_pedido
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
WHERE 
	pedidos.cliente_id IS NULL;

--  Ex12. Mostrar os produtos que nunca foram vendidos
SELECT
	produtos.nome AS produto_nao_vendido
FROM
	produtos
LEFT JOIN	
	pedidos ON pedidos.produto_id = produtos.id
WHERE 
	pedidos.produto_id IS NULL;

--  Ex13. Contar o número de pedidos feitos por dia
SELECT DISTINCT
	pedidos.data_pedido AS data_do_pedido,
	COUNT(pedidos.data_pedido) AS qnt_de_pedidos
FROM
	pedidos
GROUP BY
	pedidos.data_pedido, pedidos.data_pedido;

--  Ex14. Listar os produtos mais vendidos
SELECT
	produtos.nome AS produtos,
    SUM(pedidos.quantidade) AS qnt_vendida
FROM
	produtos
LEFT JOIN 
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY 
	produtos.nome
ORDER BY
	qnt_vendida DESC;

--  Ex15. Encontrar o cliente que mais fez pedidos
SELECT
	clientes.nome,
    COUNT(pedidos.cliente_id) AS total_de_pedidos
FROM
	clientes
JOIN
	pedidos ON pedidos.cliente_id = clientes.id
GROUP BY
	clientes.nome, pedidos.cliente_id
ORDER BY
	total_de_pedidos DESC
LIMIT 1; -- ORDER BY e LIMIT 1 apenas para o primeiro na tabela... Caso tenhe mais de uma pessoa com o maior numero de pedidos:
-- HAVING
--    COUNT(p.cliente_id) = (SELECT MAX(pedido_count)
--                             FROM (SELECT COUNT(cliente_id) AS pedido_count
--                                   FROM pedidos
--                                   GROUP BY cliente_id) AS counts);

--  Ex16. Listar os pedidos e os clientes que os fizeram, incluindo pedidos sem clientes
SELECT
	pedidos.id AS pedido_id,
    clientes.nome AS cliente,
    produtos.nome AS produto
FROM
	pedidos
LEFT JOIN
	clientes ON clientes.id = pedidos.cliente_id
LEFT JOIN
	produtos ON produtos.id = pedidos.produto_id;

--  Ex17. Listar os produtos e o total de vendas por produto
SELECT
	produtos.nome AS produto,
    COUNT(pedidos.produto_id) AS total_de_pedidos,
    SUM(pedidos.quantidade) AS unidades_vendidas
FROM
	produtos
LEFT JOIN
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY
	produtos.nome;

--  Ex18. Calcular a média de quantidade de produtos por pedido
SELECT
	AVG(pedidos.quantidade) AS quantidade_media_por_pedido
FROM
	pedidos;

--  Ex19. Listar os pedidos ordenados por data (mais recentes primeiro)
SELECT
	pedidos.data_pedido AS data,
    pedidos.id AS pedido_id
FROM
	pedidos
ORDER BY
	data DESC;

--  Ex20. Contar quantos clientes possuem telefone cadastrado
SELECT
	COUNT(clientes.id) AS telefones_cadastrados
FROM
	clientes
WHERE
	clientes.telefone IS NOT NULL;

--  Ex21. Encontrar o cliente que gastou mais dinheiro em pedidos.
SELECT
	clientes.nome AS cliente,
	SUM(pedidos.quantidade*produtos.preco) AS qnt_gasto_em_pedidos
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
LEFT JOIN produtos ON pedidos.produto_id = produtos.id
GROUP BY
	clientes.nome
ORDER BY
	qnt_gasto_em_pedidos DESC
LIMIT 1;

-- Ex22. Listar os 5 produtos mais vendidos.
SELECT
	produtos.nome AS produto,
    SUM(pedidos.quantidade) AS unidades_vendidas
FROM
	produtos
LEFT JOIN
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY
	produtos.nome
ORDER BY
	unidades_vendidas DESC
LIMIT 5;

-- Ex23. Listar os clientes que já fizeram pedidos e o número de pedidos de cada um.
SELECT
	clientes.nome AS cliente,
    COUNT(pedidos.cliente_id) AS qnt_de_pedidos
FROM
	clientes
JOIN 
	pedidos ON pedidos.cliente_id = clientes.id
GROUP BY
	clientes.nome;

-- Ex24. Encontrar a data com mais pedidos realizados
SELECT DISTINCT
	pedidos.data_pedido AS data,
    COUNT(pedidos.data_pedido) AS qnt_pedidos
FROM 
	pedidos
GROUP BY
	pedidos.data_pedido
ORDER BY
	qnt_pedidos DESC
LIMIT 1;

-- Ex25. Calcular a média de valor gasto por pedido
SELECT
	AVG(soma_preco) AS media_por_pedido
FROM (
	SELECT
		pedidos.id AS pedido_id,
		SUM(produtos.preco*pedidos.quantidade) AS soma_preco
	FROM
		pedidos
	JOIN
		produtos ON pedidos.produto_id = produtos.id
	GROUP BY
		pedidos.id, produtos.preco
    ) AS valores_pedidos;