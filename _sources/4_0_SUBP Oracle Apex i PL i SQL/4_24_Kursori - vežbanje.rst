Курсори - вежбање
=================

Решити следеће задатке писањем програма у програмској језику PL/SQL. Приликом решавања задатака, погледајте претходно решене примере. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, погледајте решење које ће се приказати након што кликнете на дугме. 

Програми се пишу у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

Креирати PL/SQL програме који узимају податке из базе података библиотеке. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_73a.jpg
   :width: 780
   :align: center

.. questionnote::

    1. Приказати укупан број позајмица за сваког члана библиотеке. Приказати и чланове који нису имали позајмице (користити спољно спајање).

.. reveal:: Pitanje_8_10a
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Погледајмо прво упит којим ове податке узимамо из базе података. 

    ::

        --SELECT upit koji vraca ukupan broj pozajmica za svakog clana biblioteke
        SELECT broj_clanske_karte, ime, prezime, COUNT(datum_uzimanja) AS broj
        FROM clanovi LEFT OUTER JOIN pozajmice USING (broj_clanske_karte)
        GROUP BY broj_clanske_karte, ime, prezime

    .. image:: ../../_images/slika_810a.jpg
        :width: 780
        :align: center

    Уколико би се изоставило спољно спајање LEFT OUTER, не би био приказан члан који није имао позајмице. 

    У програму ћемо креирати курсор који је везан за овај упит. Прво ћемо радити експлицитно са курсором. Приказиваћемо одговарајућу поруку уколико члан није позајмљивао књиге.

    ::

        DECLARE
            CURSOR kursor_clanovi IS 
                SELECT broj_clanske_karte, ime, prezime, COUNT(datum_uzimanja) AS broj
                FROM clanovi LEFT OUTER JOIN pozajmice USING (broj_clanske_karte)
                GROUP BY broj_clanske_karte, ime, prezime; 
            v_clan kursor_clanovi%ROWTYPE;
        BEGIN
            OPEN kursor_clanovi;
            LOOP
                FETCH kursor_clanovi INTO v_clan;
                EXIT WHEN kursor_clanovi%NOTFOUND;
            DBMS_OUTPUT.PUT_LINE(v_clan.broj_clanske_karte||' - '||v_clan.ime||' '||v_clan.prezime);
                IF v_clan.broj = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Clan nije pozajmljivao knjige');
                ELSE DBMS_OUTPUT.PUT_LINE('  Broj pozajmica: '||v_clan.broj);
                END IF;
            END LOOP;
            CLOSE kursor_clanovi;
        END

    Други приступ раду са курсором подразумева имплицитни облик рада и употребу циклуса FOR.

    ::


        DECLARE
            CURSOR kursor_clanovi IS 
                SELECT broj_clanske_karte, ime, prezime, COUNT(datum_uzimanja) AS broj
                FROM clanovi LEFT OUTER JOIN pozajmice USING (broj_clanske_karte)
                GROUP BY broj_clanske_karte, ime, prezime; 
                v_clan kursor_clanovi%ROWTYPE;
        BEGIN
            FOR v_clan IN kursor_clanovi LOOP
            DBMS_OUTPUT.PUT_LINE(v_clan.broj_clanske_karte||' '||v_clan.ime||' '||v_clan.prezime);
                IF v_clan.broj = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Clan nije pozajmljivao knjige');
                ELSE 
                DBMS_OUTPUT.PUT_LINE('  Broj pozajmica: '||v_clan.broj);
                END IF;
            END LOOP;
        END

    .. image:: ../../_images/slika_810b.jpg
        :width: 400
        :align: center
    
    У наредном задатку, који је сличан, приказаћемо други начин да се приступи решавању овог проблема, а без спајања табела, без потребе да водимо рачуна о спољном спајању, и без употребе GROUP BY.

.. questionnote::

    2. Приказати број текућих позајмица за сваког члана библиотеке. 

.. reveal:: Pitanje_8_10b
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    У овом решењу задатка, који је веома сличан претходном, имамо другачији приступ. Курсором идемо кроз списак свих чланова, а за сваког члана наредбом SELECT INTO узмемо број његових позајмица.

    ::

        DECLARE
            CURSOR kursor_clanovi IS
                SELECT * FROM clanovi;
            broj NUMBER(3);
        BEGIN
            FOR v_clan IN kursor_clanovi LOOP
            DBMS_OUTPUT.PUT_LINE(v_clan.broj_clanske_karte||' - '||v_clan.ime||' '||v_clan.prezime);
                DBMS_OUTPUT.PUT_LINE('Telefon: '||v_clan.telefon);
                DBMS_OUTPUT.PUT_LINE('Mejl: '||v_clan.mejl_adresa);
                SELECT COUNT(*) INTO broj
                FROM pozajmice WHERE broj_clanske_karte=v_clan.broj_clanske_karte 
                AND datum_vracanja IS NULL;
                IF broj = 0 THEN
                DBMS_OUTPUT.PUT_LINE('  Nema tekucih pozajmica');
                ELSE 
                DBMS_OUTPUT.PUT_LINE('  Broj tekucih pozajmica: '||broj);
                END IF;
            END LOOP;
        END

    .. image:: ../../_images/slika_810c.jpg.jpg
        :width: 350
        :align: center

.. questionnote::

    3. Приказати све позајмице за члана библиотеке са бројем чланске карте 33.

.. reveal:: Pitanje_8_10c
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Задатак може да се реши и без употребе курсора са параметром. 

    ::

        DECLARE
            CURSOR kursor_pozajmice (p_broj_clanske_karte clanovi.broj_clanske_karte%TYPE) IS
                SELECT naziv, datum_uzimanja, datum_vracanja 
                FROM pozajmice JOIN primerci USING (inventarski_broj)
                JOIN knjige USING (id_knjige)
                WHERE broj_clanske_karte = p_broj_clanske_karte;  
        BEGIN
            FOR v_pozajmica IN kursor_pozajmice(33) LOOP
                DBMS_OUTPUT.PUT_LINE('  '||v_pozajmica.naziv||' - '||v_pozajmica.datum_uzimanja||
                ' - '||v_pozajmica.datum_vracanja);
            END LOOP;
        END

.. questionnote::

    4. Приказати све позајмице за сваког члана библиотеке.

.. reveal:: Pitanje_8_10d
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            CURSOR kursor_clanovi IS
                SELECT * FROM clanovi;
            CURSOR kursor_pozajmice (p_broj_clanske_karte clanovi.broj_clanske_karte%TYPE) IS
                SELECT naziv, datum_uzimanja, datum_vracanja 
                FROM pozajmice JOIN primerci USING (inventarski_broj)
                JOIN knjige USING (id_knjige)
                WHERE broj_clanske_karte = p_broj_clanske_karte;  
        BEGIN
            FOR v_clan IN kursor_clanovi LOOP
            DBMS_OUTPUT.PUT_LINE(v_clan.broj_clanske_karte||' - '||v_clan.ime||' '||v_clan.prezime);
                DBMS_OUTPUT.PUT_LINE('Telefon: '||v_clan.telefon);
                DBMS_OUTPUT.PUT_LINE('Mejl: '||v_clan.mejl_adresa);

                FOR v_pozajmica IN kursor_pozajmice(v_clan.broj_clanske_karte) LOOP
                    DBMS_OUTPUT.PUT_LINE('  '||v_pozajmica.naziv||' - '||v_pozajmica.datum_uzimanja||
                    ' - '||v_pozajmica.datum_vracanja);
                    END LOOP;
            END LOOP;
        END

    .. image:: ../../_images/slika_810d.jpg
        :width: 600
        :align: center

.. questionnote::

   5. Приказати списак свих тренутних позајмица уређен од оних књига које су најдуже издате до најскоријих позајмица. 

.. reveal:: Pitanje_8_10e
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            CURSOR spisak_pozajmica IS 
            SELECT broj_clanske_karte, ime, prezime, knjige.naziv, datum_uzimanja from clanovi
            JOIN pozajmice USING (broj_clanske_karte)
            JOIN primerci USING (inventarski_broj)
            JOIN knjige USING (id_knjige)
            WHERE datum_vracanja IS NULL
            ORDER BY datum_uzimanja;
            v_red spisak_pozajmica%rowtype;
        BEGIN
            OPEN spisak_pozajmica;
            LOOP
                FETCH spisak_pozajmica INTO v_red;
                EXIT WHEN spisak_pozajmica%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE(v_red.broj_clanske_karte||' - '||v_red.ime||' '||v_red.prezime);
                DBMS_OUTPUT.PUT_LINE(' '||v_red.naziv||'; '||v_red.datum_uzimanja);
            END LOOP;
            CLOSE spisak_pozajmica;
        END

    Други приступ раду са курсором подразумева имплицитни облик рада и употребу циклуса FOR.

    ::

        DECLARE
            CURSOR spisak_pozajmica IS 
            SELECT broj_clanske_karte, ime, prezime, knjige.naziv, datum_uzimanja from clanovi
            JOIN pozajmice USING (broj_clanske_karte)
            JOIN primerci USING (inventarski_broj)
            JOIN knjige USING (id_knjige)
            WHERE datum_vracanja IS NULL
            ORDER BY datum_uzimanja;
        BEGIN
            FOR v_red IN spisak_pozajmica LOOP
                DBMS_OUTPUT.PUT_LINE(v_red.broj_clanske_karte||' - '||v_red.ime||' '||v_red.prezime);
                DBMS_OUTPUT.PUT_LINE(' '||v_red.naziv||'; '||v_red.datum_uzimanja);
            END LOOP;
        END

.. questionnote::

    6. За унет назив издавача, приказати све контакт информације чланова библиотеке који су читали књиге тог издавача. 

.. reveal:: Pitanje_8_10f
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            CURSOR spisak_clanova (p_naziv izdavaci.naziv%TYPE) IS 
            SELECT DISTINCT ime, prezime, broj_clanske_karte, mejl_adresa FROM pozajmice
            JOIN clanovi USING (broj_clanske_karte)
            JOIN primerci USING (inventarski_broj)
            JOIN knjige USING (id_knjige)
            JOIN izdavaci ON izdavaci.id = id_izdavaca
            WHERE izdavaci.naziv = p_naziv;
            v_naziv izdavaci.naziv%TYPE;
        BEGIN
            v_naziv := :naziv;
            FOR clan IN spisak_clanova(v_naziv) LOOP
                DBMS_OUTPUT.PUT_LINE('Broj clanske karte: ' || clan.broj_clanske_karte);
                DBMS_OUTPUT.PUT_LINE(' ' || clan.ime || ' ' || clan.prezime || ' - ' ||
                clan.mejl_adresa);
            END LOOP;
        END

.. questionnote::

    7. За сваког члана који је имао позајмице, приказати списак издавача књига које је читао. 

.. reveal:: Pitanje_8_10g
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_br_pozajmica NUMBER(10);
            CURSOR spisak_clanova IS SELECT broj_clanske_karte, ime, prezime FROM clanovi;
            CURSOR spisak_izdavaca(p_broj_clanske_karte pozajmice.broj_clanske_karte%TYPE) IS 
            SELECT DISTINCT izdavaci.naziv FROM izdavaci 
            JOIN knjige ON (id = id_izdavaca) 
            JOIN primerci USING (id_knjige)
            JOIN pozajmice USING (inventarski_broj) 
            WHERE pozajmice.broj_clanske_karte=p_broj_clanske_karte;
        BEGIN
            FOR v_clan IN spisak_clanova LOOP 
                DBMS_OUTPUT.PUT_LINE('Ime i prezime clana: ' || v_clan.ime ||' '|| v_clan.prezime);
                DBMS_OUTPUT.PUT_LINE('Broj clanske karte: ' || v_clan.broj_clanske_karte);
                SELECT COUNT(*) INTO v_br_pozajmica 
                FROM pozajmice WHERE v_clan.broj_clanske_karte = broj_clanske_karte;
                IF v_br_pozajmica = 0 THEN
                    DBMS_OUTPUT.PUT_LINE('Clan nije imao pozajmica');
                ELSE 
                    DBMS_OUTPUT.PUT_LINE('Broj pozajmica: ' || v_br_pozajmica);
                    FOR v_izdavac in spisak_izdavaca(v_clan.broj_clanske_karte) LOOP
                    DBMS_OUTPUT.PUT_LINE('  Naziv izdavaca: ' || v_izdavac.naziv);
                    END LOOP;
                END IF;
            END LOOP;
        END;

    Део резултата рада програма може да се види на следећој слици. 

    .. image:: ../../_images/slika_810c.jpg
        :width: 350
        :align: center

.. questionnote::

    8. За сваког запосленог приказати списак свих позајмица за које је био задужен. 

.. reveal:: Pitanje_8_10h
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            CURSOR spisak_zaposlenih IS SELECT id, ime, prezime FROM zaposleni;
            CURSOR spisak_pozajmica(p_id_zaposlenog zaposleni.id%TYPE) 
            IS SELECT inventarski_broj, broj_clanske_karte, datum_uzimanja 
            FROM pozajmice WHERE id_zaposlenog=p_id_zaposlenog;
        BEGIN
            FOR v_zaposleni IN spisak_zaposlenih LOOP 
                    DBMS_OUTPUT.PUT_LINE('Ime i prezime:' || v_zaposleni.ime || ' ' || 
                    v_zaposleni.prezime);
                FOR v_pozajmica IN spisak_pozajmica(v_zaposleni.id) LOOP  
                    DBMS_OUTPUT.PUT_LINE('  Inventarski broj:' || v_pozajmica.inventarski_broj);
                    DBMS_OUTPUT.PUT_LINE('  Broj clanske karte:' || v_pozajmica.broj_clanske_karte);
                    DBMS_OUTPUT.PUT_LINE('  Datum uzimanja:' || v_pozajmica.datum_uzimanja);
                END LOOP;
                DBMS_OUTPUT.PUT_LINE('   ');
            END LOOP;
        END

.. questionnote::

    9. За члана који је дошао у библиотеку, према његовом броју чланске карте, приказати списак свих књига свих аутора чију је бар једну књигу прочитао. 


.. reveal:: Pitanje_8_10i
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::


        DECLARE
            CURSOR spisak_knjiga(p_broj_clanske_karte clanovi.broj_clanske_karte%TYPE) 
                IS SELECT naziv, ime||' '||prezime AS autor
                FROM knjige JOIN autori_knjige ON (autori_knjige.id_knjige=knjige.id_knjige)
                JOIN autori ON (autori_knjige.id_autora=autori.id_autora)
                WHERE autori.id_autora IN (SELECT autori.id_autora
                FROM pozajmice JOIN primerci 
                ON (pozajmice.inventarski_broj=primerci.inventarski_broj)
                JOIN knjige ON (primerci.id_knjige=knjige.id_knjige) 
                JOIN autori_knjige ON (autori_knjige.id_knjige=primerci.id_knjige)
                WHERE broj_clanske_karte=p_broj_clanske_karte);
            v_broj_clanske_karte clanovi.broj_clanske_karte%TYPE;
        BEGIN
            v_broj_clanske_karte := :broj_cl_karte;
            FOR knjiga IN spisak_knjiga(v_broj_clanske_karte) LOOP
                DBMS_OUTPUT.PUT_LINE('Naziv knjige: '||knjiga.naziv);
                DBMS_OUTPUT.PUT_LINE(' Ime autora: '||knjiga.autor);
            END LOOP;
        END
