CREATE OR REPLACE PACKAGE clientes_pkg AS
    FUNCTION inativo(p_id_cliente IN NUMBER) RETURN CHAR;
    PROCEDURE inativar_clientes;
END;
/

CREATE OR REPLACE PACKAGE BODY clientes_pkg AS

    FUNCTION inativo(
        p_id_cliente IN NUMBER
    ) RETURN CHAR
    IS
        v_qtd_pedidos NUMBER;
    BEGIN
        SELECT COUNT(*)
        INTO v_qtd_pedidos
        FROM pedidos_e3
        WHERE id_cliente = p_id_cliente
        AND data_pedido >= SYSDATE - 365;

        IF v_qtd_pedidos = 0 THEN
            RETURN 'V';
        ELSE
            RETURN 'F';
        END IF;

    EXCEPTION
        WHEN OTHERS THEN
            RETURN 'F';
    END;


    PROCEDURE inativar_clientes
    IS
    BEGIN
        FOR cliente IN (
            SELECT id
            FROM clientes_e3
        ) LOOP

            IF inativo(cliente.id) = 'V' THEN
                UPDATE clientes_e3
                SET ativo = 0
                WHERE id = cliente.id;

                DBMS_OUTPUT.PUT_LINE('Cliente ' || cliente.id || ' inativado.');
            END IF;

        END LOOP;

        COMMIT;

    EXCEPTION
        WHEN OTHERS THEN
            ROLLBACK;
            DBMS_OUTPUT.PUT_LINE('Erro ao inativar clientes: ' || SQLERRM);
    END;

END clientes_pkg;
/
