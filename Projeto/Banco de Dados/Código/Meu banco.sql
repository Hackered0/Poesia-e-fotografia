CREATE DATABASE IF NOT EXISTS fotografia_poetica;
USE fotografia_poetica;

-- Tabela poesia 
CREATE TABLE cadastro_poesia(
    id_cadastro INT PRIMARY KEY AUTO_INCREMENT,
    nome_poesia VARCHAR(45),
    dtPoesia DATE,
    conteudo_poesia VARCHAR(200),
    poesia VARCHAR(1000) 
);

-- Tabela de Usuário
CREATE TABLE usuario (
    id_usuario INT PRIMARY KEY AUTO_INCREMENT,
    nome_sobrenome VARCHAR(200),
    cpf CHAR(11) UNIQUE,
    dtNascimento DATE,
    email VARCHAR(45),
    telefone CHAR(11),
    dt_Cadastro DATETIME DEFAULT CURRENT_TIMESTAMP() -- Mostrar data e hora 
);

-- Tabela endereço 
CREATE TABLE endereco(
    id_endereco INT PRIMARY KEY AUTO_INCREMENT,
    estado VARCHAR(45),
    cidade VARCHAR(45),
    bairro VARCHAR(45),
    nome_rua VARCHAR(100),
    numero_rua VARCHAR(15),
    complemento VARCHAR(100),
    dtCadastro DATETIME DEFAULT CURRENT_TIMESTAMP(), -- Mostrar data e hora
    fk_usuario INT,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario)
);

-- Tabela de categoria da poesia
CREATE TABLE categoria (
    id_categoria INT PRIMARY KEY AUTO_INCREMENT,
    nome_categoria VARCHAR(45) NOT NULL,
    descricao_foto_poesia VARCHAR(200)
);

-- Tabela da fotografia 
CREATE TABLE fotografia (
    id_foto INT PRIMARY KEY AUTO_INCREMENT,
    titulo VARCHAR(100),
    url_arquivo VARCHAR(255) NOT NULL,
    estilo_da_fotografia VARCHAR(50),
    fk_usuario INT,
    fk_categoria INT,
    fk_cadastro INT,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_categoria) REFERENCES categoria(id_categoria),
    FOREIGN KEY (fk_cadastro) REFERENCES cadastro_poesia(id_cadastro)
);

-- Tabela comentário
CREATE TABLE comentario (
    id_comentario INT PRIMARY KEY AUTO_INCREMENT,
    comentario VARCHAR(300),
    dt_comentario DATETIME DEFAULT CURRENT_TIMESTAMP,
    fk_usuario INT,
    fk_foto INT,
    FOREIGN KEY (fk_usuario) REFERENCES usuario(id_usuario),
    FOREIGN KEY (fk_foto) REFERENCES fotografia(id_foto)
);

-- Insert  tabela usuario
INSERT INTO usuario (nome_sobrenome, cpf, dtNascimento, email, telefone) VALUES
					('João Silva', '11122233344', '1980-01-15', 'joao.silva@email.com', '11987654321'),
					('Maria Santos', '22233344455', '1992-05-20', 'maria.santos@email.com', '21976543210'),
					('Pedro Almeida', '33344455566', '1988-11-30', 'pedro.almeida@email.com', '31965432109'),
					('Ana Pereira', '44455566677', '1995-03-10', 'ana.pereira@email.com', '41954321098');

-- Insert tabela cadastro_poesia
INSERT INTO cadastro_poesia (nome_poesia, dtPoesia, conteudo_poesia, poesia) VALUES
							('O Voo da Gaivota', '2023-01-10', 'Uma poesia sobre liberdade e o mar.', 'No azul do céu, a gaivota a voar, liberdade em suas asas, a me encantar. O mar, espelho da alma, a refletir, a vida em poesia, a me sorrir.'),
							('Sussurros do Vento', '2023-02-15', 'Reflexões sobre a natureza e a passagem do tempo.', 'O vento sussurra segredos antigos, nas folhas que dançam, em seus abrigos. O tempo que passa, sem ter fim, a vida em cada sopro, a me guiar assim.'),
							('Cores do Entardecer', '2023-03-20', 'A beleza do pôr do sol e seus tons.', 'O sol se despede, em cores a pintar, o céu em aquarela, a me deslumbrar. Laranja e vermelho, em um só abraço, a alma se acalma, em seu doce compasso.'),
							('A Dança da Chuva', '2023-04-05', 'A chuva que chega e renova a vida.', 'A chuva que chega, em gotas a cair, a terra que bebe, a vida a florir. Em cada pingo, um novo começo, a dança da vida, sem ter preço.');

-- Insert tabela categoria
INSERT INTO categoria (nome_categoria, descricao_foto_poesia) VALUES
					  ('Natureza', 'Fotografias e poesias inspiradas na beleza natural.'),
					  ('Urbano', 'Imagens e versos que retratam a vida na cidade.'),
					  ('Abstrato', 'Criações que exploram formas, cores e texturas de maneira não literal.'),
					  ('Retrato', 'Foco em pessoas e suas expressões.');

-- Insert  tabela endereco
INSERT INTO endereco (estado, cidade, bairro, nome_rua, numero_rua, complemento, fk_usuario) VALUES
					 ('SP', 'São Paulo', 'Centro', 'Rua da Sé', '100', 'Apto 10', 1),
					 ('RJ', 'Rio de Janeiro', 'Copacabana', 'Av. Atlântica', '1500', 'Bloco B, Apto 501', 2),
					 ('MG', 'Belo Horizonte', 'Savassi', 'Rua Pernambuco', '300', 'Sala 20', 3),
					 ('PR', 'Curitiba', 'Batel', 'Alameda Dom Pedro II', '750', 'Casa', 4);

-- Insert para a tabela fotografia
INSERT INTO fotografia (titulo, url_arquivo, estilo_da_fotografia, fk_usuario, fk_categoria, fk_cadastro) VALUES
					   ('Pôr do Sol na Praia', 'https://example.com/fotos/por_do_sol.jpg', 'Paisagem', 1, 1, 3 ),
					   ('Rua Movimentada', 'https://example.com/fotos/rua_movimentada.jpg', 'Urbano', 2, 2, 2 ),
					   ('Gotas de Orvalho', 'https://example.com/fotos/gotas_orvalho.jpg', 'Natureza', 3, 1, 4 ),
					   ('Olhar Profundo', 'https://example.com/fotos/olhar_profundo.jpg', 'Retrato', 4, 4, 1 );

-- Insert para a tabela comentario
INSERT INTO comentario (comentario, fk_usuario, fk_foto) VALUES
					   ('Que foto incrível! A poesia combinou perfeitamente.', 1, 1),
					   ('Adorei a perspectiva urbana, muito criativo.', 2, 2),
					   ('A delicadeza das gotas é impressionante.', 3, 3),
					   ('Um retrato que transmite muita emoção.', 4, 4);

-- Selecionar todas as tabela
	SELECT * FROM usuario;
	SELECT * FROM endereco;
	SELECT * FROM cadastro_poesia;
	SELECT * FROM categoria;
	SELECT * FROM fotografia;
	SELECT * FROM comentario;
    
-- Join simples, Tabela poesia e fotografia
SELECT 
	P.nome_poesia, -- Tabela poesia 
	P.conteudo_poesia,
	P.poesia,
	F.titulo, -- Tabela fotografia
	F.url_arquivo,
	F.estilo_da_fotografia
FROM cadastro_poesia AS P
JOIN fotografia AS F
ON  F.fk_categoria = P.id_cadastro;

-- Join usuario e endereço
SELECT
U.nome_sobrenome, -- Tabela usuario
U.dtNascimento, 
U.email,
U.telefone,
E.estado,  -- Tabela endereco
E.cidade,
E.bairro, 
E.nome_rua,
E.numero_rua, 
E.complemento
FROM usuario AS U
JOIN endereco AS E
ON U.id_usuario = E.fk_usuario;


SELECT 
    P.nome_poesia,  -- Tabela poesia
    P.conteudo_poesia,
    P.poesia,
    F.titulo,  -- Tabela fotografia
    F.url_arquivo,
    F.estilo_da_fotografia,
    C.comentario -- Tabela comentario
FROM cadastro_poesia AS P
JOIN fotografia AS F
ON P.id_cadastro = F.fk_cadastro
JOIN comentario AS C  
ON F.id_foto = C.fk_foto;

-- Três tabelas, Poesia, Categoria, Fotografia
SELECT 
    P.nome_poesia, -- Tabela poesia 
    P.conteudo_poesia,
    P.poesia,
    C.nome_categoria,  -- Tabela categoria 
    C.descricao_foto_poesia,
    F.titulo,   -- Tabela fotografia
    F.url_arquivo,
    F.estilo_da_fotografia
FROM cadastro_poesia AS P
-- Primeiro ligamos a Poesia com a Fotografia
JOIN fotografia AS F ON P.id_cadastro = F.fk_cadastro
-- Depois ligamos a Fotografia com a Categoria
JOIN categoria AS C  ON F.fk_categoria = C.id_categoria;


-- Join quatro tabelas, usuario, poesia, fotografia e categoria
SELECT 
    U.nome_sobrenome, -- Tabela usuario
    U.dtNascimento, 
    U.email,
    U.telefone,
    P.nome_poesia,  -- Tabela poesia
    P.conteudo_poesia,
    P.poesia,
    F.titulo,  -- Tabela fotografia
    F.url_arquivo,
    F.estilo_da_fotografia,
    C.nome_categoria, -- Tabela categoria
    C.descricao_foto_poesia
FROM fotografia AS F
JOIN usuario AS U  
-- Primeiro ligamos a tabela usuario com a da fotografia
ON F.fk_usuario = U.id_usuario
JOIN cadastro_poesia AS P 
ON F.fk_cadastro = P.id_cadastro
-- Agora ligamos a tabela fotografia com a poesia
JOIN categoria AS C  
ON F.fk_categoria = C.id_categoria;

-- Left join
SELECT 
	P.nome_poesia, -- Tabela poesia 
	P.conteudo_poesia,
	P.poesia,
	F.titulo, -- Tabela fotografia
	F.url_arquivo,
	F.estilo_da_fotografia
FROM cadastro_poesia AS P
LEFT JOIN fotografia AS F
ON  F.fk_categoria = P.id_cadastro; -- Pega todos os dados da tabela esquerda, mesmo se estiver null

-- Três tabelas, Poesia, Categoria, Fotografia - Right join
SELECT 
    P.nome_poesia, -- Tabela poesia 
    P.conteudo_poesia,
    P.poesia,
    C.nome_categoria,  -- Tabela categoria 
    C.descricao_foto_poesia,
    F.titulo,   -- Tabela fotografia
    F.url_arquivo,
    F.estilo_da_fotografia
FROM cadastro_poesia AS P
-- Primeiro ligamos a Poesia com a Fotografia
RIGHT JOIN fotografia AS F ON P.id_cadastro = F.fk_cadastro
-- Depois ligamos a Fotografia com a Categoria
JOIN categoria AS C  ON F.fk_categoria = C.id_categoria; -- Pega todos os dados da tabela direita, mesmo se estiverem dados null, no caso
--  que o usuario não preencheu ainda.