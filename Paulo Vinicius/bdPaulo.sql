CREATE DATABASE amoniasense;

USE amoniasense;

CREATE TABLE usuarios (
idUsuario INT PRIMARY KEY AUTO_INCREMENT,
idEmpresa INT NOT NULL,
nome VARCHAR(40) NOT NULL,
email VARCHAR(40) UNIQUE NOT NULL,
senha CHAR(12) NOT NULL,
CONSTRAINT checkEmail CHECK(email LIKE '%@%'),
ocupacao VARCHAR(40),
tipo_perfil VARCHAR(25) NOT NULL,
CONSTRAINT checkPerfil CHECK(tipo_perfil IN('Super-Administrador','Administrador Cliente','Operador Cliente')),
data_cadastro DATE DEFAULT (CURDATE()),
statusUsuario TINYINT NOT NULL,
CONSTRAINT checkStatus CHECK(statusUsuario IN(0,1))
);

INSERT INTO usuarios(idEmpresa, nome, email, senha, ocupacao, tipo_perfil, statusUsuario) VALUES
	(1,'Alexandriny Santos','alexandriny.santos@amoniasense.com','amonia@123','Desenvolvedor Front-End Sênior','Super-Administrador',1),
    (1,'Ana Beatriz','ana.beatriz@amoniasense.com','amonia@123','Gerente de Suporte','Super-Administrador',1),
	(1,'Giovanna Carneiro','giovanna.carneiro@amoniasense.com','amonia@123','Engenheiro de Confiabilidade','Super-Administrador',1),
    (1,'Guilherme Breda','guilherme.breda@amoniasense.com','amonia@123','Analista de Segurança da Informação', 'Super-Administrador',1),
    (1,'Gustavo Silva','gustavo.silva@amoniasense.com','amonia@123','Desenvolvedor Back-End Sênior', 'Super-Administrador',1),
	(1,'Kevin Alves','kevin.alves@amoniasense.com','amonia@123','Engenheiro de Dados','Super-Administrador',1),
	(1,'Nickolas Merola','nickolas.merola@amoniasense.com','amonia@123','Engenheiro DevOps','Super-Administrador',1),
	(1,'Paulo Araujo','paulo.araujo@amoniasense.com','amonia@123','Desenvolvedor Back-End Sênior', 'Super-Administrador',1),
	(1,'Vitor Dias','vitor.dias@amoniasense.com','amonia@123','Analista de Suporte Avançado', 'Super-Administrador',1);
    
SELECT * FROM usuarios;

INSERT INTO usuarios(idEmpresa, nome, email, senha, ocupacao, tipo_perfil, statusUsuario) VALUES
	(2,'Aline Ferreira','aline.ferreira@ourobeef.com','ourobeef@123','Gerente de Infraestrutura e TI','Administrador Cliente',1),
	(2,'Fernando Ribeiro','fernando.ribeiro@ourobeef.com','ourobeef@123','Engenheiro de Segurança do Trabalho','Administrador Cliente',1),
	(2,'Marcos Souza','marcos.souza@ourobeef.com','ourobeef@123','Diretor de Operações Industriais','Administrador Cliente',1),
	(2,'Bruno Motta','bruno.motta@ourobeef.com','ourobeef@123','Supervisor de Automação Industrial','Operador Cliente',1),
	(2,'Thiago Oliveira','thiago.oliveira@ourobeef.com','ourobeef@123','Técnico em Refrigeração Industrial','Operador Cliente',1),
	(2,'Beatriz Cruz','beatriz.cruz@ourobeef.com','ourobeef@123','Auditora de Compliance e Meio Ambiente','Operador Cliente',1),
	(2,'Henrique Freitas','henrique.freitas@ourobeef.com','ourobeef@123','Chefe da Brigada de Incêndio','Operador Cliente',1),
	(2,'Lucas Alencar','lucas.alencar@ourobeef.com','ourobeef@123','Analista de Suporte de Automação','Operador Cliente',1),
	(2,'Laura Alves','laura.alves@ourobeef.com','ourobeef@123','Técnica de Segurança do Trabalho','Operador Cliente',1),
	(2,'Clarice Mendes','clarice.mendes@ourobeef.com','ourobeef@123','Médica do Trabalho','Operador Cliente',1);
    

-- EXIBE USUARIOS DA EMPRESA ID1 (AMONIA SENSE)
SELECT * FROM usuarios WHERE idEmpresa = 1;

-- EXIBE USUARIOS DA EMPRESA ID2 (OUROBEEF)
SELECT * FROM usuarios WHERE idEmpresa = 2;

-- EXIBE USUARIOS COM TIPO DE ACESSO SUPER ADMINISTRADOR
SELECT * FROM usuarios WHERE tipo_perfil = 'Super-Administrador';

-- EXIBE USUARIOS COM TIPO DE ACESSO ADMINISTRADOR CLIENTE
SELECT * FROM usuarios WHERE tipo_perfil = 'Administrador Cliente';

-- EXIBE USUARIOS COM TIPO DE ACESSO OPERADOR CLIENTE
SELECT * FROM usuarios WHERE tipo_perfil = 'Operador Cliente';

-- EXIBE TABELA FORMATADA: DESCRIÇÃO DE USUÁRIO, SEU CARGO E SEU TIPO DE ACESSO
SELECT concat('O usuário ', nome, ' ocupa o cargo ', ocupacao, ' e tem acesso como ', tipo_perfil) AS Descrição FROM usuarios;

-- EXIBE TABELA FORMATADA: MODELO SIMPLES
SELECT idUsuario AS 'Identificação do Usuário', idEmpresa AS 'Identificação da Empresa', nome AS 'Nome do Usuário', email AS 'E-mail', ocupacao AS 'Cargo',
	CASE
		WHEN statusUsuario =0 THEN 'Inativo'
		ELSE 'Ativo'
		END AS 'Status de Cadastro'
        FROM usuarios;
        
-- EXIBE TABELA FORMATADA: MODELO INTERMEDIÁRIO
SELECT idUsuario AS 'Identificação do Usuário', 
	CASE
		WHEN idEmpresa =1 THEN 'AmoniaSense'
		WHEN idEmpresa =2 THEN 'OuroBeef'
        ELSE NULL
		END AS 'Identificação da Empresa', nome AS 'Nome do Usuário', email AS 'E-mail', ocupacao AS 'Cargo', tipo_perfil AS 'Tipo de Acesso',
	CASE
		WHEN statusUsuario =0 THEN 'Inativo'
		ELSE 'Ativo'
		END AS 'Status de Cadastro'
        FROM usuarios;
        
-- EXIBE TABELA FORMATADA: MODELO AVANÇADO
SELECT idUsuario AS 'Identificação do Usuário', 
	CASE
		WHEN idEmpresa =1 THEN 'AmoniaSense'
		WHEN idEmpresa =2 THEN 'OuroBeef'
        ELSE NULL
		END AS 'Identificação da Empresa', nome AS 'Nome do Usuário', email AS 'E-mail', senha AS Senha, ocupacao AS 'Cargo', tipo_perfil AS 'Tipo de Acesso', DATE_FORMAT(data_cadastro, '%d/%m/%Y') AS 'Data de Cadastro',
	CASE
		WHEN statusUsuario =0 THEN 'Inativo'
		ELSE 'Ativo'
		END AS 'Status de Cadastro'
        FROM usuarios;


-- EXIBE USUÁRIOS ATIVOS DA EMPRESA DE ID1 (AMONIASENSE)
SELECT concat('O usuario ', nome, ' está ', 
	CASE
		WHEN statusUsuario =0 THEN 'Inativo'
		ELSE 'Ativo'
		END, ' na plataforma.') AS 'Descrição de Status'
	FROM usuarios;

-- EXIBE USUÁRIOS ATIVOS DA EMPRESA DE ID2 (OUROBEEF)
SELECT concat('O usuario ', nome, ' está ', 
		CASE
			WHEN statusUsuario =0 THEN 'Inativo'
			ELSE 'Ativo'
			END, ' na plataforma.') AS 'Descrição de Status'
FROM usuarios WHERE idEmpresa=2;

CREATE TABLE monitoramento (
idSensor INT PRIMARY KEY AUTO_INCREMENT NOT NULL,
idEmpresa INT NOT NULL,
modelo VARCHAR(20),
status_sensor TINYINT NOT NULL,
CONSTRAINT checkStatusSensor CHECK(status_sensor IN(0,1)),
nome VARCHAR(40),
setor VARCHAR(30),
localizacao VARCHAR(30),
leitura INT NOT NULL,
data_leitura DATETIME DEFAULT NOW() NOT NULL,
ultima_manutencao DATE,
proxima_manutencao DATE
);

INSERT INTO monitoramento (idEmpresa, modelo, status_sensor, nome, setor, localizacao, leitura, ultima_manutencao, proxima_manutencao) VALUES
	(2,'MQ-2','1','Sensor Evaporador EV-01','Sala de Desossa','Teto Esteira A Início','6','2026-02-02','2026-08-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-02','Sala de Desossa','Teto Esteira B Início','3','2026-02-02','2026-08-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-03','Sala de Desossa','Teto Hall de Entrada','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-04','Sala de Desossa','Teto Saída Anti-Câmara','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-05','Sala de Desossa','Teto Esteira A Centro','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-06','Sala de Desossa','Teto Esteira B Centro','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-07','Sala de Desossa','Teto Esteira A Final','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-08','Sala de Desossa','Teto Esteira B Final','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-09','Sala de Desossa','Teto Embalagem Estoque','0','2026-08-02','2027-02-02'),
	(2,'MQ-2','1','Sensor Evaporador EV-10','Sala de Desossa','Teto Embalagem Paletização','0','2026-08-02','2027-02-02');
    
SELECT * FROM monitoramento;

-- EXIBE TABELA: VAZAMENTO DE AMONIA
SELECT * FROM monitoramento
	WHERE leitura>0;
    
-- EXIBE TABELA: SENSORES ATIVOS
SELECT * FROM monitoramento
	WHERE status_sensor=1;
    
-- EXIBE TABELA: SENSORES DAS ESTEIRAS
SELECT * FROM monitoramento
	WHERE localizacao LIKE '%esteira%';
    
-- EXIBE TABELA: MODELO SIMPLES
SELECT concat('O ', nome, ' está captando ', leitura, 'ppm e fica localizado em ', localizacao, ' no setor ', setor) AS 'Descricao' FROM monitoramento;

-- EXIBE TABELA: MODELO INTERMEDIÁRIO - INDICADOR DE AMONIA
SELECT
	CASE
		WHEN idEmpresa =2 THEN 'OuroBeef'
        ELSE NULL
        END AS Empresa,
	modelo AS Modelo, 
	CASE
		WHEN status_sensor =1 THEN 'Ativo'
        ELSE 'Inativo'
        END AS 'Status',
	nome AS 'Nome', localizacao AS 'Localização', setor AS Setor, leitura AS 'Leitura em PPM',
    CASE
		WHEN leitura <1 THEN 'Normal'
        WHEN leitura <5 THEN 'Moderado'
        WHEN leitura >5 THEN 'Alto'
        END AS 'Concentração de Amônia no Ar'
	FROM monitoramento;

-- EXIBE TABELA: MODELO INTERMEDIÁRIO - INDICADOR DE MANUTENÇÃO
SELECT
	CASE
		WHEN idEmpresa=2 THEN 'OuroBeef'
		ELSE NULL
        END AS Empresa,
	modelo AS Modelo,
    CASE
		WHEN status_sensor =1 THEN 'Ativo'
		ELSE 'Inativo'
        END AS 'Status',
	nome AS 'Nome', localizacao AS 'Localização', setor AS Setor, leitura AS 'Leitura em PPM', DATE_FORMAT(ultima_manutencao, '%d/%m/%Y') AS 'Data da Última Manutenção', DATE_FORMAT(proxima_manutencao, '%d/%m/%Y') AS 'Data da Próxima Manutenção',
	CASE
		WHEN proxima_manutencao < NOW() THEN 'Manutenção Vencida'
        ELSE 'Manutenção em Dia'
		END AS 'Status da Manutenção'
	FROM monitoramento;
    
CREATE TABLE empresas (
idEmpresa INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(40) NOT NULL,
cnpj VARCHAR(18) UNIQUE NOT NULL,
data_cadastro DATE DEFAULT (CURDATE()),
status_contrato VARCHAR(10) NOT NULL,
CONSTRAINT checkContrato CHECK(status_contrato IN('Ativo','Cancelado')),
plano VARCHAR(40) NOT NULL,
CONSTRAINT checkPlano CHECK(plano IN('Standard','Business','Enterprise')),
valor_mensalidade DECIMAL(12,2) NOT NULL,
data_pagamento DATE,
status_pagamento TINYINT NOT NULL,
CONSTRAINT checkPagamento CHECK(status_pagamento IN(0, 1))
);

DROP TABLE empresas;

TRUNCATE TABLE empresas;

ALTER TABLE empresas AUTO_INCREMENT=2;

INSERT INTO empresas (nome, cnpj, status_contrato, plano, valor_mensalidade, data_pagamento, status_pagamento) VALUES
	('OuroBeef','14.852.963/0001-40','Ativo','Business','15500.00','2026-10-01',1),
	('FrigoSul','27.418.529/0001-85','Ativo','Enterprise','27800.00','2026-10-01',1),
	('ValeBovino','39.654.128/0001-12','Ativo','Standard','11200.00','2026-10-01',1);
    
SELECT * FROM empresas;

-- EXIBIR TABELA FORMATADA: DETALHES DAS EMPRESAS
SELECT idEmpresa AS 'Identificação', nome AS 'Nome', cnpj AS 'CNPJ', DATE_FORMAT(data_cadastro, '%d/%m/%Y') AS 'Data de Cadastro', status_contrato AS 'Status do Contrato', plano AS 'Plano', concat('R$',valor_mensalidade) AS 'Valor da Mensalidade', DATE_FORMAT(data_pagamento, '%d/%m') AS 'Data de Pagamento',
	CASE
		WHEN status_pagamento =1 THEN 'Pago'
        ELSE 'Pendente'
        END AS 'Status do Pagamento'
	FROM empresas;
    
-- EXIBIR TABELA FORMATADA: STATUS DAS EMPRESAS
SELECT concat('A empresa ', nome,' está com o contrato ', status_contrato,' e sua mensalidade do plano ', plano, ' está com status ', 
	CASE
		WHEN status_pagamento=1 THEN 'Pago'
		ELSE 'Pendente'
        END) AS 'Descrição' 
	FROM empresas;