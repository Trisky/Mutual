drop database mutual;
create database mutual;
use mutual;

CREATE TABLE tipo_usuario (
					tipo_usuario_id INT(2) UNSIGNED PRIMARY KEY,
                    tipo            VARCHAR(30) NOT NULL,
                    descripcion     VARCHAR(240)
                    );

CREATE TABLE users (
                    user_id   INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    tipo_id   INT(2) UNSIGNED ,
                    apellido  VARCHAR(50) NOT NULL,
                    nombre    VARCHAR(50) NOT NULL,
                    password  VARCHAR(16) NOT NULL,
                    tipo_doc  VARCHAR(12) NOT NULL CHECK( tipo_doc in ('DNI', 'Pasaporte') ),
                    num_doc   VARCHAR(12) NOT NULL,
                    direccion VARCHAR(240),
                    FOREIGN KEY (tipo_id) REFERENCES tipo_usuario(tipo_usuario_id)
                   );

CREATE TABLE prepaga (
                    prep_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    prep_nombre VARCHAR(240) NOT NULL,
                    prep_precio DECIMAL NOT NULL

                    );


CREATE TABLE asociados (
                    asoc_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    asoc_nombre VARCHAR(240) NOT NULL,
                    asoc_apellido VARCHAR(240) NOT NULL,
                    asoc_dni INT(20) ,
                    asoc_direccion VARCHAR(240),
                    asoc_prepaga int(6) UNSIGNED
                    );



/* --inserto datos de prueba */
INSERT INTO tipo_usuario( tipo_usuario_id, tipo, descripcion) VALUES (1, 'Developer', 'Desarrollador a cargo de soporte y mantenimiento'),
																     (2, 'Admin', 'Administrador de la aplicación' );

INSERT INTO users (user_nombre, user_password)
           VALUES ("admin", "sarasa");
INSERT INTO prepaga (prep_nombre,prep_precio)
             values ("OSDE 720",1400);
INSERT INTO asociados(asoc_nombre,asoc_apellido,asoc_dni,asoc_prepaga)
              values ("juan","perez",35000000,1);
/* --creo constrain */
ALTER TABLE asociados
ADD FOREIGN KEY (asoc_prepaga)
REFERENCES prepaga(prep_id);
