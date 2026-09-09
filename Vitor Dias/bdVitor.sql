-- 1. CRIAÇÃO E SELEÇÃO DO BANCO DE DADOS
CREATE DATABASE amonia_sense;
USE amonia_sense;

-- 2. TABELA: evaporadores
CREATE TABLE evaporadores (
    id_evaporador INT AUTO_INCREMENT PRIMARY KEY,
    nome VARCHAR(50) NOT NULL,
    setor VARCHAR(100) NOT NULL,
    capacidade_refrigeracao DECIMAL(10,2),
    statuss VARCHAR(20) NOT NULL
);

INSERT INTO evaporadores (nome, setor, capacidade_refrigeracao, statuss) VALUES
('Evaporador 01', 'Sala de Desossa', 120.00, 'ATIVO'),
('Evaporador 02', 'Sala de Desossa', 120.00, 'ATIVO'),
('Evaporador 03', 'Sala de Desossa', 100.00, 'ATIVO'),
('Evaporador 04', 'Sala de Desossa', 100.00, 'MANUTENCAO'),
('Evaporador 05', 'Sala de Desossa', 120.00, 'ATIVO');

-- Alter Table: Altera o nome da coluna 'setor' para 'sala'
ALTER TABLE evaporadores RENAME COLUMN setor TO sala;

-- Update: Atualiza a capacidade de refrigeração do evaporador 3
UPDATE evaporadores 
SET capacidade_refrigeracao = 130.00 
WHERE id_evaporador = 3;

-- Select com CONCAT e CASE
SELECT 
    CONCAT('O ', nome, ' localizado na ', sala, ' possui capacidade de ', capacidade_refrigeracao, ' TR.') AS descricao_evaporador,
    CASE 
        WHEN statuss = 'ATIVO' THEN 'Equipamento Operacional'
        WHEN statuss = 'MANUTENCAO' THEN 'Equipamento em Reparo'
        ELSE 'Status Desconhecido'
    END AS situacao_operacional
FROM evaporadores;

-- Delete: Remove um evaporador específico
DELETE FROM evaporadores WHERE id_evaporador = 5;


-- 3. TABELA: sensores
CREATE TABLE sensores (
    id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_evaporador INT NOT NULL,
    modelo VARCHAR(100) NOT NULL,
    fabricante VARCHAR(100) NOT NULL,
    data_instalacao DATE,
    statuss VARCHAR(20) NOT NULL
);

INSERT INTO sensores (id_evaporador, modelo, fabricante, data_instalacao, statuss) VALUES
(1, 'EC-FX-NH3', 'Manning', '2026-08-01', 'ATIVO'),
(2, 'EC-FX-NH3', 'Manning', '2026-08-01', 'ATIVO'),
(3, 'EC-FX-NH3', 'Manning', '2026-08-02', 'ATIVO'),
(4, 'EC-FX-NH3', 'Manning', '2026-08-02', 'MANUTENCAO'),
(5, 'EC-FX-NH3', 'Manning', '2026-08-03', 'ATIVO');

-- Alter Table: Adiciona uma coluna de observação
ALTER TABLE sensores ADD observacao VARCHAR(150);

-- Update: Atualiza o statuss do sensor 4 e adiciona observação
UPDATE sensores 
SET statuss = 'ATIVO', observacao = 'Manutenção preventiva concluída' 
WHERE id_sensor = 4;

-- Select com CONCAT e CASE
SELECT 
    CONCAT('Sensor ID #', id_sensor, ' (Modelo: ', modelo, ' - ', fabricante, ') instalado no Evaporador ', id_evaporador) AS detalhe_sensor,
    CASE 
        WHEN statuss = 'ATIVO' THEN 'Coletando dados normalmente'
        WHEN statuss = 'MANUTENCAO' THEN 'Sensor temporariamente inativo'
        ELSE 'Verificar conexão'
    END AS status_leitura
FROM sensores;

-- Delete: Remove sensores específicos
DELETE FROM sensores WHERE id_sensor = 5;


-- 4. TABELA: leituras
CREATE TABLE leituras (
    id_leitura INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    concentracao_amonia DECIMAL(10,2) NOT NULL,
    temperatura DECIMAL(5,2),
    umidade DECIMAL(5,2),
    data_hora DATETIME NOT NULL
);

INSERT INTO leituras (id_sensor, concentracao_amonia, temperatura, umidade, data_hora) VALUES
(1, 2.50, 11.20, 82.50, '2026-09-01 08:00:00'),
(2, 3.10, 10.80, 84.20, '2026-09-01 08:05:00'),
(3, 4.20, 11.00, 81.70, '2026-09-01 08:10:00'),
(4, 6.80, 10.50, 85.10, '2026-09-01 08:15:00'),
(5, 2.90, 11.30, 83.40, '2026-09-01 08:20:00'),
(1, 3.40, 11.10, 82.80, '2026-09-01 09:00:00'),
(2, 5.70, 10.90, 84.00, '2026-09-01 09:05:00'),
(3, 8.90, 11.20, 82.10, '2026-09-01 09:10:00');

-- Alter Table: Modifica a coluna de concentração de amônia
ALTER TABLE leituras MODIFY COLUMN concentracao_amonia DECIMAL(8,3);

-- Update: Corrige uma leitura 
UPDATE leituras SET concentracao_amonia = 2.80 
WHERE id_leitura = 1;

-- Select com CONCAT e CASE
SELECT 
    CONCAT('Leitura realizada em ', DATE_FORMAT(data_hora, '%d/%m/%Y às %H:%i'), ' pelo Sensor ', id_sensor) AS registro,
    CONCAT(concentracao_amonia, ' PPM') AS concentracao,
    CASE 
        WHEN concentracao_amonia < 4.00 THEN 'Nível Seguro'
        WHEN concentracao_amonia BETWEEN 4.00 AND 6.50 THEN 'Nível de Atenção'
        ELSE 'Nível Crítico / Perigo'
    END AS classificacao_risco
FROM leituras;

-- Delete: Apaga leituras 
DELETE FROM leituras WHERE id_leitura = 5;


-- 5. TABELA: alertas
CREATE TABLE alertas (
    id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    tipo_alerta VARCHAR(30) NOT NULL,
    mensagem VARCHAR(255) NOT NULL,
    data_hora DATETIME NOT NULL,
    statuss VARCHAR(20) NOT NULL
);

INSERT INTO alertas (id_sensor, tipo_alerta, mensagem, data_hora, statuss) VALUES
(4, 'ATENCAO', 'Leitura acima do parametro de monitoramento', '2026-09-01 08:15:00', 'ABERTO'),
(2, 'ATENCAO', 'Leitura acima do parametro de monitoramento', '2026-09-01 09:05:00', 'ABERTO'),
(3, 'ALERTA', 'Leitura elevada detectada pelo sensor', '2026-09-01 09:10:00', 'ABERTO');

-- Alter Table: Adiciona coluna para registrar a data de resolução do alerta
ALTER TABLE alertas ADD data_resolucao DATETIME NULL;

-- Update: Resolve o primeiro alerta e registra o horário de resolução
UPDATE alertas 
SET statuss = 'RESOLVIDO', data_resolucao = '2026-09-01 10:00:00' 
WHERE id_alerta = 1;

-- Select com CONCAT e CASE
SELECT 
    CONCAT('Alerta #', id_alerta, ' [', tipo_alerta, ']: ', mensagem) AS detalhe_alerta,
    CASE 
        WHEN statuss = 'ABERTO' THEN 'Requer Ação Imediata da Equipe'
        WHEN statuss = 'EM_ANDAMENTO' THEN 'Técnico Investigando'
        WHEN statuss = 'RESOLVIDO' THEN 'Ocorrência Finalizada'
        ELSE 'Status Não Mapeado'
    END AS prioridade_atendimento
FROM alertas;

-- Delete: Elimina alertas específicos
DELETE FROM alertas WHERE id_alerta = 1;


-- 6. COMANDOS DE TRUNCATE (Limpeza de registros das tabelas)
TRUNCATE TABLE alertas;
TRUNCATE TABLE leituras;
TRUNCATE TABLE sensores;
TRUNCATE TABLE evaporadores;


-- 7. COMANDOS DE DROP (Exclusão final das tabelas e do banco de dados)
DROP TABLE alertas;
DROP TABLE leituras;
DROP TABLE sensores;
DROP TABLE evaporadores;

DROP DATABASE amonia_sense;