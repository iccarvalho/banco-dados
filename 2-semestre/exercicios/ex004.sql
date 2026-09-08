-- 1. Crie uma tabela para cadastro de Funcionários, obedecendo as seguintes regras:
--  Um campo para código deverá ser chave primária com numeração automática,
--	Defina as chaves de todas as demais tabelas desta forma.
--	Nome é um atributo obrigatório;
--	CPF e RG são atributos que têm valor único para cada funcionário;
--	Sexo poderá ser: 'M' ou 'F';
--	Categoria deverá ser um dos seguintes valores: Auxiliar, Supervisor, Terceirizado, Contratado, Coordenador.
--	Idade deve estar entre 16 e 65 anos;
--	Código de departamento que este funcionário trabalha.

CREATE DATABASE Ex004;
GO;
USE Ex004;

CREATE TABLE funcionarios (
    codFunc INT CONSTRAINT pk_codFunc PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(80) NOT NULL,
    CPF VARCHAR(15) UNIQUE,
    RG VARCHAR(12) UNIQUE,
    sexo CHAR(1) CONSTRAINT chk_sexo CHECK(sexo IN ('M', 'F')),
    categoria VARCHAR(30) CONSTRAINT chk_categoria CHECK(categoria IN ('Auxiliar', 'Supervisor', 'Terceirizado', 'Contratado', 'Coordenador')),
    idade INT CONSTRAINT chk_idade CHECK(idade > 16 AND idade < 65),
    codDep INT -- CONSTRAINT FK_codDep FOREIGN KEY REFERENCES departamentos(codDep) 
);

-- 2. Crie uma tabela para cadastro de Departamentos, com as seguintes restrições:
--	Um campo para código do departamento também com numeração automática
--	Nome do departamento é atributo obrigatório
--	Descrição do departamento
--	Código do funcionário gerente do departamento.

CREATE TABLE departamentos (
    codDep INT CONSTRAINT pk_codDep PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(30) NOT NULL,
    descricao VARCHAR(255),
    codGerente INT CONSTRAINT fk_codGerente FOREIGN KEY REFERENCES funcionarios(codFunc) 
);

-- 3. Crie uma tabela para cadastro de Projetos
--	Código do projeto é atributo obrigatório com numeração automática a partir de 100
--	Nome é atributo obrigatório
--	Descrição do projeto

CREATE TABLE projetos (
    codProj INT CONSTRAINT pk_codProj PRIMARY KEY IDENTITY(100, 1),
    nome VARCHAR(50) NOT NULL,
    descricao VARCHAR(255)
);

-- 4. Crie uma tabela para registrar a participação dos funcionários em projetos
--  Código do funcionário deverá ser obrigatório
--	Código do projeto deverá também ser obrigatório
--	Data de início da participação no projeto
--	Data de fim da participação do projeto
--	- A data de início deverá ser menor que a data de fim

CREATE TABLE participacao (
    codFunc INT CONSTRAINT fk_codFunc FOREIGN KEY REFERENCES funcionarios(codFunc),
    codProj INT CONSTRAINT fk_codProj FOREIGN KEY REFERENCES projetos(codProj),
    dataIni DATETIME,
    dataFim DATETIME,

    CONSTRAINT chk_dataIni CHECK(dataIni < dataFim)
);

-- 5. Altere a tabela Funcionário criando uma ligação com a tabela de departamentos
ALTER TABLE funcionarios
ADD CONSTRAINT fk_codDep FOREIGN KEY (codDep) REFERENCES departamentos(codDep)

-- 6. Crie uma restrição do tipo Chave Primária composta para a tabela Participação para os campos CodFun e CodProj
ALTER TABLE participacao
ADD CONSTRAINT pk_codFunc_codProj PRIMARY KEY(codFunc, codProj);