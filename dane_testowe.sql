INSERT INTO kategorie (nazwa, typ) VALUES ('spożywcze', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('elektronika', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('meble', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('ubrania', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('zabawki', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('przychody', 'O');
INSERT INTO kategorie (nazwa, typ) VALUES ('inne', 'O');

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Ewa', 2300);
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Marek', 5000);
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Dominik', 300);
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Julia', 120.50);
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Mama i tata', 120050);
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Babcia i dziadek', 3202.10);

INSERT INTO produkty(kod_produktu, nazwa) VALUES('MLK','Mleko');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('WOD','Woda');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('MIE','Mięso');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('LEG','Klocki lego');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('TEL','Telefon');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('PRD','Prąd');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('LPG','Gaz');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('BUT','Buty');

INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota, opis) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/12/12', 600, 'zakupy świąteczne');

INSERT INTO kategorie (nazwa, typ) VALUES ('prezenty', 'Z');

INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 1, 180.99);

INSERT INTO produkty(kod_produktu, nazwa) VALUES('KOSZ','Koszula');

INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 2, 220.50);
COMMIT;
