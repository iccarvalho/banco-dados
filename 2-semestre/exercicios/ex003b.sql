CREATE TABLE TB_CLIENTE ( 
    codCliente INT IDENTITY(1, 1) NOT NULL, 
    nome VARCHAR(50) NOT NULL, 
    telefone VARCHAR(20) NOT NULL, 
    tipo_cliente VARCHAR(20) NOT NULL, 
    dt_cadastro DATETIME DEFAULT GETDATE() NOT NULL, 
    nr_dependentes INT NOT NULL, 
    
    CONSTRAINT pk_cliente PRIMARY KEY(codCliente), 
    CONSTRAINT tipos_clientes CHECK(tipo_cliente IN ('Titular', 'Dependente')), 
    CONSTRAINT nr_dependentes_cliente CHECK(nr_dependentes BETWEEN 0 AND 3) 
)