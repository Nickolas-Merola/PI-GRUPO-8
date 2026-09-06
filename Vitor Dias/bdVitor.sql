-- Cria o banco de dados 
CREATE DATABASE amonia_sense;

-- Seleciona o banco de dados que será utilizado
USE amonia_sense;


-- Cria a tabela responsável pelos evaporadores
CREATE TABLE evaporadores (
    id_evaporador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    setor VARCHAR(100) NOT NULL,
    capacidade_refrigeracao DECIMAL(10,2),
    status VARCHAR(20) NOT NULL
);


-- Insere os evaporadores utilizados na sala de desossa
INSERT INTO evaporadores
(nome, setor, capacidade_refrigeracao, status)
VALUES
('Evaporador 01', 'Sala de Desossa', 120.00, 'ATIVO'),
('Evaporador 02', 'Sala de Desossa', 120.00, 'ATIVO'),
('Evaporador 03', 'Sala de Desossa', 100.00, 'ATIVO'),
('Evaporador 04', 'Sala de Desossa', 100.00, 'MANUTENCAO'),
('Evaporador 05', 'Sala de Desossa', 120.00, 'ATIVO');


-- Cria a tabela dos sensores
CREATE TABLE sensores (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_evaporador INT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    data_instalacao DATE,
    status VARCHAR(20) NOT NULL)

-- Insere os sensores instalados nos evaporadores
INSERT INTO sensores
(id_evaporador, modelo, fabricante, data_instalacao, status)
VALUES
(1, 'EC-FX-NH3', 'Manning', '2026-08-01', 'ATIVO'),
(2, 'EC-FX-NH3', 'Manning', '2026-08-01', 'ATIVO'),
(3, 'EC-FX-NH3', 'Manning', '2026-08-02', 'ATIVO'),
(4, 'EC-FX-NH3', 'Manning', '2026-08-02', 'MANUTENCAO'),
(5, 'EC-FX-NH3', 'Manning', '2026-08-03', 'ATIVO');


-- Cria a tabela responsável por armazenar as leituras dos sensores
CREATE TABLE leituras (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    concentracao_amonia DECIMAL(10,2) NOT NULL,
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    data_hora DATETIME NOT NULL,


-- Insere alguns exemplos de leituras realizadas pelos sensores
INSERT INTO leituras
(id_sensor, concentracao_amonia, temperatura, umidade, data_hora)
VALUES
(1, 2.50, 11.20, 82.50, '2026-09-01 08:00:00'),
(2, 3.10, 10.80, 84.20, '2026-09-01 08:05:00'),
(3, 4.20, 11.00, 81.70, '2026-09-01 08:10:00'),
(4, 6.80, 10.50, 85.10, '2026-09-01 08:15:00'),
(5, 2.90, 11.30, 83.40, '2026-09-01 08:20:00'),
(1, 3.40, 11.10, 82.80, '2026-09-01 09:00:00'),
(2, 5.70, 10.90, 84.00, '2026-09-01 09:05:00'),
(3, 8.90, 11.20, 82.10, '2026-09-01 09:10:00');


-- Cria a tabela responsável por armazenar os alertas
CREATE TABLE alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    tipo_alerta VARCHAR(30) NOT NULL,
    mensagem VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL,



-- Insere exemplos de alertas gerados pelo sistema
INSERT INTO alertas (id_sensor, tipo_alerta, mensagem, data_hora, status)VALUES

(4, 'ATENCAO', 'Leitura acima do parametro de monitoramento', '2026-09-01 08:15:00', 'ABERTO'),

(2, 'ATENCAO', 'Leitura acima do parametro de monitoramento', '2026-09-01 09:05:00', 'ABERTO'),

(3, 'ALERTA', 'Leitura elevada detectada pelo sensor', '2026-09-01 09:10:00', 'ABERTO');


-- Mostra todos os evaporadores cadastrados
SELECT * FROM evaporadores;


-- Mostra todos os sensores cadastrados
SELECT * FROM sensores;


-- Mostra todas as leituras registradas
SELECT * FROM leituras;


-- Mostra todos os alertas registrados
SELECT * FROM alertas;