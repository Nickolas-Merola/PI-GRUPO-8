use pi;
CREATE TABLE alertas (
	id_alerta INT AUTO_INCREMENT PRIMARY KEY,
    id_sensor INT NOT NULL,
    nivel_ppm DECIMAL(10,2) NOT NULL,
    nivel_severidade    VARCHAR(20) NOT NULL,
    data_hora           DATETIME DEFAULT CURRENT_TIMESTAMP,
    data_resolucao      DATETIME,
    CHECK (nivel_severidade IN ('atencao', 'critico'))
);
INSERT INTO alertas (id_sensor, nivel_ppm, nivel_severidade, data_resolucao) VALUES
	(1, 35.50, 'atencao', '2024-03-05 09:00:00'),
	(2, 120.75, 'critico', '2024-03-10 15:30:00'),
	(3, 15.20, 'atencao', '2024-04-02 10:00:00'),
	(4, 200.00, 'critico', NULL),
	(5, 45.00, 'atencao', '2024-05-01 12:00:00'),
	(6, 300.40, 'critico', NULL),
	(7, 60.10, 'atencao', '2024-06-08 17:15:00'),
	(8, 25.30, 'atencao', '2024-06-15 08:00:00'),
	(9, 180.90, 'critico', NULL),
	(10, 90.00, 'atencao', '2024-07-10 14:00:00');
    
SELECT * from alertas;