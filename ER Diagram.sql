DROP TABLE Person CASCADE;
CREATE TABLE Person (
 persnr INT NOT NULL PRIMARY KEY,
 vname VARCHAR(255) NOT NULL,
 nname VARCHAR(255) NOT NULL,
 geschlecht CHAR(1) NOT NULL,
 gebdat DATE NOT NULL
);


DROP TABLE Spieler CASCADE;
CREATE TABLE Spieler (
 persnr INT NOT NULL PRIMARY KEY,
 position VARCHAR(255) NOT NULL,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


DROP TABLE Standort CASCADE;
CREATE TABLE Standort (
 sid VARCHAR(10) NOT NULL PRIMARY KEY,
 land VARCHAR(255) NOT NULL,
 plz INT NOT NULL,
 ort VARCHAR(255) NOT NULL
);


DROP TABLE Trainer CASCADE;
CREATE TABLE Trainer (
 persnr INT NOT NULL PRIMARY KEY,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


DROP TABLE Angestellter CASCADE;
CREATE TABLE Angestellter (
 persnr INT NOT NULL PRIMARY KEY,
 gehalt DECIMAL(10) NOT NULL,
 ueberstunden TIMESTAMP(10) NOT NULL,
 e_mail VARCHAR(255) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


DROP TABLE Mannschaft CASCADE;
CREATE TABLE Mannschaft (
 bezeichnung VARCHAR(255) NOT NULL PRIMARY KEY,
 klasse VARCHAR(10) NOT NULL,
 naechstes_spiel DATE NOT NULL,
 kapitaen INT NOT NULL,
 anzahlSpieler INT NOT NULL,
 chefTrainer INT NOT NULL,
 trainerAssisten INT NOT NULL,

 FOREIGN KEY (chefTrainer) REFERENCES Trainer (persnr),
 FOREIGN KEY (trainerAssisten) REFERENCES Trainer (persnr),
 FOREIGN KEY (kapitaen) REFERENCES Spieler (persnr)
);


DROP TABLE Mitglied CASCADE;
CREATE TABLE Mitglied (
 persnr INT NOT NULL PRIMARY KEY,
 beitrag DECIMAL(10) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


DROP TABLE Spiel CASCADE;
CREATE TABLE Spiel (
 datum DATE NOT NULL,
 mannschaft VARCHAR(255) NOT NULL,
 gegner VARCHAR(255) NOT NULL,
 ergebnis VARCHAR(13) NOT NULL,

 PRIMARY KEY (datum,mannschaft),

 FOREIGN KEY (mannschaft) REFERENCES Mannschaft (bezeichnung)
);


DROP TABLE SpielerInMannschaft CASCADE;
CREATE TABLE SpielerInMannschaft (
 nummer INT NOT NULL,
 bezeichnung VARCHAR(255) NOT NULL,
 persnr INT NOT NULL,

 PRIMARY KEY (nummer,bezeichnung),

 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung),
 FOREIGN KEY (persnr) REFERENCES Spieler (persnr)
);


DROP TABLE BeteiligteSpieler CASCADE;
CREATE TABLE BeteiligteSpieler (
 persnr INT NOT NULL,
 datum DATE NOT NULL,
 mannschaft VARCHAR(255) NOT NULL,
 dauer TIME(10) NOT NULL,

 PRIMARY KEY (persnr,datum,mannschaft),

 FOREIGN KEY (persnr) REFERENCES Spieler (persnr),
 FOREIGN KEY (datum,mannschaft) REFERENCES Spiel (datum,mannschaft)
);


DROP TABLE Fan-Club CASCADE;
CREATE TABLE Fan-Club (
 name VARCHAR(255) NOT NULL,
 sid VARCHAR(10) NOT NULL,
 gegruendet DATE NOT NULL,
 obmann VARCHAR(255) NOT NULL,

 PRIMARY KEY (name,sid),

 FOREIGN KEY (sid) REFERENCES Standort (sid),
 FOREIGN KEY (obmann) REFERENCES Mitglied (persnr)
);


DROP TABLE Zeitraum CASCADE;
CREATE TABLE Zeitraum (
 persnr INT NOT NULL,
 name VARCHAR(255) NOT NULL,
 sid VARCHAR(10) NOT NULL,
 anfang DATE NOT NULL,
 ende DATE NOT NULL,

 PRIMARY KEY (persnr,name,sid),

 FOREIGN KEY (persnr) REFERENCES Angestellter (persnr),
 FOREIGN KEY (name,sid) REFERENCES Fan-Club (name,sid)
);


