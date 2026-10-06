create database ex006
go
use ex006

create table Func (
         CodFunc int constraint pk_func primary key, 
         PrimeiroNome varchar(50), 
         SegundoNome varchar(50), 
         UltimoNome varchar(50), 
         DataNasci datetime, 
         CPF   varchar(20), 
         RG varchar(20), 
         Endereco varchar(50), 
         CEP varchar(15), 
         Cidade varchar(50), 
         Fone varchar(20), 
         CodDepto int, 
         Funcao varchar(50), 
         Salario money
)

create table Depto (
          CodDepto int constraint pk_deto primary key, 
          Nome varchar(50), 
          Localizacao varchar(50), 
          CodigoFuncionarioGerente int
)

alter table Func
add constraint fk_depto_func foreign key (CodDepto) references Depto(CodDepto)

alter table Depto
add constraint fk_func_gerente foreign key (CodigoFuncionarioGerente) 
      references Func(CodFunc)


INSERT INTO DEPTO 
values
      (1,         'RH',            'SUL',      NULL),
      (2,         'COMPRAS',         'SUL',      NULL),
      (3,         'VENDAS',         NULL,      NULL),
      (4,         'FINANCEIRO',      'NORTE',   NULL),
      (5,         'MARKETING',      'NORTE',   NULL),
      (6,         'DESENVOLVIMENTO',   NULL,      NULL),
      (7,         'CONTABILIDADE',   NULL,      NULL)


INSERT INTO Func (CodFunc, PrimeiroNome, SegundoNome, 
               UltimoNome, DataNasci, Cidade, 
               Funcao, Salario)
values (1, 'JOSE', 'MANOEL', 'DA SILVA', 
            '1980/01/01','FRANCA',
            'CONTADOR', 1200.00)

update func set salario = 1700
where codFunc = 5


-- 1. Listar todos os campos de funcionários ordenados por cidade
SELECT *
FROM Func
ORDER BY cidade;

-- 2. Obter os nomes dos funcionários nascidos entre as datas 1950-01-01 e 1970-01-01
SELECT CONCAT(PrimeioNome, ' ', SegundoNome, ' ', UltimoNome) AS nomeCompleto
FROM Func
WHERE DataNasci BETWEEN '1950-01-01' AND '1970-01-01';

-- 3. Liste os funcionários que têm salário superior a R$ 1.000,00 ordenados pelo nome completo
SELECT 
    CONCAT(PrimeioNome, ' ', SegundoNome, ' ', UltimoNome) AS nomeCompleto,
    salario
FROM Func
WHERE Salario > 1000
ORDER BY CONCAT(PrimeioNome, ' ', SegundoNome, ' ', UltimoNome);
-- ou ORDER BY PrimeiroNome, SegundoNome, UltimoNome;

-- 4. Liste a data de nascimento e o primeiro nome dos funcionários ordenados do mais novo para o mais velho
SELECT DataNasci, PrimeioNome
FROM Func
ORDER BY DataNasci DESC;

-- 5. Liste o total da folha de pagamento
SELECT SUM(Salario) AS folhaPagamento
FROM Func;

-- 6. Liste o nome, o nome do departamento e a função de todos os funcionários
SELECT
    f.PrimerioNome AS nome,
    d.Nome AS departamento,
    f.Funcao
FROM Func f
INNER JOIN Depto d
ON f.CodDepto = d.CodDepto;

-- 7. Liste todos os departamentos com seus respectivos gerentes
SELECT
    f.PrimerioNome AS gerente,
    d.Nome AS departamento
FROM Depto d
INNER JOIN Func f
ON d.CodigoFuncionarioGerente = f.CodFunc;

-- 8. Liste o valor da folha de pagamento de cada departamento (nome)
SELECT
    d.Nome AS departamento,
    SUM(f.Salario) AS folhaPagamento
FROM Func f
INNER JOIN Depto d
ON f.CodDepto = d.CodDepto
GROUP BY d.Nome;

-- 9. Liste os departamentos dos funcionários que têm a função de supervisor
SELECT
    d.Nome AS departamento,
    f.PrimeiroNome AS supervisor,
    Funcao
FROM Depto d
INNER JOIN Func f
ON d.codFunc = f.CodFunc
WHERE f.Funcao = 'Supervisor';

-- Usando subselect
SELECT *
FROM Depto
WHERE codDepto IN (SELECT codDepto FROM Func WHERE Funcao = 'SUPERVISOR')

-- 10. Liste a quantidade de funcionários desta empresa
SELECT COUNT(*) AS qtdeFuncionarios
FROM Func;

-- 11. Liste o salário médio pago pela empresa


-- 12. Liste a quantidade de funcionários que trabalham em cada departamento


-- 12+1. Liste o menor salário pago pela empresa em cada departamento


-- 14. Liste o nome completo de todos os funcionários que não tenham segundo nome.