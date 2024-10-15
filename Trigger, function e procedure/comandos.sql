-- Trigger para Atualizar o Progresso do Curso Quando o Progresso de uma Aula É Atualizado

DELIMITER //

CREATE TRIGGER atualizar_progresso_curso 
AFTER UPDATE ON progresso_aula
FOR EACH ROW
BEGIN
    DECLARE total_aulas INT;
    DECLARE aulas_concluidas INT;
    DECLARE progresso_total DECIMAL(5, 2);

    -- Contando o número total de aulas no curso
    SELECT COUNT(*) INTO total_aulas
    FROM aula
    WHERE id_curso = (SELECT id_curso FROM modulo WHERE 
    id_modulo = (SELECT id_modulo FROM aula WHERE id_aula = NEW.id_aula));

    -- Contando o número de aulas concluídas pelo usuário
    SELECT COUNT(*) INTO aulas_concluidas
    FROM progresso_aula 
    WHERE id_usuario = NEW.id_usuario AND concluida = true AND id_aula 
    IN (SELECT id_aula FROM aula WHERE id_curso = (SELECT id_curso FROM modulo 
    WHERE id_modulo = (SELECT id_modulo FROM aula WHERE id_aula = NEW.id_aula)));

    -- Calculando o progresso total
    SET progresso_total = (aulas_concluidas / total_aulas) * 100;

    -- Atualizando a tabela progresso_curso
    UPDATE progresso_curso SET porcentagem = progresso_total
    WHERE id_usuario = NEW.id_usuario 
    AND id_curso = (SELECT id_curso FROM modulo 
    WHERE id_modulo = (SELECT id_modulo FROM aula WHERE id_aula = NEW.id_aula));
END//

DELIMITER ;



-- Function para Gerar o Código de Certificado

DELIMITER //

CREATE FUNCTION gerar_codigo_certificado(id_curso INT, id_usuario INT) 
RETURNS VARCHAR(100) DETERMINISTIC
BEGIN
    DECLARE codigo VARCHAR(100);
    SET codigo = CONCAT('CERT-', id_curso, '-', id_usuario, '-', LEFT(UUID(), 8));
    RETURN codigo;
END//

DELIMITER ;

-- Procedure para Enviar Certificado ao Aluno Quando Curso É Concluído

DELIMITER //

CREATE PROCEDURE emitir_certificado(IN id_usuario INT, IN id_curso INT)
BEGIN
    DECLARE progresso DECIMAL(5, 2);
    DECLARE certificado_existente INT;
    DECLARE codigo_certificado VARCHAR(100);

    -- Verifica se o aluno já concluiu o curso (progresso 100%)
    SELECT porcentagem INTO progresso 
    FROM progresso_curso 
    WHERE id_usuario = id_usuario AND id_curso = id_curso;

    IF progresso = 100 THEN
        -- Verifica se o aluno já possui um certificado emitido para esse curso
        SELECT COUNT(*) INTO certificado_existente 
        FROM certificado 
        WHERE id_usuario = id_usuario AND id_curso = id_curso;

        IF certificado_existente = 0 THEN
            -- Gera o código do certificado
            SET codigo_certificado = gerar_codigo_certificado(id_curso, id_usuario);

            -- Insere o certificado na tabela
            INSERT INTO certificado (id_curso, id_usuario, codigo_certificado) 
            VALUES (id_curso, id_usuario, codigo_certificado);

            -- Mensagem de sucesso
            SELECT 'Certificado emitido com sucesso!' AS resultado;
        ELSE
            -- Mensagem de que o certificado já foi emitido
            SELECT 'Certificado já foi emitido para este aluno e curso.' AS resultado;
        END IF;
    ELSE
        -- Mensagem de que o curso não foi concluído
        SELECT 'Curso ainda não concluído pelo aluno.' AS resultado;
    END IF;
END//

DELIMITER ;

-- Trigger para Prevenir Exclusão de Curso Se Existirem Matrículas Ativas

DELIMITER //

CREATE TRIGGER prevenir_exclusao_curso
BEFORE DELETE ON curso
FOR EACH ROW
BEGIN
    DECLARE matriculas_ativas INT;

    -- Verifica se existem alunos matriculados no curso
    SELECT COUNT(*) INTO matriculas_ativas 
    FROM matricula 
    WHERE id_curso = OLD.id_curso;

    IF matriculas_ativas > 0 THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Não é possível excluir o curso, pois existem alunos matriculados.';
    END IF;
END//

DELIMITER ;
