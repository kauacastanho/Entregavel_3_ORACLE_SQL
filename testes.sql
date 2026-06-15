-- Processando pedidos
BEGIN
    KAUA_20261.faturamento_pkg.processar_pedido(1);
    KAUA_20261.faturamento_pkg.processar_pedido(9);
    KAUA_20261.faturamento_pkg.processar_pedido(12);
    KAUA_20261.faturamento_pkg.processar_pedido(16);
    KAUA_20261.faturamento_pkg.processar_pedido(13);
    KAUA_20261.faturamento_pkg.processar_pedido(5);
    KAUA_20261.faturamento_pkg.processar_pedido(48);
    KAUA_20261.faturamento_pkg.processar_pedido(50);
END;   
/ 
 
-- Verificando os clientes que devem ser inativados
DECLARE
    v_resultado CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_resultado := KAUA_20261.clientes_pkg.inativo(item.id);
        
        DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id ||' -> ' || v_resultado);
    END LOOP;
END;
/

-- Inativando clientes
DECLARE
    v_apoio CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_apoio := KAUA_20261.clientes_pkg.inativo(item.id);
        
        IF v_apoio = 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id || ' inativado.');
        END IF;
        
    END LOOP;
END;
/