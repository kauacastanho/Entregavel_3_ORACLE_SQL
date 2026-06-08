CREATE TABLE clientes_e3 (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    email VARCHAR2(70) NOT NULL UNIQUE,
    data_cadastro DATE NOT NULL,
    ativo NUMBER(1) DEFAULT 1 CHECK (ativo IN (0, 1))
);

CREATE TABLE produtos_e3 (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    nome VARCHAR2(50) NOT NULL,
    preco NUMBER NOT NULL,
    estoque NUMBER NOT NULL
);

CREATE TABLE pedidos_e3 (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    id_cliente NUMBER NOT NULL,
    data_pedido DATE NOT NULL,
    
    FOREIGN KEY (id_cliente) 
    REFERENCES clientes_e3(id)
);

CREATE TABLE pedido_itens_e3 (
    id NUMBER GENERATED AS IDENTITY PRIMARY KEY,
    id_pedido NUMBER NOT NULL,
    id_produto NUMBER NOT NULL, 
    quantidade NUMBER NOT NULL,
    preco_unit NUMBER NOT NULL,
    
    FOREIGN KEY (id_pedido)     
    REFERENCES pedidos_e3(id),
    
    FOREIGN KEY (id_produto) 
    REFERENCES produtos_e3(id)
);
