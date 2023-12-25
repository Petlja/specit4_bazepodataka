Језик PL/SQL и наредба SELECT INTO – вежбање
=============================================

Решити следеће задатке писањем програма у програмској језику PL/SQL. Приликом решавања задатака, погледајте претходно решене примере. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не успевате да га решите, можете да погледате решење које ће се приказати након што кликнете на дугме. 

Програми се пишу у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

Креирати PL/SQL програме који узимају податке из базе података библиотеке. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_73a.jpg
   :width: 780
   :align: center

.. questionnote::

    1. Приказати плату запосленог са идентификационим бројем 9.

.. reveal:: pitanje_7_5a
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE 
            v_plata zaposleni.plata%TYPE;
        BEGIN
            SELECT plata INTO v_plata
            FROM zaposleni WHERE id = 9;
            DBMS_OUTPUT.PUT_LINE('Trazena plata: '||v_plata);
        END

.. questionnote::

    2. Приказати адресу и телефон члана библиотеке који се зове Оливера Стошић. Предвидети обраду изузетка уколико нема члана са тим именом и презименом, као и ситуацију уколико постоје два члана који се зову и презивају исто.

.. reveal:: pitanje_7_5b
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE 
            v_adresa clanovi.adresa%TYPE;
            v_telefon clanovi.telefon%TYPE;
        BEGIN
            SELECT adresa, telefon INTO v_adresa, v_telefon
            FROM clanovi WHERE ime='Olivera' AND prezime='Stosic';
            DBMS_OUTPUT.PUT_LINE('Adresa: '||v_adresa);
            DBMS_OUTPUT.PUT_LINE('Telefon: '||v_telefon);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nema clana sa tim imenom');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Ima vise clanova sa istim imenom');
        END

    Други приступ са једном сложеном променљивом.

    ::

        DECLARE 
            v_podaci clanovi%ROWTYPE;
        BEGIN
            SELECT * INTO v_podaci
            FROM clanovi WHERE ime='Olivera' AND prezime='Stosic';
            DBMS_OUTPUT.PUT_LINE('Adresa: '||v_podaci.adresa);
            DBMS_OUTPUT.PUT_LINE('Telefon: '||v_podaci.telefon);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nema clana sa tim imenom');
            WHEN TOO_MANY_ROWS THEN
                DBMS_OUTPUT.PUT_LINE('Ima vise clanova sa istim imenom');
        END

.. questionnote::

    3. Приказати адресу и веб-сајт издавача чији се назив уноси са тастатуре. Предвидети обраду изузетка уколико нема издавача са унетим називом. 

.. reveal:: pitanje_7_5c
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_izdavac izdavaci%ROWTYPE;
            v_naziv izdavaci.naziv%TYPE;
        BEGIN
            v_naziv := :naziv_izdavaca;
            SELECT * INTO v_izdavac
            FROM izdavaci WHERE UPPER(naziv)=UPPER(v_naziv);
            DBMS_OUTPUT.PUT_LINE('Adresa: '||v_izdavac.adresa);
            DBMS_OUTPUT.PUT_LINE('Veb sajt: '||v_izdavac.veb_sajt);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN
                DBMS_OUTPUT.PUT_LINE('Nema izdavaca sa tim nazivom');
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Greska');
        END

.. questionnote::

    4. Приказати број примерака књиге са називом „PROGRAMIRANJE - klase i objekti“. Написати посебну поруку уколико у библиотеци постоји само један примерак. 

.. reveal:: pitanje_7_5d
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_broj_primeraka NUMBER;
        BEGIN
            SELECT COUNT(id_knjige) INTO v_broj_primeraka
            FROM knjige JOIN primerci USING(id_knjige)
            WHERE naziv = 'PROGRAMIRANJE - klase i objekti';
            IF v_broj_primeraka = 1 THEN
                DBMS_OUTPUT.PUT_LINE('U biblioteci postoji samo jedan primerak');
            ELSE
                DBMS_OUTPUT.PUT_LINE ('Broj primeraka: ' || v_broj_primeraka);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('Doslo je do greske');
        END

.. questionnote::

    5. Приказати број позајмица за члана чије се име и презиме уносе са тастатуре. 

.. reveal:: pitanje_7_5e
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            broj NUMBER(5);
            v_ime clanovi.ime%TYPE;
            v_prezime clanovi.prezime%TYPE;
        BEGIN
            v_ime := :ime_clana;
            v_prezime := :prezime_clana;
            SELECT COUNT(*) INTO broj
            FROM pozajmice JOIN clanovi USING (broj_clanske_karte) 
            WHERE UPPER(ime) = UPPER(v_ime) AND UPPER(prezime) = UPPER(v_prezime);
            DBMS_OUTPUT.PUT_LINE('Broj pozajmica: '||broj);
        EXCEPTION
            WHEN OTHERS THEN 
                DBMS_OUTPUT.PUT_LINE('Doslo je do greske');
        END

.. questionnote::

    6. Приказати за члана са бројем чланске карте 33 број различитих издавача чије је књиге позајмљивао (уколико је члан читао више књига исте издавачке куће, тај издавач треба да се преброји само једном

.. reveal:: pitanje_7_5f
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_broj_izdavaca NUMBER;
        BEGIN
            SELECT COUNT(DISTINCT id_izdavaca) INTO v_broj_izdavaca
            FROM pozajmice JOIN primerci USING (inventarski_broj)
            JOIN knjige USING (id_knjige)
            JOIN izdavaci ON izdavaci.id = knjige.id_izdavaca
            WHERE broj_clanske_karte = 33;
            DBMS_OUTPUT.PUT_LINE ('Broj izdavaca: '||v_broj_izdavaca);
        EXCEPTION
            WHEN NO_DATA_FOUND THEN DBMS_OUTPUT.PUT_LINE('Nema takvog clana');
            WHEN OTHERS THEN DBMS_OUTPUT.PUT_LINE('Doslo je do greske');
        END

.. questionnote::

    7. Приказати за члана који се зове Оливера Стошић колико година је члан библиотеке. 

.. reveal:: pitanje_7_5g
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            broj INT;
        BEGIN
            SELECT COUNT(*) INTO broj
            FROM clanarine JOIN clanovi USING (broj_clanske_karte)
            WHERE UPPER(ime)='OLIVERA' AND UPPER(prezime)='STOSIC';
            DBMS_OUTPUT.PUT_LINE('Broj godina: '||broj);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Greska!');
        END

.. questionnote::

    8. Приказати број аутора књиге чији се назив уноси са тастатуре. Написати посебну поруку уколико књига има само једног аутора.

.. reveal:: pitanje_7_5h
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            broj NUMBER(1);
            v_naziv knjige.naziv%TYPE;
        BEGIN
            v_naziv := :naziv_knjige;
            SELECT COUNT(*) INTO broj
            FROM autori JOIN autori_knjige USING(id_autora) JOIN knjige USING (id_knjige)
            WHERE naziv = v_naziv;
            IF broj = 1 THEN
                DBMS_OUTPUT.PUT_LINE('Knjiga ima jednog autora');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Broj autora: '||broj);
            END IF;
        END

.. questionnote::

    9. Приказати број књигa чији је аутор Марко Видојковић.

.. reveal:: pitanje_7_5i
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_broj_knjiga NUMBER;
        BEGIN
            SELECT COUNT(id_knjige) INTO v_broj_knjiga
            FROM autori JOIN autori_knjige USING (id_autora)
            WHERE ime = 'Marko' AND prezime = 'Vidojkovic';
            DBMS_OUTPUT.PUT_LINE(v_broj_knjiga);
        END

.. questionnote::

    10. Приказати број позајмица примерака књига чији је аутор Марко Видојковић.

.. reveal:: pitanje_7_5j
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            broj NUMBER(5);
        BEGIN
            SELECT COUNT(*) INTO broj FROM autori JOIN autori_knjige USING (id_autora)
            JOIN knjige USING (id_knjige) JOIN primerci USING (id_knjige)
            JOIN pozajmice USING (inventarski_broj)
            WHERE UPPER(ime) = 'MARKO' AND UPPER(prezime) = 'VIDOJKOVIC';
            DBMS_OUTPUT.PUT_LINE(broj);
        END

.. questionnote::

    11. Приказати све податке о запосленом са идентификационим бројем 3. Приказати име и презиме његовог менаџера

.. reveal:: pitanje_7_5k
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    :: 

        DECLARE
            v_zaposleni zaposleni%ROWTYPE;
            v_menadzer VARCHAR2(50);
        BEGIN
            SELECT * INTO v_zaposleni
            FROM zaposleni WHERE id=3;
            DBMS_OUTPUT.PUT_LINE('Ime: '||v_zaposleni.ime||' '||v_zaposleni.prezime);
            DBMS_OUTPUT.PUT_LINE('Mejl: '||v_zaposleni.mejl);
            DBMS_OUTPUT.PUT_LINE('Datum zaposlenja: '||v_zaposleni.datum_zaposlenja);
            DBMS_OUTPUT.PUT_LINE('Plata: '||v_zaposleni.plata);
            SELECT ime||' '||prezime INTO v_menadzer
            FROM zaposleni WHERE id=v_zaposleni.id_menadzera;
            DBMS_OUTPUT.PUT_LINE('Ime menadzera: '||v_menadzer);
        END

.. questionnote::

    12. Приказати поруку да ли је просечна плата запослених у тиму менаџера са идентификационим бројем 5 већа од просечне плате свих запослених. 

.. reveal:: pitanje_7_5l
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_prosek zaposleni.plata%TYPE;
            v_prosek_menadzer_5 zaposleni.plata%TYPE;
        BEGIN
            SELECT AVG(plata) INTO v_prosek
            FROM zaposleni;
            SELECT AVG(plata) INTO v_prosek_menadzer_5
            FROM zaposleni WHERE id_menadzera=5;

            IF v_prosek_menadzer_5 > v_prosek THEN
            DBMS_OUTPUT.PUT_LINE('Tim 5 ima prosek plata veci od proseka svih zaposlenih');
            ELSE
            DBMS_OUTPUT.PUT_LINE('Tim 5 nema prosek plata veci od proseka svih zaposlenih');
            END IF;
        END

.. questionnote::

    13. Приказати број запослених којима је менаџер са идентификационим бројем 

.. reveal:: pitanje_7_5m
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            broj NUMBER(2);
        BEGIN
            SELECT COUNT(id) INTO broj
            FROM zaposleni WHERE id_menadzera = 3;
            DBMS_OUTPUT.PUT_LINE('Broj zaposlenih u timu menadzera sa id 3: '||broj);
        END

.. questionnote::

    14. Приказати име, презиме и имејл запосленог који зарађује највише. Предвидети обраду изузетка уколико има више запослених који имају исти, највећи износ плате. 


.. reveal:: pitanje_7_5n
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE 
            v_ime zaposleni.ime%TYPE;
            v_prezime zaposleni.prezime%TYPE;
            v_mejl zaposleni.mejl%TYPE;
        BEGIN 
            SELECT ime, prezime, mejl INTO v_ime, v_prezime, v_mejl
            FROM zaposleni WHERE plata = (SELECT MAX(plata) FROM zaposleni);
            DBMS_OUTPUT.PUT_LINE('Zaposleni koji zaradjuje najvise');
            DBMS_OUTPUT.PUT_LINE('Ime i prezime: '||v_ime||' '||v_prezime);
            DBMS_OUTPUT.PUT_LINE('Mejl: '||v_mejl);
            EXCEPTION
            WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Postoji vise zaposlenih sa istim najvecim iznosom plate');
        END

    Друга опција са једном сложеном променљивом.
    ::

        DECLARE 
            v_zaposleni zaposleni%ROWTYPE;
        BEGIN 
            SELECT * INTO v_zaposleni
            FROM zaposleni WHERE plata = (SELECT MAX(plata) FROM zaposleni);
            DBMS_OUTPUT.PUT_LINE('Zaposleni koji zaradjuje najvise');
            DBMS_OUTPUT.PUT_LINE('Ime i prezime: '||v_zaposleni.ime||' '||v_zaposleni.prezime);
            DBMS_OUTPUT.PUT_LINE('Mejl: '||v_zaposleni.mejl);
            EXCEPTION
            WHEN TOO_MANY_ROWS THEN
            DBMS_OUTPUT.PUT_LINE('Postoji vise zaposlenih sa istim najvecim iznosom plate');
        END

.. questionnote::

    15. Приказати презиме и имејл адресу менаџера запосленог чије се име и презиме уносе са тастатуре

.. reveal:: pitanje_7_5o
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        DECLARE
            v_id_menadzera zaposleni.id_menadzera%TYPE;
            v_prezime_menadzera zaposleni.prezime%TYPE;
            v_mejl_menadzera zaposleni.mejl%TYPE;
            v_ime zaposleni.ime%TYPE;
            v_prezime zaposleni.prezime%TYPE;
        BEGIN
            v_ime := :ime_zaposlenog;
            v_prezime := :prezime_zaposlenog;
            SELECT id_menadzera INTO v_id_menadzera
            FROM zaposleni WHERE UPPER(ime) = UPPER(v_ime) AND UPPER(prezime) = UPPER(v_prezime);
            SELECT prezime, mejl INTO v_prezime_menadzera, v_mejl_menadzera
            FROM zaposleni WHERE id = v_id_menadzera;
            DBMS_OUTPUT.PUT_LINE('Menadzer: '||v_prezime_menadzera);
            DBMS_OUTPUT.PUT_LINE('Mejl menadzera: '||v_mejl_menadzera);
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Greska');
        END

.. questionnote::

    16. Приказати број примерака књига које су тренутно издате. Приказати одговарајућу поруку уколико тренутно нема издатих књига. 

.. reveal:: pitanje_7_5p
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        
        DECLARE
         broj NUMBER(3);
        BEGIN
            SELECT COUNT(*) INTO broj
            FROM pozajmice
            WHERE datum_vracanja IS NULL;
            IF broj = 0 THEN
                DBMS_OUTPUT.PUT_LINE('Nema trenutno izdatih knjiga.');
            ELSE
                DBMS_OUTPUT.PUT_LINE('Broj trenutno izdatih knjiga: '||broj);
            END IF;
        EXCEPTION
            WHEN OTHERS THEN
                DBMS_OUTPUT.PUT_LINE('Greska!');
        END
