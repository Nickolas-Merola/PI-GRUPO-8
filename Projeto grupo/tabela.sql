CREATE DATABASE amoniaSense;

USE amoniaSense;

CREATE TABLE usuario (
    idUsuario INT PRIMARY KEY AUTO_INCREMENT,
    nome VARCHAR(150) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    senha VARCHAR(255) NOT NULL,
    ocupacao VARCHAR(100),
    data_cadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT chk_usuario_email CHECK (email LIKE '%@%')
);

INSERT INTO usuario (nome, email, senha, ocupacao) VALUES
('João Silva', 'joao@gmail.com', '123456', 'Técnico'),
('Maria Santos', 'maria@gmail.com', '123456', 'Gerente'),
('Carlos Oliveira', 'carlos@gmail.com', '123456', 'Operador');

SELECT * FROM usuario;

CREATE TABLE sensor (
    idSensor INT PRIMARY KEY AUTO_INCREMENT,
    idEmpresa INT,
    nomeSensor VARCHAR(100) NOT NULL,
    modelo VARCHAR(50) DEFAULT 'MQ-2',
    equipamento VARCHAR(100),
    localizacao VARCHAR(150),
    dataInstalacao DATE,
    statuss VARCHAR(20) DEFAULT 'ATIVO',
    CONSTRAINT chk_sensor_status CHECK (statuss IN ('ATIVO' , 'MANUTENCAO', 'INATIVO'))
);

INSERT INTO sensor (idEmpresa, nomeSensor, modelo, equipamento, localizacao, dataInstalacao, statuss) VALUES
(1, 'Sensor A', 'MQ-2', 'Tanque de Amônia', 'Setor 1', '2026-08-01', 'ATIVO'),
(1, 'Sensor B', 'MQ-2', 'Tubulação', 'Setor 2', '2026-08-05', 'ATIVO'),
(2, 'Sensor C', 'MQ-2', 'Reservatório', 'Setor 3', '2026-08-10', 'MANUTENCAO');

SELECT * FROM sensor;

SELECT * FROM sensor
WHERE statuss = 'ATIVO';

SELECT 
    CONCAT(nomeSensor, ' - ', localizacao) AS sensor_local
FROM sensor;

CREATE TABLE leitura_sensor (
    idLeitura INT PRIMARY KEY AUTO_INCREMENT,
    idSensor INT NOT NULL,
    valorBruto DECIMAL(10,2) NOT NULL,
    vazamento BOOLEAN DEFAULT FALSE,
    dtHora DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_resolucao DATETIME,
    ppm INT,
    CONSTRAINT chk_leitura_severidade CHECK (nivel_severidade IN ('NORMAL','ATENCAO','CRITICO')),
    CONSTRAINT fk_leitura_sensor FOREIGN KEY (idSensor) REFERENCES sensor(idSensor)
);

INSERT INTO leitura_sensor (idSensor, valorBruto, vazamento, ppm) VALUES
(1, 120.50, FALSE, 20),
(1, 350.80, TRUE, 80),
(2, 150.30, FALSE, 25),
(2, 500.90, TRUE, 120),
(3, 100.20, FALSE, 15);

SELECT * FROM leitura_sensor;

SELECT * FROM leitura_sensor
WHERE vazamento = TRUE;

SELECT * FROM leitura_sensor
WHERE ppm > 50;

SELECT 
    idLeitura,
    ppm,
    IFNULL(data_resolucao, 'Pendente') AS resolucao
FROM leitura_sensor;

SELECT 
    idLeitura,
    ppm,
    CASE
        WHEN ppm <= 30 THEN 'NORMAL'
        WHEN ppm <= 80 THEN 'ATENCAO'
        ELSE 'CRITICO'
    END AS nivel
FROM leitura_sensor;