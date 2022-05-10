DROP DATABASE IF EXISTS `utenze`;

CREATE DATABASE IF NOT EXISTS `utenze`;

USE `utenze`;

CREATE TABLE IF NOT EXISTS `modalità_di_pagamento` (
	`modalità` VARCHAR (25) NOT NULL PRIMARY KEY COMMENT "Modalità di pagamento delle utenze"
) ENGINE = InnoDB CHARSET = UTF8MB4 COLLATE = utf8mb4_general_ci COMMENT = "Modalità di pagamento delle utenze";

INSERT INTO `modalità_di_pagamento` (`modalità`)
VALUES
	('Contanti'),
	('Domiciliazione'),
	('Bonifico bancario'),
	('Bollettino postale'),
	('F24'),
	('Carta di credito'),
	('Carta di debito'),
	('Girofondo');

CREATE TABLE IF NOT EXISTS `natura` (
	`natura` VARCHAR (25) NOT NULL,
	CONSTRAINT `natura_pk` PRIMARY KEY `natura_pk_indx` (`natura` ASC)
) ENGINE=InnoDB CHARSET=UTF8MB4 COLLATE utf8mb4_general_ci;

INSERT INTO `natura` (`natura`)
VALUES
	('Quantità'),
	('Tempo'),
	('Valuta'),
	('Distanza'),
	('Superficie'),
	('Volume'),
	('Capienza'),
	('Velocità'),
	('Accelerazione'),
	('Forza'),
	('Massa');

CREATE TABLE IF NOT EXISTS `unità_di_misura` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`natura` VARCHAR (25) NOT NULL COMMENT "Dominio delle unità di misura",
	`unità_di_misura` VARCHAR (25) NOT NULL DEFAULT 'Quantità' COMMENT "Unità di misura",
	`abbreviazione` VARCHAR (10) NULL DEFAULT NULL COMMENT "Abbreviazione canonica dell'unità di misura",
	`mysql` VARCHAR (25) NULL DEFAULT NULL COMMENT "Denominazione della funzione MySQL corrispondente, se esiste",
	CONSTRAINT `id_pk` PRIMARY KEY `id_pk_indx` (`id` ASC),
	CONSTRAINT `unità_di_misura_uk` UNIQUE KEY `unità_di_misura_uk_indx` (`unità_di_misura` ASC),
	CONSTRAINT `natura_fk` FOREIGN KEY `natura_fk_indx` (`natura`) REFERENCES `natura` (`natura`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB CHARSET=UTF8MB4 COLLATE utf8mb4_general_ci;

INSERT INTO `unità_di_misura` (`natura`, `unità_di_misura`, `abbreviazione`, `mysql`)
VALUES
	('Quantità', 'Numero', 'nr.', NULL),
	('Tempo', 'Secondo/i', 's', 'SECOND'),
	('Tempo', 'Minuto/i', 'min', 'MINUTE'),
	('Tempo', 'Ora/e', 'h', 'HOUR'),
	('Tempo', 'Giorno/i', 'g', 'DAY'),
	('Tempo', 'Mese/i', 'M', 'MONTH'),
	('Tempo', 'Anno/i', 'A', 'YEAR');

CREATE TABLE IF NOT EXISTS `periodicità` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`periodicità` VARCHAR (25) NOT NULL UNIQUE,
	`durata` INT NOT NULL DEFAULT 1 COMMENT "Durata del lasso temporale",
	`unità_di_misura` INT NOT NULL DEFAULT 5 COMMENT "Unità di misura del lasso temporale",
	CONSTRAINT `id_pk` PRIMARY KEY `id_pk_indx` (`id` ASC),
	CONSTRAINT `periodicità_uk` UNIQUE KEY `periodicità_uk_indx` (`periodicità`),
	CONSTRAINT `unità_di_misura_fk` FOREIGN KEY `unità_di_misura_fk_indx` (`unità_di_misura`) REFERENCES `unità_di_misura` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB CHARSET = UTF8MB4 COLLATE = utf8mb4_general_ci;

INSERT INTO `periodicità` (`periodicità`)
VALUES
	('mensile'),
	('bimestrale'),
	('trimestrale'),
	('quadrimestrale'),
	('semestrale'),
	('annuale'),
	('biennale');

CREATE TABLE IF NOT EXISTS `designatori` (
	`designatore` VARCHAR (25) NOT NULL,
	`abbr` VARCHAR (10) NOT NULL,
	CONSTRAINT `designatori_pk` PRIMARY KEY `designatori_pk_indx` (`abbr`),
	CONSTRAINT `designatore_uk` UNIQUE KEY `designatore_uk_indx` (`designatore` ASC)
) ENGINE=InnoDB CHARSET=UTF8MB4 COLLATE=utf8mb4_general_ci;

INSERT INTO `designatori` (`designatore`, `abbr`)
VALUES
	('Via', 'V.'),
	('Viale', 'V.le'),
	('Vicolo', 'Vic.'),
	('Piazza', 'P.zza'),
	('Piazzetta', 'P.tta'),
	('Corso', 'C.so'),
	('Largo', 'L.'),
	('Lungargine', 'L.argine'),
	('Lungofiume', 'L.fiume'),
	('Lungolago', 'L.lago'),
	('Lungomare', 'L.mare');

CREATE TABLE IF NOT EXISTS `indirizzi` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`designatore` VARCHAR (10) NOT NULL DEFAULT 'V.',
	`indirizzo` VARCHAR (50) NOT NULL,
	`civico` VARCHAR (10) NOT NULL DEFAULT 's.n.c.',
	`interno` VARCHAR (5) NULL DEFAULT NULL,
	`cap` VARCHAR (5) NOT NULL,
	`località` VARCHAR (50) NOT NULL,
	`provincia` VARCHAR (2) NOT NULL,
	`stato` VARCHAR (3) NOT NULL,
	CONSTRAINT `indirizzo_pk` PRIMARY KEY `indirizzo_pk_indx` (`id`),
	CONSTRAINT `indirizzo_uk` UNIQUE KEY `indirizzo_uk_indx` (`stato` ASC, `provincia` ASC, `località` ASC, `cap` ASC, `designatore` ASC, `indirizzo` ASC, `civico` ASC, `interno` ASC),
	CONSTRAINT `designatore_fk` FOREIGN KEY `designatore_fk_indx` (`designatore`) REFERENCES `designatori` (`abbr`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB CHARSET=UTF8MB4 COLLATE=utf8mb4_general_ci;

INSERT INTO `indirizzi` (`designatore`, `indirizzo`, `civico`, `interno`, `cap`, `località`, `provincia`, `stato`)
VALUE
	('V.', 'Francesco de Lazara', '1', '3', '35124', 'Padova', 'PD', 'I');

CREATE TABLE IF NOT EXISTS `utenti` (
	`nome` VARCHAR (25) NULL DEFAULT NULL,
	`cognome` VARCHAR (25),
	`codice_fiscale` VARCHAR (16) NOT NULL,
	`indirizzo` INT NULL DEFAULT NULL,
	CONSTRAINT `codice_fiscale_pk` PRIMARY KEY (`codice_fiscale` ASC),
	CONSTRAINT `domicilio_fk` FOREIGN KEY `domicilio_fk_indx` (`indirizzo`) REFERENCES `indirizzi` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE=InnoDB CHARSET=UTF8MB4 COLLATE=utf8mb4_general_ci;

INSERT INTO `utenti` (`nome`, `cognome`, `codice_fiscale`, `indirizzo`)
VALUES
	('Giulio', 'Criscoli', 'CRSGLI73E07G224Q', 1);

CREATE TABLE IF NOT EXISTS `utenze` (
	`ID` INT NOT NULL PRIMARY KEY AUTO_INCREMENT,
	`utenza` VARCHAR (25) NOT NULL,
	`intestazione` VARCHAR (16) NOT NULL,
	`indirizzo` INT NULL DEFAULT NULL,
	`codice_utente` VARCHAR (25) NOT NULL,
	`periodicità` INT NOT NULL DEFAULT 2,
	`modalità_di_pagamento` VARCHAR (25) NOT NULL DEFAULT 'Domiciliazione',
	CONSTRAINT `utenza_UK` UNIQUE KEY utenza_UK_INDX (`utenza` ASC, `codice_utente` ASC),
	CONSTRAINT `periodicità_FK` FOREIGN KEY `periodicità_FK_INDX` (`periodicità`) REFERENCES `periodicità` (`ID`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `intestazione_fk` FOREIGN KEY `intestazione_fk_indx` (`intestazione`) REFERENCES `utenti` (`codice_fiscale`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `modalità_di_pagamento_FK` FOREIGN KEY `modalità_di_pagamento_FK_INDX` (`modalità_di_pagamento`) REFERENCES `modalità_di_pagamento` (`modalità`) ON UPDATE CASCADE ON DELETE RESTRICT,
	CONSTRAINT `indirizzo_fk` FOREIGN KEY `indirizzo_fk_indx` (`indirizzo`) REFERENCES `indirizzi` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB CHARSET = UTF8MB4 COLLATE = utf8mb4_general_ci;

INSERT INTO `utenze` (`utenza`, `intestazione`, `indirizzo`, `codice_utente`, `periodicità`, `modalità_di_pagamento`)
VALUES
	('TARI', 'CRSGLI73E07G224Q', 1, '101443001', 4, 'Domiciliazione');

CREATE TABLE IF NOT EXISTS `bollette` (
	`id` INT NOT NULL AUTO_INCREMENT,
	`utenza` INT NOT NULL DEFAULT 1,
	`numero` VARCHAR (35) NOT NULL,
	`data_di_emissione` DATE NOT NULL,
	`data_di_scadenza` DATE NOT NULL,
	`periodo` VARCHAR (50) NULL DEFAULT NULL,
	`importo` FLOAT NOT NULL DEFAULT 0,
	CONSTRAINT `id_pk` PRIMARY KEY `id_pk_indx` (`id`),
	CONSTRAINT `utenza_fk` FOREIGN KEY `utenza_fk_indx` (`utenza`) REFERENCES `utenze` (`id`) ON UPDATE CASCADE ON DELETE RESTRICT
) ENGINE = InnoDB CHARSET = UTF8MB4 COLLATE = utf8mb4_general_ci;

INSERT INTO `bollette` (`utenza`, `numero`, `data_di_emissione`, `data_di_scadenza`, `periodo`, `importo`)
VALUES
	(1, '20226101920', '2022-02-18', '2022-03-25', 'Gennaio - Aprile 2022', 125.00),
	(1, '20216346520', '2021-11-05', '2021-12-10', 'Settembre - Dicembre 2021', 119.00),
	(1, '20216221911', '2021-07-21', '2021-07-15', 'Maggio - Agosto 2021', 132.00),
	(1, '20206326204', '2020-11-06', '2020-12-10', 'Settembre - Dicembre 2020', 134.00),
	(1, '20206208478', '2020-07-31', '2020-09-30', 'Maggio - Agosto 2020', 130.00),
	(1, '20206103295', '2020-02-02', '2020-03-16', 'Gennaio - Aprile 2020', 127.00),
	(1, '20196363331', '2019-10-08', '2019-11-16', 'Settembre - Dicembre 2019', 129.00),
	(1, '20196228583', '2019-06-02', '2019-07-16', 'Maggio - Agosto 2019', 130.07),
	(1, '20196098442', '2019-01-28', '2019-03-16', 'Gennaio - Aprile 2019', 127.00);
