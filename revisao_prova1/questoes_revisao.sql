--  Contar o número total de clientes
SELECT
	COUNT(clientes.id) AS total_de_clientes
FROM
	clientes;

-- Contar o número total de pedidos
SELECT
	COUNT(pedidos.id) AS total_de_pedidos
FROM
	pedidos;

--  Calcular o valor total de todos os pedidos
SELECT
	SUM(produtos.preco*pedidos.quantidade) AS preco_total_pedidos
FROM
	pedidos
JOIN
	produtos ON pedidos.produto_id = produtos.id;

--  Calcular a média de preço dos produtos
SELECT
	AVG(preco) AS media_de_preco
FROM
	produtos;

--  Listar todos os clientes e seus pedidos
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

--  Listar todos os pedidos e seus produtos, incluindo pedidos sem produtos
SELECT
	pedidos.id AS pedido_id,
    produtos.nome AS produto
FROM
	pedidos
LEFT JOIN
	produtos ON produtos.id = pedidos.produto_id;

--  Listar os produtos mais caros primeiro
SELECT
	produtos.nome,
    produtos.preco
FROM
	produtos
ORDER BY preco DESC;

--  Listar os produtos com menor estoque
SELECT
	produtos.nome,
    produtos.estoque
FROM
	produtos
ORDER BY estoque;

--  Contar quantos pedidos foram feitos por cliente
SELECT
	clientes.nome AS cliente,
    COUNT(pedidos.cliente_id) AS total_pedidos
FROM
	clientes
LEFT JOIN
	pedidos ON clientes.id = pedidos.cliente_id
GROUP BY
	clientes.id, clientes.nome;


--  Contar quantos produtos diferentes foram vendidos
SELECT DISTINCT
	COUNT(pedidos.produto_id) AS qnt_pedidos
FROM
	pedidos;

--  Mostrar os clientes que não realizaram pedidos
SELECT
	clientes.nome AS cliente_sem_pedido
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
WHERE 
	pedidos.cliente_id IS NULL;

--  Mostrar os produtos que nunca foram vendidos
SELECT
	produtos.nome AS produto_nao_vendido
FROM
	produtos
LEFT JOIN	
	pedidos ON pedidos.produto_id = produtos.id
WHERE 
	pedidos.produto_id IS NULL;

--  Contar o número de pedidos feitos por dia
SELECT DISTINCT
	pedidos.data_pedido AS data_do_pedido,
	COUNT(pedidos.id) AS qnt_de_pedidos
FROM
	pedidos
GROUP BY
	pedidos.data_pedido, pedidos.id;

--  Listar os produtos mais vendidos
SELECT
	produtos.nome AS produtos,
    SUM(pedidos.quantidade) AS qnt_vendida
FROM
	produtos
LEFT JOIN 
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY 
	produtos.nome, pedidos.quantidade
ORDER BY
	qnt_vendida DESC;

--  Encontrar o cliente que mais fez pedidos
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

--  Listar os pedidos e os clientes que os fizeram, incluindo pedidos sem clientes
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

--  Listar os produtos e o total de vendas por produto
SELECT
	produtos.nome AS produto,
    COUNT(pedidos.produto_id) AS total_de_pedidos,
    SUM(pedidos.quantidade) AS unidades_vendidas
FROM
	produtos
LEFT JOIN
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY
	produtos.nome, pedidos.produto_id, pedidos.quantidade;

--  Calcular a média de quantidade de produtos por pedido
SELECT
	AVG(pedidos.quantidade)
FROM
	pedidos;

--  Listar os pedidos ordenados por data (mais recentes primeiro)
SELECT
	pedidos.data_pedido AS data,
    pedidos.id AS pedido_id
FROM
	pedidos
ORDER BY
	data DESC;

--  Contar quantos clientes possuem telefone cadastrado
SELECT
	COUNT(clientes.id) AS telefones_cadastrados
FROM
	clientes
WHERE
	clientes.telefone IS NOT NULL;

--  Encontrar o cliente que gastou mais dinheiro em pedidos.
SELECT
	clientes.nome AS cliente,
	SUM(pedidos.quantidade*produtos.preco) AS qnt_gasto_em_pedidos
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
LEFT JOIN produtos ON pedidos.produto_id = produtos.id
GROUP BY
	clientes.nome, pedidos.quantidade, produtos.preco
ORDER BY
	qnt_gasto_em_pedidos DESC
LIMIT 1;

-- Listar os 5 produtos mais vendidos.
SELECT
	produtos.nome AS produto,
    SUM(pedidos.quantidade) AS unidades_vendidas
FROM
	produtos
LEFT JOIN
	pedidos ON pedidos.produto_id = produtos.id
GROUP BY
	produtos.nome, pedidos.quantidade
ORDER BY
	unidades_vendidas DESC
LIMIT 5;

-- Listar os clientes que já fizeram pedidos e o número de pedidos de cada um.
SELECT
	clientes.nome AS cliente,
    COUNT(pedidos.cliente_id) AS qnt_de_pedidos
FROM
	clientes
JOIN 
	pedidos ON pedidos.cliente_id = clientes.id
GROUP BY
	clientes.nome, pedidos.cliente_id;

-- Encontrar a data com mais pedidos realizados
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

-- Calcular a média de valor gasto por pedido
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