CREATE TABLE teste (
    id INT PRIMARY KEY,
    campoA VARCHAR(50) NOT NULL,
    campoB VARCHAR(50) NULL
)

-- Transação de autoconfirmação (executadas uma a uma)
INSERT INTO teste VALUES (1, 'Um texto qualquer', 'Outro texto')
INSERT INTO teste VALUES (1, null, 'Novo texto')
INSERT INTO teste VALUES (1, 'Terceiro qualquer', 'Nova tentativa')

SELECT * FROM teste

-- Transação explícita
BEGIN TRANSACTION testeTran
    BEGIN TRY
        INSERT INTO teste VALUES (1, 'Um texto qualquer', 'Outro texto')
        INSERT INTO teste VALUES (1, null, 'Novo texto')
        INSERT INTO teste VALUES (1, 'Terceiro qualquer', 'Nova tentativa')
        COMMIT TRANSACTION testeTran
    END TRY
    BEGIN CATCH
        SELECT  ERROR_NUMBER() AS NumeroErro,
                ERROR_LINE() AS LinhaComErro,
                ERROR_MESSAGE() AS MensagemErro
        ROLLBACK TRANSACTION testeTran
    END CATCH

-- Transação implícita
SET IMPLICIT_TRANSACTIONS ON

SELECT @@TRANCOUNT

CREATE TABLE NovoTeste (
    id INT PRIMARY KEY,
    nome VARCHAR(40),
    sexo VARCHAR(1)
)

SELECT @@TRANCOUNT
INSERT INTO NovoTeste VALUES (500, 'MACHADO DE ASSIS', 'M')
SELECT * FROM NovoTeste
SELECT @@TRANCOUNT

COMMIT

PRINT @@TRANCOUNT
BEGIN TRAN
    PRINT @@TRANCOUNT
    BEGIN TRAN
        PRINT @@TRANCOUNT
    COMMIT
    PRINT @@TRANCOUNT
COMMIT
PRINT @@TRANCOUNT
