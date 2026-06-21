BEGIN
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(1);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(9);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(12);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(16);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(13);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(5);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(48);
    JOAOPEDRO_20261.faturamento_pkg.processar_pedido(50);
END;   
/ 
 
DECLARE
    v_resultado CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_resultado := JOAOPEDRO_20261.clientes_pkg.inativo(item.id);
        
        DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id ||' -> ' || v_resultado);
    END LOOP;
END;
/

DECLARE
    v_apoio CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_apoio := JOAOPEDRO_20261.clientes_pkg.inativo(item.id);
        
        IF v_apoio = 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id || ' inativado.');
        END IF;
        
    END LOOP;
END;
/
