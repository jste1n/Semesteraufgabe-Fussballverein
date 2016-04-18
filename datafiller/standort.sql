CREATE TABLE Standort (
 sid VARCHAR(10) NOT NULL PRIMARY KEY nextval('Standort_sid_seq'),
 land VARCHAR(255) NOT NULL,
 plz INT NOT NULL,
 ort VARCHAR(255) NOT NULL
);