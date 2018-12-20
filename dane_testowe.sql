INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Ewa', 2300);
INSERT INTO kategorie (nazwa, typ) VALUES ('zakupy TESCO', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/12/12', -100.00);
INSERT INTO produkty(kod_produktu, nazwa) VALUES('MLK_ŁAC_2','Mleko Łaciate 2%');
INSERT INTO kategorie (nazwa, typ) VALUES ('spożywcze', 'Z');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 2, -4.30);
INSERT INTO produkty(kod_produktu, nazwa) VALUES('MIE_IND','Mięso z indyka');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka,koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 2, 'kg', -25.99);
INSERT INTO produkty(kod_produktu, nazwa) VALUES('WOD_NAŁ','Nałęczowianka');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka,koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 12, 'szt', -20.00);
INSERT INTO kategorie (nazwa, typ) VALUES ('kosmetyki', 'Z');
INSERT INTO produkty(kod_produktu, nazwa) VALUES('PAST_MER','Meridol pasta do zębów');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka,koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 2, 'szt', -26.98);
INSERT INTO produkty(kod_produktu, nazwa) VALUES('DEO_REX','Dezodorant Rexona');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka,koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 1, 'szt', -14.90);

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Julia', 120.50);
INSERT INTO kategorie (nazwa, typ) VALUES ('przychody', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota, opis) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/12/10', +4000.00, 'pensja');
INSERT INTO kategorie (nazwa, typ) VALUES ('rachunki', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota, opis) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/12/10', -80.00, 'oplata za internet');

INSERT INTO kategorie (nazwa, typ) VALUES ('jedzenie miasto', 'O');
INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Marek', 5000);
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota, opis) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/12/01', -80.00, 'obiad Lalka');

INSERT INTO kategorie (nazwa, typ) VALUES ('zakupy IKEA', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/11/01', -249.00);
INSERT INTO produkty(kod_produktu, nazwa) VALUES('FOT_BIUR','Fotel biurowy');
INSERT INTO kategorie (nazwa, typ) VALUES ('wyposazenie domu', 'Z');
INSERT INTO zakupione_produkty(id_produktu, id_operacji, id_kategorii, ilosc, jednostka,koszt) VALUES(sekwencja_produkty.CURRVAL, sekwencja_operacje.CURRVAL, sekwencja_kategorie.CURRVAL, 1, 'szt', -249.00);

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Dominik', 300);
INSERT INTO kategorie (nazwa, typ) VALUES ('kultura', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota, opis) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/11/01', -28.98, 'wyjscie do kina');

INSERT INTO kategorie (nazwa, typ) VALUES ('zakupy Zabka', 'O');
INSERT INTO operacje(id_zrodla, id_kategorii, data_operacji, kwota) VALUES(sekwencja_zrodla_srodkow.CURRVAL, sekwencja_kategorie.CURRVAL, '2018/11/01', -15.99);

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Babcia i dziadek', 3202.10);
INSERT INTO kategorie (nazwa, typ) VALUES ('elektronika', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('meble', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('ubrania', 'Z');
INSERT INTO kategorie (nazwa, typ) VALUES ('zabawki', 'Z');

INSERT INTO zrodla_srodkow(nazwa, stan_srodkow) VALUES('Mama i tata', 120050);

COMMIT;







