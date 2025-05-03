# MySQL CRUD Notes

## Databases
```sql
-- criar e remover
CREATE DATABASE nome_db;
DROP DATABASE nome_db;

-- verificar e alternar
SHOW DATABASES;
USE nome_db;
SELECT DATABASE();   -- mostra a que está em uso
```

## Data Types

| Categoria | Tipo                       | Observações rápidas                              |
|-----------|----------------------------|--------------------------------------------------|
| Numéricos | `INT`, `TINYINT`, `BIGINT` | Inteiros (- a +)                                 |
|           | `DECIMAL(p,s)`             | Dinheiro, precisoe não sofre *rounding* binário. |
|           | `FLOAT`, `DOUBLE`          | Ponto‑flutuante.                                 |
| Texto     | `CHAR(n)`                  | Tamanho fixo.                                    |
|           | `VARCHAR(n)`               | Tamanho variável.                                |
|           | `TEXT`/`MEDIUMTEXT`        | Muito texto.                                     |
| Datas     | `DATE` and `TIME`          | *yyyy‑mm‑dd* and *hh:mm:ss*                      |
|           | `DATETIME`                 | yyyy‑mm‑dd hh:mm:ss                              |
|           | `TIMESTAMP`                | Igual `DATETIME`, mas converte fuso.             |
| Binário   | `BLOB`                     | Arquivos binários (Imagens, PDFs...).            |
| Lógico    | `BOOLEAN` (`TINYINT(1)`)   | 0 / 1                                            |
---------------------------------------------------------------------------------------------
> Escolha o melhor tipo dependendo da situação, isso ajuda performance e economiza disco.

## Constraints

| Constraint     | Para quê serve                                                          | Exemplo de uso                                                 |
|----------------|-------------------------------------------------------------------------|----------------------------------------------------------------|
| `PRIMARY KEY`  | Garante unicidade e impede valores `NULL`. Cria índice automaticamente. | `id INT PRIMARY KEY`                                           |
| `NOT NULL`     | Impede valores nulos na coluna.                                         | `nome VARCHAR(50) NOT NULL`                                    |
| `UNIQUE`       | Garante que todos os valores da coluna (ou combinação) sejam distintos. | `email VARCHAR(255) UNIQUE`                                    |
| `DEFAULT`      | Define valor padrão quando `INSERT` não especifica a coluna.            | `status VARCHAR(20) DEFAULT 'ativo'`                           |
| `CHECK`        | Validação em nível de linha (MySQL 8.0 +).                              | `idade TINYINT CHECK (idade >= 0)`                             |
| `FOREIGN KEY`  | Referência a chave de outra tabela; mantém integridade relacional.      | `FOREIGN KEY (dono_id) REFERENCES donos(id) ON DELETE CASCADE` |

## Tables (DDL)
```sql
CREATE TABLE produtos (
    id INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(100) NOT NULL,
    preco DECIMAL(4,2) CHECK (preco >= 0), -- max 999.9
    fabricante VARCHAR(30) NOT NULL,
    categoria_id INT,
    criado_em DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT unicos UNIQUE (nome, fabricante), -- cria nome a constraint
    FOREIGN KEY (categoria_id)
        REFERENCES categorias(id)
        ON DELETE SET NULL
        ON UPDATE CASCADE
);

DESC produtos;  -- printa a estrutura
SHOW TABLES;
DROP TABLE produtos;
```

### Ajustes posteriores
```sql
-- Adiciona coluna com posição, valor-padrão e comentário
ALTER TABLE produtos
RENAME COLUMN fabricante TO fab,
ADD COLUMN estoque TINYINT AFTER nome,
ADD COLUMN importado BOOLEAN DEFAULT 0
COMMENT 'estoque e importado adicionados em 2025-05-01';

-- Altera restrições e tipo de uma coluna existente
ALTER TABLE produtos
ADD CONSTRAINT chk_preco_pos
CHECK (preco >= 0);

ALTER TABLE produtos
DROP CONSTRAINT chk_preco_pos;

ALTER TABLE produtos
MODIFY estoque INT UNSIGNED NOT NULL,  -- estoque maior e evita negativos
ALGORITHM= INPLACE, LOCK= NONE;  -- (MySQL 8.0) sem bloqueio de escrita

-- Remover colunas
ALTER TABLE produtos
DROP COLUMN importado,
DROP COLUMN criado_em;
```

### Chave Primaria
```sql
-- Controle dos atributos da Primary Key:
CREATE TABLE donos (
    id INT PRIMARY KEY AUTO_INCREMENT,  -- 4 bytes (-2147483648 a +2147483648)
    nome VARCHAR(50) NOT NULL
);

-- O equivalente seria:
CREATE TABLE donos (
    id SERIAL PRIMARY KEY,  -- 8 bytes (0 a 18446744073709551615)
    nome VARCHAR(50) NOT NULL
);
-- Dessa forma, MySQL ja assume o id como:
-- id BIGINT UNSIGNED NOT NULL AUTO_INCREMENT, UNIQUE KEY id (id)
```

### Chave estrangeira
```sql
-- TABELA-PAI
CREATE TABLE donos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,  -- ou SERIAL (BIGINT UNSIGNED).
    nome VARCHAR(50) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = InnoDB;  -- FK só funciona em InnoDB (storage engine do MySQL).

-- TABELA-FILHA 
CREATE TABLE gatos (
    id INT UNSIGNED NOT NULL AUTO_INCREMENT,
    nome VARCHAR(40) NOT NULL,
    dono_id INT UNSIGNED,  -- mesmo tipo da TABELA-PAI, tamanho e UNSIGNED.
    PRIMARY KEY (id),

    -- FK declarada inline: mais legível se já souber todas as colunas
    CONSTRAINT fk_gatos_donos
    FOREIGN KEY (dono_id)
    REFERENCES donos(id)
    ON UPDATE CASCADE  -- se o id do dono mudar, atualiza
    ON DELETE CASCADE  -- se o dono sumir, apaga os gatos
) ENGINE = InnoDB;

-- Exemplo de adição posterior (ALTER) se a coluna já existisse:
-- ALTER TABLE gatos
--   ADD CONSTRAINT fk_gatos_donos
--       FOREIGN KEY (dono_id) REFERENCES donos(id)
--       ON UPDATE CASCADE
--       ON DELETE CASCADE;
```

| Ação                     | Efeito prático                                                                 |
|--------------------------|--------------------------------------------------------------------------------|
| `CASCADE`                | Propaga a operação: ao atualizar/excluir o pai, o filho é atualizado/excluído. |
| `SET NULL`               | Grava `NULL` na coluna-filha (ela precisa permitir `NULL`).                    |
| `RESTRICT` / `NO ACTION` | Bloqueia a operação se existirem linhas filhas (comporta-se como padrão).      |
| `SET DEFAULT`            | Grava o valor `DEFAULT` definido na coluna (pouco usado).                      |
-------------------------------------------------------------------------------------------------------------

---

## CRUD — Create, Read, Update, Delete

### Create (INSERT)
```sql
INSERT INTO gatos (nome, raca, idade)
VALUES
    ('Mingau', 'Siamês', 3),
    ('Misty',  'Shorthair', 14);

-- inserir só alguns campos (os outros pegam DEFAULT / NULL)
INSERT INTO gatos (nome) VALUES ('Garfield');
```

### Read (SELECT)
```sql
-- tudo
SELECT * FROM gatos;

-- colunas específicas + filtro
SELECT nome, idade
FROM gatos
WHERE raca = 'Siamês' AND idade < 5;

-- ordenação e paginação
SELECT *
FROM gatos
ORDER BY idade DESC
LIMIT 10 OFFSET 20; -- “página 3” num site de 10 por vez

-- junção simples (JOIN)
SELECT g.nome, d.nome AS dono
FROM gatos g
JOIN donos d ON g.dono_id = d.id;
```

### Update
```sql
UPDATE gatos
SET raca = 'Shorthair'
WHERE raca = 'Tabby'; -- muda a raça de todos os Tabbys para Shorthair.

UPDATE gatos
SET idade = idade + 1 -- aniversário coletivo :)
WHERE criado_em < '2020-01-01';
```
>⚠️ Sem `WHERE`, **todos** os registros serão alterados!

### Delete
```sql
DELETE FROM gatos
WHERE idade < 1;

-- tudo de uma vez (use com extremo cuidado)
TRUNCATE TABLE gatos;  -- zera a tabela, auto-increment volta a 1
```
>⚠️ Sem `WHERE`, **todos** os registros serão zerados!

## Índices & Performance
```sql
-- índice simples
CREATE INDEX idx_raca ON gatos(raca);

-- índice composto (faz sentido quando a consulta filtra/ordena por ambas)
CREATE INDEX idx_raca_idade ON gatos(raca, idade);
```
>Basta lembrar que índices aceleram `SELECT`, mas tornam `INSERT/UPDATE/DELETE` um pouco mais lentos
>(manutenção do índice).

## Transações (version control)
```sql
START TRANSACTION;

UPDATE contas SET saldo = saldo - 100 WHERE id = 1;
UPDATE contas SET saldo = saldo + 100 WHERE id = 2;

COMMIT;  -- grava tudo
ROLLBACK;  -- desfaz, se algo deu errado
```
>Útil para garantir consistência quando várias tabelas/linhas precisam mudar juntas.

## Safe Updates
```sql
SET SQL_SAFE_UPDATES = 0; -- Set off
SET SQL_SAFE_UPDATES = 1; -- Set on
```

## Checklist rápido
1. Planeje o esquema.
2. Use transações.
3. Cuidado com safe updates.
4. Faça backups.
5. Use `SELECT` (teste o `WHERE`) antes de UPDATE/DELETE.
