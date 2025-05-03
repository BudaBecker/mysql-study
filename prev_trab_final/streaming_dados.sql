INSERT INTO plano_assinatura (nome_plano, preco_mensal, resolucao_maxima, numero_telas, codigo_promo)
VALUES
	('Básico', 19.90, '480p',  1, NULL),
	('Padrão HD', 29.90, '720p', 2, 'PROMO720'),
	('Premium', 39.90, '1080p', 3, 'PROMO1080'),
	('Ultra HD', 49.90, '4K', 4, NULL),
	('Familiar', 34.90, '1080p', 5, NULL),
	('Estudante', 14.90, '480p', 1, NULL),
	('Empresarial', 59.90, '4K', 10, 'PROMOEMP'),
	('Cinéfila', 24.90, '1080p', 3, 'PROMOCINE'),
	('Noites', 19.90, '720p', 2, NULL),
	('Anual', 299.00, '4K', 8, 'PROMOANUAL');

INSERT INTO usuario (nome, cpf, email, telefone, plano_assinatura_id)
VALUES
	('Ana Silva', '12345678901', 'ana.silva@example.com', '+5511987654321', 1),
	('Bruno Souza', '23456789012', 'bruno.souza@example.com', '+5511998765432', 2),
	('Carla Pereira', '34567890123', 'carla.pereira@example.com', '+5511976543210', 3),
	('Eduardo Lima', '45678901234', 'eduardo.lima@example.com', '+5511934567890', 4),
	('Fernanda Costa', '56789012345', 'fernanda.costa@example.com', '+5511945678901', 5),
	('Gabriel Santos', '67890123456', 'gabriel.santos@example.com', '+5511987654300', 6),
	('Helena Rodrigues', '78901234567', 'helena.rodrigues@example.com', '+5511991234567', 7),
	('Isabela Fernandes', '89012345678', 'isabela.fernandes@example.com', '+5511932123456', 8),
	('João Pereira', '90123456789', 'joao.pereira@example.com', '+5511954321098', 9),
	('Lucas Carvalho', '01234567890', 'lucas.carvalho@example.com', '+5511965432109',10);

-- 3) popular conteudo
INSERT INTO conteudo (titulo, tipo, genero, ano_lancamento, duracao_minutos, classificacao_etaria, status_disponibilidade, disponivel_no_pais)
VALUES
	('Matrix', 'filme', 'Ação', 1999, 136, '14', 'disponivel', TRUE),
	('Breaking Bad', 'serie', 'Crime', 2008, 47, '16', 'disponivel', TRUE),
	('Inception', 'filme', 'Ficção Científica', 2010, 148, '14', 'disponivel', TRUE),
	('Stranger Things', 'serie', 'Suspense', 2016, 51, '12', 'disponivel', TRUE),
	('Avengers: Endgame', 'filme', 'Ação', 2019, 181, '12', 'indisponivel', TRUE),
	('The Office', 'serie', 'Comédia', 2005,  22, '10', 'disponivel', FALSE),
	('Parasite', 'filme', 'Thriller', 2019, 132, '16', 'disponivel', TRUE),
	('Friends', 'serie', 'Comédia', 1994,  22, '10', 'brevemente', TRUE),
	('Joker', 'filme', 'Drama', 2019, 122, '16', 'disponivel', TRUE),
	('Dark', 'serie', 'Suspense', 2017,  50, '16', 'disponivel', TRUE);

INSERT INTO historico_visualizacao (id_usuario, id_conteudo, data_visualizacao, progresso_percentual)
VALUES
	(1,  1, '2025-04-28 20:15:00', 100),
	(1,  2, '2025-04-29 18:30:00', 45),
	(2,  3, '2025-04-30 14:00:00', 75),
	(3,  4, '2025-05-01 10:15:00', 20),
	(4,  5, '2025-05-01 21:45:00', 100),
	(5,  6, '2025-05-02 08:00:00', 60),
	(6,  7, '2025-05-02 12:30:00', 95),
	(7,  8, '2025-05-02 15:20:00', 10),
	(8,  9, '2025-05-02 17:45:00', 100),
	(9, 10, '2025-05-02 19:00:00', 30);

INSERT INTO avaliacoes (id_usuario, id_conteudo, nota, comentario, data_avaliacao)
VALUES
	(1, 1, 5, 'Excelente filme, intrigante do início ao fim.', '2025-04-28 21:00:00'),
	(1, 2, 4, 'Ótima série com narrativa envolvente.', '2025-04-29 19:00:00'),
	(2, 3, 5, 'Inception é um clássico imperdível!', '2025-04-30 15:00:00'),
	(3, 4, 3, 'Série promissora mas com episódios irregulares.', '2025-05-01 11:00:00'),
	(4, 5, 4, 'Avengers surpreendeu pela grandiosidade.', '2025-05-01 22:00:00'),
	(5, 6, 2, 'The Office é engraçado mas simples.', '2025-05-02 08:30:00'),
	(6, 7, 5, 'Parasite é uma obra-prima.', '2025-05-02 13:00:00'),
	(7, 8, 1, 'Não gostei muito, esperava mais.', '2025-05-02 15:30:00'),
	(8, 9, 4, 'Joker tem performance brilhante de Joaquin Phoenix.', '2025-05-02 18:00:00'),
	(10, 5, 3, 'Bom entretenimento, mas faltou profundidade.', '2025-05-02 21:00:00');