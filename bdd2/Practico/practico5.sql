--############################################################################################
--                  Practico 5 | Parte 1 - Joaquin Sellanes
--############################################################################################
-- S - Proveedores
-- P - Partes
-- J - Proyectos
-- SPJ - Envio
--############################################################################################

-- 1. Obtener los detalles completos de todos los proyectos
SELECT * FROM j;

-- 2. Obtener los detalles completos de todos los proyectos de Londres
SELECT * FROM j
WHERE ciudad = 'LONDRES';

-- 3. Obtener los números de los proveedores que suministran partes al proyecto J1, ordenados por número de proveedor
SELECT * FROM spj
WHERE j_j = 'J1'
ORDER BY s_s;

-- 4. Obtener todos los envíos en los cuales la cantidad está en el intervalo de 300 a 750 inclusive
SELECT * FROM spj
WHERE cant >= 300 AND
      cant <= 750;

-- 5. Obtener todas las tripletas número de proveedor / número de parte / número de proyecto tales que el proveedor,
-- la parte y el proyecto indicados estén todos en la misma ciudad.
SELECT spj.s_s, spj.j_j, spj.p_p FROM spj
JOIN j j2 on j2.j = spj.j_j
JOIN s s2 on s2.s = spj.s_s
WHERE j2.ciudad = s2.ciudad;

-- 6. Obtener los números de las partes suministradas por algún proveedor de Londres.
SELECT spj.p_p FROM spj
JOIN p p2 on p2.p = spj.p_p
WHERE p2.ciudad = 'LONDRES';

-- 7. Obtener los números de las partes suministradas por algún proveedor de Londres a un proyecto en Londres
SELECT spj.p_p FROM spj
JOIN s s2 on s2.s = spj.s_s
JOIN j j2 on j2.j = spj.j_j
WHERE s2.ciudad = 'LONDRES'
AND j2.ciudad = 'LONDRES';

-- 8. Obtener el número total de proyectos a los cuales suministra partes el proveedor S1.---> EN DUDA <---
SELECT count(*) as total_ind, spj.j_j FROM spj
WHERE spj.s_s='S1'
GROUP BY spj.j_j;

SELECT count(spj.j_j) as total FROM spj
WHERE spj.s_s='S1';

-- 9. Obtener la cantidad total de la parte P1 suministrada por el proveedor S1.
SELECT sum(cant) as total FROM spj
WHERE s_s='S1'
AND p_p='P1';

-- 10. Para cada parte suministrada a un proyecto, obtener el número de parte, el número de proyecto y la
-- cantidad total correspondiente.
SELECT spj.p_p as parte, spj.j_j as proyecto ,sum(cant) as total FROM spj
GROUP BY spj.p_p, spj.j_j
ORDER BY spj.j_j;

SET search_path = 'public';

-- 11. Obtener los números de partes suministradas a algún proyecto tales que la cantidad promedio
-- suministrada sea mayor que 320
SELECT spj.p_p, avg(cant) as promedio FROM spj
GROUP BY spj.p_p HAVING avg(cant) >= 320
ORDER BY spj.p_p;

-- 12. Obtener todos los envíos para los cuales la cantidad no sea nula
SELECT * FROM spj
WHERE cant IS NOT NULL;

-- 13. Obtener números de proyectos y ciudades en los cuales la segunda letra del nombre de la ciudad sea una “o”
SELECT * FROM j
WHERE ciudad LIKE '_O%';

-- 14. Obtener los nombres de los proyectos a los cuales suministra partes el proveedor S1
SELECT j2.jnombre as NombreProy FROM spj
JOIN j j2 on j2.j = spj.j_j
JOIN s s2 on s2.s = spj.s_s
WHERE s2.s = 'S1';

-- 15. Mostrar el resultado de la siguiente selección:
SELECT P.COLOR FROM P
UNION
SELECT P.COLOR FROM P;

-- ROJO
-- AZUL
-- VERDE

-- 16. Construir una lista ordenada de todas las ciudades en las cuales esté situado por lo menos un
-- proveedor, una parte o un Proyecto.
(SELECT ciudad FROM s
UNION
SELECT ciudad FROM j
UNION
SELECT ciudad FROM p)
ORDER BY ciudad;

-- 17. Obtener los números de los proveedores cuya situación sea inferior a la del proveedor S1.
SELECT * FROM s
WHERE s.situacion < (
        SELECT s.situacion FROM s
        WHERE s.s = 'S1'
    );

--############################################################################################
--                  Practico 5 | Parte 2 - Joaquin Sellanes
--############################################################################################

-- 1. Cambiar a color gris el color de todas las partes rojas
UPDATE p
SET color = 'GRIS'
WHERE color = 'ROJO';

-- 2. Eliminar todos los proyectos para los cuales no haya envíos.
DELETE FROM j
WHERE j NOT IN(
    SELECT j_j FROM spj
    );

-- 3. Insertar un nuevo proveedor (S10) en la tabla S. El nombre y la ciudad son ‘Salazar’ y ‘Nueva York’. La
-- situación es 25.
INSERT INTO s (s, snombre, situacion, ciudad) VALUES ('S10','Salazar',25,'Nueva York');

-- 4. Construir una tabla con los números de las partes suministradas por un proveedor de Londres.
CREATE VIEW view_prov_londres AS
    SELECT p2.p FROM spj
    JOIN s s2 on s2.s = spj.s_s
    JOIN p p2 on p2.p = spj.p_p
    WHERE s2.ciudad='LONDRES';

SELECT * FROM view_prov_londres;

--############################################################################################
--                  Practico 5 | Parte 3 - Joaquin Sellanes
--############################################################################################


-- 1. Obtener los nombres de los proyectos a los cuales suministra partes el proveedor S1
-- utilizando EXISTS en la solución
SELECT j2.j FROM j j2
WHERE EXISTS(
    SELECT spj.j_j FROM spj
    WHERE spj.j_j = j2.j AND spj.s_s='S1'
    );

SELECT spj.j_j FROM spj
    WHERE spj.s_s='S1';

-- 2. Obtener los números de los proyectos donde se utilice al menos una de las partes
-- suministradas por el proveedor S1, utilizando EXISTS en la solución.
SELECT j2.j FROM j j2
WHERE EXISTS(
    SELECT j_j FROM spj
    JOIN p p2 on p2.p = spj.p_p
    WHERE s_s='S1'
    AND j2.j = spj.j_j
    );

SELECT * FROM spj
JOIN p p2 on p2.p = spj.p_p
WHERE s_s='S1';


-- 3. Obtener los números de los proyectos para los cuales S1 es el único proveedor,
-- utilizando EXISTS en la solución.

SELECT spj.j_j, count(*) FROM spj
GROUP BY spj.j_j HAVING count(*)=1;

SELECT j2.j FROM j j2
join spj s on j2.j = s.j_j
            WHERE EXISTS(
                SELECT spj.j_j FROM spj
                WHERE spj.j_j = j2.j
                GROUP BY spj.j_j HAVING count(*)=1
                )
AND s.s_s='S1';