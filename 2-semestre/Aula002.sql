USE Revisao1Sem; 

-- Funções de agregação

-- MAX -> retorna o valor máximo
SELECT MAX(estoque) as maiorEstoque FROM Produtos;

-- MIN -> retorna o valor minimo
SELECT MIN(estoque) as menorEstoque FROM Produtos;


-- Campo Calculado
SELECT descricao, estoque, preco, estoque * preco AS valorEstoque
FROM produtos;

-- Qual seria o novo preço dos produtos se aplicasse 10% de acréscimo?
SELECT preco, preco * 1.1 AS precoReajustado
FROM produtos;

-- SUM -> retorna a soma
SELECT SUM(preco) AS precoTotal
FROM produtos;

SELECT SUM(estoque * preco) AS valorTotalEstoque
FROM produtos;


-- AVG -> calcula a média
SELECT AVG(preco) AS precoMedio
FROM produtos;


-- ROUND -> arredondamento
SELECT ROUND(12345.6789, 2); -- 12345.6800

SELECT ROUND(AVG(preco), 2) AS precoMedio
FROM produtos;


-- COUNT -> conta o número de ocorrências
SELECT COUNT(descricao) FROM produtos; -- Retorna quantas ocorrências estão com o campo 'descricao' preenchido

SELECT COUNT(*) AS contagem FROM produtos; -- Retorna a quantidade de linhas na tabela

SELECT COUNT(*) - COUNT(codCat) AS totalSemCategoria
FROM produtos; -- Retorna a quantidade de produtos sem categoria


-- DISTINCT -> seleciona linhas exclusivas
SELECT DISTINCT(codCat) AS categoriasProdutos
FROM produtos;

SELECT * FROM produtos;