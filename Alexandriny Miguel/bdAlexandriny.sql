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