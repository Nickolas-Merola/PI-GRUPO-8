USE sprint1;

CREATE TABLE cadastro (
id INT PRIMARY KEY AUTO_INCREMENT,
nome VARCHAR(50),
cpf CHAR(11),
dtNasc DATE,
altura FLOAT,
salario DECIMAL(10,2),
email VARCHAR(60),
CONSTRAINT chkEmail CHECK(email LIKE '%@%')
) AUTO_INCREMENT = 2000;

INSERT INTO cadastro (nome, dtNasc, salario, email) VALUES
	('Rick', '2000-01-01', 3000.00, 'rick@email.com'),
	('Rock', '2002-03-01', 600.99, 'rock@email.com');
    
ALTER TABLE cadastro MODIFY COLUMN cpf CHAR(11) UNIQUE,
	MODIFY COLUMN email VARCHAR(60) NOT NULL;
    
DESCRIBE cadastro;

ALTER TABLE cadastro ADD CONSTRAINT ckhSalario 
	CHECK(salario >= 0);
    
ALTER TABLE cadastro ADD COLUMN dtCadastro DATETIME DEFAULT current_timestamp;


UPDATE cadastro SET dtCadastro = curdate()
	WHERE id >= 2000;


UPDATE cadastro SET dtCadastro = now()
	WHERE id >= 2000;

SELECT * FROM cadastro;

SELECT ifnull(cpf, 'Estrangeiro') as CPF,
	concat('Nome é ', nome) as NOME,
    case 
		WHEN salario > 1000 THEN 'Top'
        ELSE 'Não top'
        END as SALARIO
        FROM cadastro;
        
SELECT concat('Cadastro realizado! ', nome, ' tem o cpf ', 
	ifnull(cpf, 'Sem cpf'), ' e o salário é ',
    CASE
    WHEN salario > 1000 THEN 'Ganha bem'
    ELSE 'Ganha mais ou menos'
    END) AS FRASE_COMPLETA FROM cadastro;
    
SELECT dtNasc,
	timestampdiff(YEAR, dtNasc, now()) AS IDADE FROM cadastro;

SELECT * FROM cadastro;

UPDATE cadastro SET cpf = '12345678901', altura = 1.67,
	salario = NULL WHERE id = 2000;
    
SELECT cpf FROM cadastro WHERE cpf IS NULL;

ALTER TABLE cadastro ADD COLUMN statusCadastro TINYINT,
	ADD CONSTRAINT chkStatusCadastro 
		CHECK(statusCadastro IN (0,1));