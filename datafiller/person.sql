CREATE TABLE Person (
 persnr INT NOT NULL PRIMARY KEY default nextval('Person_persnr_seq'),
 vname VARCHAR(255) NOT NULL,
 nname VARCHAR(255) NOT NULL,
 geschlecht CHAR(1) NOT NULL,
 gebdat DATE NOT NULL
);