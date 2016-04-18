CREATE TABLE Spiel (
 mannschaft VARCHAR(255) NOT NULL,
 datum DATE NOT NULL,
 gegner VARCHAR(255) NOT NULL,
 ergebnis VARCHAR(13) NOT NULL,

 PRIMARY KEY (mannschaft,datum),

 FOREIGN KEY (mannschaft) REFERENCES Mannschaft (bezeichnung)
);