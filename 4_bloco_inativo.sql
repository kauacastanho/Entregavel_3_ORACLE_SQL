DECLARE
    v_apoio CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_apoio := clientes_pkg.inativo(item.id);
        
        IF v_apoio = 'V' THEN
            DBMS_OUTPUT.PUT_LINE('Cliente ' || item.id || ' inativado.');
        END IF;
        
    END LOOP;
END;
