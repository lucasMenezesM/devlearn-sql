-- Criando o usuário admin
-- Concedendo todas as permissões ao admin no banco de dados 
CREATE USER 'admin'@'localhost' IDENTIFIED BY 'admin_password';

GRANT ALL PRIVILEGES ON *.* TO 'admin'@'localhost' WITH GRANT OPTION;

FLUSH PRIVILEGES;

-- Criando o user1
-- Concedendo permissões ao user1 para acessar apenas 3 tabelas
CREATE USER 'user1'@'localhost' IDENTIFIED BY 'user1_password';

GRANT SELECT, INSERT, UPDATE, DELETE ON devlearn_db.usuario TO 'user1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON devlearn_db.curso TO 'user1'@'localhost';
GRANT SELECT, INSERT, UPDATE, DELETE ON devlearn_db.matricula TO 'user1'@'localhost';

FLUSH PRIVILEGES;

-- Criando o user2
-- Concedendo permissão de leitura apenas para as colunas nome e email da tabela usuario
CREATE USER 'user2'@'localhost' IDENTIFIED BY 'user2_password';

GRANT SELECT (nome, email) ON devlearn_db.usuario TO 'user2'@'localhost';

FLUSH PRIVILEGES;

-- Criando o usuario3
-- Concedendo permissão de leitura em todas as tabelas do banco de dados
CREATE USER 'usuario3'@'localhost' IDENTIFIED BY 'usuario3_password';

GRANT SELECT ON devlearn.* TO 'usuario3'@'localhost';

FLUSH PRIVILEGES;

-- Revogando a permissão de escrita em uma tabela para usuario1
REVOKE INSERT, UPDATE, DELETE ON devlearn_db.matricula FROM 'usuario1'@'localhost';

FLUSH PRIVILEGES;
