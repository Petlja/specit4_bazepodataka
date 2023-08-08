CREATE TABLE autori
( id_autora INT PRIMARY KEY, 
ime VARCHAR(15) NOT NULL, 
prezime VARCHAR(15) NOT NULL );

CREATE TABLE izdavaci
( id INT PRIMARY KEY, 
naziv VARCHAR(40) NOT NULL UNIQUE, 
adresa VARCHAR(50), 
veb_sajt VARCHAR(50) UNIQUE);

CREATE TABLE clanovi
( broj_clanske_karte INT PRIMARY KEY, 
ime VARCHAR(15) NOT NULL, 
prezime VARCHAR(15) NOT NULL, 
adresa VARCHAR(50) NOT NULL, 
telefon VARCHAR(20) NOT NULL,
mejl_adresa VARCHAR(50) );

CREATE TABLE clanarine
( broj_clanske_karte INT REFERENCES clanovi(broj_clanske_karte), 
god INT NOT NULL, 
iznos INT NOT NULL, 
opis VARCHAR(50), 
PRIMARY KEY (broj_clanske_karte, god) );

CREATE TABLE knjige
( id_knjige INT PRIMARY KEY, 
naziv VARCHAR(50) NOT NULL, 
id_izdavaca INT NOT NULL REFERENCES izdavaci(id) );

CREATE TABLE primerci
( inventarski_broj INT PRIMARY KEY, 
id_knjige INT NOT NULL REFERENCES knjige(id_knjige) );

CREATE TABLE autori_knjige
(id_autora INT REFERENCES autori(id_autora),
id_knjige INT REFERENCES knjige(id_knjige), 
PRIMARY KEY (id_autora, id_knjige) );

CREATE TABLE zaposleni
( id INT PRIMARY KEY, 
ime VARCHAR(15) NOT NULL, 
prezime VARCHAR(15) NOT NULL,
mejl VARCHAR(50),
datum_zaposlenja DATE NOT NULL,
plata INT NOT NULL,
id_menadzera INT REFERENCES zaposleni(id) );

CREATE TABLE pozajmice
( inventarski_broj INT REFERENCES primerci(inventarski_broj), 
broj_clanske_karte INT REFERENCES clanovi(broj_clanske_karte), 
datum_uzimanja DATE, 
datum_vracanja DATE, 
id_zaposlenog INT NOT NULL REFERENCES zaposleni(id),
PRIMARY KEY (inventarski_broj, broj_clanske_karte, datum_uzimanja), 
CHECK (datum_vracanja >= datum_uzimanja) );

CREATE TABLE kazne
( id_kazne INT PRIMARY KEY,
iznos INT NOT NULL,
datum DATE NOT NULL,  
inventarski_broj INT NOT NULL, 
broj_clanske_karte INT NOT NULL, 
datum_uzimanja DATE NOT NULL,
FOREIGN KEY (inventarski_broj, broj_clanske_karte, datum_uzimanja) 
REFERENCES pozajmice(inventarski_broj, broj_clanske_karte, datum_uzimanja),
UNIQUE (inventarski_broj, broj_clanske_karte, datum_uzimanja) );

INSERT INTO autori
VALUES (101, 'Stanka', 'Matkovic');
INSERT INTO autori
VALUES (102, 'Mijodrag', 'Djurisic');
INSERT INTO autori
VALUES (103, 'Dusa', 'Vukovic');
INSERT INTO autori
VALUES (104, 'Stephen', 'Grosz');
INSERT INTO autori
VALUES (105, 'Marko', 'Vidojkovic');

INSERT INTO izdavaci
VALUES (1, 'Zavod za udzbenike', 'Obilicev venac 5, Beograd', 
'http://www.knjizara.zavod.co.rs/');
INSERT INTO izdavaci
VALUES (2, 'CET', 'Knez Mihailova 6, Beograd', 'http://cet.rs/');
INSERT INTO izdavaci
VALUES (3, 'Vintage', 'Random House 20, London', 'www.vintage-books.co.uk');
INSERT INTO izdavaci
VALUES (4, 'Laguna', 'Resavska 33, Beograd', 'https://www.laguna.rs/');

INSERT INTO clanovi
VALUES (11, 'Milica', 'Zoranovic', 'Dunavska 22, Beograd', '061-111-111', null);
INSERT INTO clanovi
VALUES (22, 'Slavica', 'Mastilovic', 'Borska 1, Beograd', '062-222-332', 'slavica@gmail.com');
INSERT INTO clanovi
VALUES (33, 'Olivera', 'Stosic', 'Kneza 121, Beograd', '062-987-432', 'olja@gmail.com');
INSERT INTO clanovi
VALUES (44, 'Vukman', 'Mastilovic', 'Beogradska 8, Beograd', '061-323-656', 'vukman@gmail.com');
INSERT INTO clanovi
VALUES (55, 'Marko', 'Markovic', 'Krunska 9, Beograd', '065-221-221', 'marko@gmail.com');

INSERT INTO clanarine
VALUES (11, 2018, 3000, null);
INSERT INTO clanarine
VALUES (11, 2019, 3100, null);
INSERT INTO clanarine
VALUES (22, 2019, 3100, null);
INSERT INTO clanarine
VALUES (33, 2017, 2400, null);
INSERT INTO clanarine
VALUES (33, 2018, 2500, 'Popust za trudnice');
INSERT INTO clanarine
VALUES (33, 2019, 3100, null);
INSERT INTO clanarine
VALUES (44, 2019, 2000, 'Popust za ucenike');
INSERT INTO clanarine
VALUES (55, 2019, 2000, 'Popust za ucenike');

INSERT INTO knjige 
VALUES (111, 'Racunarstvo i informatika za 4. razred gimnazije', 1);
INSERT INTO knjige 
VALUES (222, 'Racunarstvo i informatika za 3. razred gimnazije', 1);
INSERT INTO knjige 
VALUES (321, 'Osnovi programiranja, programski jezici c#', 1);
INSERT INTO knjige 
VALUES (555, 'PROGRAMIRANJE - klase i objekti', 2);
INSERT INTO knjige 
VALUES (323, 'Veb programiranje', 2);
INSERT INTO knjige 
VALUES (999, 'The Examined Life', 3);
INSERT INTO knjige 
VALUES (414, 'Kandze', 4);
INSERT INTO knjige 
VALUES (415, 'E bas vam hvala', 4);

INSERT INTO primerci 
VALUES (12345, 111);
INSERT INTO primerci 
VALUES (12346, 111);
INSERT INTO primerci 
VALUES (12347, 222);
INSERT INTO primerci 
VALUES (12348, 321);
INSERT INTO primerci 
VALUES (12349, 321);
INSERT INTO primerci 
VALUES (13001, 555);
INSERT INTO primerci 
VALUES (13002, 555);
INSERT INTO primerci 
VALUES (13003, 555);
INSERT INTO primerci 
VALUES (13004, 555);
INSERT INTO primerci 
VALUES (13005, 555);
INSERT INTO primerci 
VALUES (14001, 323);
INSERT INTO primerci 
VALUES (14002, 323);
INSERT INTO primerci 
VALUES (14003, 323);
INSERT INTO primerci 
VALUES (15001, 999);
INSERT INTO primerci 
VALUES (16001, 414);
INSERT INTO primerci 
VALUES (17001, 415);
INSERT INTO primerci 
VALUES (17002, 415);
INSERT INTO primerci 
VALUES (17003, 415);

INSERT INTO autori_knjige
VALUES (101, 111);
INSERT INTO autori_knjige
VALUES (101, 222);
INSERT INTO autori_knjige
VALUES (101, 321);
INSERT INTO autori_knjige
VALUES (102, 321);
INSERT INTO autori_knjige
VALUES (103, 321);
INSERT INTO autori_knjige
VALUES (102, 111);
INSERT INTO autori_knjige
VALUES (102, 222);
INSERT INTO autori_knjige
VALUES (103, 111);
INSERT INTO autori_knjige
VALUES (103, 555);
INSERT INTO autori_knjige
VALUES (103, 323);
INSERT INTO autori_knjige
VALUES (101, 323);
INSERT INTO autori_knjige
VALUES (102, 323);
INSERT INTO autori_knjige
VALUES (104, 999);
INSERT INTO autori_knjige
VALUES (105, 414);
INSERT INTO autori_knjige
VALUES (105, 415);

INSERT INTO zaposleni
VALUES (1, 'Jovan', 'Jovanovic', 'jjovanovic@biblioteka.rs', 
TO_DATE('23.09.2002.', 'dd.mm.yyyy.'), 95000, null);
INSERT INTO zaposleni
VALUES (2, 'Vojin', 'Pupavac', 'vpupavac@biblioteka.rs', 
TO_DATE('20.11.2010.', 'dd.mm.yyyy.'), 70000, 1);
INSERT INTO zaposleni
VALUES (3, 'Ana', 'Milosavljevic', 'amilosavljevic@biblioteka.rs',
TO_DATE('25.10.2015.', 'dd.mm.yyyy.'), 60000, 1);
INSERT INTO zaposleni
VALUES (4, 'Nemanja', 'Granic', 'ngranic@biblioteka.rs', 
TO_DATE('20.11.2010.', 'dd.mm.yyyy.'), 62000, 1);
INSERT INTO zaposleni
VALUES (5, 'Aleksandar', 'Jovic', 'ajovic@biblioteka.rs', 
TO_DATE('25.05.2014.', 'dd.mm.yyyy.'), 50000, 2);
INSERT INTO zaposleni
VALUES (6, 'Iva', 'Lazovic', 'ilazovic@biblioteka.rs', 
TO_DATE('20.07.2015.', 'dd.mm.yyyy.'), 50000, 2);
INSERT INTO zaposleni
VALUES (7, 'Lena', 'Kulic', 'lkulic@biblioteka.rs', 
TO_DATE('12.10.2017.', 'dd.mm.yyyy.'), 45000, 3);
INSERT INTO zaposleni
VALUES (8, 'Maja', 'Petrovic', 'mpetrovic@biblioteka.rs', 
TO_DATE('02.03.2015.', 'dd.mm.yyyy.'), 46000, 3);
INSERT INTO zaposleni
VALUES (9, 'Petar', 'Petrovic', 'ppetrovic@biblioteka.rs', 
TO_DATE('01.10.2018.', 'dd.mm.yyyy.'), 42000, 3);

INSERT INTO pozajmice
VALUES (12345, 33, TO_DATE('27.03.2019.', 'dd.mm.yyyy.'), 
TO_DATE('15.04.2019.', 'dd.mm.yyyy.'), 5);
INSERT INTO pozajmice
VALUES (12347, 33, TO_DATE('15.04.2019.', 'dd.mm.yyyy.'), 
TO_DATE('27.04.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (12349, 33, TO_DATE('27.04.2019.', 'dd.mm.yyyy.'), 
TO_DATE('20.05.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (13003, 33, TO_DATE('20.05.2019.', 'dd.mm.yyyy.'), null , 5);
INSERT INTO pozajmice
VALUES (17003, 33, TO_DATE('20.05.2019.', 'dd.mm.yyyy.'), null , 5);
INSERT INTO pozajmice
VALUES (13001, 22, TO_DATE('10.10.2018.', 'dd.mm.yyyy.'), 
TO_DATE('18.02.2019.', 'dd.mm.yyyy.'), 5);
INSERT INTO pozajmice
VALUES (17001, 22, TO_DATE('18.02.2019.', 'dd.mm.yyyy.'), 
TO_DATE('25.02.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (13005, 22, TO_DATE('25.02.2019.', 'dd.mm.yyyy.'), 
TO_DATE('07.03.2019.', 'dd.mm.yyyy.'), 5);
INSERT INTO pozajmice
VALUES (16001, 22, TO_DATE('07.03.2019.', 'dd.mm.yyyy.'), 
TO_DATE('21.05.2019.', 'dd.mm.yyyy.'), 5);
INSERT INTO pozajmice
VALUES (17002, 22, TO_DATE('21.05.2019.', 'dd.mm.yyyy.'), null, 6);
INSERT INTO pozajmice
VALUES (12345, 22, TO_DATE('21.05.2019.', 'dd.mm.yyyy.'), null, 6);
INSERT INTO pozajmice
VALUES (12347, 22, TO_DATE('21.05.2019.', 'dd.mm.yyyy.'), null, 6);
INSERT INTO pozajmice
VALUES (17003, 55, TO_DATE('15.01.2019.', 'dd.mm.yyyy.'),
TO_DATE('15.04.2019.', 'dd.mm.yyyy.'), 5);
INSERT INTO pozajmice
VALUES (15001, 11, TO_DATE('15.03.2019.', 'dd.mm.yyyy.'),
TO_DATE('01.04.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (16001, 11, TO_DATE('01.04.2019.', 'dd.mm.yyyy.'),
TO_DATE('16.04.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (12345, 11, TO_DATE('16.04.2019.', 'dd.mm.yyyy.'),
TO_DATE('28.04.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (12347, 11, TO_DATE('28.04.2019.', 'dd.mm.yyyy.'),
TO_DATE('22.05.2019.', 'dd.mm.yyyy.'), 6);
INSERT INTO pozajmice
VALUES (12349, 11, TO_DATE('22.05.2019.', 'dd.mm.yyyy.'), null, 6);

INSERT INTO kazne
VALUES (1, 500, TO_DATE('18.02.2019.', 'dd.mm.yyyy.'), 13001, 22, TO_DATE('10.10.2018.', 'dd.mm.yyyy.'));
INSERT INTO kazne
VALUES (2, 500, TO_DATE('21.05.2019.', 'dd.mm.yyyy.'), 16001, 22, TO_DATE('07.03.2019.', 'dd.mm.yyyy.'));
INSERT INTO kazne
VALUES (3, 400, TO_DATE('15.04.2019.', 'dd.mm.yyyy.'), 17003, 55, TO_DATE('15.01.2019.', 'dd.mm.yyyy.'));

