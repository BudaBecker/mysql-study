
# MySQL – VIEWS, GROUP BY‑HAVING, Functions, Window Functions & Triggers

> **Formato “pocket cheat‑sheet”** para consulta rápida.

---

## 1 · Views

```sql
-- criar
CREATE [OR REPLACE] VIEW relatorio_gatos AS
SELECT raca, COUNT(*) AS qtd
FROM   gatos
GROUP  BY raca;

-- consultar
SELECT * FROM relatorio_gatos;

-- atualizar a view
ALTER VIEW relatorio_gatos AS
SELECT raca, AVG(idade) AS idade_media
FROM gatos GROUP BY raca;

-- remover
DROP VIEW relatorio_gatos;
```

*Dicas*  
- Uma view pode ser **updatable** se não contiver `GROUP BY`, `DISTINCT`, agregações, subqueries etc.  
- Use `WITH CASCADED CHECK OPTION` para exigir que INSERT/UPDATE obedecem o filtro da view.  
- `ALGORITHM = MERGE | TEMPTABLE` controla como o otimizador resolve a view.

---

## 2 · GROUP BY, HAVING & WITH ROLLUP

```sql
-- agregação simples
SELECT raca, COUNT(*) AS qtd
FROM gatos
GROUP BY raca
HAVING COUNT(*) > 1;      -- filtra depois da agregação

-- subtotais e total geral
SELECT raca, COUNT(*) AS qtd
FROM gatos
GROUP BY raca WITH ROLLUP;
```

`WITH ROLLUP` adiciona linhas‑subtotal ascendentes (NULL nos níveis agrupados).  
Combine com `COALESCE()` ou `IFNULL()` para rotular o total:  
```sql
SELECT COALESCE(raca, 'TOTAL') AS raca, COUNT(*) AS qtd
FROM gatos
GROUP BY raca WITH ROLLUP;
```

---

## 3 · Stored Functions

```sql
DELIMITER //

CREATE FUNCTION idade_humana(anos_gato TINYINT)
RETURNS TINYINT
DETERMINISTIC
BEGIN
    RETURN CASE
        WHEN anos_gato = 1 THEN 15
        WHEN anos_gato = 2 THEN 24
        ELSE 24 + (anos_gato - 2) * 4
    END;
END //

DELIMITER ;
```

*Highlights*  
| Característica | Stored Function | Stored Procedure |
|----------------|-----------------|------------------|
| Retorna valor | **Sim** (`RETURN`) | Opcional (`OUT`) |
| Chamada em | `SELECT`, `WHERE`, `SET` | Via `CALL` |
| Uso comum | encapsular lógica de coluna, cálculo | tarefas administrativas |

- Marque `DETERMINISTIC` se o resultado só depender dos parâmetros → ilustra planejador.  
- Privilegiar `NOT DETERMINISTIC` quando há chamadas a funções não determinísticas (`NOW()`).  
- Defina privilégios com `CREATE FUNCTION … SQL SECURITY DEFINER`.

---

## 4 · Window Functions (MySQL 8+)

```sql
SELECT
    nome,
    idade,
    raca,
    AVG(idade) OVER (PARTITION BY raca) AS media_idade_raca,
    RANK()    OVER (ORDER BY idade DESC) AS ranking_idade
FROM gatos;
```

| Elemento | Explicação |
|----------|-----------|
| `PARTITION BY` | “Reinicia” a janela por grupo (opcional). |
| `ORDER BY`     | Define a ordem dentro da janela. |
| `ROWS BETWEEN …` | Intervalo de linhas (frame); default = `RANGE UNBOUNDED PRECEDING`. |

Exemplo de *running total*:

```sql
SELECT
    data_venda,
    valor,
    SUM(valor) OVER (ORDER BY data_venda
                     ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS acumulado
FROM vendas;
```

---

## 5 · Database Triggers

```sql
CREATE TRIGGER prevent_idade_negativa
BEFORE INSERT ON gatos
FOR EACH ROW
BEGIN
    IF NEW.idade < 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Idade não pode ser negativa';
    END IF;
END;
```

| Ponto de disparo | Momentos | Qual linha? |
|------------------|----------|-------------|
| `INSERT`, `UPDATE`, `DELETE` | `BEFORE` ou `AFTER` | `NEW` (após) / `OLD` (antes) |

Outros exemplos:

```sql
-- auditoria
CREATE TABLE log_update (
    gato_id INT,
    campo   VARCHAR(30),
    valor_antigo VARCHAR(100),
    alterado_em DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TRIGGER audit_raca_change
AFTER UPDATE ON gatos
FOR EACH ROW
BEGIN
    IF OLD.raca <> NEW.raca THEN
        INSERT INTO log_update (gato_id, campo, valor_antigo)
        VALUES (NEW.id, 'raca', OLD.raca);
    END IF;
END;
```

> **Boas práticas**  
> ‑ Mantenha as rotinas do trigger pequenas; lógica complexa → procedures.  
> ‑ Gere erros com `SIGNAL …` para reforçar regras de negócio.  
> ‑ Documente ordem de firing se existir mais de um trigger para o mesmo evento.

---

### Mini‑Checklist

1. View updatable? —> Remover agregações.  
2. Agregação avançada? —> `WITH ROLLUP` ou Window Functions.  
3. Reutilizar cálculo? —> Stored Function.  
4. Necessário total/índices por linha? —> Window Function.  
5. Regra automática por linha? —> Trigger.

---

*Happy querying!* 🚀
