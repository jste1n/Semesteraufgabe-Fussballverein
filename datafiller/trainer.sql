CREATE TABLE Trainer (
 persnr INT NOT NULL PRIMARY KEY,
 gehalt DECIMAL(10) NOT NULL,
 von DATE NOT NULL,
 bis DATE NOT NULL,
 bezeichnung VARCHAR(255) NOT NULL,

 FOREIGN KEY (persnr) REFERENCES Person (persnr),
 FOREIGN KEY (bezeichnung) REFERENCES Mannschaft (bezeichnung)
);