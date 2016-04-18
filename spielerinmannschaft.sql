CREATE TABLE SpielerInMannschaft (
 persnr INT NOT NULL PRIMARY KEY,
 bezeichnung VARCHAR(255) NOT NULL,
 nummer INT NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Spieler (persnr),
 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung)
);