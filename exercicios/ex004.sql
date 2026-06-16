USE Hospital;

SELECT * FROM medicos;
SELECT * FROM especialidades;
SELECT * FROM consultas;
SELECT * FROM pacientes;

-- 1) Cadastre 6 pacientes
INSERT INTO pacientes VALUES
    ('PEDRO', '1384372843'),
    ('MARIA', '20482394839'),
    ('RITA', '39483905323'),
    ('RAFAEL', '2033283429'),
    ('PALOMA', '1103482923'),
    ('AUGUSTO', '1693240324');

-- 2) Cadastre 10 consultas para médicos e pacientes diversos
INSERT INTO consultas VALUES
    ('2025/12/31', 'SUS', 3, 2),
    ('2026/01/10', 'SUS', 3, 4),
    ('2026/01/20', 'UNIMED', 5, 2),
    ('2026/01/15', 'UNIMED', 1, 3),
    ('2025/12/28', 'SUS', 8, 6),
    ('2025/12/28', 'SUS', 3, 4),
    ('2026/01/17', 'UNIMED', 5, 1),
    ('2026/01/22', 'SUS', 7, 4),
    ('2026/01/15', 'SUS', 6, 2),
    ('2026/01/14', 'SUS', 4, 4);

-- 3) Atualize o nome do Médico 'JOÃO' para 'JOÃO DA SILVA'
UPDATE medicos SET nome = 'JOÃO DA SILVA'
WHERE nome = 'JOÃO';

-- 4) A data da consulta número 3 é 15/maio/2026 (atualize essa informação)
UPDATE consultas SET data = '2026/05/15'
WHERE codCons = 3;

-- 5) Exclua a primeira consulta cadastrada
DELETE consultas
WHERE codCons = 1;

-- 6) Liste os nomes dos médicos e a especialidade de cada um.
SELECT m.nome, e.nome AS espMedica
FROM medicos AS m INNER JOIN especialidades AS e
ON m.codEsp = e.codEsp;

-- 7) Liste os médicos que não têm especialidades.
SELECT nome, codEsp FROM medicos
WHERE codEsp is NULL;

-- 8) Liste as consultas feitas pelo convêncio UNIMED no mês de abril.
SELECT * FROM consultas
WHERE convenio = 'UNIMED'
    AND
    data BETWEEN '2026/04/01' AND '2026/04/30';

-- 9) Liste os nomes dos pacientes e os convênios que usaram nas suas consultas.
SELECT p.nome, c.convenio
FROM pacientes AS p INNER JOIN consultas AS c
ON p.codPac = c.codPac;

-- 10) Liste os telefones dos pacientes que nunca consultaram.
SELECT p.nome, p.fone, c.data
FROM pacientes AS P LEFT JOIN consultas AS c
ON p.codPac = c.codPac
WHERE c.codPac IS NULL;

-- 11) Liste os convênios das consultas feitas por DERMATOLOGISTA.
SELECT c.convenio, m.nome, e.nome AS espMedica
FROM consultas AS c INNER JOIN medicos AS m
ON c.codMed = m.CodMed
    INNER JOIN especialidades AS e
    ON m.codEsp = e.codEsp
WHERE e.nome = 'DERMATOLOGISTA';

-- 12) Liste os nomes e fones dos pacientes atendidos por PEDIATRAS ou DERMATOLOGISTAS em abril/2026.
SELECT p.nome as nomePaciente, p.fone
FROM especialidades AS e INNER JOIN medicos AS m
ON e.codEsp = m.codEsp
    INNER JOIN consultas AS c
    ON c.codMed = m.codMed
        INNER JOIN pacientes AS p
        ON c.codPac = p.codPac
WHERE
    (e.nome = 'PEDIATRA' OR e.nome = 'DERMATOLOGISTA')
    AND
    data BETWEEN '2025/04/01' AND '2026/04/30';

-- 13) Cadastre a especialidade 'NEUROLOGISTA' e atualize as especialidades de 2 médicos para esta nova.
INSERT INTO especialidades VALUES
    ('NEUROLOGISTA');

UPDATE medicos SET codEsp = 70
WHERE nome = 'KARINA' OR nome = 'RODOLFO';

-- 14) Crie 3 consultas para médicos NEUROLOGISTAS no mês de maio/2026.
INSERT INTO consultas VALUES
    ('2026/05/05', 'UNIMED', 12, 5),
    ('2026/05/18', 'UNIMED', 12, 1),
    ('2026/05/20', 'SUS', 10, 6);

-- 15) As consultas feitas pelos PEDIATRAS em abril/2026 devem se somente do convênio 'SUS'. Atualize essa informação.
