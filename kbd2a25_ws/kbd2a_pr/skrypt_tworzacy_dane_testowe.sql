INSERT INTO kategorie (nazwa, typ) VALUES ('spożywcze', 'Z')
INSERT INTO kategorie (nazwa, typ) VALUES ('elektronika', 'Z')
INSERT INTO kategorie (nazwa, typ) VALUES ('meble', 'Z')
INSERT INTO kategorie (nazwa, typ) VALUES ('ubrania', 'Z')
INSERT INTO kategorie (nazwa, typ) VALUES ('zabawki', 'Z')
INSERT INTO kategorie (nazwa, typ) VALUES ('wydatki', 'O')
INSERT INTO kategorie (nazwa, typ) VALUES ('przychody', 'O')

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Ewa', 2300)
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Marek', 5000)
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Dominik', 300)
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Julia', 120.50)
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Mama i tata', 120050)
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Babcia i dziadek', 3202.10)

INSERT INTO produkty(kod_produktu, nazwa) VALUES('MLK','Mleko')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('WOD','Woda')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('MIE','Mięso')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('LEG','Klocki lego')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('TEL','Telefon')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('PRD','Prąd')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('LPG','Gaz')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('BUT','Buty')
INSERT INTO produkty(kod_produktu, nazwa) VALUES('KOSZ','Koszula')

INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, opis) VALUES(1, 6, '12.12.2018', 'szał świątecznych zakupów')

INSERT INTO zapukione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka, cena) VALUES(4, 1, 5, 1, 'szt', 180.99)
INSERT INTO zapukione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka, cena) VALUES(9, 1, 4, 2, 'szt', 220.50)






