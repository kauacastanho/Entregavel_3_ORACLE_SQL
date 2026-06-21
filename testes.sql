BEGIN
    JOAO_20261.faturamento_pkg.processar_pedido(1);
    JOAO_20261.faturamento_pkg.processar_pedido(9);
    JOAO_20261.faturamento_pkg.processar_pedido(12);
    JOAO_20261.faturamento_pkg.processar_pedido(16);
    JOAO_20261.faturamento_pkg.processar_pedido(13);
    JOAO_20261.faturamento_pkg.processar_pedido(5);
    JOAO_20261.faturamento_pkg.processar_pedido(48);
    JOAO_20261.faturamento_pkg.processar_pedido(50);
END;   
/ 
 
DECLARE
    v_resultado CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_resultado := JOAO_20261.clientes_pkg.inativo(item.id);
        
        DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id ||' -> ' || v_resultado);
    END LOOP;
END;
/

DECLARE
    v_apoio CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_apoio := JOAO_20261.clientes_pkg.inativo(item.id);
        
        IF v_apoio = 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id || ' inativado.');
        END IF;
        
    END LOOP;
END;
/
