CREATE DATABASE amoniaSense;
USE amoniaSense;

CREATE TABLE usuario(
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR (50) NOT NULL,
email VARCHAR (50) NOT NULL,
CONSTRAINT chk_email CHECK ( email LIKE '%@%'),
CONSTRAINT uk_email UNIQUE (email),
ocupacao VARCHAR (20)
);

CREATE TABLE sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
nomeSensor VARCHAR (30) NOT NULL,
dataInstalacao DATE,
marca VARCHAR (20),
modelo VARCHAR (15),
peso DECIMAL (6,2),
sensibilidade DECIMAL(6,2),
statuss VARCHAR (15) DEFAULT 'Inativo',
CONSTRAINT chk_statuss CHECK(statuss IN ('Ativo','Inativo','Manutenção'))
);

CREATE TABLE leituraSensor(
idLeituraSensor INT PRIMARY KEY AUTO_INCREMENT,
idSensor INT NOT NULL,
nivelAmonia DECIMAL(6,2) NOT NULL,
vazamento BOOLEAN,
dataHora DATETIME NOT NULL
);

INSERT INTO usuario (nome, email, ocupacao)
VALUES
('Carlos Silva', 'carlos.silva@email.com', 'Supervisor'),
('Mariana Santos', 'mariana.santos@email.com', 'Gestora');

INSERT INTO sensor 
(nomeSensor, dataInstalacao, marca, modelo, peso, sensibilidade, statuss)
VALUES
('Sensor Desossa 01', '2026-08-01', 'MQ', 'MQ-2', 0.050, 0.30, 'Ativo'),
('Sensor Desossa 02', '2026-08-01', 'MQ', 'MQ-2', 0.050, 0.30, 'Ativo'),
('Sensor Desossa 03', '2026-08-05', 'MQ', 'MQ-2', 0.050, 0.30, 'Inativo');

INSERT INTO leituraSensor 
(idSensor, nivelAmonia, vazamento, dataHora)
VALUES
(1, 5.20, FALSE, '2026-09-10 08:00:00'),
(1, 6.10, FALSE, '2026-09-10 08:00:02'),
(1, 7.50, FALSE, '2026-09-10 08:00:04'),
(1, 10.30, TRUE, '2026-09-10 08:00:06');

SELECT * FROM usuario;
SELECT * FROM sensor;
SELECT * FROM leituraSensor;

ALTER TABLE usuario ADD telefone VARCHAR(15);

UPDATE usuario SET ocupacao = 'Supervisor'
WHERE idUsuario = 1;

ALTER TABLE sensor MODIFY modelo VARCHAR(30);

DROP TABLE sensor, leituraSensor, usuario;