-- 1 Relatório de Progresso de Alunos em Cursos
-- Esse relatório mostra o progresso de cada aluno em todos os cursos em que estão matriculados, exibindo o nome do aluno, o título do curso e a porcentagem de progresso.

SELECT u.nome AS nome_aluno, c.titulo AS titulo_curso, pc.porcentagem AS progresso
FROM usuario u
JOIN progresso_curso pc ON u.id_usuario = pc.id_usuario
JOIN curso c ON pc.id_curso = c.id_curso
WHERE u.tipo_usuario = 'Aluno'
ORDER BY u.nome, c.titulo;

-- 2. Relatório de Aulas Concluídas vs Total de Aulas em Cada Curso (Agrupado por Curso)
-- Relatório que exibe o número de aulas concluídas por alunos em cada curso, comparando com o número total de aulas de cada curso.

SELECT c.titulo AS titulo_curso, 
       COUNT(DISTINCT a.id_aula) AS total_aulas, 
       COUNT(DISTINCT CASE WHEN pa.concluida = true THEN pa.id_aula END) AS aulas_concluidas
FROM curso c
JOIN modulo m ON c.id_curso = m.id_curso
JOIN aula a ON m.id_modulo = a.id_modulo
LEFT JOIN progresso_aula pa ON a.id_aula = pa.id_aula
GROUP BY c.titulo;

-- 3. Relatório de Avaliação de Cursos com Média de Notas e Comentários
-- Relatório que retorna a média das avaliações e os comentários deixados pelos alunos em cada curso, exibindo o título do curso e a nota média.

SELECT c.titulo AS titulo_curso,
       AVG(a.nota) AS media_nota,
       GROUP_CONCAT(a.comentario SEPARATOR '; ') AS comentarios
FROM curso c
JOIN avaliacao a ON c.id_curso = a.id_curso
GROUP BY c.titulo
HAVING AVG(a.nota) IS NOT NULL;

-- 4. Relatório de Certificados Emitidos para Alunos (3 Tabelas)
-- Esse relatório retorna os alunos que receberam certificados, o curso correspondente e a data de matrícula do aluno nesse curso.

SELECT u.nome AS nome_aluno, c.titulo AS titulo_curso, ce.codigo_certificado, m.data_matricula
FROM usuario u
JOIN certificado ce ON u.id_usuario = ce.id_usuario
JOIN curso c ON ce.id_curso = c.id_curso
JOIN matricula m ON u.id_usuario = m.id_usuario AND c.id_curso = m.id_curso
ORDER BY u.nome, c.titulo;

-- 5. Relatório de Cursos com Módulos Não Publicados (usando CASE WHEN)
-- Esse relatório lista todos os cursos e exibe uma coluna indicando se algum módulo do curso ainda não foi publicado.

SELECT c.titulo AS titulo_curso,
       CASE 
           WHEN (SELECT COUNT(*) FROM modulo m WHERE m.id_curso = c.id_curso AND m.publicado = false) > 0 
           THEN 'Existem módulos não publicados'
           ELSE 'Todos os módulos estão publicados'
       END AS status_publicacao
FROM curso c;
