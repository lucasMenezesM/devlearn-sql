-- Atualização do status de publicação de cursos e módulos. Imagine que os cursos podem ser automaticamente publicados ou desativados dependendo de um conjunto dos seguintes critérios:

-- Cursos: Se o curso tiver mais de 5 módulos publicados, ele será automaticamente publicado. Caso contrário, ele será desativado (não publicado).

-- Módulos: Se um módulo tiver mais de 3 aulas publicadas, ele será publicado. Caso contrário, ele será desativado.

UPDATE curso c
SET c.publicado = CASE 
    WHEN (SELECT COUNT(*) FROM modulo m WHERE m.id_curso = c.id_curso AND m.publicado = true) > 5 THEN true
    ELSE false
END;

UPDATE modulo m
SET m.publicado = CASE 
    WHEN (SELECT COUNT(*) FROM aula a WHERE a.id_modulo = m.id_modulo AND a.publicado = true) > 3 THEN true
    ELSE false
END;

--Progresso aula: Atualiza a coluna concluida na tabela progresso_aula, definindo-a como verdadeira (true) ou falsa (false) com base na nota do aluno na tabela avaliacao

UPDATE progresso_aula pa
JOIN aula a ON pa.id_aula = a.id_aula
JOIN curso c ON a.id_curso = c.id_curso
SET pa.concluida = CASE 
    WHEN (SELECT ac.nota 
          FROM avaliacao ac 
          WHERE ac.id_curso = c.id_curso 
            AND ac.id_usuario = pa.id_usuario) >= 60 
    THEN true 
    ELSE false 
END;
