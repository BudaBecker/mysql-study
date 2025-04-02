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
JOIN
	pedidos ON pedidos.cliente_id = clientes.id
JOIN
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
JOIN
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
	clientes.nome AS cliente
FROM
	clientes
LEFT JOIN
	pedidos ON pedidos.cliente_id = clientes.id
WHERE 
	pedidos.cliente_id IS NULL;

--  Mostrar os produtos que nunca foram vendidos
SELECT
	produtos.nome AS produto
FROM
	produtos
LEFT JOIN	
	pedidos ON pedidos.produto_id = produtos.id
WHERE pedidos.produto_id IS NULL;

--  Contar o número de pedidos feitos por dia
SELECT
	pedidos.data_pedido AS data_do_pedido,
    COUNT(*) AS qnt_de_pedidos
FROM
	pedidos
GROUP BY
	pedidos.data_pedido, pedidos.id;

--  Listar os produtos mais vendidos

--  Encontrar o cliente que mais fez pedidos

--  Listar os pedidos e os clientes que os fizeram, incluindo pedidos sem clientes

--  Listar os produtos e o total de vendas por produto

--  Calcular a média de quantidade de produtos por pedido

--  Listar os pedidos ordenados por data (mais recentes primeiro)

--  Contar quantos clientes possuem telefone cadastrado

--  Encontrar o cliente que gastou mais dinheiro em pedidos.

-- Listar os 5 produtos mais vendidos.

-- Listar os clientes que já fizeram pedidos e o número de pedidos de cada um.

-- Encontrar a data com mais pedidos realizados

-- Calcular a média de valor gasto por pedido
