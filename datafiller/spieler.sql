CREATE TABLE Spieler (
 persnr INT NOT NULL PRIMARY KEY,
 position VARCHAR(255) NOT NULL,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr)
);