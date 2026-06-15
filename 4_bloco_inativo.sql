DECLARE
    v_apoio CHAR;
BEGIN
    FOR item IN (SELECT id FROM clientes_e3) LOOP
        v_apoio := clientes_pkg.inativo(item.id);
    END LOOP;
END;


SHOW USER;

SELECT username
FROM all_users
ORDER BY username;