drop database mutual;
create database mutual;
use mutual;

CREATE TABLE tipo_usuario (
					tipo_usuario_id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    tipo            VARCHAR(20) UNIQUE NOT NULL,
                    descripcion     VARCHAR(240)
                    );

CREATE TABLE usuarios (
                    user_id   INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    tipo_id   INT(2) UNSIGNED ,
                    apellido  VARCHAR(50) NOT NULL,
                    nombre    VARCHAR(50) NOT NULL,
                    password  VARCHAR(16) NOT NULL,
                    tipo_doc  VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DNI', 'Pasaporte') ),
                    num_doc   VARCHAR(12) NOT NULL UNIQUE,
                    domicilio VARCHAR(240),
                    FOREIGN KEY (tipo_id) REFERENCES tipo_usuario(tipo_usuario_id)
                   );

CREATE TABLE planes_prepagas (
					plan_id     INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    nombre      VARCHAR(60) NOT NULL,
                    precio      DECIMAL(10,2) NOT NULL,
                    descripcion VARCHAR(240)
				    );
 
CREATE TABLE prepagas (
                    prepaga_id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    nombre     VARCHAR(60) NOT NULL
                    );

CREATE TABLE rel_prepagas_planes (
					prepaga_id INT(2) UNSIGNED NOT NULL,
                    plan_id    INT(2) UNSIGNED NOT NULL,
                    PRIMARY KEY (prepaga_id, plan_id),
                    FOREIGN KEY (prepaga_id) REFERENCES prepagas(prepaga_id),
                    FOREIGN KEY (plan_id)    REFERENCES planes_prepagas(plan_id)
                    );

CREATE TABLE tipo_asociado (
				    tipo_asociado_id INT(2) UNSIGNED PRIMARY KEY NOT NULL,
                    tipo             VARCHAR(2) NOT NULL,
                    descripcion      VARCHAR(50)
                    );
                    
CREATE TABLE motivos_baja (
					motivo_baja_id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
					codigo_baja    CHAR(2) NOT NULL UNIQUE,
                    nombre         VARCHAR(40) NOT NULL,
					descripcion    VARCHAR(240)
					);

CREATE TABLE descuentos (
					descuento_id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
					descripcion  VARCHAR(60) NOT NULL
                    );

CREATE TABLE asociados (
				  	num_asoc    INT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    tipo_id     INT(2) UNSIGNED NOT NULL,
                    prepaga_id  INT(2) UNSIGNED NOT NULL,
                    plan_id     INT(2) UNSIGNED NOT NULL,
                    desc_id     INT(2) UNSIGNED,
                    cod_desc    INT(8) UNSIGNED,
                    legajo      INT(8) UNSIGNED UNIQUE NOT NULL,
                    ex_legajo   INT(8) UNSIGNED,
                    fec_ingreso DATE NOT NULL,
                    fec_baja    DATE,
                    apellido    VARCHAR(50) NOT NULL,
                    nombre      VARCHAR(50) NOT NULL,
                    domicilio   VARCHAR(240) NOT NULL,
                    provincia   VARCHAR(30),
                    ciudad      VARCHAR(60),
                    localidad   VARCHAR(60) NOT NULL,
                    telefono    INT(8) UNSIGNED NOT NULL,
                    celular     INT(10) UNSIGNED UNIQUE NOT NULL,
                    cod_postal  INT(4) UNSIGNED NOT NULL,
                    email       VARCHAR(60) UNIQUE NOT NULL,
                    tipo_doc    VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DU', 'Pasaporte') ),
                    num_doc     VARCHAR(12) NOT NULL UNIQUE,
                    sexo        CHAR(1) NOT NULL CHECK( sexo in ('M', 'F') ),
                    estado_civ  CHAR(1) NOT NULL CHECK( estado_civ in ('C', 'S', 'D', 'V') ),
                    fnac        DATE NOT NUll,
                    dir_fact    VARCHAR(240) NOT NULL,
                    loc_fact    VARCHAR(60) NOT NULL,
                    tel_fact    INT(8) UNSIGNED NOT NULL,
                    cp_fact     INT(4) UNSIGNED NOT NULL,
                    FOREIGN KEY (tipo_id)    REFERENCES tipo_asociado(tipo_asociado_id),
                    FOREIGN KEY (prepaga_id) REFERENCES prepagas(prepaga_id),
                    FOREIGN KEY (plan_id)    REFERENCES planes_prepagas(plan_id),
                    FOREIGN KEY (desc_id)    REFERENCES descuentos(descuento_id)
					);

CREATE TABLE bajas_asoc_hist (
					num_asoc       INT(8) UNSIGNED NOT NULL,
                    fecha_baja     DATE NOT NULL,
                    motivo_baja_id INT(2) UNSIGNED NOT NULL,
                    PRIMARY KEY (num_asoc, fecha_baja),
                    FOREIGN KEY (num_asoc)       REFERENCES asociados(num_asoc),
                    FOREIGN KEY (motivo_baja_id) REFERENCES motivos_baja(motivo_baja_id)
                    );
				
CREATE TABLE parentescos (
				    parentesco_id INT(2) UNSIGNED PRIMARY KEY NOT NULL,
                    tipo          VARCHAR(30) NOT NULL
                    );

CREATE TABLE familiares (
				   	familiar_id   INT(8) UNSIGNED AUTO_INCREMENT PRIMARY KEY NOT NULL,
                    asociado_id   INT(6) UNSIGNED NOT NULL,
                    parentesco_id INT(2) UNSIGNED NOT NULL,
                    apellido      VARCHAR(50) NOT NULL,
                    nombre        VARCHAR(50) NOT NULL,
                    tipo_doc      VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DU', 'Pasaporte') ),
                    num_doc       VARCHAR(12) NOT NULL UNIQUE,
				   	sexo          CHAR(1) NOT NULL CHECK( sexo in ('M', 'F') ),
                    disc_tot_perm BOOLEAN,
                    FOREIGN KEY (asociado_id)   REFERENCES asociados(num_asoc),
                    FOREIGN KEY (parentesco_id) REFERENCES parentescos(parentesco_id)
                    );

/* --Inserto datos de prueba */
INSERT INTO tipo_usuario(tipo, descripcion)
	VALUES ('Desarrollador', 'Desarrollador a cargo de soporte y mantenimiento'),
	       ('Administrador', 'Administrador de la aplicación (usuario)' );

INSERT INTO usuarios(tipo_id, apellido, nombre, password, tipo_doc, num_doc, domicilio)
	VALUES (1, 'Miranda', 'Matias', 'sarasa', 'DNI', 36401087, 'Av. Siempre viva 1234'),
		   (2, 'Juan', 'Perez', 'asdfg', 'DNI', 27401035, 'Av. Libertadores 123');
           
INSERT INTO planes_prepagas(nombre, precio, descripcion)
	VALUES ('Plata', 1500, 'Plan "Plata" correspndiente a Galeno'),
	       ('Oro', 2200, 'Plan "Oro" correspndiente a Galeno'),
		   ('Platinum', 3500, 'Plan "Platinum" correspondiente a Galeno'),
           ('Platinum', 4200, 'Plan "Platinum" correspondiente a OSDE'),
           ('SMG02', 2000, 'Plan SMG02 correspondiente a Swiss Medical'),
           ('110', 900,  'Plan 210 correspondiente a Accord Salud'),
           ('210', 1700, 'Plan 210 correspondiente a Accord Salud'),
           ('310', 2400, 'Plan 210 correspondiente a Accord Salud');

INSERT INTO prepagas (nombre)
	VALUES ('Galeno'),
		   ('OSDE'), 
           ('Swiss Medical'),
           ('Accord Salud');

INSERT INTO rel_prepagas_planes(prepaga_id, plan_id)
	VALUES (1,1),
		   (1,2),
           (1,3),
           (2,4),
           (3,5),
           (4,6),
           (4,7),
           (4,8);

INSERT INTO tipo_asociado (tipo_asociado_id, tipo, descripcion)
	VALUES (1, 'AC', 'Activo'),
		   (2, 'PA', 'Pasivo/Jubilado'),
           (3, 'AD', 'Adherente'),
           (4, 'AA', 'Activo adherente'),
           (5, 'CA', 'Activo adherente vitalicio'),
           (6, 'AM', 'Absorvido'),
           (7, 'EM', 'Empleado');
           
INSERT INTO motivos_baja (codigo_baja, nombre, descripcion)
	VALUES ('FA', 'Fallecido', null),
		   ('RE', 'Renuncio', null),
           ('BA', 'Baja sin motivo', 'Cualquier otro motivo que no sea "Fallecido" ni "Renuncia"');
           
INSERT INTO descuentos (descripcion)
	VALUES ('A.N.S.E.S');
           

INSERT INTO asociados (tipo_id, prepaga_id, plan_id, desc_id, cod_desc, legajo, ex_legajo, fec_ingreso, fec_baja, apellido, nombre, domicilio, provincia, ciudad, localidad, telefono, celular, cod_postal, email, tipo_doc, num_doc, sexo, estado_civ, fnac, dir_fact, loc_fact, tel_fact, cp_fact)
	VALUES (2, 1, 1, 1, 93678443, 90123, null,'2017-12-25', null, 'Vader', 'Darth', 'Estrella de la muerte 25°,-76°', null, null, 'Star Wars', 66666666, 1199999999, 1406, 'anakin.skywaler@sith.com.ar', 'DNI', 36444123, 'M', 'S', '1977-11-25', 'Estrella de la muerte 25°,-76°', 'Star Wars', 66666666, 1406),
		   (3, 4, 7, null, nullif(desc_id, null), 34167, null, '1996-07-21', null, 'Kenobi', 'Obi-Wan', 'Tatooine 761', null, null, 'Star Wars', 11111111, 1111111112, 1421, 'theforcebewithyou@jedi.com.ar', 'DNI', 21563123, 'M', 'D', '1953-12-16', 'Av. Republica 411', 'Star Wars', 11111111, 1421);

INSERT INTO parentescos (parentesco_id, tipo)
	VALUES (1, 'Hijo'),
		   (2, 'Cónyuge'),
           (3, 'Padre/Madre'),
           (4, 'Suegro'),
           (5, 'Otra persona');

INSERT INTO familiares (asociado_id, parentesco_id, apellido, nombre, tipo_doc, num_doc, sexo, disc_tot_perm)
			VALUES(1, 1, 'Skywalker', 'Luke', 'DNI', 96123456, 'M', false),
			  	  (1, 1, 'Skywalker', 'Leia', 'DNI', 96123457, 'F', true);
