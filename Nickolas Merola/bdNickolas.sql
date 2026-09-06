create database pi;

use pi;

-- -----------------------------------------------------------------

CREATE TABLE Locais (
idLocal INT PRIMARY KEY AUTO_INCREMENT,
nomeLocal VARCHAR(100) NOT NULL,
cidade VARCHAR(50),
cep CHAR(8),
responsavelLocal VARCHAR(50)
);

INSERT INTO Locais (nomeLocal, cidade, cep, responsavelLocal) VALUES
('Fazenda Nova Orla', 'São José', '13010111', 'Carlos Silva'),
('Abatedouro do José', 'São Paulo', '01001000', NULL),
('Dessosa Minas', 'Volta Redonda', NULL, 'Mariana Costa'),
('Fazenda Novos Ares', 'Uberlândia', '14010200', 'Roberto Almeida');

SELECT * FROM Locais;

UPDATE Locais SET responsavelLocal = 'José Fernando' WHERE idLocal = 2;

UPDATE Locais SET cep = '30120010' WHERE idLocal = 3;

ALTER TABLE Locais ADD COLUMN statusOperacao TINYINT DEFAULT 1;

ALTER TABLE Locais MODIFY COLUMN responsavelLocal VARCHAR(80);

ALTER TABLE Locais ADD COLUMN ColunaTeste VARCHAR(10);
ALTER TABLE Locais DROP COLUMN ColunaTeste;

DELETE FROM Locais WHERE idLocal = 4;

UPDATE Locais SET statusOperacao = 0 WHERE idLocal = 3;

SELECT CONCAT(
    'Frigorífico: ', nomeLocal, 
    ' | Cidade: ', IFNULL(cidade, 'Não informada'), 
    ' | CEP: ', IFNULL(cep, 'CEP Pendente'), 
    ' | Gerente: ', IFNULL(responsavelLocal, 'Aguardando contratação'),
    ' | Status: ', 
    CASE 
        WHEN statusOperacao = 1 THEN 'Ativo'
        ELSE 'Desativado'
    END
) AS 'Relatório de Unidades' 
FROM Locais;

-- -------------------------------------------------------------------------------------

CREATE TABLE Usuarios (
idUsers INT PRIMARY KEY AUTO_INCREMENT,
nomeCompleto VARCHAR(100) NOT NULL,
email VARCHAR(100) UNIQUE NOT NULL,
dataNascimento DATE,
fkLocais VARCHAR(100) NOT NULL, -- SOMENTE PARA EXEMPLIFICAÇÃO, VAI SER UTILIZADO QUANDO FOR PERMITIDO PELO DICIPLINA DE BANCO DE DADOS!!!
senha VARCHAR(255), -- Alteração para Hash para que seja possivel a criptografia das senhas quando o conteudo for disponibilizado para uso!
dtAquisicao DATETIME DEFAULT CURRENT_TIMESTAMP,
cpf CHAR(11) UNIQUE,
cnpj CHAR(14) UNIQUE,
statusConta TINYINT DEFAULT 1,
CONSTRAINT chkEmail CHECK (email LIKE '%@%'),
CONSTRAINT chkDocumento CHECK(cpf IS NOT NULL OR cnpj IS NOT NULL)
);

DESCRIBE Usuarios;

INSERT INTO Usuarios (nomeCompleto,email,dataNascimento,senha,cpf,cnpj) VALUES
('José Fernando da Silva','jose@gmail.com','1978-02-20','Senha segura 123',null,'12345678901234'),
('Pedro Afonso dos Santos','pedro.afo@gmail.com','2000-04-10','Senha segura 123','09876543211',null),
('Guilherme dos Campos','gui.campos@gmail.com','1990-10-29','Senha segura 123',null,'47294238581048'),
('Julia Miranda','julia.miranda@gmail.com','1988-07-25','Senha segura 123','98245016285',null);

SELECT * FROM Usuarios;

UPDATE Usuarios SET senha = 'Estou protegido' WHERE idUsers = 2;

UPDATE Usuarios SET senha = 'Senhas iguais' WHERE idUsers IN(3,4);

ALTER TABLE Usuarios RENAME COLUMN nomeCompleto TO Nome;

ALTER TABLE Usuarios MODIFY COLUMN Nome VARCHAR(150);

ALTER TABLE Usuarios ADD COLUMN Teste VARCHAR(10);

ALTER TABLE Usuarios DROP COLUMN Teste;

ALTER TABLE Usuarios ADD CONSTRAINT chkNome CHECK (Nome LIKE '% %');

DELETE FROM Usuarios WHERE idUsers = 4;

SELECT CONCAT('Nome do usuario: ',Nome,' | Email: ',email,' | cpf: ',IFNULL(cpf, '(Sem CPF cadastrado)'),' | cnpj: ',IFNULL(cnpj,'(Sem CNPJ cadastrado)')) AS 'Descrição' FROM Usuarios;

SELECT Nome,TIMESTAMPDIFF(YEAR,dataNascimento,now()) AS 'IDADE DO USUARIO' FROM Usuarios;

UPDATE Usuarios SET statusConta = 0 WHERE idUsers = 3;

SELECT CONCAT('Nome do usuario: ',Nome,' | Email: ',email,' | cpf: ',IFNULL(cpf, '(Sem CPF cadastrado)'),' | cnpj: ',IFNULL(cnpj,'(Sem CNPJ cadastrado)'),' | Status da Conta: ',
CASE 
WHEN statusConta = 1 THEN 'Ativo'
ELSE 'Desativado'
END) AS 'Descrição' FROM Usuarios;

TRUNCATE TABLE Usuarios;

-- -------------------------------------------------------------------------------------

CREATE TABLE Sensor (
idSensor INT PRIMARY KEY AUTO_INCREMENT,
fkLocais VARCHAR(100) NOT NULL, -- SOMENTE PARA EXEMPLIFICAÇÃO, VAI SER UTILIZADO QUANDO FOR PERMITIDO PELO DICIPLINA DE BANCO DE DADOS!!!
identificarSensor VARCHAR(50) NOT NULL,
statusVazamento VARCHAR(20) DEFAULT 'Normal',
concentracaoValor INT NOT NULL,
dataHoraLeitura DATETIME DEFAULT CURRENT_TIMESTAMP,
CONSTRAINT chkconcentracaoValor CHECK (concentracaoValor >= 0 AND concentracaoValor <= 1023),
CONSTRAINT chkStatusVazamento CHECK (statusVazamento IN ('Normal', 'Alerta', 'Evacuação'))
);
/* valorAnalogico: Recebe o sinal elétrico do Arduino (de 0 a 1023)
0    = Ar limpo (Sem amônia)
1023 = Saturação máxima (Risco extremo)
Guardamos o valor bruto para calcular o PPM com exatidão no backend. */
INSERT INTO Sensor (identificarSensor,fkLocais,concentracaoValor) VALUES 
('MQ-2','Fazenda Nova Orla',200),
('MQ-2','Abatedouro do José',400),
('MQ-2','Dessosa Minas',300),
('MQ-2','Fazenda Novos Ares',800);

SELECT * FROM Sensor;

UPDATE Sensor SET fkLocais = 'Fazenda Grupo 8' WHERE idSensor = 3;

UPDATE Sensor SET concentracaoValor = 900 WHERE idSensor = 4;

DELETE FROM Sensor WHERE idSensor = 1;

ALTER TABLE Sensor MODIFY COLUMN identificarSensor VARCHAR(40);

SELECT CONCAT('SENSOR UTILIZADO: ',identificarSensor,' | CONCENTRAÇÃO DO VALOR NO LOCAL: ',concentracaoValor,' | DATA E HORA DA LEITURA: ',dataHoraLeitura,' | STATUS VAZAMENTO: ',
CASE
	WHEN concentracaoValor <= 200 THEN 'Normal - Ar limpo'
    WHEN concentracaoValor <= 600 THEN 'Alerta - Ligar exaustores'
    ELSE 'Evacuação - Nível tóxico'
END) AS 'STATUS DA OPERAÇÃO'
FROM Sensor;


-- -------------------------------------------------------------------------------------

CREATE TABLE Incidente (
idIncidente INT PRIMARY KEY AUTO_INCREMENT,
fkSensor INT NOT NULL, -- SOMENTE PARA EXEMPLIFICAÇÃO, PARA QUANDO FOR PERMITIDO A UTILIZAÇÃO!!!
fkresponsavelLocal INT, -- SOMENTE PARA EXEMPLIFICAÇÃO, PARA QUANDO FOR PERMITIDO A UTILIZAÇÃO!!!
nivelDePerigo VARCHAR(20) NOT NULL,
acaoTomada VARCHAR(150),
dataAlerta DATETIME DEFAULT CURRENT_TIMESTAMP,
dataResolucao DATETIME,
statusIncidente VARCHAR(20) DEFAULT 'Aberto',
    
CONSTRAINT chkStatusIncidente CHECK (statusIncidente IN ('Aberto', 'Em Atendimento', 'Resolvido')),
CONSTRAINT chkNivelDePerigo CHECK (nivelDePerigo IN ('Atenção', 'Perigo', 'Risco de Morte'))
);
INSERT INTO Incidente (fkSensor, fkUsuarioResponsavel, nivelDePerigo, acaoTomada, dataResolucao, statusIncidente) VALUES 
(2, 1, 'Perigo', 'Ventilação ativada manualmente e local evacuado', '2026-09-04 10:30:00', 'Resolvido'),
(3, NULL, 'Atenção', NULL, NULL, 'Aberto'),
(4, 2, 'Risco de Morte', 'Isolamento da área e acionamento dos bombeiros', NULL, 'Em Atendimento'),
(2, NULL, 'Atenção', NULL, NULL, 'Aberto');

SELECT * FROM Incidente;

UPDATE Incidente SET fkUsuarioResponsavel = 3, statusIncidente = 'Em Atendimento' WHERE idIncidente = 2;

UPDATE Incidente SET statusIncidente = 'Resolvido', acaoTomada = 'Vazamento contido na válvula principal, bombeiros liberaram a área', dataResolucao = NOW() WHERE idIncidente = 3;

ALTER TABLE Incidente MODIFY COLUMN acaoTomada VARCHAR(255);

ALTER TABLE Incidente ADD COLUMN tempoResposta INT;
ALTER TABLE Incidente DROP COLUMN tempoResposta;

DELETE FROM Incidente WHERE idIncidente = 4;

SELECT 
    CONCAT('Alerta no Sensor ID: ',
            fkSensor,
            ' | Nível: ',
            nivelDePerigo,
            ' | Técnico: ',
            IFNULL(fkUsuarioResponsavel, '(Aguardando)'),
            ' | Ação: ',
            IFNULL(acaoTomada, '(Nenhuma ação registrada)'),
            ' | Status da Ocorrência: ',
            CASE
                WHEN statusIncidente = 'Aberto' THEN 'REQUER ATENÇÃO IMEDIATA'
                WHEN statusIncidente = 'Em Atendimento' THEN 'EQUIPE NO LOCAL'
                ELSE 'PROBLEMA RESOLVIDO'
            END) AS 'Painel de Monitoramento'
FROM
    Incidente;

SELECT idIncidente, nivelDePerigo, 
    DATE_FORMAT(dataAlerta, '%d/%m/%Y %H:%i') AS 'Data do Alerta',
    TIMESTAMPDIFF(HOUR, dataAlerta, NOW()) AS 'Horas desde o disparo'
FROM Incidente
WHERE statusIncidente != 'Resolvido';

-- ---------------------------------------------------------------------------------