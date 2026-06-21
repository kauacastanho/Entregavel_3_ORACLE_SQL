DECLARE
    v_id_pedido NUMBER;
    v_cliente NUMBER;
BEGIN
    FOR i IN 1..15 LOOP

        v_cliente := MOD(i, 15) + 1;

        INSERT INTO pedidos_e3(id_cliente, data_pedido)
        VALUES (v_cliente, SYSDATE)
        RETURNING id INTO v_id_pedido;

        INSERT INTO pedido_itens_e3(id_pedido, id_produto, quantidade, preco_unit)
        VALUES (v_id_pedido, 1, 1, 3500);

        faturamento_pkg.processar_pedido(v_id_pedido);

        DBMS_OUTPUT.PUT_LINE('-------------------------');

    END LOOP;
END;
/
