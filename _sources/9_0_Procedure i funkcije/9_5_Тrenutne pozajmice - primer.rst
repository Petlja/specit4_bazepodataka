Тренутне позајмице - пример
===========================

.. suggestionnote::

    За библиотеку је у сваком тренутку важно да има информације о тренутно издатим књигама. Већ смо видели доста задатака посвећених тренутно издатим књигама. 

    Овој теми ћемо приступити кроз неколико различитих програмских решења која сада укључују и писање процедура и функција. 

Програми се пишу у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

Сви примери PL/SQL програма узимају податке из базе података библиотеке. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_94a.jpg
    :width: 600
    :align: center

.. questionnote::

    1. Написати PL/SQL процедуру која приказује све тренутне позајмице

::

        --PROCEDURA
        CREATE OR REPLACE PROCEDURE tekuce_pozajmice IS
            CURSOR spisak_pozajmica IS 
                SELECT datum_uzimanja, inventarski_broj, naziv, broj_clanske_karte, ime, prezime
                FROM pozajmice JOIN clanovi USING (broj_clanske_karte)
                JOIN primerci USING (inventarski_broj) JOIN knjige USING (id_knjige)
                WHERE datum_vracanja IS NULL;
    BEGIN
        FOR v_pozajmica IN spisak_pozajmica LOOP
            DBMS_OUTPUT.PUT_LINE(v_pozajmica.datum_uzimanja);
            DBMS_OUTPUT.PUT_LINE(' '||v_pozajmica.inventarski_broj||' - '||v_pozajmica.naziv);
            DBMS_OUTPUT.PUT_LINE(' '||v_pozajmica.broj_clanske_karte||' - '||v_pozajmica.ime||
        ' '||v_pozajmica.prezime);
        END LOOP;
    END;

Следи PL/SQL програм у којем се позива процедура. 

::

    --poziv procedure
    BEGIN
        tekuce_pozajmice;
    END

.. questionnote::

    2. Написати PL/SQL функцију која приказује укупан број тренутно издатих књига. 

::

    
    --FUNKCIJA - ukupan broj tekucih pozajmica
    CREATE OR REPLACE FUNCTION broj_tekucih_pozajmica RETURN NUMBER IS
        v_broj NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_broj FROM pozajmice WHERE datum_vracanja IS NULL;
        RETURN v_broj;
    END

Следи PL/SQL програм у којем се позива функција. 

::

    --poziv funkcije
    BEGIN
        DBMS_OUTPUT.PUT_LINE(broj_tekucih_pozajmica);
    END

.. questionnote::

    3. Написати PL/SQL процедуру која за дати број чланске карте приказује све књиге које се тренутно налазе код тог члана. 

::

        --PROCEDURA
    CREATE OR REPLACE PROCEDURE 
        tekuce_pozajmice_clana(p_broj_clanske_karte clanovi.broj_clanske_karte%TYPE) IS
        CURSOR spisak_pozajmica IS 
            SELECT datum_uzimanja, inventarski_broj, naziv
            FROM pozajmice JOIN primerci USING (inventarski_broj) JOIN knjige USING (id_knjige)
            WHERE datum_vracanja IS NULL AND broj_clanske_karte = p_broj_clanske_karte;
    BEGIN
        FOR v_pozajmica IN spisak_pozajmica LOOP
            DBMS_OUTPUT.PUT_LINE(v_pozajmica.datum_uzimanja);
            DBMS_OUTPUT.PUT_LINE(' '||v_pozajmica.inventarski_broj||' - '||v_pozajmica.naziv);
        END LOOP;
    END 

Следи PL/SQL програм у којем се позива процедура за члана чији је број чланске карте 33. 

::

    BEGIN
        tekuce_pozajmice_clana(33);
    END

Следи други PL/SQL програм у којем се позива процедура за члана чији се број чланске карте уноси са тастатуре. 

::

    DECLARE
        v_broj_clanske_karte clanovi.broj_clanske_karte%TYPE;
    BEGIN
        v_broj_clanske_karte := :BROJ_CLANSKE;
        tekuce_pozajmice_clana(v_broj_clanske_karte);
    END

Следи трећи PL/SQL програм у којем се позива процедура за сваког члана библиотеке. 

::

    DECLARE 
        CURSOR spisak_clanova IS SELECT * FROM clanovi;
    BEGIN
        FOR v_clan IN spisak_clanova LOOP
            DBMS_OUTPUT.PUT_LINE('CLAN: '||v_clan.ime||' '||v_clan.prezime);
            tekuce_pozajmice_clana(v_clan.broj_clanske_karte);
        END LOOP;
    END

.. questionnote::

    4. Написати PL/SQL функцију која за дати број чланске карте враћа број књига које се тренутно налазе код тог члана. 

::

    CREATE OR REPLACE FUNCTION 
        broj_tekucih_pozajmica(p_broj_clanske_karte clanovi.broj_clanske_karte%TYPE) 
        RETURN NUMBER
        IS
            v_broj NUMBER;
    BEGIN
        SELECT COUNT(*) INTO v_broj
        FROM pozajmice WHERE broj_clanske_karte = p_broj_clanske_karte
        AND datum_vracanja IS NULL;
        RETURN v_broj;
    END

У следећем програму се позива функција за члана са бројем чланске карте 33. 

::

    BEGIN
        DBMS_OUTPUT.PUT_LINE(broj_tekucih_pozajmica(33));
    END


У следећем програму се користи курсор којим се пролази кроз све чланове и за сваког се позива креирана функција. Приказати одговарајућу поруку уколико члан тренутно нема код себе књиге из библиотеке. 

::

    DECLARE
        CURSOR kursor_clanovi IS SELECT * FROM clanovi;
        v_broj NUMBER;
    BEGIN
        FOR v_clan IN kursor_clanovi LOOP
            DBMS_OUTPUT.PUT_LINE('Ime i prezime clana: '||v_clan.ime||' '||v_clan.prezime);
            v_broj := broj_tekucih_pozajmica(v_clan.broj_clanske_karte);
            IF v_broj = 0 THEN
            DBMS_OUTPUT.PUT_LINE('Nema tekuce pozajmice');
            ELSE 
            DBMS_OUTPUT.PUT_LINE('Broj trenutno zaduzenih knjiga: '||v_broj);
            END IF;
        END LOOP; 
    END

 
