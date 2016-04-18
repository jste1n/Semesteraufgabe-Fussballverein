CREATE USER vereinAdmin WITH LOGIN PASSWORD 'root';

CREATE DATABASE fussballVerein OWNER vereinAdmin;
GRANT ALL PRIVILEGES ON DATABASE fussballVerein TO vereinAdmin;


CREATE TABLE Mannschaft (
 bezeichnung VARCHAR(255) NOT NULL PRIMARY KEY,
 klasse VARCHAR(10) NOT NULL,
 naechstes_spiel DATE NOT NULL
);


CREATE SEQUENCE Person_persnr_seq INCREMENT 2 MINVALUE 10000 MAXVALUE 99998;
CREATE TABLE Person (
 persnr INT NOT NULL PRIMARY KEY default nextval('Person_persnr_seq'),
 vname VARCHAR(255) NOT NULL,
 nname VARCHAR(255) NOT NULL,
 geschlecht CHAR(1) NOT NULL,
 gebdat DATE NOT NULL
);
ALTER SEQUENCE Person_persnr_seq OWNED by Person.persnr;


CREATE TABLE Spiel (
 mannschaft VARCHAR(255) NOT NULL,
 datum DATE NOT NULL,
 gegner VARCHAR(255) NOT NULL,
 ergebnis VARCHAR(13) NOT NULL,

 PRIMARY KEY (mannschaft,datum),

 FOREIGN KEY (mannschaft) REFERENCES Mannschaft (bezeichnung)
);


CREATE TABLE Spieler (
 persnr INT NOT NULL PRIMARY KEY,
 position VARCHAR(255) NOT NULL,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE SpielerInMannschaft (
 persnr INT NOT NULL PRIMARY KEY,
 bezeichnung VARCHAR(255) NOT NULL,
 nummer INT NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Spieler (persnr),
 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung)
);


CREATE SEQUENCE Standort_sid_seq MINVALUE 1;
CREATE TABLE Standort (
 sid VARCHAR(10) NOT NULL PRIMARY KEY nextval('Standort_sid_seq'),
 land VARCHAR(255) NOT NULL,
 plz INT NOT NULL,
 ort VARCHAR(255) NOT NULL
);
ALTER SEQUENCE Standort_sid_seq OWNED BY Standort.sid;


CREATE TABLE Trainer (
 persnr INT NOT NULL PRIMARY KEY,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,
 bezeichnung VARCHAR(255) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr),
 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung)
);


CREATE TABLE TrainerAssistenten (
 bezeichnung VARCHAR(255) NOT NULL,
 persnr INT NOT NULL,

 PRIMARY KEY (bezeichnung,persnr),

 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung),
 FOREIGN KEY (persnr) REFERENCES Trainer (persnr)
);


CREATE TABLE Angestellter (
 persnr INT NOT NULL PRIMARY KEY,
 gehalt DECIMAL(10) NOT NULL,
 ueberstunden TIMESTAMP(10) NOT NULL,
 e_mail VARCHAR(255) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE BeteiligteSpieler (
 mannschaft VARCHAR(255) NOT NULL,
 persnr INT NOT NULL,
 datum DATE NOT NULL,
 dauer TIME(10) NOT NULL,

 PRIMARY KEY (mannschaft,persnr,datum),

 FOREIGN KEY (mannschaft,datum) REFERENCES Spiel (mannschaft,datum),
 FOREIGN KEY (persnr) REFERENCES Spieler (persnr)
);


CREATE TABLE ChefTrainer (
 bezeichnung VARCHAR(255) NOT NULL,
 persnr INT NOT NULL,

 PRIMARY KEY (bezeichnung,persnr),

 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung),
 FOREIGN KEY (persnr) REFERENCES Trainer (persnr)
);


CREATE TABLE Kapitän (
 bezeichnung VARCHAR(255) NOT NULL,
 persnr INT NOT NULL,

 PRIMARY KEY (bezeichnung,persnr),

 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung),
 FOREIGN KEY (persnr) REFERENCES Spieler (persnr)
);


CREATE TABLE Mitglied (
 persnr INT NOT NULL PRIMARY KEY,
 beitrag DECIMAL(10) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE Fan-Club (
 name VARCHAR(255) NOT NULL,
 sid VARCHAR(10) NOT NULL,
 persnr INT NOT NULL,
 gegruendet DATE NOT NULL,
 obmann VARCHAR(255) NOT NULL,

 PRIMARY KEY (name,sid,persnr),

 FOREIGN KEY (sid) REFERENCES Standort (sid),
 FOREIGN KEY (persnr) REFERENCES Mitglied (persnr)
);


CREATE TABLE Obmann (
 persnr INT NOT NULL,
 name VARCHAR(255) NOT NULL,
 sid VARCHAR(10) NOT NULL,

 PRIMARY KEY (persnr,name,sid),

 FOREIGN KEY (persnr) REFERENCES Mitglied (persnr),
 FOREIGN KEY (name,sid,persnr) REFERENCES Fan-Club (name,sid,persnr)
);


CREATE TABLE Zeitraum (
 persnr INT NOT NULL,
 name VARCHAR(255) NOT NULL,
 sid VARCHAR(10) NOT NULL,
 anfang DATE NOT NULL,
 ende DATE NOT NULL,

 PRIMARY KEY (persnr,name,sid),

 FOREIGN KEY (persnr) REFERENCES Angestellter (persnr),
 FOREIGN KEY (name,sid,persnr) REFERENCES Fan-Club (name,sid,persnr)
);


