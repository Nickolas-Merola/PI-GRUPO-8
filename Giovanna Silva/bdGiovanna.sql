CREATE DATABASE amoniaSense;

USE amoniaSense;
CREATE TABLE usuario (
idUsuario INT AUTO_INCREMENT PRIMARY KEY,
nomeCompleto VARCHAR(50) NOT NULL,
email VARCHAR(50) NOT NULL UNIQUE,
senha VARCHAR(50) NOT NULL,
telefone CHAR(14) NOT NULL UNIQUE,
cpf VARCHAR(14) UNIQUE,
tipoUsuario VARCHAR(30),
dataCadastro DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chkUsuario CHECK (tipoUsuario IN ('funcionário', 'administrador')),
CONSTRAINT chkEmail CHECK (email LIKE ('%@%'))
);

INSERT INTO usuario (nomeCompleto, email, senha, telefone, cpf, tipoUsuario)  VALUES 
('Lorenzo dos Santos', 'lorenzo@gmail.com', '12345', '(11)12345-6789', '1234567891012', 'funcionário'),
('Julia Vieira', 'Julinha@gmail.com', '2345', '(12)12345-6789', '2345678910111','administrador');

ALTER TABLE usuario MODIFY nomeCompleto VARCHAR(100);

DESCRIBE usuario;

ALTER TABLE usuario MODIFY telefone CHAR(14) NULL;

ALTER TABLE usuario ADD COLUMN cargo VARCHAR(50);

UPDATE usuario SET telefone ='(11)98768-4321'
	WHERE idUsuario = 1;


CREATE TABLE sensor (
idSensor INT AUTO_INCREMENT PRIMARY KEY,
codigoIdentificador CHAR(8) UNIQUE,
nomeSensor VARCHAR (10),
localizacao VARCHAR(40) NOT NULL,
tipoSensor VARCHAR(40),
dataInstalacao DATE,
ultimaManutencao DATE,
CONSTRAINT chkNomeSensor CHECK (nomeSensor = 'MQ-2'),
CONSTRAINT chkTipoSensor CHECK (tipoSensor = 'Sensor de gás')
);

INSERT INTO sensor (codigoIdentificador, nomeSensor, localizacao, tipoSensor, dataInstalacao, ultimaManutencao) VALUES
('12345678', 'MQ-2', 'Parede Norte' ,'Sensor de gás', '2026-05-11', '2026-09-05'),
('23456789', 'MQ-2', 'Parede Leste' , 'Sensor de gás', '2026-05-11', '2026-09-05');

SELECT CONCAT('O sesor ' ,codigoIdentificador, ' está localizado na ', localizacao,'.') AS Local_Sensor FROM sensor;

CREATE TABLE leituraSensor (
idLeitura INT AUTO_INCREMENT PRIMARY KEY,
idSensor CHAR(8) NOT NULL,
nivelPPM DECIMAL(6,2) NOT NULL,
dataHora DATETIME DEFAULT CURRENT_TIMESTAMP);

    
INSERT INTO leituraSensor (idSensor, nivelPPM) VALUES
(1, 12),
(2, 24.8);
    
DESCRIBE leituraSensor;
    
SELECT * FROM leituraSensor;

SELECT 
  CONCAT('sensor:', idSensor, ' | Concentração PPM: ', nivelPPM, ' | Categoria Alerta:  ', 
  CASE 
        WHEN nivelPPM <= 10 THEN 'Normal'
        WHEN nivelPPM <= 20 THEN 'Atenção'
        WHEN nivelPPM > 20 THEN 'Crítico'
	END , ' | Data e Hora: ' ,dataHora) AS mensagem FROM leituraSensor;
