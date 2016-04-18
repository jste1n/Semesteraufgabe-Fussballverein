-- df vornamen: word=givennames.list
-- df family: word=familynames.list
-- df product: word=products.list
-- df verp: word=verpackung.list
-- df masch: word=maschinen.list
-- df kunst: word=kunstschau.list
-- df null=0.0001

CREATE TABLE Person (
	nummer		INTEGER PRIMARY KEY, 
	vorname		TEXT,	-- df: text=vornamen length=1
	nachname	TEXT	-- df: text=family length=1
);
	
CREATE TABLE Mitarbeiter(
	nummer		INTEGER PRIMARY KEY REFERENCES Person,
	einstellungsdatum	DATE	-- df: start=1923-01-01 end=2015-01-01
);
	
CREATE TABLE Kuendigung (
	nummer		INTEGER PRIMARY KEY REFERENCES Mitarbeiter, 
	kuendigungsdatum	DATE	-- df: null=0.8
);
	
CREATE TABLE Kuenstler (
	nummer		INTEGER PRIMARY KEY REFERENCES Person, 
	bekanntheit	INTEGER,	-- df: size=10
	CHECK (bekanntheit between 0 and 10)); 
	
CREATE TABLE Produkt (
	nummer		INTEGER PRIMARY KEY, 
	bezeichnung	TEXT,	-- df: text=product length=1
	gewicht		INTEGER		-- df: size=50
);
	
CREATE TABLE Standardsortiment (
	nummer		INTEGER PRIMARY KEY REFERENCES Produkt,
	preis		NUMERIC(7,2), 
	verpackung	TEXT	-- df: text=verp length=1
);
	
CREATE TABLE Kunstwerk (
	nummer		INTEGER PRIMARY KEY REFERENCES Produkt,
	schaetzwert	NUMERIC(10,2));
	
CREATE TABLE Maschine (
	nummer		INTEGER PRIMARY KEY, 
	beschreibung	TEXT	-- df: text=masch length=1
);
	
CREATE TABLE Bedient (
	mitnummer	INTEGER REFERENCES Mitarbeiter(nummer) NOT NULL, 
	maschnummer	INTEGER REFERENCES Maschine (nummer) NOT NULL,
	PRIMARY KEY (mitnummer, maschnummer)
);
	
CREATE TABLE Erzeugt (
	maschnummer	INTEGER REFERENCES Maschine (nummer) NOT NULL,
	pnummer		INTEGER REFERENCES Produkt (nummer) NOT NULL,
	PRIMARY KEY (maschnummer, pnummer)
);
	
CREATE TABLE Lager (				-- df: mult=0.8
	bezeichnung	TEXT PRIMARY KEY,	-- df: prefix=lager length=10
	flaeche		NUMERIC(10,2)
);
	
CREATE TABLE betreut(
	mitnummer	INTEGER PRIMARY KEY REFERENCES Mitarbeiter (nummer), 
	bezeichnung 	TEXT REFERENCES Lager
);
	
CREATE TABLE Lagert (
	bezeichnung	TEXT REFERENCES Lager NOT NULL, 
	pnummer		INTEGER REFERENCES Produkt (nummer) NOT NULL, 
	menge		INTEGER,
	PRIMARY KEY (bezeichnung, pnummer)
);
	
CREATE TABLE Kunde (
	firmenname	TEXT PRIMARY KEY,	-- df: prefix=kunde length=15
	adresse		TEXT,
	telefonnummer	TEXT			-- df: pattern='\+4[0-9]+[0-9]{6,9}'
);
	
CREATE TABLE Auftrag (
	firmenname	TEXT NOT NULL,		-- df: prefix=firma sub=serial
	nummer		INTEGER NOT NULL,	-- df: count
	datum		DATE, 
	status		TEXT,			-- df: pattern='(abgeschlossen|in Produktion|bereit zur Auslieferung|in Vorbereitung)' null=0.0
	PRIMARY KEY (firmenname, nummer)
); 
	
CREATE TABLE Enthaelt (
	firmenname	TEXT NOT NULL, 		-- df: prefix=firma sub=serial
	nummer		INTEGER NOT NULL,	-- df: count
	pnummer		INTEGER REFERENCES Produkt (nummer) NOT NULL,
	menge		INTEGER NOT NULL,
	FOREIGN KEY (firmenname, nummer) REFERENCES Auftrag,
	PRIMARY KEY (firmenname, nummer, pnummer)
); 
	
CREATE TABLE Kunstschau (
	datum		DATE NOT NULL,		-- df: sub=serial start=1995-01-01 end=2015-12-01
	name		TEXT NOT NULL,		-- df: prefix=kunstschau sub=serial
	ort		TEXT, 
	land		TEXT,
	PRIMARY KEY (datum, name)
);

CREATE TABLE Zeigt (
	knummer 	INTEGER REFERENCES Kuenstler (nummer) NOT NULL, 
	kunstwerknummer	INTEGER REFERENCES Kunstwerk (nummer) NOT NULL, 
	datum		DATE NOT NULL,		-- df: sub=serial start=1995-01-01 end=2015-12-01
	name		TEXT NOT NULL,		-- df: prefix=kunstschau sub=serial
	platz		INTEGER,		-- df: size=50
	FOREIGN KEY (datum, name) REFERENCES Kunstschau,
	PRIMARY KEY (knummer, kunstwerknummer, datum, name)
); 

