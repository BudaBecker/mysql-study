-- Cria o banco
CREATE DATABASE IF NOT EXISTS Eventos;
USE Eventos;

-- Tabela organizador
CREATE TABLE organizador (
    id SERIAL PRIMARY KEY,
    nome VARCHAR(100) NOT NULL,
    contato_email VARCHAR(100) NOT NULL UNIQUE,
    telefone VARCHAR(20),
    cargo VARCHAR(11) NOT NULL,
    CONSTRAINT chk_organizador_cargo CHECK (cargo IN ('professor' , 'aluno', 'palestrante'))
);

-- Tabela evento
CREATE TABLE evento (
    id SERIAL PRIMARY KEY,
    nome_evento VARCHAR(100) NOT NULL,
    descricao TEXT,
    data_inicio DATE NOT NULL,
    data_fim DATE NOT NULL,
    local VARCHAR(255) NOT NULL,
    certificado BOOLEAN NOT NULL DEFAULT FALSE,
    organizador_id BIGINT UNSIGNED NOT NULL,
    CONSTRAINT chk_evento_datas CHECK (data_fim >= data_inicio),
    
    CONSTRAINT fk_evento_organizador FOREIGN KEY (organizador_id)
	REFERENCES organizador (id)
	ON UPDATE CASCADE ON DELETE CASCADE
);

-- Tabela participante
CREATE TABLE participante (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	email VARCHAR(100) NOT NULL UNIQUE,
	telefone VARCHAR(20),
	data_inscricao DATE NOT NULL DEFAULT (CURRENT_DATE),
	aluno_ceub BOOLEAN NOT NULL DEFAULT FALSE
);

-- Tabela inscricao
CREATE TABLE inscricao (
	id SERIAL PRIMARY KEY,
	id_evento BIGINT UNSIGNED NOT NULL,
	id_participante BIGINT UNSIGNED NOT NULL,
	data_inscricao DATE NOT NULL DEFAULT (CURRENT_DATE),
	status_pagamento  BOOLEAN NOT NULL DEFAULT FALSE,
	kit_inscricao VARCHAR(11) NOT NULL,
	CONSTRAINT chk_inscricao_kit
    CHECK (kit_inscricao IN ('sacochila','camisa','garrafa')),
	
    CONSTRAINT fk_inscricao_evento
    FOREIGN KEY (id_evento)
    REFERENCES evento(id)
	ON DELETE CASCADE,
	
    CONSTRAINT fk_inscricao_participante
    FOREIGN KEY (id_participante)
    REFERENCES participante(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);