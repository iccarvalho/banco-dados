-- 1. Observe o DER apresentado e crie o banco de dados correspondente. As chaves primárias de todas as tabelas deverão ter numeração automática.
CREATE DATABASE Ex002;
GO;
USE Ex002;

CREATE TABLE quartos(
    codQuarto INT PRIMARY KEY IDENTITY(1, 1),
    tipo VARCHAR(30),
    numero INT,
    andar VARCHAR(30),
);

CREATE TABLE hospedes(
    codHospede INT PRIMARY KEY IDENTITY(1, 1),
    nome VARCHAR(30),
    idade INT,
    sexo CHAR(1)
);

CREATE TABLE reservas(
    codReserva INT PRIMARY KEY IDENTITY(1, 1),
    dtEntrada DATE,
    dtSaida DATE,
    codHospede INT FOREIGN KEY REFERENCES hospedes(codHospede),
    codQuarto INT FOREIGN KEY REFERENCES quartos(codQuarto)
);

CREATE TABLE pagamentos(
    codPagto INT PRIMARY KEY IDENTITY(1, 1),
    valor MONEY,
    dtPagto DATE,
    codReserva INT FOREIGN KEY REFERENCES reservas(codReserva)
);

CREATE TABLE refeicoes(
    codConsumo INT PRIMARY KEY IDENTITY(1, 1),
    descRefeicao VARCHAR(30),
    valor MONEY,
    codReserva INT FOREIGN KEY REFERENCES reservas(codReserva)
);

-- 2. Cadastre 5 quartos, 8 hóspedes, 4 reservas e 6 refeições.
INSERT INTO quartos VALUES
    ('Individual', 101, '1º Andar'),
    ('Individual', 102, '1º Andar'),
    ('Duplo/Casal', 201, '2º Andar'),
    ('Superior Master', 202, '2º Andar'),
    ('Superior Master', 302, '3º Andar');

INSERT INTO hospedes VALUES
    ('João da Silva', 35, 'M'),
    ('Maria Santos', 28, 'F'),
    ('Ana Oliveira', 42, 'F'),
    ('Carlos Souza', 50, 'M'),
    ('Beatriz Lima', 23, 'F'),
    ('Fernanda Costa', 31, 'F'),
    ('Lucas Pereira', 29, 'M'),
    ('Mariana Rocha', 38, 'F');

INSERT INTO reservas VALUES
    ('2024-12-10', '2024-12-15', 1, 3),
    ('2025-02-01', '2025-02-08', 2, 4),
    ('2024-11-20', '2024-11-25', 3, 1),
    ('2025-02-10', '2025-02-18', 6, 5);

INSERT INTO refeicoes VALUES
    ('Café da Manhã', 35.00, 1),
    ('Prato Executivo', 65.00, 1),
    ('Jantar Especial', 90.00, 2),
    ('Prato Executivo', 65.00, 2),
    ('Café da Manhã', 35.00, 3),
    ('Jantar Especial', 110.00, 4);

-- 3. Qual a quantidade de quartos do tipo ‘Superior Master’ existe neste hotel?
SELECT COUNT(*)
FROM quartos
WHERE tipo = 'Superior Master';

-- 4. Qual o valor médio pago por uma refeição?
SELECT AVG(valor) as valorMedio
FROM refeicoes;

-- 5. Exclua o campo Idade e crie um campo para guardar a data de nascimento dos hóspedes.
ALTER TABLE hospedes
DROP COLUMN idade;

ALTER TABLE hospedes
ADD dataNasc DATE;

-- 6. Quantos hóspedes fizeram reserva neste hotel?
SELECT COUNT(DISTINCT(codHospede)) AS qtdeHospedes
FROM reservas;

-- 7. Selecione os nomes dos hóspedes e as datas de entradas das suas reservas.
SELECT h.nome, r.dtEntrada
FROM hospedes AS h
INNER JOIN reservas AS r
ON h.codHospede = r.codHospede;

-- 8. Atualize as datas de nascimentos de cada hóspede.
UPDATE hospedes
SET dataNasc = CASE codHospede
    WHEN 1 THEN '1989-05-15'
    WHEN 2 THEN '1996-08-20'
    WHEN 3 THEN '1982-01-10'
    WHEN 4 THEN '1974-11-30'
    WHEN 5 THEN '2001-03-25'
    WHEN 6 THEN '1993-07-12'
    WHEN 7 THEN '1995-09-05'
    WHEN 8 THEN '1986-12-18'
END;

-- 9. Selecione os nomes dos hóspedes, juntamente com as datas de entrada das hospedagens que aconteceram antes do dia 01/01/2025. Faça esta lista mostrando os hóspedes em ordem alfabética.
SELECT h.nome, r.dtEntrada
FROM hospedes AS h
INNER JOIN reservas AS r
ON h.codHospede = r.codHospede
WHERE r.dtEntrada < '2025-01-01'
ORDER BY h.nome;

-- 10. Selecione os nomes das mulheres que já se hospedaram no 4º andar.
SELECT h.nome
FROM hospedes AS h
INNER JOIN reservas AS r
ON h.codHospede = r.codHospede
    INNER JOIN quartos AS q
    ON r.codQuarto = q.codQuarto
WHERE h.sexo = 'F' AND q.andar = '4º Andar';

-- 11. Selecione os números e tipos dos quartos que ainda não tiveram reservas.
SELECT q.numero, q.tipo
FROM quartos AS q
LEFT JOIN reservas AS r
ON q.codQuarto = r.codQuarto
WHERE r.codReserva IS NULL;

-- 12. O hóspede ‘João da Silva’ pagou quanto por suas hospedagens?
SELECT SUM(p.valor) AS valorHospedagem
FROM hospedes AS h
INNER JOIN reservas AS r
ON h.codHospede = r.codHospede
    INNER JOIN pagamentos AS p
    ON r.codReserva = p.codReserva
WHERE h.nome = 'João da Silva';

-- 13. Quantos hóspedes ficaram hospedados mais de 5 dias durantes o mês de fevereiro deste ano?
SELECT COUNT(DISTINCT(codHospede)) AS qtdeHospedes
FROM reservas
WHERE DATEDIFF(DAY, dtEntrada, dtSaida) > 5
AND MONTH(dtEntrada) = 2;


SELECT * FROM quartos;
SELECT * FROM hospedes;
SELECT * FROM reservas;
SELECT * FROM refeicoes;
SELECT * FROM pagamentos;
