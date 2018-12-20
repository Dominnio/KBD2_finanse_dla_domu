DROP SEQUENCE sekwencja_produkty;
DROP SEQUENCE sekwencja_operacje;
DROP SEQUENCE sekwencja_kategorie;
DROP SEQUENCE sekwencja_zrodla_srodkow;

CREATE SEQUENCE sekwencja_produkty
  START WITH 1
  INCREMENT BY 1;

CREATE SEQUENCE sekwencja_operacje
  START WITH 1
  INCREMENT BY 1;

CREATE SEQUENCE sekwencja_kategorie
  START WITH 1
  INCREMENT BY 1;

CREATE SEQUENCE sekwencja_zrodla_srodkow
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE TRIGGER podstaw_id_produktu 
BEFORE INSERT ON produkty
FOR EACH ROW 
  WHEN (new.id_produktu IS NULL)
BEGIN
   SELECT sekwencja_produkty.NEXTVAL
   INTO :new.id_produktu
   FROM dual;
END;
/

CREATE OR REPLACE TRIGGER podstaw_id_operacji BEFORE INSERT ON operacje
FOR EACH ROW 
  WHEN (new.id_operacji IS NULL)
  BEGIN
   SELECT sekwencja_operacje.NEXTVAL
   INTO :new.id_operacji
   FROM dual;
  END;
/

CREATE OR REPLACE TRIGGER podstaw_id_kategorii BEFORE INSERT ON kategorie
FOR EACH ROW 
  WHEN (new.id_kategorii IS NULL)
  BEGIN
   SELECT sekwencja_kategorie.NEXTVAL
   INTO :new.id_kategorii
   FROM dual;
  END;
/

CREATE OR REPLACE TRIGGER podstaw_id_zrodla BEFORE INSERT ON zrodla_srodkow
FOR EACH ROW 
  WHEN (new.id_zrodla IS NULL)
  BEGIN
   SELECT sekwencja_zrodla_srodkow.NEXTVAL
   INTO :new.id_zrodla
   FROM dual;
  END;
/

CREATE OR REPLACE TRIGGER uaktualnij_stan_srodkow
AFTER INSERT OR DELETE OR UPDATE OF kwota ON operacje
FOR EACH ROW 
BEGIN
  IF INSERTING THEN
    UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow + :new.kwota
    WHERE id_zrodla = :new.id_zrodla;
  END IF;
  IF DELETING THEN
    UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow - :old.kwota
    WHERE id_zrodla = :old.id_zrodla;
  END IF;
  IF UPDATING THEN
    UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow + :new.kwota - :old.kwota
    WHERE id_zrodla = :old.id_zrodla;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER sprawdz_date BEFORE INSERT OR DELETE OR UPDATE ON operacje
FOR EACH ROW 
  BEGIN
    IF(:new.data_operacji > SYSDATE)
    THEN
      raise_application_error(-20000, 'Data musi byc z przeslosci');
    END IF;
  END;
/

CREATE OR REPLACE TRIGGER sprawdz_typ_operacji BEFORE INSERT OR UPDATE OF id_kategorii ON operacje
FOR EACH ROW 
  DECLARE 
    typ_kategorii CHAR(1);
  BEGIN
    SELECT typ INTO typ_kategorii FROM kategorie WHERE id_kategorii = :new.id_kategorii;
    IF(typ_kategorii = 'Z') THEN
      raise_application_error(-20001, 'Typ produktu przypisany do operacji');
    END IF;
  END;
/

CREATE OR REPLACE TRIGGER sprawdz_typ_produktu BEFORE INSERT OR UPDATE OF id_kategorii ON zakupione_produkty
FOR EACH ROW 
  DECLARE 
    typ_kategorii CHAR(1);
  BEGIN
    SELECT typ INTO typ_kategorii FROM kategorie WHERE id_kategorii = :new.id_kategorii;
    IF(typ_kategorii = 'O') THEN
      raise_application_error(-20002, 'Typ operacji przypisany do produktu');
    END IF;
  END;
/
  -- perspektywy

CREATE OR REPLACE VIEW wydatki_kat_zakupu AS
SELECT SUM(z.koszt) AS wydatki, k.nazwa AS kategoria FROM zakupione_produkty z
JOIN kategorie k ON z.id_kategorii = k.id_kategorii
GROUP BY k.nazwa;

CREATE OR REPLACE VIEW wydatki_kat_operacji AS
SELECT SUM(o.kwota) AS wydatki, k.nazwa AS kategoria FROM operacje o
JOIN kategorie k ON o.id_kategorii = k.id_kategorii
GROUP BY k.nazwa;
