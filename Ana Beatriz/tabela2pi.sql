use pi;
CREATE TABLE sensores (
	id_sensor INT AUTO_INCREMENT PRIMARY KEY,
    id_clientes INT NOT NULL,
    data_instalacao DATE,
    statuss VARCHAR(20) DEFAULT 'ativo',
    CHECK (statuss IN ('ativo', 'inativo', 'manutencao'))
);
INSERT INTO sensores (id_clientes, data_instalacao, statuss) VALUES
(1, '2024-01-20', 'ativo'),
(2, '2024-02-10', 'ativo'),
(3, '2024-02-25', 'manutencao'),
(4, '2024-03-15', 'ativo'),
(5, '2024-04-01', 'inativo'),
(6, '2024-04-20', 'ativo'),
(7, '2024-05-10', 'ativo'),
(8, '2024-05-25', 'ativo'),
(9, '2024-06-12', 'manutencao'),
(10, '2024-07-01', 'ativo');

select * from sensores;