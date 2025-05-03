INSERT INTO organizador (nome, contato_email, telefone, cargo) 
VALUES
	('Ana Costa', 'ana.costa@example.com', '61991234567', 'professor'),
	('Bruno Souza', 'bruno.souza@example.com', '61992345678', 'aluno'),
	('Carla Lima', 'carla.lima@example.com', '61993456789', 'palestrante'),
	('Daniel Rocha', 'daniel.rocha@example.com', '61994567890', 'professor'),
	('Eduardo Dias', 'eduardo.dias@example.com', '61995678901', 'aluno'),
	('Fernanda Alves', 'fernanda.alves@example.com', '61996789012', 'palestrante'),
	('Gustavo Pereira', 'gustavo.pereira@example.com', '61997890123', 'professor'),
	('Helena Martins', 'helena.martins@example.com', '61998901234', 'aluno'),
	('Igor Santos', 'igor.santos@example.com', '61999012345', 'palestrante'),
	('Juliana Luz', 'juliana.luz@example.com', '61990123456', 'professor');

INSERT INTO evento (nome_evento, descricao, data_inicio, data_fim, local, certificado, organizador_id)
VALUES
	('Workshop de Python', 'Introdução ao Python.','2025-06-10','2025-06-12','Laboratório de Informática', TRUE, 1),
	('Palestra de IA', 'Tendências em IA.',   '2025-07-05','2025-07-05','Auditório Principal', FALSE, 2),
	('Conferência de Segurança','Segurança de redes.','2025-08-20','2025-08-22','Centro de Convenções', TRUE,  3),
	('Seminário de BD', 'Modelagem de dados.', '2025-05-15','2025-05-16','Sala 201', FALSE, 4),
	('SQL Avançado', 'Queries complexas.',  '2025-09-01','2025-09-03','Lab Banco de Dados', TRUE,  5),
	('Workshop de Redes', 'Administrar redes.',  '2025-10-10','2025-10-11','Sala 305', FALSE, 6),
	('Palestra de Cloud', 'Computação em nuvem.', '2025-11-25','2025-11-25','Auditório Nobre', FALSE, 7),
	('DevOps Conferência', 'Cultura DevOps.',     '2025-12-05','2025-12-07','Centro de Inovações', TRUE,  8),
	('Cybersegurança', 'Proteção cibernética.','2025-06-18','2025-06-19','Auditório Central', FALSE, 9),
	('Machine Learning', 'Técnicas de ML.',     '2025-07-20','2025-07-23','Lab IA',  TRUE, 10);

INSERT INTO participante (nome, email, telefone, data_inscricao, aluno_ceub)
VALUES
	('Gabriel Becker', 'gabriel.becker@sempreceub.com', '48999999999', '2025-04-25', TRUE),
    ('Ana Rubia Becker', 'anabecker@mail.br', '4899999212', '2025-04-27', FALSE),
	('Lucas Fernandes', 'lucas.fernandes@example.com', '61991234567','2025-05-01', TRUE),
	('Mariana Costa', 'mariana.costa@example.com', '61992345678','2025-05-02', FALSE),
	('Pedro Oliveira', 'pedro.oliveira@example.com', '61993456789','2025-05-03', TRUE),
	('Juliana Rocha', 'juliana.rocha@example.com', '61994567890','2025-05-04', FALSE),
	('Rafael Santos', 'rafael.santos@example.com', '61995678901','2025-05-05', TRUE),
	('Ana Paula', 'ana.paula@example.com', '61996789012','2025-05-06', FALSE),
	('Gustavo Lima', 'gustavo.lima@example.com', '61997890123','2025-05-07', TRUE),
	('Camila Alves', 'camila.alves@example.com', '61998901234','2025-05-08', FALSE),
	('Felipe Ribeiro', 'felipe.ribeiro@example.com', '61999012345','2025-05-09', TRUE),
	('Bruna Martins', 'bruna.martins@example.com', '61990123456','2025-05-10', FALSE);

INSERT INTO inscricao (id_evento, id_participante, data_inscricao, status_pagamento, kit_inscricao)
VALUES
	(1,  1, '2025-05-01', TRUE,  'sacochila'),
	(2,  2, '2025-05-02', FALSE, 'camisa'),
	(3,  3, '2025-05-03', TRUE,  'garrafa'),
	(4,  4, '2025-05-04', FALSE, 'sacochila'),
	(5,  5, '2025-05-05', TRUE,  'camisa'),
	(6,  6, '2025-05-06', FALSE, 'garrafa'),
	(7,  7, '2025-05-07', TRUE,  'sacochila'),
	(8,  8, '2025-05-08', FALSE, 'camisa'),
	(9,  9, '2025-05-09', TRUE,  'garrafa'),
	(10, 10,'2025-05-10', FALSE, 'sacochila');