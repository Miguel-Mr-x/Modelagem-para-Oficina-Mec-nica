-- base de dados para testes de querys
use Repairshop;
show tables;

-- ========================================
-- CLIENTES
-- ========================================
insert into clients (pName, Minit, Lname, CPF, cellNumber, email, address, vehicles, feedback) values
	('Carlos', 'A', 'Ferreira', '12345678901', '11987654321', 'carlos@email.com', 'Rua das Oficinas, 123', 'Civic', 'Ótimo atendimento, recomendo.'),
	('Juliana', 'B', 'Santos', '23456789012', '11999887766', 'juliana@email.com', 'Av. Brasil, 45', 'Corolla', 'Serviço rápido e eficiente.'),
	('Marcos', 'C', 'Almeida', '34567890123', '11988776655', 'marcos@email.com', 'Rua Nova, 89', 'HB20', 'Poderia ter mais opções de pagamento.'),
	('Fernanda', 'D', 'Oliveira', '45678901234', '11977665544', 'fernanda@email.com', 'Rua Aurora, 321', 'Fiesta', 'Equipe muito atenciosa.'),
	('Lucas', 'E', 'Souza', '56789012345', '11966554433', 'lucas@email.com', 'Rua Central, 222', 'Onix', 'Voltaria novamente.');

-- ========================================
-- EQUIPE MECÂNICA
-- ========================================
insert into teamMechanic (pName, Minit, Lname, mechanicNumber, addressShop, professionalSkills) values
	('Ricardo', 'M', 'Lima', 1001, 'Oficina Central - Box 1', 'Suspensão e freios'),
	('André', 'F', 'Carvalho', 1002, 'Oficina Central - Box 2', 'Elétrica automotiva'),
	('Paula', 'T', 'Souza', 1003, 'Oficina Central - Box 3', 'Troca de óleo e filtros'),
	('Bruno', 'G', 'Alves', 1004, 'Oficina Central - Box 4', 'Motor e transmissão'),
	('Carla', 'R', 'Martins', 1005, 'Oficina Central - Box 5', 'Diagnóstico eletrônico');

-- ========================================
-- PEÇAS AUTOMOTIVAS
-- ========================================
insert into atomotiveParts (typeParts) values
	('Pastilhas de freio'),
	('Filtro de óleo'),
	('Amortecedor'),
	('Correia dentada'),
	('Bateria'),
	('Velas de ignição'),
	('Filtro de ar'),
	('Radiador');

-- ========================================
-- GRUPO DE PEÇAS
-- ========================================
insert into groupParts (idAutoParts, valueParts, quantity, partCondition, supplier) values
	(1, 250.00, 4, 'Nova', 'AutoPeças Brasil'),
	(2, 60.00, 1, 'Nova', 'Filtros & Cia'),
	(3, 420.00, 2, 'Nova', 'Amortecedores São Paulo'),
	(4, 150.00, 1, 'Usada', 'ReAuto Center'),
	(5, 480.00, 1, 'Nova', 'Baterias Moura'),
	(6, 120.00, 4, 'Nova', 'Spark Auto'),
	(7, 80.00, 1, 'Nova', 'Filtros & Cia'),
	(8, 600.00, 1, 'Usada', 'Peças Recuperadas ABC');

-- ========================================
-- SERVIÇOS
-- ========================================
insert into services (idTclient, numberService, startDate, serviceStatus, expectedEnd_date, serviceFee) values
	(1, 5001, '2025-10-01', 'Concluído', '2025-10-02', 350.00),
	(2, 5002, '2025-10-03', 'Em andamento', '2025-10-08', 620.00),
	(3, 5003, '2025-09-28', 'Concluído', '2025-09-29', 480.00),
	(4, 5004, '2025-10-04', 'Em andamento', '2025-10-09', 920.00),
	(5, 5005, '2025-10-05', 'Aguardando peças', '2025-10-10', 300.00);

-- ========================================
-- RELAÇÃO EQUIPE ↔ SERVIÇOS
-- ========================================
insert into teamService (idSteam, idSservice, accomplishedService) values
	(1, 1, 'Troca de pastilhas de freio'),
	(3, 1, 'Troca de filtro de óleo'),
	(2, 2, 'Verificação elétrica e troca de bateria'),
	(5, 2, 'Diagnóstico eletrônico completo'),
	(4, 3, 'Substituição de amortecedores'),
	(1, 4, 'Troca de correia dentada'),
	(3, 4, 'Troca de velas de ignição'),
	(2, 5, 'Troca de filtro de ar e revisão elétrica');

-- ========================================
-- RELAÇÃO SERVIÇOS ↔ PEÇAS
-- ========================================
insert into groupServices (idGservices, idGgroupParts, maintenanceService) values
	(1, 1, 'Substituição de freios'),
	(1, 2, 'Troca de filtro'),
	(2, 5, 'Instalação de bateria'),
	(2, 7, 'Limpeza de sistema de ar'),
	(3, 3, 'Troca de amortecedores'),
	(4, 4, 'Substituição de correia dentada'),
	(4, 6, 'Troca de velas'),
	(5, 8, 'Limpeza e manutenção do radiador');

select * from clients;
select * from teamMechanic;
select * from atomotiveParts;
select * from groupParts;
select * from services;
select * from teamService;
select * from groupServices;
select s.idServices, c.pname as Cliente, s.serviceStatus, s.serviceFee from services s join clients c on s.idTclient;
select s.idServices, tm.pName as Mecanico, ts.accomplishedService from teamService ts join teamMechanic tm on ts.idSteam = tm.idTeam join services s on ts.idSservice = idServices;
select s.idServices, ap.typeParts, gp.valueParts, gs.maintenanceService from groupServices gs join groupParts gp on gs.idGgroupParts = gp.idGroup join atomotiveParts ap 
	on gp.idAutoParts = ap.idParts join services s on gs.idGservices = s.idServices;
select * from clients c, services s where c.idClient = idTclient;
select concat(Pname,' ',Lname) as client, serviceStatus, serviceFee from clients c, services s where c.idClient = idTclient;
select * from clients c, services s
	where idClient = idTclient
	group by idServices;
-- Quantos pedidos realizados pelos clientes
Select c.idClient, Pname, count(*) as Number_of_services from clients c 
				inner join services s on c.idClient = s.idTclient
				inner join teamService ts on s.idServices = ts.idSservice
        group by idClient;

select * from services, clients order by concat(Pname, expectedEnd_date);
select supplier, COUNT(*) as qtd_pecas from groupParts where valueParts > 100.00 group by supplier;


