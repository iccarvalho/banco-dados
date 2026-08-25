CREATE DATABASE Aula003;
GO;
USE Aula003;

-- Restrições de integridade

CREATE TABLE professores (
    codProf INT CONSTRAINT pk_codProf PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(80) NOT NULL,
    RG NUMERIC(12) UNIQUE,
    sexo CHAR(1) CHECK(sexo IN ('M', 'F')),
    idade INT CHECK(idade BETWEEN 21 AND 80),
    cidade VARCHAR(50) CONSTRAINT DF_Prof_cidade DEFAULT('FRANCA'),
    titulacao VARCHAR(15) CONSTRAINT chk_tit CHECK(titulacao IN ('GRADUADO', 'ESPECIALISTA', 'MESTRE', 'DOUTOR')),
    categoria VARCHAR(15) CHECK(categoria IN ('AUXILIAR', 'ASSISTENTE', 'ADJUNTO', 'TITULAR')),
    salario MONEY CHECK(salario >= 500)
);

SELECT * FROM professores;

INSERT INTO professores (nome, RG, sexo, idade, titulacao, categoria, salario)
VALUES ('JOÃO', 123456, 'M', 30, 'GRADUADO', 'AUXILIAR', 2000);

ALTER TABLE professores
ADD CONSTRAINT ch_titulacao_salario CHECK
(
    (titulacao = 'GRADUADO' AND salario < 1000)
    OR
    (titulacao <> 'GRADUADO')
);

INSERT INTO professores (nome, RG, sexo, idade, titulacao, categoria, salario)
VALUES ('PEDRO', 7891011, 'M', 25, 'DOUTOR', 'ASSISTENTE', 8000);