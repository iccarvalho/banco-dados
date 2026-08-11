CREATE DATABASE Exercicio_Revisao;

USE Exercicio_Revisao;

CREATE TABLE garcons(
    codGarcom INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(80),
    calcularComissao VARCHAR(1)
);

CREATE TABLE mesas(
    nroMesa INT PRIMARY KEY IDENTITY(1, 1),
    setor VARCHAR(30),
    capacidade INT,
    situacao VARCHAR(30)
);

CREATE TABLE atendimentos(
    codAtendimento INT PRIMARY KEY IDENTITY(1001, 1),
    situacao VARCHAR(30),
    dataHora_Chegada datetime,
    nroPessoas INT,
    codGarcom INT FOREIGN KEY REFERENCES garcons(codGarcom),
    nroMesa INT FOREIGN KEY REFERENCES mesas(nroMesa)
);

CREATE TABLE produtos(
    codProd INT PRIMARY KEY IDENTITY(101, 1),
    descricao VARCHAR(255),
    preco MONEY
);

CREATE TABLE consumos(
    codCon INT PRIMARY KEY IDENTITY(1001, 1),
    qtde INT,
    valorUnitario MONEY,
    codProd INT FOREIGN KEY REFERENCES produtos(codProd),
    codAtendimento INT FOREIGN KEY REFERENCES atendimentos(codAtendimento)
);

SELECT * FROM garcons;
SELECT * FROM mesas;
SELECT * FROM atendimentos;
SELECT * FROM produtos;
SELECT * FROM consumos;

-- 1.   Cadastrar 5 mesas, 10 produtos, 5 garçons, 10 atendimentos e 15 produtos consumidos nesses atendimentos (com dados diferentes).
INSERT INTO mesas
VALUES  ('SALÃO PRINCIPAL', 4, 'LIVRE'),
        ('SALÃO PRINCIPAL', 2, 'OCUPADO'),
        ('VARANDA', 4, 'OCUPADO'),
        ('VARANDA', 6, 'LIVRE'),
        ('VIP', 8, 'OCUPADO');

INSERT INTO produtos
VALUES  ('HAMBÚRGUER', 35),
        ('BATATA FRITA', 22),
        ('PIZZA', 45),
        ('REFRIGERANTE LATA', 6),
        ('SUCO DE LARANJA', 9),
        ('CERVEJA LONG NECK', 12),
        ('SOBREMESA PETIT GATEAU', 25),
        ('FILÉ À PARMEGIANA', 65),
        ('ÁGUA MINERAL COM GÁS', 5),
        ('PORÇÃO PASTÉIS', 28);

INSERT INTO garcons
VALUES  ('PEDRO', 'S'),
        ('ROBERTO', 'S'),
        ('MARIA', 'N'),
        ('JULIANA', 'S'),
        ('JOÃO', 'S');

INSERT INTO atendimentos
VALUES  ('FINALIZADO', '20260616 11:30:00', 2, 1, 1),
        ('FINALIZADO', '20260616 12:00:00', 4, 3, 2),
        ('ATENDENDO', '20260616 13:15:00', 2, 3, 3),
        ('FINALIZADO', '20260615 20:00:00', 3, 1, 3),
        ('ATENDENDO', '20260616 14:00:00', 4, 4, 3),
        ('FINALIZADO', '20260616 12:30:00', 1, 2, 4),
        ('ATENDENDO', '20260616 14:30:00', 6, 5, 5),
        ('FINALIZADO', '20260614 19:00:00', 2, 3, 1),
        ('FINALIZADO', '20260616 08:30:00', 2, 4, 3),
        ('FINALIZADO', '20260615 21:30:00', 5, 2, 5);

INSERT INTO consumos (qtde, valorUnitario, codProd, codAtendimento)
VALUES  (2, 35, 101, 1001),
        (2, 6, 104, 1001),
        (1, 45, 103, 1002),
        (3, 12, 106, 1002),
        (1, 22, 102, 1003),
        (1, 6, 104, 1003),
        (2, 65, 108, 1004),
        (3, 9, 105, 1004),
        (2, 28, 110, 1005),
        (4, 12, 106, 1005),
        (1, 35, 101, 1006),
        (3, 65, 108, 1007),
        (2, 25, 107, 1007),
        (2, 35, 101, 1009),
        (2, 45, 103, 1010);

-- 2.	Atualize o nome do garçom que possui o maior código para o seu nome.
UPDATE garcons SET nome = 'IGOR'
WHERE codGarcom = 5;

-- 3.	Crie um campo para guardar o salário dos garçons.
ALTER TABLE garcons
ADD salario MONEY;

-- 4.	Liste os produtos e seus preços em ordem do mais caro para o mais barato.
SELECT descricao, preco FROM produtos
ORDER BY preco DESC;

-- 5.	Liste o número e o setor das mesas que estão em atendimentos (atendimentos cuja situação seja ‘ATENDENDO’). Esta situação significa que os clientes ainda estão consumindo produtos.
SELECT m.nroMesa, m.setor, a.situacao FROM
mesas AS m INNER JOIN atendimentos as a
ON m.nroMesa = a.nroMesa
WHERE a.situacao = 'ATENDENDO';

-- 6.	Atualize os salários de cada garçom.
UPDATE garcons SET salario = 1800
WHERE codGarcom = 1;

UPDATE garcons SET salario = 2500
WHERE codGarcom = 2;

UPDATE garcons SET salario = 4000
WHERE codGarcom = 3;

UPDATE garcons SET salario = 1800
WHERE codGarcom = 4;

UPDATE garcons SET salario = 3300
WHERE codGarcom = 5;

-- 7.	Liste o seu salário caso você tivesse um aumento de salário de 15%. Não atualize seu novo salário, apenas o exiba com o possível aumento.
SELECT (salario * 1.15) AS salario FROM garcons
WHERE nome = 'IGOR';

-- 8.	Cadastre uma nova mesa e 2 novos atendimentos para esta mesa. Você é o garçom que está atendendo estes clientes e eles já consumiram 3 produtos diferentes.
INSERT INTO mesas
VALUES ('VIP', 2, 'OCUPADO');

INSERT INTO atendimentos
VALUES  ('ATENDENDO', '20260616 15:45:00', 2, 5, 6),
        ('ATENDENDO', '20260616 16:10:00', 2, 5, 6);

INSERT INTO consumos
VALUES  (2, 35, 101, 1011),
        (2, 6, 104, 1011),
        (1, 22, 102, 1012);

-- 9.	Liste os produtos que nunca foram consumidos.
SELECT p.descricao AS nome FROM
produtos AS p LEFT JOIN consumos as c
ON p.codProd = c.codProd
WHERE c.codProd IS NULL;

-- 10.	Liste os atendimentos já realizados no dia de hoje. Considere apenas atendimentos que já estão com situação de ‘FINALIZADO’, juntamente com os nomes dos garçons que fizeram tais atendimentos.
SELECT a.situacao, g.nome FROM
atendimentos AS a INNER JOIN garcons as g
ON a.codGarcom = g.codGarcom
WHERE
    situacao = 'FINALIZADO' AND
    a.dataHora_Chegada BETWEEN '20260616 00:00:00' AND '20260616 23:59:59';
