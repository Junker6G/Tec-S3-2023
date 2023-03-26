CREATE SCHEMA persona;
CREATE SCHEMA admision;

CREATE SEQUENCE persona.seq_idcontacto START 1;
CREATE SEQUENCE admision.seq_idmodalidad START 1;


create table persona.contacto
(
IDContacto int default nextval('persona.seq_idcontacto'),
Nombres varchar(30) not null,
Paterno varchar(30) not null,
Materno varchar(30) not null,
Genero char(1) default('0') not null,
DNI varchar(10) null,
FechaNac date null,
FechaCreacion date not null default now()
);

create table persona.postulante
(
IDPostulante char(10) not null ,
IDContacto int not null,
IDCarrera char(3) not null,
IDPerAcad char(6) not null,
IDModalidad int not null,
Puntaje int not null default(0),
AsistioExamen char(1) not null default('0'),
Ingreso char(1) not null default('0')
);

Create Table admision.perAcad
(
IDPerAcad char(6) not null ,
Periodo char(4),
Ano char(1)
);

create table admision.carrera
(
IDCarrera char(3) not null,
Nombre varchar(150) not null
);

create table admision.modalidad
(
IDModalidad int default nextval('admision.seq_idmodalidad'),
Modalidad varchar(100) not null
);

ALTER TABLE persona.contacto
ADD CONSTRAINT ck_Genero
CHECK (Genero in ('0','1'));

ALTER TABLE persona.postulante
ADD CONSTRAINT ck_asistioexamen
CHECK (asistioexamen in ('0','1'));

ALTER TABLE persona.postulante
ADD CONSTRAINT ck_ingreso
CHECK (ingreso in ('0','1'));

ALTER TABLE persona.postulante
add CONSTRAINT ck_puntaje
CHECK (
(asistioexamen = '1' and puntaje >=0)
or
(asistioexamen = '0' and puntaje =0)
);

--

ALTER TABLE admision.carrera
ADD CONSTRAINT uq_nombrecarrera
UNIQUE(Nombre);

ALTER TABLE persona.contacto
ADD CONSTRAINT uq_ContactoDNI
UNIQUE(DNI);

ALTER TABLE admision.modalidad
ADD CONSTRAINT uq_Modalidad
UNIQUE(Modalidad);

--

ALTER TABLE admision.perAcad
ADD CONSTRAINT pk_IDPerAcad
PRIMARY KEY(IDPerAcad);

ALTER TABLE admision.carrera
ADD CONSTRAINT pk_IDCarrera
PRIMARY KEY(IDCarrera);

ALTER TABLE persona.contacto
ADD CONSTRAINT pk_IDContacto
PRIMARY KEY(IDContacto);

ALTER TABLE persona.postulante
ADD CONSTRAINT pk_IDPostulante
PRIMARY KEY(IDPostulante);

ALTER TABLE admision.modalidad
ADD CONSTRAINT pk_IDModalidad
PRIMARY KEY(IDModalidad);

--

ALTER TABLE persona.postulante
ADD CONSTRAINT fk_IDCarrera
FOREIGN KEY(idcarrera)
references Admision.Carrera(IDCarrera);

ALTER TABLE persona.postulante
ADD CONSTRAINT fk_IDPerAcad
FOREIGN KEY(IDPerAcad)
references Admision.PerAcad(IDPerAcad);

ALTER TABLE persona.postulante
ADD CONSTRAINT fk_IDModalidad
FOREIGN KEY(IDModalidad)
references Admision.Modalidad(IDModalidad);

ALTER TABLE persona.postulante
ADD CONSTRAINT fk_IDContacto
FOREIGN KEY(IDContacto)
references Persona.Contacto(IDContacto);

--

ALTER TABLE persona.postulante
DROP CONSTRAINT fk_IDCarrera;

ALTER TABLE persona.postulante
DROP CONSTRAINT fk_IDPerAcad;

ALTER TABLE persona.postulante
DROP CONSTRAINT fk_IDModalidad;

ALTER TABLE persona.postulante
DROP CONSTRAINT fk_IDContacto;

--

ALTER TABLE admision.PerAcad
DROP CONSTRAINT pk_IDPerAcad;

ALTER TABLE admision.carrera
DROP CONSTRAINT pk_IDCarrera;

ALTER TABLE persona.contacto
DROP CONSTRAINT pk_IDContacto;

ALTER TABLE persona.postulante
DROP CONSTRAINT pk_IDPostulante;

ALTER TABLE admision.modalidad
DROP CONSTRAINT pk_IDModalidad;

--

ALTER TABLE admision.carrera
DROP CONSTRAINT uq_nombrecarrera;

ALTER TABLE persona.contacto
DROP CONSTRAINT uq_ContactoDNI;

ALTER TABLE admision.modalidad
DROP CONSTRAINT uq_Modalidad;

--

ALTER TABLE persona.contacto
DROP CONSTRAINT ck_Genero;

ALTER TABLE persona.postulante
DROP CONSTRAINT ck_asistioexamen;

ALTER TABLE persona.postulante
DROP CONSTRAINT ck_ingreso;

ALTER TABLE persona.postulante
DROP CONSTRAINT ck_puntaje;

--

ALTER TABLE admision.carrera
DROP COLUMN IDCarrera,
DROP COLUMN Nombre;

--

DROP TABLE admision.carrera;
DROP table persona.contacto;
DROP table persona.postulante;
DROP Table admision.PerAcad;
DROP TABLE admision.modalidad;

--

DROP SEQUENCE Persona.seq_idcontacto;
DROP SEQUENCE Admision.seq_idmodalidad;

--

DROP DATABASE clase22_3;
