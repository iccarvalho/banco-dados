USE Hospital;

CREATE TABLE pacientes(
    codPac INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(80),
    fone VARCHAR(30)
);

CREATE TABLE consultas(
    codCons INT PRIMARY KEY IDENTITY(1, 1),
    data DATE,
    convenio VARCHAR(50),
    codMed INT FOREIGN KEY REFERENCES medicos(codMed) NOT NULL, -- Campo obrigatório
    codPac INT FOREIGN KEY REFERENCES pacientes(codPac) NOT NULL -- Campo obrigatório
);

SELECT m.nome as nomeMedico, c.data, p.nome AS nomePaciente FROM
    medicos AS m INNER JOIN consultas AS c
        ON m.codMed = c.codMed
    INNER JOIN pacientes AS p
        ON p.codPac = c.codPac
    INNER JOIN especialidades AS e
        ON e.codEsp = m.codEsp
WHERE
    c.data >= '2026/05/01' AND c.data <= '2026/06/31'
    AND e.nome = 'PEDIATRA';
