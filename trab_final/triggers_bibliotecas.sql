-- setta data de devolucao em 7 dias
DELIMITER $$
CREATE TRIGGER trg_set_data_devolucao_prevista
	BEFORE INSERT ON emprestimos FOR EACH ROW
	BEGIN
		SET NEW.data_devolucao_prevista = CURDATE() + INTERVAL 7 DAY;
	END
$$
DELIMITER ;

-- calcula multa com atraso
DELIMITER $$
CREATE TRIGGER trg_calc_multa
	BEFORE UPDATE ON emprestimos FOR EACH ROW
	BEGIN
		IF NEW.data_devolucao_real IS NOT NULL AND NEW.data_devolucao_real > OLD.data_devolucao_prevista
        THEN
			SET NEW.multa = DATEDIFF(NEW.data_devolucao_real, OLD.data_devolucao_prevista) * 1.00;
		ELSE
			SET NEW.multa = 0.00;
		END IF;
	END
$$
DELIMITER ;

-- marca o livro como indisponivel depois de um emprestimo
DELIMITER $$
CREATE TRIGGER trg_set_livro_indisponivel
	AFTER INSERT ON emprestimos FOR EACH ROW
	BEGIN
		UPDATE livros SET disponibilidade = FALSE
		WHERE id = NEW.id_livro;
	END
$$
DELIMITER ;

-- devolve o livro como disponivel
DELIMITER $$
CREATE TRIGGER trg_set_livro_disponivel
	AFTER UPDATE ON emprestimos FOR EACH ROW
	BEGIN
		IF NEW.data_devolucao_real IS NOT NULL
        THEN
			UPDATE livros SET disponibilidade = TRUE
			WHERE id = NEW.id_livro;
		END IF;
	END
$$
DELIMITER ;

-- impede reserva duplicada
DELIMITER $$
CREATE TRIGGER trg_prevent_reserva_duplicada
	BEFORE INSERT ON reservas FOR EACH ROW
	BEGIN
		IF EXISTS (
			SELECT 1
			FROM reservas
			WHERE id_usuario = NEW.id_usuario
			AND id_livro = NEW.id_livro
			AND status_reserva = TRUE
		)
		THEN
			SIGNAL SQLSTATE '45000'
			SET MESSAGE_TEXT = 'O usuário já possui reserva ativa para este livro.';
		END IF;
	END
$$
DELIMITER ;