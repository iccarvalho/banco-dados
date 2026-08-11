-- 1. Modelagem Relacional (DER)
/*
   [Categoria] (1,1) ------< (0,N) [Produto]
   - codCat                         - codProd
   - nomeCat                        - descricao
                                    - codBarra
                                    - estoque
*/


-- 2. Criação do Banco de Dados e Tabelas
CREATE DATABASE Revisao1Sem;
GO
USE Revisao1Sem;

CREATE TABLE categorias (
    codCat INT PRIMARY KEY IDENTITY(1,1),
    nomeCat VARCHAR(80)
);

CREATE TABLE produtos (
    codPro INT PRIMARY KEY IDENTITY(1,1),
    descricao VARCHAR(60),
    codBarra VARCHAR(100),
    estoque INT,
    codCat INT FOREIGN KEY REFERENCES categorias(codCat)
);


-- 3. Inserção de Dados
INSERT INTO categorias VALUES
    ('Limpeza'),
    ('Comida'),
    ('Higiene'),
    ('Pets');

INSERT INTO produtos VALUES
    ('Veja', '1', 0, 1),
    ('Arroz', '2', 3, 2),
    ('Farofa', '3', 4, 2),
    ('Macon', '4', 5, 2),
    ('Ração gato', '5', 7, 4),
    ('Papel hig.', '6', 11, 3),
    ('Pasta de dentes', '7', 10, 3),
    ('Sabão', '8', 23, 3);


-- 4. Atualizar estoque do produto com codProd = 4
UPDATE Pprodutos
SET estoque = 350
WHERE codProd = 4;


-- 5. Selecionar descrição, código de barras e estoque dos produtos com estoque maior que 500
SELECT descricao, codBarra, estoque
FROM produtos
WHERE estoque > 500;


-- 6. Deletar produtos pertencentes à categoria com codCat = 3
DELETE FROM produtos
WHERE codCat = 3;


-- 7. Inserir um novo produto especificando as colunas
INSERT INTO produtos (descricao, estoque, codCat)
VALUES ('Feijão', 3, 2);


-- 8. Remover a coluna codBarra da tabela Produtos
ALTER TABLE produtos
DROP COLUMN codBarra;


-- 9. Selecionar descrição e estoque ordenando pelo estoque em ordem decrescente
SELECT descricao, estoque
FROM produtos
ORDER BY estoque DESC;


-- 10. Adicionar nova coluna precoUnit na tabela Produtos
ALTER TABLE Produtos
ADD preco MONEY;


-- 11. Deletar produtos de determinadas categorias
DELETE FROM produtos
WHERE codCat = 1 OR codCat = 3 OR codCat = 5;

-- OU

DELETE FROM produtos
WHERE codCat IN(1, 3, 5);


-- 12. Atualizar o preço unitário (preco) com base no codProd usando CASE
UPDATE Produtos
SET preco = CASE codProd
    WHEN 2 THEN 10.01
    WHEN 4 THEN 9.99
    WHEN 6 THEN 21.19
    WHEN 7 THEN 22.22
    WHEN 8 THEN 44.12
END;


-- 13. Selecionar descrição do produto e nome da categoria com INNER JOIN
SELECT p.descricao, c.nomeCat
FROM produtos AS p
INNER JOIN categorias AS c
    ON p.codCat = c.codCat;


-- 14. Selecionar todas as categorias com seus produtos usando LEFT JOIN
SELECT *
FROM categorias AS c
LEFT JOIN produtos AS p
    ON p.codCat = c.codCat
WHERE p.codCat IS NULL;


-- 15. Reajustar o preço unitário dos produtos com estoque menor que 400
UPDATE produtos
SET preco = preco * 1.05
WHERE estoque < 400;