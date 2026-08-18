CREATE DATABASE Ex001;
GO
USE Ex001;

CREATE TABLE veterinarios(
    codVet INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(30),
    dataNasc DATE
);

CREATE TABLE animais(
    codPac INT PRIMARY KEY IDENTITY(1, 1),
    nomeAnimal VARCHAR(30),
    especie VARCHAR(30)
);

CREATE TABLE consultas(
    codCons INT PRIMARY KEY IDENTITY(1, 1),
    dataCons DATE,
    valor MONEY,
    codVet INT FOREIGN KEY REFERENCES veterinarios(codMed),
    codPac INT FOREIGN KEY REFERENCES animais(codPac)
);

-- Cadastrar 5 médicos (veterinários) para esta clínica
INSERT INTO veterinarios VALUES
    ('JOÃO', "1985/05/12"),
    ('MARIA', "1990/07/20"),
    ('PEDRO', "2000/03/19"),
    ('RAFAELA', "1999/10/125"),
    ('JOÃO', "2001/07/28");

-- Cadastrar 10 pacientes (animais) para a clínica de pelo menos 3 espécies diferentes
INSERT INTO animais VALUES
    ('REX', 'CACHORRO'),
    ('PLUTO', 'CACHORRO'),
    ('MAX', 'CACHORRO'),
    ('MIAU', 'GATO'),
    ('BOLINHA', 'GATO'),
    ('LUNA', 'PAPAGAIO'),
    ('TEWWTY', 'PAPAGAIO'),
    ('THOR', 'CACHORRO'),
    ('SIMBA', 'GATO'),
    ('POLI', 'PAPAGAIO');

-- Cadastre 20 consultas para estes médicos e pacientes com datas e valores diferentes
INSERT INTO consultas VALUES
    ('2026/03/11', 180, 3, 7),
    ('2026/04/07', 250, 1, 8),
    ('2026/04/15', 90, 5, 7),
    ('2026/03/11', 480, 3, 9),
    ('2026/04/20', 200, 2, 5),
    ('2026/05/02', 780, 4, 9),
    ('2026/05/03', 150, 3, 3),
    ('2026/05/04', 100, 4, 3),
    ('2026/05/10', 300, 1, 10),
    ('2026/05/10', 300, 1, 10),
    ('2026/05/18', 170, 3, 8),
    ('2026/05/23', 500, 2, 1),
    ('2026/05/29', 320, 4, 5),
    ('2026/06/01', 150, 5, 10),
    ('2026/06/07', 150, 1, 1),
    ('2026/06/12', 290, 4, 9),
    ('2026/06/15', 430, 2, 6),
    ('2026/06/24', 610, 1, 7),
    ('2026/06/30', 230, 5, 1),
    ('2026/07/02', 350, 3, 8),
    ('2026/07/05', 610, 5, 6);

-- 1. Selecione o maior valor pago por uma consulta
SELECT MAX(valor) AS maiorValor
FROM consultas;

-- 2. Selecione o valor médio, maior valor e menor valor das consultas realizadas no mês passado
SELECT
    AVG(valor) AS valorMedio,
    MAX(valor) AS maiorValor,
    MIN(valor) AS menorValor
FROM consultas
WHERE dataCons >= '2026/07/01' AND dataCons <= '2026/07/31';

-- 3. Cadastre uma nova consulta para um paciente que já está cadastrado


-- 4. Atualize o nome do médico cujo código é 3 para o seu nome
UPDATE veterinario SET nome = "IGOR"
WHERE codVet = 3;

-- 5. Selecione as espécies de pacientes que estão cadastrados.
SELECT DISTINCT(especies)
FROM animais;

-- 6. Quantas consultas você já realizou nesta clínica?
SELECT COUNT(*) as qtdeConsultas
FROM consultas
WHERE codVet = 3;

-- 7. Quantas consultas foram feitas por todos os médicos?
SELECT COUNT(*) as qtdeConsultas
FROM consultas

-- 8. Selecione, de forma exclusiva, as espécies de pacientes que estão cadastrados.
SELECT DISTINCT(especies)
FROM animais;

-- 9. Liste os nomes dos pacientes em ordem alfabética.
SELECT nomeAnimal
FROM animais
ORDER BY nomeAnimal;

SELECT especie, nomeAnimal
FROM animais
ORDER BY especie, nomeAnimal; -- Ordenação por mais de um campo

-- 10. Qual o valor total de todas as consultas feitas por você?
SELECT SUM(valor) AS valorTotal
FROM consultas
WHERE codVet = 3;

-- 11. Qual a quantidade de médicos que esta clínica possui?
SELECT COUNT(*) AS qtdeVeterinarios
FROM veterinarios;

-- 12. Quanto seria o total das consultas que você realizou se estas consultas tivessem um aumento de 10%?
SELECT valor * 1.1 AS valorAumento
FROM consultas
WHERE codVet = 3;

-- 13. Quantas consultas foram feitas por você entre os dias 01/01/2026 e 31/03/2026?
SELECT COUNT()
FROM CONSULTAS
WHERE codVet = 3 AND
dataCons >= '2026/01/01' AND dataCons <= '2026/03/31';