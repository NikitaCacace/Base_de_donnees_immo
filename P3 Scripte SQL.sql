SET PATH=%PATH%;C:\Program Files\MySQL\MySQL Server 8.0\bin 

mysql -h localhost --local-infile -u root -p 

USE DataImmo

SET NAMES 'utf8';

CREATE TABLE IF NOT EXISTS adresse_bien (
                index_adresse INT AUTO_INCREMENT NOT NULL,
                numero_voie VARCHAR(5),
                complement_numero_voie CHAR(1),
                type_de_voie VARCHAR(25),
                nom_voie TEXT NOT NULL,
                code_postal CHAR(5) NOT NULL,
                commune VARCHAR(50) NOT NULL,
                PRIMARY KEY (index_adresse)
)
ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS caracteristique_interieure (
                index_caracteristique_interieure INT AUTO_INCREMENT NOT NULL,
                surface_carrez DECIMAL(6,2) NOT NULL,
                type_local VARCHAR(50) NOT NULL,
                nombre_de_pieces_principales TINYINT,
                index_adresse INT NOT NULL,
                PRIMARY KEY (index_caracteristique_interieure)
)
ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS caracteristique_exterieure (
                index_caracteristique_exterieure INT AUTO_INCREMENT NOT NULL,
                surface_terrain SMALLINT,
                nature_culture VARCHAR(4),
                index_adresse INT NOT NULL,
                PRIMARY KEY (index_caracteristique_exterieure)
)
ENGINE=INNODB;


CREATE TABLE IF NOT EXISTS mutation (
                index_mutation INT AUTO_INCREMENT NOT NULL,
                valeur_fonciere DECIMAL(10,2),
                date_mutation DATE NOT NULL,
                index_adresse INT NOT NULL,
                PRIMARY KEY (index_mutation)
)
ENGINE=INNODB;


ALTER TABLE mutation ADD CONSTRAINT 
fk_index_mutation
FOREIGN KEY (index_adresse)
REFERENCES adresse_bien (index_adresse)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE caracteristique_exterieure ADD CONSTRAINT fk_caracteristique_exterieure
FOREIGN KEY (index_adresse)
REFERENCES adresse_bien (index_adresse)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE caracteristique_interieure ADD CONSTRAINT fk_caracteristique_interieure
FOREIGN KEY (index_adresse)
REFERENCES adresse_bien (index_adresse)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

SET GLOBAL local_infile=1;

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataImmo_adresse_bien.txt' 
	INTO TABLE adresse_bien
		FIELDS TERMINATED BY '\t'
		LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
(index_adresse, numero_voie, complement_numero_voie, type_de_voie, nom_voie, code_postal, commune);

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataImmo_mutation.txt' 
	INTO TABLE mutation
		FIELDS TERMINATED BY '\t'
		LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
(index_mutation, valeur_fonciere, date_mutation, index_adresse);

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataImmo_caracteristique_interieure.txt' 
	INTO TABLE caracteristique_interieure
		FIELDS TERMINATED BY '\t'
		LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
(index_caracteristique_interieure, surface_carrez, type_local, nombre_de_pieces_principales, index_adresse);

LOAD DATA LOCAL INFILE 'C:\\ProgramData\\MySQL\\MySQL Server 8.0\\Uploads\\DataImmo_caracteristique_exterieure.txt' 
	INTO TABLE caracteristique_exterieure
		FIELDS TERMINATED BY '\t'
		LINES TERMINATED BY '\r\n'
	IGNORE 1 LINES
(index_caracteristique_exterieure, surface_terrain, nature_culture, index_adresse); 

mysql -u root -p DataImmo > sauvegardeP3_1.sql