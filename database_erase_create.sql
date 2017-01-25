drop database mutual;
create database mutual;
use mutual;

CREATE TABLE tipo_usuario (
					tipo_usuario_id INT(2) UNSIGNED PRIMARY KEY,
                    tipo            VARCHAR(30) NOT NULL,
                    descripcion     VARCHAR(240)
                    );

CREATE TABLE usuarios (
                    user_id   INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    tipo_id   INT(2) UNSIGNED ,
                    apellido  VARCHAR(50) NOT NULL,
                    nombre    VARCHAR(50) NOT NULL,
                    password  VARCHAR(16) NOT NULL,
                    tipo_doc  VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DNI', 'Pasaporte') ),
                    num_doc   VARCHAR(12) NOT NULL UNIQUE,
                    domicilio VARCHAR(240),
                    FOREIGN KEY (tipo_id) REFERENCES tipo_usuario(tipo_usuario_id)
                   );

CREATE TABLE prepagas (
                    prepaga_id INT(2) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    nombre     VARCHAR(60) NOT NULL,
                    tipo_plan  VARCHAR(60),
                    precio     DECIMAL(10,2) NOT NULL
                    );


CREATE TABLE tipo_asociado (
					tipo_asociado_id INT(2) UNSIGNED PRIMARY KEY,
                    tipo             VARCHAR(50) NOT NULL,
                    descripcion      VARCHAR(240)
                    );

CREATE TABLE asociados (
					legajo      INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    tipo_id     INT(2) UNSIGNED NOT NULL,
                    prepaga_id  INT(2) UNSIGNED NOT NULL,
                    asoc_num    BIGINT UNSIGNED NOT NULL UNIQUE,
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
                    tipo_doc    VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DNI', 'Pasaporte') ),
                    num_doc     VARCHAR(12) NOT NULL UNIQUE,
                    sexo        CHAR(1) NOT NULL CHECK( sexo in ('M', 'F') ),
                    estado_civ  CHAR(1) NOT NULL CHECK( estado_civ in ('C', 'S', 'D', 'V') ),
                    fnac        DATE NOT NUll,
                    dir_fact    VARCHAR(240) NOT NULL,
                    loc_fact    VARCHAR(60) NOT NULL,
                    tel_fact    INT(8) UNSIGNED NOT NULL,
                    cp_fact     INT(4) UNSIGNED NOT NULL,
                    FOREIGN KEY (tipo_id)    REFERENCES tipo_asociado(tipo_asociado_id),
                    FOREIGN KEY (prepaga_id) REFERENCES prepagas(prepaga_id)
                    );
                    
CREATE TABLE parentescos (
					parentesco_id INT(2) UNSIGNED PRIMARY KEY,
                    tipo          VARCHAR(30) NOT NULL
                    );
                    
CREATE TABLE familiares (
					familiar_id   INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    asociado_id   INT(6) UNSIGNED NOT NULL,
                    parentesco_id INT(2) UNSIGNED NOT NULL,
                    apellido      VARCHAR(50) NOT NULL,
                    nombre        VARCHAR(50) NOT NULL,
                    tipo_doc      VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DNI', 'Pasaporte') ),
                    num_doc       VARCHAR(12) NOT NULL UNIQUE,
					sexo          CHAR(1) NOT NULL CHECK( sexo in ('M', 'F') ),
                    disc_tot_perm BOOLEAN,
                    FOREIGN KEY (parentesco_id) REFERENCES parentescos(parentesco_id)
                    );
                    
/* --inserto datos de prueba */
INSERT INTO tipo_usuario(tipo_usuario_id, tipo, descripcion) 
	VALUES (1, 'Desarrollador', 'Desarrollador a cargo de soporte y mantenimiento'),
	       (2, 'Administrador', 'Administrador de la aplicación (usuario)' );
                                                                     
INSERT INTO usuarios(tipo_id, apellido, nombre, password, tipo_doc, num_doc, domicilio)
	VALUES (1, 'Miranda', 'Matias', 'sarasa', 'DNI', 36401087, 'Av. Siempre viva 1234'),
		   (2, 'Juan', 'Perez', 'asdfg', 'DNI', 27401035, 'Av. Libertadores 123');
    
INSERT INTO prepagas (nombre, tipo_plan, precio)
	VALUES ('Galeno', 'Oro', 2000),
		   ('Galeno', 'Plata', 2000),
		   ('Osde', 'Platinum', 3800),
           ('Swiss Medical', 'Platinum', 4200),
           ('Accord Salud', null , 866.23) ;
           
INSERT INTO tipo_asociado (tipo_asociado_id, tipo, descripcion)
	VALUES (1, 'Pasivo', 'Descripción de pasivo'),
		   (2, 'Adherente', 'Descripción de adherente'),
           (3, 'Jubilado', null);

INSERT INTO asociados (tipo_id, prepaga_id, asoc_num, fec_ingreso, fec_baja, apellido, nombre, domicilio, provincia, ciudad, localidad, telefono, celular, cod_postal, email, tipo_doc, num_doc, sexo, estado_civ, fnac, dir_fact, loc_fact, tel_fact, cp_fact)
	VALUES (2, 1, 4000001, '2017-12-25', null, 'Vader', 'Darth', 'Estrella de la muerte 25°,-76°', null, null, 'Star Wars', 66666666, 1199999999, 1406, 'anakin.skywaler@sith.com.ar', 'DNI', 36444123, 'M', 'S', '1977-11-25', 'Estrella de la muerte 25°,-76°', 'Star Wars', 66666666, 1406),	
		   (3, 4, 4000002, '1996-07-21', null, 'Kenobi', 'Obi-Wan', 'Tatooine 761', null, null, 'Star Wars', 11111111, 1111111112, 1421, 'theforcebewithyou@jedi.com.ar', 'DNI', 21563123, 'M', 'D', '1953-12-16', 'Av. Republica 411', 'Star Wars', 11111111, 1421); 

INSERT INTO parentescos (parentesco_id, tipo)
	VALUES (1, 'Hijo'),
		   (2, 'Cónyuge'),
           (3, 'Padre/Madre'),
           (4, 'Suegro');
           
INSERT INTO familiares (asociado_id, parentesco_id, apellido, nombre, tipo_doc, num_doc, sexo, disc_tot_perm)
			VALUES(1, 1, 'Skywalker', 'Luke', 'DNI', 96123456, 'M', false),
				  (1, 1, 'Skywalker', 'Leia', 'DNI', 96123457, 'F', true);
           

