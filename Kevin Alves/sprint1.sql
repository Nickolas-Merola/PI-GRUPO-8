USE sprint1;

CREATE TABLE usuario (
idUser INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
senha VARCHAR(100) NOT NULL,
idade INT NOT NULL,
cargo VARCHAR(50)
);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
modelo CHAR(4) DEFAULT 'MQ-2',
dtInstalacao DATE NOT NULL,
statuss VARCHAR(20) DEFAULT 'ATIVO',
CONSTRAINT chkStatus CHECK(statuss IN ('ATIVO','MANUTENÇÃO','INATIVO'))
);

CREATE TABLE leitura_sensor (
idLeitura INT PRIMARY KEY AUTO_INCREMENT,
idSensor INT NOT NULL,
valorBruto INT NOT NULL,
vazamento BOOLEAN,
dtHora TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

USE sprint1;

INSERT INTO usuario (nome, email, senha, idade, cargo)
VALUES
('João Silva', 'joao@email.com', '123456', 25, 'Operador'),
('Maria Santos', 'maria@email.com', '654321', 32, 'Supervisora'),
('Carlos Oliveira', 'carlos@email.com', '123123', 28, 'Técnico'),
('Ana Souza', 'ana@email.com', '456456', 24, 'Operadora');

INSERT INTO sensor (modelo, dtInstalacao, statuss)
VALUES
('MQ-2', '2026-08-01', 'ATIVO'),
('MQ-2', '2026-08-05', 'ATIVO'),
('MQ-2', '2026-08-10', 'MANUTENÇÃO'),
('MQ-2', '2026-08-15', 'INATIVO');

INSERT INTO leitura_sensor (idSensor, valorBruto, vazamento)
VALUES
(1, 150, FALSE),
(1, 180, FALSE),
(1, 450, TRUE),
(2, 120, FALSE),
(2, 300, TRUE),
(3, 200, FALSE),
(3, 500, TRUE),
(4, 100, FALSE);

SELECT nome FROM usuario;

SELECT * FROM usuario;

SELECT nome, email, cargo
FROM usuario;

SELECT *
FROM usuario
WHERE cargo = 'Operador';

SELECT * FROM sensor;

SELECT *
FROM sensor
WHERE statuss = 'ATIVO';

SELECT *
FROM sensor
WHERE dtInstalacao > '2026-08-05';

SELECT * FROM leitura_sensor;

SELECT *
FROM leitura_sensor
WHERE vazamento = TRUE;

SELECT *
FROM leitura_sensor
WHERE valorBruto > 300;

SELECT 
    idLeitura,
    valorBruto,
    CASE
        WHEN valorBruto >= 400 THEN 'ALTO'
        WHEN valorBruto >= 200 THEN 'MÉDIO'
        ELSE 'BAIXO'
    END AS nivel
FROM leitura_sensor;

SELECT 
    CONCAT('Sensor ', idSensor, ' - ', modelo) AS sensor,
    statuss
FROM sensor;

UPDATE usuario
SET cargo = 'Gerente'
WHERE idUser = 1;

UPDATE usuario
SET idade = 26
WHERE idUser = 1;

UPDATE sensor
SET statuss = 'MANUTENÇÃO'
WHERE idSensor = 2;

UPDATE sensor
SET statuss = 'ATIVO'
WHERE idSensor = 3;

UPDATE leitura_sensor
SET valorBruto = 550,
    vazamento = TRUE
WHERE idLeitura = 3;

SELECT * FROM usuario;

SELECT * FROM sensor;

SELECT * FROM leitura_sensor;