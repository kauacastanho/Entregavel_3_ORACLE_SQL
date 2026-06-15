CREATE OR REPLACE PACKAGE faturamento_pkg AS
    PROCEDURE processar_pedido(p_id_pedido IN NUMBER);
END;
/

CREATE OR REPLACE PACKAGE BODY faturamento_pkg AS
    msg_erro VARCHAR2(200);
    
    PROCEDURE registrar_falha(
        p_id_pedido IN NUMBER
    )IS
    BEGIN
        INSERT INTO log_erros(pedido_id, data_erro, mensagem_erro) VALUES
        (p_id_pedido, SYSDATE, msg_erro);
        
        COMMIT;
        EXCEPTION
            WHEN OTHERS THEN
            ROLLBACK; 
            DBMS_OUTPUT.PUT_LINE('Erro ao registrar falha: ' || SQLERRM);
    END;


    FUNCTION verificar_estoque (
        p_id_produto IN NUMBER,
        p_qtd IN NUMBER
    )RETURN CHAR
    IS
        v_estoque NUMBER;
    BEGIN
        SELECT estoque 
        INTO v_estoque 
        FROM produtos_e3
        WHERE id = p_id_produto;
        
        IF v_estoque >= p_qtd THEN
            RETURN 'V';
        ELSE 
            RETURN 'F';
        END IF;
        
        EXCEPTION 
            WHEN NO_DATA_FOUND THEN
                RETURN 'F';
            WHEN OTHERS THEN
                RETURN 'F';
    END;

    
    PROCEDURE processar_pedido (
        p_id_pedido IN NUMBER
    )IS
        v_total_pedido NUMBER := 0;
    BEGIN 
    
        FOR item IN (SELECT id_produto, quantidade FROM pedido_itens_e3 WHERE id_pedido = p_id_pedido) LOOP

            IF verificar_estoque(item.id_produto, item.quantidade) = 'F' THEN
                msg_erro := 'Pedido ' || p_id_pedido || ': estoque insuficiente para o produto ' || item.id_produto;
                registrar_falha(p_id_pedido);
                DBMS_OUTPUT.PUT_LINE(msg_erro);
                
                RETURN;
            END IF;

        END LOOP;

       FOR item IN (SELECT id_produto, quantidade, preco_unit FROM pedido_itens_e3 WHERE id_pedido = p_id_pedido) LOOP

            UPDATE produtos_e3
            SET estoque = estoque - item.quantidade
            WHERE id = item.id_produto;

            v_total_pedido := v_total_pedido + (item.preco_unit * item.quantidade);

        END LOOP;

        DBMS_OUTPUT.PUT_LINE('Pedido ' || p_id_pedido || ' - Total: R$ ' || v_total_pedido);

        COMMIT;

        EXCEPTION
            WHEN OTHERS THEN
                msg_erro := SQLERRM;
                registrar_falha(p_id_pedido);
                ROLLBACK;
                DBMS_OUTPUT.PUT_LINE('Erro ao processar pedido: ' || p_id_pedido || ' ' || SQLERRM);
    END;

END faturamento_pkg;
/

