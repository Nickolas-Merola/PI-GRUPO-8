CREATE DATABASE amoniaSense;

USE amoniaSense;

-- CRIAÇÃO TABELA USUARIO

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    ocupacao VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_usuario_email 
        CHECK (email LIKE '%@%')
);


-- CRIAÇÃO TABELA SENSOR

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    idEmpresa INT,
    nomeSensor VARCHAR(100) NOT NULL,
    modelo VARCHAR(50) DEFAULT 'MQ-2',
    equipamento VARCHAR(100),
    localizacao VARCHAR(150),
    dataInstalacao DATE,
    statusSensor VARCHAR(20) DEFAULT 'ATIVO',
    CONSTRAINT chk_sensor_status 
        CHECK (statusSensor IN ('ATIVO', 'MANUTENCAO', 'INATIVO'))
);


-- CRIAÇÃO TABELA LEITURA_SENSOR

CREATE TABLE leitura_sensor (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    idSensor INT NOT NULL,
    valorBruto DECIMAL(10,2) NOT NULL,
    vazamento BOOLEAN DEFAULT FALSE,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_resolucao DATETIME,
    ppm INT,
    CONSTRAINT fk_leitura_sensor 
        FOREIGN KEY (idSensor) REFERENCES sensor(idSensor)
);


-- EXECUÇÃO DE SCRIPTS DE INSERÇÃO TABELA USUARIO

INSERT INTO usuario 
(nome, email, senha, ocupacao) 
VALUES
('João Silva', 'joao@gmail.com', '123456', 'Técnico'),
('Maria Santos', 'maria@gmail.com', '123456', 'Gerente'),
('Carlos Oliveira', 'carlos@gmail.com', '123456', 'Operador');


-- EXECUÇÃO DE SCRIPTS DE INSERÇÃO TABELA SENSOR

INSERT INTO sensor 
(idEmpresa, nomeSensor, modelo, equipamento, localizacao, dataInstalacao, statusSensor) 
VALUES
(1, 'Sensor A', 'MQ-2', 'Tanque de Amônia', 'Setor 1', '2026-08-01', 'ATIVO'),
(1, 'Sensor B', 'MQ-2', 'Tubulação', 'Setor 2', '2026-08-05', 'ATIVO'),
(2, 'Sensor C', 'MQ-2', 'Reservatório', 'Setor 3', '2026-08-10', 'MANUTENCAO');


-- EXECUÇÃO DE SCRIPTS DE INSERÇÃO TABELA LEITURA_SENSOR

INSERT INTO leitura_sensor 
(idSensor, valorBruto, vazamento, ppm) 
VALUES
(1, 120.50, FALSE, 20),
(1, 350.80, TRUE, 80),
(2, 150.30, FALSE, 25),
(2, 500.90, TRUE, 120),
(3, 100.20, FALSE, 15);


-- EXECUÇÃO DE SCRIPTS DE SELEÇÃO TABELA USUARIO

SELECT * FROM usuario;

SELECT nome FROM usuario;

SELECT nome FROM usuario
WHERE nome = 'João Silva';

SELECT nome FROM usuario
WHERE nome != 'João Silva';

SELECT nome FROM usuario
WHERE nome LIKE 'J%';

SELECT nome FROM usuario
WHERE nome LIKE 'M%';

SELECT nome FROM usuario
WHERE idUsuario = 1 OR idUsuario = 2;

SELECT nome FROM usuario
WHERE idUsuario IN (1, 2);

SELECT nome, email FROM usuario;

SELECT nome, ocupacao FROM usuario;

SELECT email FROM usuario
WHERE email LIKE '%@%';

SELECT CONCAT(nome, ' - ', ocupacao) AS usuario_ocupacaoFROM usuario;

SELECT nome, IFNULL(ocupacao, 'Não informado') AS ocupacaoFROM usuario;


-- EXECUÇÃO DE SCRIPTS DE SELEÇÃO TABELA SENSOR

SELECT * FROM sensor;

SELECT nomeSensor FROM sensor;

SELECT nomeSensor FROM sensor
WHERE nomeSensor = 'Sensor A';

SELECT nomeSensor FROM sensor
WHERE nomeSensor != 'Sensor A';

SELECT nomeSensor FROM sensor
WHERE nomeSensor LIKE 'S%';

SELECT nomeSensor FROM sensor
WHERE idEmpresa = 1;

SELECT nomeSensor FROM sensor
WHERE idEmpresa = 1 OR idEmpresa = 2;

SELECT nomeSensor FROM sensor
WHERE idEmpresa IN (1, 2);

SELECT nomeSensor FROM sensor
WHERE statusSensor = 'ATIVO';

SELECT nomeSensor FROM sensor
WHERE statusSensor != 'ATIVO';

SELECT nomeSensor, localizacao FROM sensor;

SELECT CONCAT(nomeSensor, ' - ', localizacao) AS sensor_local FROM sensor;

SELECT nomeSensor, IFNULL(equipamento, 'Não informado') AS equipamento FROM sensor;


-- EXECUÇÃO DE SCRIPTS DE SELEÇÃO TABELA LEITURA_SENSOR

SELECT * FROM leitura_sensor;

SELECT ppm FROM leitura_sensor;

SELECT valorBruto FROM leitura_sensor;

SELECT idLeitura, ppm FROM leitura_sensor;

SELECT * FROM leitura_sensor
WHERE idSensor = 1;

SELECT * FROM leitura_sensor
WHERE idSensor = 1 OR idSensor = 2;

SELECT * FROM leitura_sensor
WHERE idSensor IN (1, 2);

SELECT * FROM leitura_sensor
WHERE vazamento = TRUE;

SELECT * FROM leitura_sensor
WHERE vazamento = FALSE;

SELECT * FROM leitura_sensor
WHERE ppm > 50;

SELECT * FROM leitura_sensor
WHERE ppm <= 50;

SELECT idLeitura, ppm,
    IFNULL(data_resolucao, 'Pendente') AS resolucao
FROM leitura_sensor;

SELECT idLeitura, ppm, 
    CASE
        WHEN ppm <= 30 THEN 'NORMAL'
        WHEN ppm <= 80 THEN 'ATENCAO'
        ELSE 'CRITICO'
    END AS nivel
FROM leitura_sensor;

SELECT idLeitura, CONCAT('Sensor ', idSensor) AS sensor
FROM leitura_sensor;


SELECT  idLeitura, ppm FROM leitura_sensor
ORDER BY ppm;

SELECT  idLeitura, ppm FROM leitura_sensor
ORDER BY ppm DESC;
