create database pi;

use pi;

CREATE TABLE Usuarios (
idUsers INT PRIMARY KEY AUTO_INCREMENT,
nomeCompleto VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
dataNascimento DATE,
dtAquisicao DATETIME DEFAULT CURRENT_TIMESTAMP,
cpf CHAR(11) UNIQUE,
cnpj CHAR(14) UNIQUE,
statusConta VARCHAR(20) DEFAULT 'Ativo',
CONSTRAINT chkStatus CHECK (statusConta IN('Ativo','Inativo')),
CONSTRAINT chkEmail CHECK (email LIKE '%@%'),
CONSTRAINT chkDocumento CHECK(cpf IS NOT NULL OR cnpj IS NOT NULL)
);

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
idenficarSensor VARCHAR(50) NOT NULL,
statusVazamento VARCHAR(20) DEFAULT 'Normal',
concentracaoValor INT NOT NULL,
dataHoraLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chkconcentracaoValor CHECK (concentracaoValor >= 0 AND concentracaoValor <= 1023),
CONSTRAINT chkStatusVazamento CHECK (statusVazamento IN ('Normal', 'Alerta', 'Evacuação'))
);

CREATE TABLE Incidente (
idIncidente INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT NOT NULL,
fkUsuarioResponsavel INT,
nivelDePerigo VARCHAR(20) NOT NULL,
acaoTomada VARCHAR(150),
dataAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
dataResolucao DATETIME,
statusIncidente VARCHAR(20) DEFAULT 'Aberto',
    
CONSTRAINT fk_Incidente_Sensor FOREIGN KEY (fkSensor) REFERENCES Sensor(idSensor),
CONSTRAINT fk_Incidente_Usuario FOREIGN KEY (fkUsuarioResponsavel) REFERENCES Usuarios(idUsers),
    
CONSTRAINT chkStatusIncidente CHECK (statusIncidente IN ('Aberto', 'Em Atendimento', 'Resolvido')),
CONSTRAINT chkNivelDePerigo CHECK (nivelDePerigo IN ('Atenção', 'Perigo', 'Risco de Morte'))
);
