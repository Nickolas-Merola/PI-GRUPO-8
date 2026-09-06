use sprint1;

create table usuario (
id int primary key auto_increment,
nome varchar(255) not null,
email varchar(100) not null,
	constraint chkEmail check(email like '%@%'),
numero int,
senha varchar(255) not null,
ConfirmacaoSenha varchar(255) not null,
ocupacao varchar(255),
	constraint chkOcupacao check(ocupacao in('Professor','Estudante','Outro'))
) auto_increment = 1;

insert into usuario (nome, email, numero, senha, ConfirmacaoSenha, ocupacao) values
('Lucas Monteiro', 'luc.monteiro@email.com', 987654321, 'sadg12347', 'sadg12347', null),
('Marina Albuquerque', 'mari.102@outlook.com', null, 'KSDdad23', 'KSDdad23', 'Professor'),
('Rafael Vasconcelos', 'rafaVasco@bol.com.br', 998765432, 'weg763123', 'weg763123', 'Outro'),
('João Pereira', 'joao209@gmail.com', null, 'jdhas2KJ9', 'jdhas2KJ9', 'Estudante');


create table sensor (
id int primary key auto_increment,
nomeSensor varchar(255) not null,
statuss tinyint not null,
	constraint chkStatus check(statuss in('1','0')),
ppm int not null,
locall varchar(255) not null
) auto_increment = 1;

insert into sensor values
(default,'MQ-2', 0, 520, 'Ao lado do tubulação'),
(default,'MQ-2', 1, 45, 'Parede 1'),
(default,'MQ-2', 0, 8, 'Valvula'),
(default,'MQ-2', 1, 120, 'parede 2');


create table acidente (
id int primary key auto_increment,
tipoAcid varchar(255) not null,
dtAcidente datetime not null,
qtdVitimas int,
carnePerdida int,
locall varchar(255)
) auto_increment = 1;

insert acidente (tipoAcid, dtAcidente, qtdVitimas, carnePerdida, locall) values
('Vazamento de Amônia', '2025-03-14 08:36:51', 3, 450, 'Valvula'),
('Vazamento de Amônia', '2025-06-22 14:14:14', 0, 1200, 'Compressor'),
('Rompimento da Tubulação', '2025-08-09 23:57:13', 1, 800, 'Tubulação Principal'),
('Vazamento de Amônia', '2026-01-30 03:48:04', 1, 1900, 'Tubulação');