create database devlearn;

use devlearn;

create table usuario (
	id_usuario int auto_increment primary key,
    nome varchar(100) not null,
    email varchar(100) unique not null,
    senha varchar(255) not null,
    tipo_usuario ENUM('Professor', 'Admin', 'Aluno'),
    data_criacao datetime default current_timestamp,
    ativo boolean default true
);

create table curso (
	id_curso int auto_increment primary key,
    titulo varchar(255) not null,
    descricao varchar(255),
    data_criacao datetime default current_timestamp,
    publicado boolean default false
);
    
create table modulo (
	id_modulo int auto_increment primary key,
    id_curso int,
    titulo varchar(255) not null,
    descricao text,
    publicado boolean default false,
    foreign key (id_curso) references curso(id_curso) ON DELETE CASCADE
);
    
create table aula (
	id_aula int auto_increment primary key,
    id_modulo int,
    -- id_curso int,
    titulo varchar(255) not null,
    descricao text,
    url_video varchar(255),
    publicado boolean default false,
    foreign key (id_modulo) references modulo(id_modulo) ON DELETE CASCADE
    -- foreign key (id_curso) references modulo(id_curso) ON DELETE CASCADE
);

create table atividade (
	id_atividade int auto_increment primary key,
    id_modulo int, 
    id_aula int,
    titulo varchar(255) not null, 
    descricao text,
    data_criacao datetime default current_timestamp,
    publicado boolean default true,
    tipo_atividade ENUM('Multipla escolha', 'Discursiva'),
    foreign key (id_modulo) references modulo(id_modulo) ON DELETE SET NULL,
    foreign key (id_aula) references aula(id_aula) ON DELETE CASCADE
);
    
create table resposta_atividade (
	id_resposta_atividade int auto_increment primary key,
    id_atividade int,
    id_usuario int, 
    resposta boolean default false,
    data_envio datetime default current_timestamp,
    foreign key (id_atividade) references atividade(id_atividade) ON DELETE CASCADE,
    foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE
);
    
create table progresso_curso (
	id_progresso_curso int auto_increment primary key,
    porcentagem float default 0,
    id_usuario int,
    id_curso int,
    foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE,
    foreign key (id_curso) references curso(id_curso) ON DELETE CASCADE
);
    
create table progresso_aula (
	id_progresso_aula int auto_increment primary key,
    id_aula int, 
    id_usuario int, 
    tempo_assistido decimal(5, 2),
    concluida boolean default false,
    data_conclusao datetime,
    foreign key (id_aula) references aula(id_aula),
    foreign key (id_usuario) references usuario(id_usuario)
);

create table certificado (
	id_certificado int auto_increment primary key,
    id_curso int, 
    id_usuario int,
    codigo_certificado varchar(100) unique not null,
    foreign key (id_curso) references curso(id_curso) ON DELETE SET NULL,
    foreign key (id_usuario) references usuario(id_usuario) ON DELETE SET NULL
);

create table avaliacao (
	id_avaliacao int auto_increment primary key,
    id_curso int, 
    id_usuario int, 
    nota int check(nota >=1 and nota <=10),
    comentario text,
    data_avaliacao datetime default current_timestamp,
    foreign key (id_curso) references curso(id_curso),
    foreign key (id_usuario) references usuario(id_usuario)
);
    
create table matricula (
	id_matricula int auto_increment primary key,
    id_curso int, 
    id_usuario int,
    data_matricula datetime default current_timestamp,
    avanco_conclusao decimal(5, 2) default 0.00,
    foreign key (id_curso) references curso(id_curso) ON DELETE CASCADE,
    foreign key (id_usuario) references usuario(id_usuario) ON DELETE CASCADE
);

create table categoria (
	id_categoria int auto_increment primary key,
    nome varchar(100) not null);
    
create table curso_categoria (
	id_curso int,
    id_categoria int,
    primary key (id_curso, id_categoria),
    foreign key (id_curso) references curso(id_curso) ON DELETE CASCADE,
    foreign key (id_categoria) references categoria(id_categoria) ON DELETE CASCADE
);
    
create table forum (
	id_forum int auto_increment primary key,
    id_curso int, 
    foreign key (id_curso) references curso(id_curso)
);
    
create table forum_topico (
	id_forum_topico int auto_increment primary key,
    id_forum int,
    id_usuario_criador int,
    titulo varchar(255) not null,
    conteudo varchar(255) not null,
    data_criacao datetime default current_timestamp,
    foreign key (id_forum) references forum(id_forum),
    foreign key (id_usuario_criador) references usuario(id_usuario)
);
    
create table forum_topico_resposta (
	id_forum_topico_resposta int auto_increment primary key,
    id_forum_topico int,
    id_usuario int,
    conteudo text not null,
    data_criacao datetime default current_timestamp,
    foreign key (id_forum_topico) references forum_topico(id_forum_topico),
    foreign key (id_usuario) references usuario(id_usuario)
);

-- CRIAÇÃO DE ÍNDICES

CREATE INDEX idx_usuarios_nome_email_tipo ON usuario (nome, email, tipo_usuario);
CREATE INDEX idx_usuario_email ON usuario (email);
CREATE INDEX idx_cursos_titulo_descricao ON curso (titulo, descricao);

CREATE INDEX idx_matricula_usuario_curso ON matricula (id_usuario, id_curso);

CREATE INDEX idx_curso_categoria ON curso_categoria (id_categoria, id_curso);

CREATE INDEX idx_forums_topico_titulo_conteudo ON forum_topico (id_forum, conteudo, titulo);

CREATE INDEX idx_modulo_id_curso ON modulo (id_curso);
CREATE INDEX idx_aula_id_modulo ON aula (id_modulo);
CREATE INDEX idx_aula_publicado ON aula (publicado);
CREATE INDEX idx_atividade_id_modulo ON atividade (id_modulo);
CREATE INDEX idx_atividade_id_aula ON atividade (id_aula);

CREATE INDEX idx_resposta_atividade_id_atividade ON resposta_atividade (id_atividade);
CREATE INDEX idx_resposta_atividade_id_usuario ON resposta_atividade (id_usuario);

CREATE INDEX idx_progresso_curso_id_usuario_id_curso ON progresso_curso (id_usuario, id_curso);
CREATE INDEX idx_progresso_aula_id_usuario_id_aula ON progresso_aula (id_usuario, id_aula);

CREATE INDEX idx_certificado_usuario_curso ON certificado (id_curso, id_usuario);
CREATE INDEX idx_certificado_id_usuario ON certificado (id_usuario);
CREATE INDEX idx_certificado_id_curso ON certificado (id_curso);
CREATE INDEX idx_certificado_codigo ON certificado (codigo_certificado);

CREATE INDEX idx_avaliacao_id_curso ON avaliacao (id_curso);
CREATE INDEX idx_avaliacao_id_usuario ON avaliacao (id_usuario);
