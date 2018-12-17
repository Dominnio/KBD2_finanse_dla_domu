-- Dodane przeze mnie

-- sekwencje

CREATE OR REPLACE SEQUENCE sekwencja_produkty
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE SEQUENCE sekwencja_operacje
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE SEQUENCE sekwencja_kategorie
  START WITH 1
  INCREMENT BY 1;

CREATE OR REPLACE SEQUENCE sekwencja_zrodla_srodkow
  START WITH 1
  INCREMENT BY 1;

-- wyzwalacze

CREATE OR REPLACE TRIGGER podstaw_id_produktu BEFORE INSERT ON produkty
FOR EACH ROW 
  WHEN (new.id_produktu IS NULL)
  BEGIN
   SELECT sekwencja_produkty.NEXTVAL
   INTO :new.id_produktu
   FROM dual
  END;
 
CREATE OR REPLACE TRIGGER podstaw_id_operacji BEFORE INSERT ON operacje
FOR EACH ROW 
  WHEN (new.id_operacji IS NULL)
  BEGIN
   SELECT sekwencja_operacji.NEXTVAL
   INTO :new.id_operacji
   FROM dual
  END;
  
CREATE OR REPLACE TRIGGER podstaw_id_kategorii BEFORE INSERT ON kategorie
FOR EACH ROW 
  WHEN (new.id_kategorii IS NULL)
  BEGIN
   SELECT sekwencja_kategorie.NEXTVAL
   INTO :new.id_kategorii
   FROM dual
  END;
  
CREATE OR REPLACE TRIGGER podstaw_id_zrodla BEFORE INSERT ON zrodla_srodkow
FOR EACH ROW 
  WHEN (new.id_zrodla IS NULL)
  BEGIN
   SELECT sekwencja_zrodla_srodkow.NEXTVAL
   INTO :new.id_zrodla
   FROM dual
  END;

CREATE OR REPLACE TRIGGER uaktualnij_stan_srodkow AFTER INSERT OR DELETE OR UPDATE ON operacje
FOR EACH ROW 
  WHEN (new.kwota_operacji <> old.kwota_operacji)
  BEGIN
    IF(new.kwota_operacji IS NULL) THEN
      UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow + :old.kwota_operacji
      FROM zrodla_srodkow JOIN operacje ON zrodla_srodkow.id_zrodla = operacje.id_zrodla
  ELSE
    IF(old.kwota_operacji IS NULL) THEN
      UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow - :new.kwota_operacji
      FROM zrodla_srodkow JOIN operacje ON zrodla_srodkow.id_zrodla = operacje.id_zrodla
    ELSE
      UPDATE zrodla_srodkow SET stan_srodkow = stan_srodkow + :old.kwota_operacji - :new.kwota_operacji
      FROM zrodla_srodkow JOIN operacje ON zrodla_srodkow.id_zrodla = operacje.id_zrodla 
  END;

CREATE OR REPLACE TRIGGER sprawdz_czy_data_nie_jest_z_przyszlosci BEFORE INSERT OR DELETE OR UPDATE ON operacje
FOR EACH ROW 
  BEGIN
    IF(:new.data_operacji > SYSDATE)
    THEN
      raise_application_error(-20000, 'Data musi byc z przeslosci')
    END IF;
  END;

CREATE OR REPLACE TRIGGER sprawdz_typ_operacji BEFORE INSERT OR DELETE OR UPDATE ON operacje
FOR EACH ROW 
  DECLARE 
    @typ_kategorii CHAR(1)   
  BEGIN
    SELECT @typ_kategorii = typ FROM kategorie JOIN operacje ON kategorie.id_kategorii = operacje.id_kategorii
    IF(@typ_kategorii = 'Z') THEN
      raise_application_error(-20001, 'Typ produktu przypisany do operacji')
  END;

CREATE OR REPLACE TRIGGER sprawdz_typ_zakupionego_produktu BEFORE INSERT OR DELETE OR UPDATE ON zakupione_produkty
FOR EACH ROW 
  DECLARE 
    @typ_kategorii CHAR(1)   
  BEGIN
    SELECT @typ_kategorii = typ FROM kategorie JOIN zakupione_produkty ON kategorie.id_kategorii = zakupione_produkty.id_kategorii
    IF(@typ_kategorii = 'O') THEN
      raise_application_error(-20002, 'Typ operacji przypisany do produktu')
  END
  
-- perspektywy

CREATE OR REPLACE VIEW wydatki_w_ramach_kategorii_zakupu AS
SELECT nazwa, SUM(koszt) FROM zakupione_produkty
INNER JOIN kategorie ON zakupione_produkty.id_kategorii = kategorie.id_kategorii
GROUP BY nazwa

CREATE OR REPLACE VIEW wydatki_w_ramach_kategorii_operacji AS
SELECT nazwa, SUM(koszt) FROM operacje
INNER JOIN kategorie ON operacje.id_kategorii = operacje.id_kategorii
GROUP BY nazwa

-- Dodane przeze mnie (koniec)

SET SQLBLANKLINES ON
CREATE TABLE KATEGORIE 
(
  ID_KATEGORII NUMBER(4) NOT NULL 
, NAZWA VARCHAR2(50 CHAR) NOT NULL 
, TYP CHAR(1) NOT NULL 
, CONSTRAINT KATEGORIE_PK PRIMARY KEY 
  (
    ID_KATEGORII 
  )
  ENABLE 
);

CREATE TABLE PRODUKTY 
(
  ID_PRODUKTU NUMBER(5) NOT NULL 
, KOD_PRODUKTU VARCHAR2(50) NOT NULL 
, NAZWA VARCHAR2(100) NOT NULL 
, CONSTRAINT PRODUKTY_PK PRIMARY KEY 
  (
    ID_PRODUKTU 
  )
  ENABLE 
);

CREATE TABLE ZRODLA_SRODKOW 
(
  ID_ZRODLA NUMBER(2) NOT NULL 
, NAZWA VARCHAR2(50) NOT NULL 
, STAN_SRODKOW NUMBER(8, 2) NOT NULL 
, CONSTRAINT ZRODLA_SRODKOW_PK PRIMARY KEY 
  (
    ID_ZRODLA 
  )
  ENABLE 
);

CREATE TABLE OPERACJE 
(
  ID_OPERACJI NUMBER(8) NOT NULL 
, ID_ZRODLA NUMBER(2) NOT NULL 
, ID_KATEGORII NUMBER(4) NOT NULL 
, DATA_OPERACJI DATE NOT NULL 
, KWOTA NUMBER(8,2) NOT NULL 
, OPIS VARCHAR2(150 CHAR) 
, CONSTRAINT OPERACJE_PK PRIMARY KEY 
  (
    ID_OPERACJI 
  )
  ENABLE 
);

CREATE TABLE ZAKUPIONE_PRODUKTY 
(
  ID_PRODUKTU NUMBER(5) NOT NULL 
, ID_OPERACJI NUMBER(8) NOT NULL 
, ID_KATEGORII NUMBER(4) NOT NULL 
, KOSZT NUMBER(8, 2) NOT NULL 
, ILOSC NUMBER(4) 
, JEDNOSTKA VARCHAR2(5) 
, CENA NUMBER(8, 2) 
, CONSTRAINT ZAKUPIONE_PRODUKTY_PK PRIMARY KEY 
  (
    ID_OPERACJI 
  , ID_PRODUKTU 
  )
  ENABLE 
);

CREATE INDEX OPERACJE_KATEGORIE_IDX ON OPERACJE (ID_KATEGORII);

CREATE INDEX OPERACJE_ZRODLA_IDX ON OPERACJE (ID_ZRODLA);

CREATE INDEX ZAKUPIONE_PRODUKTY_KAT_IDX ON ZAKUPIONE_PRODUKTY (ID_KATEGORII);

CREATE INDEX ZAKUPIONE_PRODUKTY_PR_IDX ON ZAKUPIONE_PRODUKTY (ID_PRODUKTU);

ALTER TABLE KATEGORIE
ADD CONSTRAINT KATEGORIE_UK UNIQUE 
(
  NAZWA 
, TYP 
)
ENABLE;

ALTER TABLE PRODUKTY
ADD CONSTRAINT PRODUKTY_UK UNIQUE 
(
  KOD_PRODUKTU 
)
ENABLE;

ALTER TABLE ZRODLA_SRODKOW
ADD CONSTRAINT ZRODLA_SRODKOW_UK UNIQUE 
(
  NAZWA 
)
ENABLE;

ALTER TABLE OPERACJE
ADD CONSTRAINT OPERACJE_KATEGORIE_FK1 FOREIGN KEY
(
  ID_KATEGORII 
)
REFERENCES KATEGORIE
(
  ID_KATEGORII 
)
ENABLE;

ALTER TABLE OPERACJE
ADD CONSTRAINT OPERACJE_ZRODLA_SRODKOW_FK1 FOREIGN KEY
(
  ID_ZRODLA 
)
REFERENCES ZRODLA_SRODKOW
(
  ID_ZRODLA 
)
ENABLE;

ALTER TABLE ZAKUPIONE_PRODUKTY
ADD CONSTRAINT ZAKUPIONE_PRODUKTY_FK1 FOREIGN KEY
(
  ID_PRODUKTU 
)
REFERENCES PRODUKTY
(
  ID_PRODUKTU 
)
ENABLE;

ALTER TABLE ZAKUPIONE_PRODUKTY
ADD CONSTRAINT ZAKUPIONE_PRODUKTY_FK2 FOREIGN KEY
(
  ID_OPERACJI 
)
REFERENCES OPERACJE
(
  ID_OPERACJI 
)
ENABLE;

ALTER TABLE ZAKUPIONE_PRODUKTY
ADD CONSTRAINT ZAKUPIONE_PRODUKTY_FK3 FOREIGN KEY
(
  ID_KATEGORII 
)
REFERENCES KATEGORIE
(
  ID_KATEGORII 
)
ENABLE;

ALTER TABLE KATEGORIE
ADD CONSTRAINT KATEGORIE_CHK CHECK 
(TYP IN ('O', 'Z'))
ENABLE;

COMMENT ON TABLE KATEGORIE IS 'Tabela przechowująca kategorie zakupów i operacji.';

COMMENT ON TABLE OPERACJE IS 'Tabela przechowująca operacje na kontach i gotówce.';

COMMENT ON TABLE PRODUKTY IS 'Tabela reprezentujaca wirtualne produkty';

COMMENT ON TABLE ZAKUPIONE_PRODUKTY IS 'Tabela przechowująca produkty zakupione w ramach operacji.';

COMMENT ON TABLE ZRODLA_SRODKOW IS 'Tabela reprezentujace konta bankowe i gotowke';

COMMENT ON COLUMN KATEGORIE.ID_KATEGORII IS 'Klucz główny kategorii';

COMMENT ON COLUMN KATEGORIE.NAZWA IS 'Nazwa kategorii unikalna w ramach typu';

COMMENT ON COLUMN KATEGORIE.TYP IS 'O - typ operacji, Z - typ zakupu';

COMMENT ON COLUMN OPERACJE.ID_OPERACJI IS 'Klucz glowny operacji';

COMMENT ON COLUMN OPERACJE.ID_ZRODLA IS 'Klucz obcy zrodla srodkow';

COMMENT ON COLUMN OPERACJE.ID_KATEGORII IS 'Klucz obcy kategorii operacji';

COMMENT ON COLUMN OPERACJE.DATA_OPERACJI IS 'Data zaksiegowania operacji lub wydania gotowki';

COMMENT ON COLUMN OPERACJE.KWOTA IS 'Suma pieniedzy w operacji';

COMMENT ON COLUMN OPERACJE.OPIS IS 'Dodatkowe informacje, np. odbiorca operacji';

COMMENT ON COLUMN PRODUKTY.ID_PRODUKTU IS 'Identyfikator produktu';

COMMENT ON COLUMN PRODUKTY.KOD_PRODUKTU IS 'Skrocona unikalna nazwa produktu';

COMMENT ON COLUMN PRODUKTY.NAZWA IS 'Pelna nazwa produktu';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.ID_PRODUKTU IS 'klucz obcy produktu';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.ID_OPERACJI IS 'klucz obcy operacji';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.ID_KATEGORII IS 'klucz obcy kategorii';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.KOSZT IS 'całkowity koszt produktów o id id_produktu dla operacji';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.ILOSC IS 'ilość (liczba) produktu';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.JEDNOSTKA IS 'jednostka w jakiej podana jest ilość produktu, w przypadku liczby - szt';

COMMENT ON COLUMN ZAKUPIONE_PRODUKTY.CENA IS 'cena pojedynczego prododuktu (jednostki wagi)';

COMMENT ON COLUMN ZRODLA_SRODKOW.ID_ZRODLA IS 'Klucz glowny zrodla, identyfikator konta bankowego lub gotowki';

COMMENT ON COLUMN ZRODLA_SRODKOW.NAZWA IS 'Unikalna nazwa zrodla';

COMMENT ON COLUMN ZRODLA_SRODKOW.STAN_SRODKOW IS 'Stan srodkow zgodny ze stanem faktycznym ';
