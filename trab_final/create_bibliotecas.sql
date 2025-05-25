DROP DATABASE bibliotecas;
CREATE DATABASE bibliotecas;
USE bibliotecas;

-- Tabela de autores
CREATE TABLE autores (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	nacionalidade VARCHAR(50) NOT NULL,
	data_nascimento DATE,
	website VARCHAR(200)
) ENGINE=InnoDB;

-- Tabela de usuários
CREATE TABLE usuarios (
	id SERIAL PRIMARY KEY,
	nome VARCHAR(100) NOT NULL,
	curso VARCHAR(50),
	RA INT,
	email VARCHAR(100) NOT NULL UNIQUE,
	telefone VARCHAR(20) NOT NULL UNIQUE,
	data_cadastro DATE NOT NULL DEFAULT (CURDATE())
) ENGINE=InnoDB;

-- Tabela de livros
CREATE TABLE livros (
	id SERIAL PRIMARY KEY,
	titulo VARCHAR(150) NOT NULL,
	edicao TINYINT DEFAULT 1,
	autor_id BIGINT UNSIGNED NOT NULL,
	ano_publicacao YEAR,
	genero VARCHAR(100),
	idioma VARCHAR(50),
	editora VARCHAR(150),
	descricao TEXT,
	disponibilidade BOOLEAN NOT NULL DEFAULT TRUE,
  CONSTRAINT fk_autor_livro FOREIGN KEY (autor_id) REFERENCES autores(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de reservas
CREATE TABLE reservas (
	id SERIAL PRIMARY KEY,
	id_usuario BIGINT UNSIGNED NOT NULL,
	id_livro BIGINT UNSIGNED NOT NULL,
	data_reserva DATE NOT NULL DEFAULT (CURDATE()),
	status_reserva BOOLEAN NOT NULL,
	CONSTRAINT fk_usuario_reserva FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_livro_reserva FOREIGN KEY (id_livro) REFERENCES livros(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;

-- Tabela de empréstimos
CREATE TABLE emprestimos (
	id SERIAL PRIMARY KEY,
	id_usuario BIGINT UNSIGNED NOT NULL,
	id_livro BIGINT UNSIGNED NOT NULL,
	data_emprestimo DATE NOT NULL DEFAULT (CURDATE()),
	data_devolucao_prevista DATE NOT NULL,
	data_devolucao_real DATE,
	multa DECIMAL(6,2) DEFAULT 0.00,
	status BOOLEAN NOT NULL,
	CONSTRAINT fk_usuario_emprestimo FOREIGN KEY (id_usuario) REFERENCES usuarios(id) ON UPDATE CASCADE ON DELETE CASCADE,
	CONSTRAINT fk_livro_emprestimo FOREIGN KEY (id_livro) REFERENCES livros(id) ON UPDATE CASCADE ON DELETE CASCADE
) ENGINE=InnoDB;