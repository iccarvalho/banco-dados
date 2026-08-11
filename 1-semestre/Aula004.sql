CREATE DATABASE Hospital;

USE Hospital;

CREATE TABLE especialidades(
    codEsp INT PRIMARY KEY IDENTITY(10, 10),
    nome VARCHAR(40)
);

CREATE TABLE medicos(
    codMed INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(80),
    idade INT, -- O correto é guardar a data de nascimento
    salario MONEY,
    codEsp INT FOREIGN KEY REFERENCES especialidades(codEsp)
);

-- Cadastro das especialidades:
INSERT INTO especialidades VALUES
    ('OTORRINO'),
    ('OBSTETRA'),
    ('PEDIATRA'),
    ('CARDIOLOGISTA'),
    ('DERMATOLOGISTA'),
    ('ORTOPEDISTA');

-- Cadastro dos médicos preenchendo TODOS os campos:
INSERT INTO medicos VALUES
    ('JOÃO', 48, 800, 10),
    ('JOSÉ', 35, 1200, 10),
    ('ANA', 47, 1400, 30),
    ('IVO', 51, 750, NULL),
    ('SILVIO', NULL, 2550, 20),
    ('ADÃO', 62, 1950, 50),
    ('EVA', 42, 800, NULL),
    ('JOANA', 39, 1200, 10),
    ('AFONSO', NULL, 800, 30);

-- Cadastro de médicos preenchendo apenas alguns campos (mais usado):
INSERT INTO medicos (nome, idade, salario) VALUES
    ('KARINA', 40, 750),
    ('CARLA', 41, 1950);

-- Cadastro de médicos preenchendo apenas alguns campos (mais usado):
INSERT INTO medicos (nome, salario) VALUES
    ('RODOLFO', 1330);

SELECT * FROM especialidades;
SELECT * FROM medicos;

-- Médicos com e sem especialidades
SELECT m.nome, e.nome
FROM medicos AS m
LEFT JOIN especialidades AS e
ON m.codEsp = e.codEsp;

-- Médicos com especialidade
SELECT m.nome, e.nome
FROM medicos AS m
INNER JOIN especialidades AS e
ON m.codEsp = e.codEsp;

-- Médicos sem especialidade
SELECT m.nome AS nomeMed, e.nome AS nomeEspec
FROM medicos AS m
LEFT JOIN especialidades AS e
ON m.codEsp = e.codEsp
WHERE e.codEsp IS NULL;
