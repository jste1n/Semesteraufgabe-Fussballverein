-- df vornamen: word=givennames.list
-- df family: word=familynames.list
-- df position: word=position.list
-- df land: word=country.list
-- df plz: word=plz.list
-- df ort: word=ort.list
-- df liga: word=ligen.list


CREATE SEQUENCE Person_persnr_seq INCREMENT 2 MINVALUE 10000 MAXVALUE 99998;
CREATE TABLE Person (			-- df: mult=5000.00
 persnr INT NOT NULL PRIMARY KEY CHECK (persnr between 9999 and 99999 and persnr%2=0),	-- df: nogen
 vname VARCHAR(255) NOT NULL CHECK (vname ~* '^[A-Z]+$'),	-- df: text=vornamen length=1
 nname VARCHAR(255) NOT NULL CHECK (nname ~* '^[A-Z]+$'),	-- df: text=family length=1
 geschlecht CHAR(1) NOT NULL CHECK (geschlecht ~* 'm|w|n'),	-- df: pattern='(M|W|N)' null=0.0
 gebdat DATE NOT NULL CHECK (gebdat between '1900-01-01' and '2017-01-01')			-- df: start=1916-01-01 end=2010-01-01
);
ALTER SEQUENCE Person_persnr_seq OWNED by Person.persnr;



CREATE TABLE Spieler (				-- df: mult=5000.00
 persnr INT NOT NULL PRIMARY KEY,	-- df: nogen
 position VARCHAR(255) NOT NULL,	-- df: text=position length=1
 gehalt DECIMAL NOT NULL,		--df: pattern='[0-9]{3,9}'
 von DATE NOT NULL,		-- df: start=1916-01-01 end=1960-01-01
 bis DATE NOT NULL,		-- df: start=1960-02-01 end=2016-01-01
 CHECK (von < bis),
 
 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE SEQUENCE Standort_sid_seq MINVALUE 1;
CREATE TABLE Standort (				-- df: mult=5000.00
 sid VARCHAR(10) NOT NULL PRIMARY KEY CHECK (persnr >0), -- df: nogen
 land VARCHAR(255) NOT NULL,		-- df: text=land length=1
 plz INT  NOT NULL,					-- df: text=plz length=1
 ort VARCHAR(255) NOT NULL,			-- df: text=ort length=1
 UNIQUE (plz, ort)
);
ALTER SEQUENCE Standort_sid_seq OWNED BY Standort.sid;


CREATE TABLE Trainer (	-- df: mult=5000.00
 persnr INT NOT NULL PRIMARY KEY,	-- df: nogen
 gehalt DECIMAL(10) NOT NULL,	--df: pattern='[0-9]{3,8}'
 von DATE NOT NULL,		-- df: start=1916-01-01 end=1960-01-01
 bis DATE NOT NULL,		-- df: start=1960-02-01 end=2016-01-01

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE Angestellter (	-- df: mult=5000.00
 persnr INT NOT NULL PRIMARY KEY,	-- df: nogen
 gehalt DECIMAL(10) NOT NULL,	--df: pattern='[0-9]{3,5}'
 ueberstunden TIMESTAMP(10) NOT NULL,	--df: start='1990-01-01 00:00:01' end='2016-01-01 23:59:59'
 e_mail VARCHAR(255) NOT NULL,		-- df: pattern='[a-z]{3,8}\.[a-z]{3,8}@(gmail|yahoo)\.com'
 CHECK(e_mail LIKE '%@%')
 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE Mannschaft (		-- df: mult=5000.00
 bezeichnung VARCHAR(255) NOT NULL PRIMARY KEY,		-- df: pattern='(SK|SC|FC|SV) [:text=ort length=1:]'
 klasse VARCHAR(255) NOT NULL,		-- df: text=liga length=1
 naechstes_spiel DATE NOT NULL,		-- df: start=2016-01-01 end=2018-01-01
 kapitaen INT NOT NULL,		-- df: nogen
 anzahlSpieler INT NOT NULL CHECK (anzahlSpieler>10),	-- df: size=88 offset=11
 chefTrainer INT NOT NULL UNIQUE,		-- df: nogen
 trainerAssisten INT NOT NULL UNIQUE,		-- df: nogen

 UNIQUE (chefTrainer, trainerAssisten),			-- FEHLER
 
 FOREIGN KEY (chefTrainer) REFERENCES Trainer (persnr),
 FOREIGN KEY (trainerAssisten) REFERENCES Trainer (persnr),
 FOREIGN KEY (kapitaen) REFERENCES Spieler (persnr)
);


CREATE TABLE Mitglied (		-- df: mult=5000.00
 persnr INT NOT NULL PRIMARY KEY,	-- df: nogen
 beitrag DECIMAL(10) NOT NULL,	--df: pattern='[0-9]{2,4}'

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);


CREATE TABLE Spiel (		-- df: mult=5000.00
 datum DATE NOT NULL,	-- df: start=1970-01-01 end=2016-01-01
 mannschaft VARCHAR(255) NOT NULL,	-- df: nogen
 gegner VARCHAR(255) NOT NULL,		-- df: text=ort length=1
 ergebnis VARCHAR(13) NOT NULL,		-- df: pattern='[0-9]:[0-9]'

 PRIMARY KEY (datum,mannschaft),		-- FEHLER

 FOREIGN KEY (mannschaft) REFERENCES Mannschaft (bezeichnung)
);


CREATE TABLE SpielerInMannschaft (		-- df: mult=5000.00
 nummer INT NOT NULL,		-- df: size=88 offset=11
 bezeichnung VARCHAR(255) NOT NULL,		-- df: text=ort length=1
 persnr INT NOT NULL,		-- df: nogen

 UNIQUE(persnr, bezeichnung),
 
 PRIMARY KEY (nummer,bezeichnung),			-- FEHLER

 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung),
 FOREIGN KEY (persnr) REFERENCES Spieler (persnr)
);


CREATE TABLE BeteiligteSpieler (		-- df: mult=5000.00
 persnr INT NOT NULL,		-- df: nogen
 datum DATE NOT NULL,		-- df: nogen
 mannschaft VARCHAR(255) NOT NULL,		-- df: nogen
 dauer INT(3) NOT NULL,		-- df: size=140

 PRIMARY KEY (persnr,datum,mannschaft),	-- FEHLER

 FOREIGN KEY (persnr) REFERENCES Spieler (persnr),
 FOREIGN KEY (datum,mannschaft) REFERENCES Spiel (datum,mannschaft)
);


CREATE TABLE FanClub (		-- df: mult=5000.00
 name VARCHAR(255) NOT NULL,	-- df: pattern='Club [:count:]'
 sid VARCHAR(10) NOT NULL,		-- df: nogen
 gegruendet DATE NOT NULL,		-- df: start=1916-01-01 end=2000-01-01
 obmann VARCHAR(255) NOT NULL UNIQUE,	-- df: nogen

 PRIMARY KEY (name,sid),		-- FEHLER

 FOREIGN KEY (sid) REFERENCES Standort (sid),
 FOREIGN KEY (obmann) REFERENCES Mitglied (persnr)
);


CREATE TABLE Zeitraum (		-- df: mult=5000.00
 persnr INT NOT NULL,		-- df: nogen
 name VARCHAR(255) NOT NULL,		-- df: nogen
 sid VARCHAR(10) NOT NULL,		-- df: nogen
 anfang DATE NOT NULL,		-- df: start=1916-01-01 end=1960-01-01
 ende DATE NOT NULL,		-- df: start=1960-02-01 end=2016-01-01

 PRIMARY KEY (persnr,name,sid),		-- FEHLER

 FOREIGN KEY (persnr) REFERENCES Angestellter (persnr),
 FOREIGN KEY (name,sid) REFERENCES Fan-Club (name,sid)
);



