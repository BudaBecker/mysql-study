-- Cria o banco
CREATE DATABASE IF NOT EXISTS Streaming;
USE Streaming;

-- Tabela planos
CREATE TABLE plano_assinatura (
	id SERIAL PRIMARY KEY,
	nome_plano VARCHAR(100) NOT NULL,
	preco_mensal DECIMAL(10,2) NOT NULL,
	resolucao_maxima VARCHAR(5) NOT NULL,
	numero_telas TINYINT UNSIGNED NOT NULL,
	codigo_promo CHAR(10),
    
    CONSTRAINT chk_plano_resolucao
	CHECK (resolucao_maxima IN ('480p','720p','1080p','4K')),
	
    CONSTRAINT chk_plano_telas
    CHECK (numero_telas BETWEEN 1 AND 10)
);

-- Tabela usuarios
CREATE TABLE usuario (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
    cpf CHAR(11) NOT NULL UNIQUE,
	email VARCHAR(150) NOT NULL UNIQUE,
	telefone VARCHAR(20),
	data_cadastro DATE NOT NULL DEFAULT (CURRENT_DATE),
	plano_assinatura_id BIGINT UNSIGNED NOT NULL,
	
    CONSTRAINT fk_usuario_plano
	FOREIGN KEY (plano_assinatura_id)
	REFERENCES plano_assinatura(id)
	ON UPDATE CASCADE
	ON DELETE RESTRICT
);

-- Tabela conteudos
CREATE TABLE conteudo (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(255) NOT NULL,
	tipo VARCHAR(10) NOT NULL,
	genero VARCHAR(50) NOT NULL,
	ano_lancamento YEAR NOT NULL,
	duracao_minutos SMALLINT UNSIGNED NOT NULL,
	classificacao_etaria VARCHAR(5) NOT NULL,
	status_disponibilidade VARCHAR(20) NOT NULL,
    disponivel_no_pais BOOL NOT NULL DEFAULT FALSE,

	CONSTRAINT chk_conteudo_tipo
	CHECK (tipo IN ('filme','serie')),
	CONSTRAINT chk_conteudo_status
    CHECK (status_disponibilidade IN ('disponivel','indisponivel','brevemente')),
	CONSTRAINT chk_conteudo_classif
    CHECK (classificacao_etaria IN ('Livre','10','12','14','16','18'))
);

-- Tabela historico
CREATE TABLE historico_visualizacao (
	id SERIAL PRIMARY KEY,
	id_usuario BIGINT UNSIGNED NOT NULL,
	id_conteudo BIGINT UNSIGNED NOT NULL,
	data_visualizacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
	progresso_percentual TINYINT UNSIGNED NOT NULL,

	CONSTRAINT chk_historico_progresso
	CHECK (progresso_percentual BETWEEN 0 AND 100),
	
    CONSTRAINT fk_historico_usuario
    FOREIGN KEY (id_usuario)
	REFERENCES usuario(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	
    CONSTRAINT fk_historico_conteudo
    FOREIGN KEY (id_conteudo)
	REFERENCES conteudo(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);

-- Tabela avaliacoes
CREATE TABLE avaliacoes (
	id SERIAL PRIMARY KEY,
	id_usuario BIGINT UNSIGNED NOT NULL,
	id_conteudo BIGINT UNSIGNED NOT NULL,
	nota TINYINT UNSIGNED NOT NULL,
	comentario TEXT,
	data_avaliacao DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

	CONSTRAINT chk_avaliacao_nota
	CHECK (nota BETWEEN 0 AND 5),
	
    CONSTRAINT fk_avaliacao_usuario
    FOREIGN KEY (id_usuario)
	REFERENCES usuario(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE,
	
    CONSTRAINT fk_avaliacao_conteudo
    FOREIGN KEY (id_conteudo)
	REFERENCES conteudo(id)
	ON UPDATE CASCADE
	ON DELETE CASCADE
);