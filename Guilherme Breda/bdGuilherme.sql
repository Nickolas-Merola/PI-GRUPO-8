use sprint1;

create table usuario (
id int primary key auto_increment,
nome varchar(255) not null,
email varchar(100) not null,
numero int,
senha varchar(255) not null,
ConfirmacaoSenha varchar(255) not null,
ocupacao varchar(255),
	constraint chkOcupacao check(ocupacao in('Professor','Estudante','Outro'))
) auto_increment = 1;

alter table usuario add constraint chkEmailUser check (email like '%@%');


insert into usuario (nome, email, numero, senha, ConfirmacaoSenha, ocupacao) values
('Lucas Monteiro', 'luc.monteiro@email.com', 987654321, 'sadg12347', 'sadg12347', null),
('Marina Albuquerque', 'mari.102@outlook.com', null, 'KSDdad23', 'KSDdad23', 'Professor'),
('Rafael Vasconcelos', 'rafaVasco@bol.com.br', 998765432, 'weg763123', 'weg763123', 'Outro'),
('João Pereira', 'joao209@gmail.com', null, 'jdhas2KJ9', 'jdhas2KJ9', 'Estudante');

select *from usuario;

select concat('Parabens ', nome,', com ocupação de ', ocupacao,' , seu cadastro foi finalizado') as msgCadastro from usuario;

update usuario set numero = '98263912'
	where id = 2;
    
update usuario  set email = 'LucasMont231@gmail.com', ocupacao = 'Professor'
	where id = 1;
    
alter table usuario drop column numero;

select *,
	case
		when ocupacao = 'Outro' then 'Fora da instituição de ensino'
        else 'Dentro da instituição de ensino'
        end as Instituicao
from usuario;
	

-- Tabela 2
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

select *from sensor;

select concat('O sensor ', nomeSensor,', esta com o status', 
	case
		when statuss = 1 then 'Ativo'
        else 'Inativo'
	end) as mensagem
from sensor;

update sensor set statuss = 0
	where id = 2;
    
update sensor set locall = 'Tubulação'
	where id = 1;
    
alter table sensor add column numeroAcidente int;

update sensor set numeroAcidente = 1
	where id = 1;
update sensor set numeroAcidente = 4
	where id = 2;
update sensor set numeroAcidente =11
	where id = 3;
update sensor set numeroAcidente = 7
	where id = 4;
    
select nomeSensor,statuss,locall from sensor;


-- Tabela 3
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

select *from acidente;

select concat('o ',tipoAcid,' resultou em ',qtdVitimas,', e teve sua origem no local ',locall) as mensagem from sensor;

alter table acidente add column empresa varchar(255);

update acidente set empresa = 'Frigorífico Boi Real'
	where id = 1;
update acidente set empresa = 'Carnes Vale Verde'
	where id = 2;
update acidente set empresa = 'Frigorífico Pampa Sul'
	where id = 3;
update acidente set empresa = 'Agropecuária Terra Nova'
	where id = 4;