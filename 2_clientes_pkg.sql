-- PACOTE INCOMPLETO, MAS NA IDEIA


CREATE OR REPLACE PACKAGE clientes_pkg AS
    FUNCTION inativo(p_id_cliente IN NUMBER) RETURN CHAR;
    PROCEDURE inativar_clientes;
END;
/

CREATE OR REPLACE PACKAGE BODY clientes_pkg AS
    -- Função que retorna V caso o cliente não tenha pedidos nos últimos 365 dias
    FUNCTION inativo (
        p_id_cliente NUMBER
    )RETURN CHAR
    IS
        v_qtd_pedidos NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_qtd_pedidos
        FROM pedidos_e3
        WHERE id_cliente = p_id_cliente AND data_pedido >= SYSDATE - 365;
        
        IF v_qtd_pedidos = 0 THEN
            inativar_clientes(p_id_cliente);
            RETURN 'V';
        ELSE
            RETURN 'F';
        END IF;
    END;
    
    -- Procedure que inativa clientes se a função inativo() for verdadeira
    PROCEDURE inativar_clientes (
        p_id_cliente NUMBER
    )IS
        v_ativo NUMBER;
    BEGIN
        SELECT ativo 
        INTO v_ativo
        FROM clientes_e3
        WHERE id = p_id_cliente;
        
        IF v_ativo = 1 THEN
            UPDATE clientes_e3 SET ativo = 0 WHERE id = p_id_cliente;
        END IF;
    END;
END clientes_pkg;
/

