drop database mutual;
create database mutual;
use mutual;
CREATE TABLE users (
                    user_id INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
                    user_nombre VARCHAR(240) NOT NULL,
                    user_password VARCHAR(240) NOT NULL
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
