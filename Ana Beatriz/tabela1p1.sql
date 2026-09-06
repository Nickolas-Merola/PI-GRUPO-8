create database pi;
use pi;
create table clientes (
	id_cliente INT AUTO_INCREMENT PRIMARY KEY,
    nome_empresa VARCHAR(150) NOT NULL,
    email_contato  VARCHAR(100) NOT NULL,
    endereco  VARCHAR(200) NOT NULL,
    data_cadastro       DATETIME DEFAULT CURRENT_TIMESTAMP
);
INSERT INTO clientes (nome_empresa, email_contato, endereco, data_cadastro) VALUES
('Frigorífico Boa Carne', 'contato@boacarne.com.br', 'Rod. BR-153, Km 12', '2024-01-15'),
('Frigorífico Vale Verde', 'contato@valeverde.com.br', 'Av. Industrial, 450', '2024-02-03'),
('Frigorífico Santa Fé', 'financeiro@santafealimentos.com.br', 'Rua das Indústrias, 1200', '2024-02-20'),
('Frigorífico Rio Claro', 'atendimento@rioclarofrig.com.br', 'Rod. GO-050, Km 8', '2024-03-10'),
('Frigorífico Central', 'contato@centralcarnes.com.br', 'Distrito Industrial, Lote 5', '2024-03-28'),
('Frigorífico Pantanal', 'comercial@pantanalfrig.com.br', 'Av. Marechal Rondon, 3000', '2024-04-15'),
('Frigorífico São Marcos', 'contato@saomarcosbeef.com.br', 'Rua XV de Novembro, 890', '2024-05-02'),
('Frigorífico Nova Era', 'nova.era@nefrig.com.br', 'Rod. MT-130, Km 22', '2024-05-19'),
('Frigorífico Cerrado', 'contato@cerradocarnes.com.br', 'Av. Goiás, 1500', '2024-06-07'),
('Frigorífico Tropical', 'atendimento@tropicalbeef.com.br', 'Rod. BR-364, Km 40', '2024-06-25');

SELECT * FROM clientes;
