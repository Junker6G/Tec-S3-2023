CREATE TABLE dpto(
    id_dpto     INT         NOT NULL,
    nombre      VARCHAR(20) NOT NULL,
    PRIMARY KEY (id_dpto)
);

CREATE TABLE persona(
    ci          CHAR(8)     NOT NULL,
    nombre      VARCHAR(30) NOT NULL,
    apellido    VARCHAR(30) NOT NULL,
    id_dpto     INT,
    PRIMARY KEY (ci),
    FOREIGN KEY (id_dpto) REFERENCES dpto(id_dpto)
);

INSERT INTO dpto (id_dpto, nombre) VALUES ('1','RRHH');
INSERT INTO dpto (id_dpto, nombre) VALUES ('2','Operaciones');
INSERT INTO dpto (id_dpto, nombre) VALUES ('3','Comercial');
INSERT INTO dpto (id_dpto, nombre) VALUES ('4','Contabilidad');

INSERT INTO persona (ci, nombre, apellido) VALUES ('31249876','Maria','Rodriguez');
INSERT INTO persona (ci, nombre, apellido, id_dpto) VALUES ('12345678','Juan','Perez','2');
INSERT INTO persona (ci, nombre, apellido, id_dpto) VALUES ('98765432','Ana','Diaz','1');

--

SELECT p.nombre, p.apellido, d.nombre FROM persona p
JOIN dpto d on d.id_dpto = p.id_dpto;

SELECT p.nombre, p.apellido, d.nombre FROM persona p
LEFT JOIN dpto d on d.id_dpto = p.id_dpto;

SELECT p.nombre, p.apellido, d.nombre FROM persona p
RIGHT JOIN dpto d on d.id_dpto = p.id_dpto;

SELECT p.nombre, p.apellido, d.nombre FROM persona p
FULL JOIN dpto d on d.id_dpto = p.id_dpto;

SELECT p.nombre, p.apellido, d.nombre FROM persona p
LEFT JOIN dpto d on d.id_dpto = p.id_dpto
UNION
SELECT p.nombre, p.apellido, d.nombre FROM persona p
RIGHT JOIN dpto d on d.id_dpto = p.id_dpto;

SELECT d.nombre FROM persona p
FULL JOIN dpto d on d.id_dpto = p.id_dpto
WHERE p.nombre is NULL;

---------------------------------------------------

SELECT m.ci, m.nombre FROM miembros m 
JOIN  reservas r ON m.ci=r.ciMiembro
GROUP BY r.fecha HAVING count(r.*) > 1