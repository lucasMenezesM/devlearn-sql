INSERT INTO usuario (nome, email, senha, tipo_usuario) VALUES 
('Alice Mendes', 'alice.mendes@email.com', 'senha123', 'Professor'),
('Bruno Lima', 'bruno.lima@email.com', 'senha456', 'Aluno'),
('Camila Souza', 'camila.souza@email.com', 'senha789', 'Admin'),
('Daniel Pereira', 'daniel.pereira@email.com', 'senha321', 'Aluno');

INSERT INTO curso (titulo, descricao, publicado) VALUES 
('Desenvolvimento Web com React', 'Curso completo de desenvolvimento web utilizando React', true),
('Introdução ao Docker', 'Curso básico sobre o uso de Docker para containers', false),
('Desenvolvimento de APIs RESTful com Node.js', 'Curso sobre criação de APIs com Node.js e Express', true);

INSERT INTO categoria (nome) VALUES 
('Desenvolvimento Web'),
('DevOps'),
('Back-end');

INSERT INTO curso_categoria (id_curso, id_categoria) VALUES 
(1, 1),  -- Desenvolvimento Web com React na categoria Desenvolvimento Web
(2, 2),  -- Introdução ao Docker na categoria DevOps
(3, 3);  -- Desenvolvimento de APIs RESTful com Node.js na categoria Back-end

INSERT INTO modulo (id_curso, titulo, descricao, publicado) VALUES 
(1, 'Fundamentos do React', 'Introdução aos conceitos principais do React', true),
(1, 'Gerenciamento de Estado com Redux', 'Usando Redux para gerenciamento de estado em aplicações React', false),
(3, 'Introdução ao Node.js', 'Visão geral e primeiros passos com Node.js', true);

INSERT INTO aula (id_modulo, titulo, descricao, url_video, publicado) VALUES 
(1, 'Introdução ao JSX', 'Conceitos de JSX e como utilizá-lo no React', 'https://example.com/react-jsx', true),
(1, 'Componentes e Props', 'Criando e utilizando componentes no React', 'https://example.com/react-components', true),
(2, 'Instalando e Configurando Redux', 'Passos para instalação e configuração do Redux', 'https://example.com/redux-setup', false),
(3, 'Primeiros passos com Node.js', 'Iniciando com Node.js e o ambiente de execução', 'https://example.com/node-basics', true);

INSERT INTO atividade (id_modulo, id_aula, titulo, descricao, tipo_atividade, publicado) VALUES 
(1, 1, 'Atividade sobre JSX', 'Exercícios para prática de JSX', 'Multipla escolha', true),
(1, 2, 'Componentes e Props no React', 'Pratique o uso de componentes e props no React', 'Discursiva', true),
(3, 4, 'Atividade de APIs em Node.js', 'Desenvolva sua primeira API utilizando Node.js', 'Multipla escolha', true);

INSERT INTO resposta_atividade (id_atividade, id_usuario, resposta) VALUES 
(1, 2, true),   -- Bruno respondeu a Atividade sobre JSX
(2, 4, false);  -- Daniel respondeu a Atividade sobre Componentes e Props

INSERT INTO progresso_curso (id_usuario, id_curso, porcentagem) VALUES 
(2, 1, 50),   -- Bruno completou 50% do curso de Desenvolvimento Web com React
(4, 3, 20);   -- Daniel completou 20% do curso de Desenvolvimento de APIs com Node.js

INSERT INTO progresso_aula (id_aula, id_usuario, tempo_assistido, concluida) VALUES 
(1, 2, 45.00, true),  -- Bruno assistiu 45 minutos e concluiu a Aula de JSX
(4, 4, 20.50, false); -- Daniel assistiu 20.5 minutos da Aula de Node.js, mas não concluiu

INSERT INTO certificado (id_curso, id_usuario, codigo_certificado) VALUES 
(1, 2, 'CERT-REACT-123456'),  -- Bruno recebeu um certificado pelo curso de React
(3, 4, 'CERT-NODE-654321');  -- Daniel recebeu um certificado pelo curso de APIs com Node.js

INSERT INTO avaliacao (id_curso, id_usuario, nota, comentario) VALUES 
(1, 2, 5, 'Curso muito bom! Aprendi bastante sobre React.'),   -- Bruno avaliou o curso de React
(3, 4, 4, 'Curso de APIs em Node.js muito prático e direto.'); -- Daniel avaliou o curso de APIs com Node.js

INSERT INTO matricula (id_curso, id_usuario) VALUES 
(1, 2),  -- Bruno matriculado no curso de Desenvolvimento Web com React
(3, 4);  -- Daniel matriculado no curso de Desenvolvimento de APIs com Node.js

INSERT INTO forum (id_curso) VALUES 
(1),  -- Fórum para o curso de Desenvolvimento Web com React
(3);  -- Fórum para o curso de Desenvolvimento de APIs com Node.js

INSERT INTO forum_topico (id_forum, id_usuario_criador, titulo, conteudo) VALUES 
(1, 2, 'Dúvidas sobre Componentes no React', 'Alguém pode explicar como funciona o uso de props?'),
(2, 4, 'Problema com rotas no Node.js', 'Estou enfrentando um erro ao configurar as rotas em Node.js, alguém pode ajudar?');

INSERT INTO forum_topico_resposta (id_forum_topico, id_usuario, conteudo) VALUES 
(1, 1, 'O uso de props é bem simples. Você passa os dados de um componente pai para um filho via propriedades.'),
(2, 3, 'Verifique se você está utilizando o método HTTP correto e se as rotas estão bem definidas.');
