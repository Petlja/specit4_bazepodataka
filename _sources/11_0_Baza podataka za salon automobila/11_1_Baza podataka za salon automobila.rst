База података за салон аутомобила у СУБП-у *Oracle Apex* - пројектни рад - 1. део
=======================================================================================

.. suggestionnote::

    Пројектни задатак се састоји од три веће целине:

    1.	Креирати базу података за салон аутомобила на основу датог модела и података. 
    2.	Написати PL/SQL програме који су решења датих задатака. 
    3.	Креирати апликацију помоћу алата App Builder. 

    Први део пројекта подразумева да се креира база податка тако што се направе табеле и унесу подаци. 

Приликом рада на било ком делу пројекта, погледајте претходно решене примере и лекције. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, можете да погледате решење које ће се приказати након што кликнете на дугме. 

Команде за креирање базе података и програми пишу се у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

**САЛОН АУТОМОБИЛА:** Сваки произвођач аутомобила има назив и адресу седишта. Произвођачи аутомобила су правна лица којима су додељени ПИБ и матични број. Произвођач аутомобила производи више различитих модела. Сваки модел има своју ознаку, јачину мотора, број врата и тип горива. Аутомобили су подељени у категорије: лимузина, караван, кабриолет... 

.. infonote::

    НАПОМЕНА: Препоручљиво је да се у сваки назив табеле на почетак дода *sa_* да би ове табеле биле груписане на списку свих табела које имамо на онлајн налогу *Oracle APEX*. Тако су предложени називи табела базе података за салон аутомобила *sa_proizvodjaci, sa_kategorije и sa_modeli*.

.. image:: ../../_images/slika_11_1a.jpg
    :width: 800
    :align: center 

Следе подаци које треба унети у базу командама INSERT INTO.

.. image:: ../../_images/slika_11_1b.jpg
    :width: 800
    :align: center 

.. reveal:: pitanje_11_1a
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Следе команде за креирање базе података. 

::


    CREATE TABLE sa_kategorije
    (
        id_kategorije NUMBER(2) PRIMARY KEY,
        naziv VARCHAR2(30) NOT NULL UNIQUE,
        opis VARCHAR2(150)
    )

::

    CREATE TABLE sa_proizvodjaci
    (
        pib NUMBER(8) PRIMARY KEY,
        maticni_broj NUMBER(11) UNIQUE,
        naziv VARCHAR2(100) NOT NULL UNIQUE,
        adresa VARCHAR2(150) NOT NULL
    )

::

    CREATE TABLE sa_modeli
    (
        id_modela NUMBER(4) PRIMARY KEY,
        oznaka VARCHAR2(20) NOT NULL UNIQUE,
        jacina_motora VARCHAR2(6) NOT NULL,
        broj_vrata NUMBER(1) NOT NULL,
        tip_goriva VARCHAR2(10) NOT NULL,
        pib NUMBER(8) NOT NULL REFERENCES sa_proizvodjaci(pib),
        id_kategorije NUMBER(2) NOT NULL REFERENCES sa_kategorije(id_kategorije)
    )

::

    INSERT INTO sa_kategorije VALUES(1, 'dzip', 'terensko vozilo')
    INSERT INTO sa_kategorije VALUES(2, 'limuzina', null)
    INSERT INTO sa_kategorije VALUES(3, 'kabriolet', 'mobilni krov')
    INSERT INTO sa_proizvodjaci 
    VALUES(12345678, 12121212121, 'Mercedes-Benz', 'Daimler AG 70546, Stuttgart, Germany')
    INSERT INTO sa_proizvodjaci 
    VALUES(87654321, 34343434343, 'Dacia', 
    'Str. Uzinei, nr. 1, Mioveni, judetul Arges, Romania')
    INSERT INTO sa_modeli VALUES(1, 'CLS', '258hp', 5, 'dizel', 12345678, 2)
    INSERT INTO sa_modeli VALUES(2, 'Duster', '100hp', 5, 'hibrid', 87654321, 1)
    INSERT INTO sa_modeli VALUES(3, 'Aventurier', '115hp', 3, 'benzin', 87654321, 3)
    INSERT INTO sa_modeli VALUES(4, 'Maybach', '523hp', 5, 'dizel', 12345678, 2)
    INSERT INTO sa_modeli VALUES(5, 'C300', '214hp', 3, 'dizel', 12345678, 3)

PL/SQL програми
---------------

Креирати PL/SQL програме који узимају податке из базе података за салон аутомобила. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

sa_kategorije(id_kategorije, naziv, opis)
sa_proizvodjaci(pib, maticni_broj, naziv, adresa)
sa_modeli (id_modela, oznaka, jacina_motora, broj_vrata, tip_goriva, pib, id_kategorije)

Задаци су груписани у неколико целина.

НАРЕДБА SELECT INTO
--------------------

.. questionnote::

    1. Приказати у два реда са одговарајућим порукама матични број и адресу произвођача са називом Mercedes-Benz.

.. questionnote::

    2. Приказати назив произвођача, назив категорије и остале податке о моделу са ознаком C300. Постоји само један модел са овом ознаком. Сваки податак приказати са одговарајућим порукама у засебном реду. 

.. questionnote::

    3. Приказати назив произвођача, назив категорије и остале податке о моделу са датом ознаком. Ознака се уноси са тастатуре. Свака ознака модела је јединствена, тј. не постоје два модела са истом ознаком. Сваки податак приказати са одговарајућим порукама у засебном реду. Уколико је модел хибрид (тип горива), приказати поруку да је модел тренутно на снижењу 20%. 

КУРСОР
-------

.. questionnote::

    1. Приказати све податке о моделима који имају више од троја врата. Задатак урадити на два начина, експлицитним и имплицитним радом са курсором. 


.. reveal:: pitanje_11_1b
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Експлицитан начин рада са курсором.

    ::

        
        DECLARE
            CURSOR kursor_modeli IS SELECT oznaka, sa_proizvodjaci.naziv AS proizvodjac, 
            sa_kategorije.naziv AS kategorija, jacina_motora, broj_vrata, tip_goriva 
            FROM sa_modeli JOIN sa_proizvodjaci USING(pib) 
            JOIN sa_kategorije USING(id_kategorije) WHERE broj_vrata>3;
            v_model kursor_modeli%ROWTYPE;
        BEGIN
            OPEN kursor_modeli;
            LOOP
                FETCH kursor_modeli INTO v_model;
                EXIT WHEN kursor_modeli%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('MODEL: '||v_model.proizvodjac||' - '||v_model.oznaka);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
            END LOOP;
        END

    Имплицитан начин рада са курсором.

    ::
        
        DECLARE
            CURSOR kursor_modeli IS SELECT oznaka, sa_proizvodjaci.naziv AS proizvodjac, 
            sa_kategorije.naziv AS kategorija, jacina_motora, broj_vrata, tip_goriva 
            FROM sa_modeli JOIN sa_proizvodjaci USING(pib) 
            JOIN sa_kategorije USING(id_kategorije) WHERE broj_vrata>3;
        BEGIN
            FOR v_model IN kursor_modeli LOOP
                DBMS_OUTPUT.PUT_LINE('MODEL: '||v_model.proizvodjac||' - '||v_model.oznaka);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
            END LOOP;
        END  

        .. image:: ../../_images/slika_11_1c.jpg
            :width: 600
            :align: center

.. questionnote::

    2. Приказати ознаку модела, јачину мотора, број врата, тип горива и назив категорије, за сва возила произвођача Mercedes-Benz. Уколико је број врата већи од три, приказати поруку да је реч о возилу за већи број путника. Задатак урадити на два начина, експлицитним и имплицитним радом са курсором. 

.. reveal:: pitanje_11_1c
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Имплицитан   начин рада са курсором.

    ::

        DECLARE
            CURSOR kursor_modeli IS SELECT oznaka, jacina_motora, 
            broj_vrata, tip_goriva, sa_kategorije.naziv
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv='Mercedes-Benz';
        BEGIN
            FOR v_model IN kursor_modeli LOOP
                DBMS_OUTPUT.PUT_LINE('Oznaka modela: '||v_model.oznaka);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.naziv);
                IF v_model.broj_vrata>3 THEN
                    DBMS_OUTPUT.PUT_LINE(' Vozilo za veci broj putnika');
                END IF;
            END LOOP;
        END

    Експлицитан начин рада са курсором.

    ::
        
        DECLARE
            CURSOR kursor_modeli IS SELECT oznaka, jacina_motora, 
            broj_vrata, tip_goriva, sa_kategorije.naziv
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv='Mercedes-Benz';
            v_model kursor_modeli%ROWTYPE;
        BEGIN
            OPEN kursor_modeli;
            LOOP
                FETCH kursor_modeli INTO v_model;
                EXIT WHEN kursor_modeli%NOTFOUND;
                DBMS_OUTPUT.PUT_LINE('Oznaka modela: '||v_model.oznaka);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.naziv);
                IF v_model.broj_vrata>3 THEN
                    DBMS_OUTPUT.PUT_LINE(' Vozilo za veci broj putnika');
                END IF;
            END LOOP;
            CLOSE kursor_modeli;
        END

Курсор са параметром
--------------------

.. questionnote::

    1. Приказати све податке о моделима који имају више од унетог броја врата. Број врата се уноси са тастатуре

.. reveal:: pitanje_11_1d
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Како и категорија и произвођач имају назив, има смисла да у курсору одговарајућа поља преименујемо, тако да ће *sa_kategorije.naziv* бити kategorija, а *sa_proizvodjaci*.naziv ће бити *proizvodjac*.

    ::
        
        DECLARE
            CURSOR kursor_modeli(p_broj_vrata sa_modeli.broj_vrata%TYPE) 
            IS SELECT oznaka, jacina_motora, broj_vrata, tip_goriva, 
            sa_kategorije.naziv AS kategorija, sa_proizvodjaci.naziv AS proizvodjac
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE broj_vrata>p_broj_vrata;
            v_broj_vrata sa_modeli.broj_vrata%TYPE;
        BEGIN
            v_broj_vrata := :broj_vrata;
            FOR v_model IN kursor_modeli(v_broj_vrata) LOOP
                DBMS_OUTPUT.PUT_LINE('Model: '||v_model.oznaka||' - '||v_model.proizvodjac);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
            END LOOP;
        END

.. questionnote::

    2. Приказати све моделе унетог произвођача. Назив произвођача се уноси са тастатуре. За сваки модел приказати ознаку модела, јачину мотора, број врата, тип горива и назив категорије. 


.. reveal:: pitanje_11_1y
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::
        
        DECLARE
            CURSOR kursor_modeli(p_naziv sa_proizvodjaci.naziv%TYPE) 
            IS SELECT oznaka, jacina_motora, broj_vrata, tip_goriva, 
            sa_kategorije.naziv AS kategorija
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv=p_naziv;
            v_naziv sa_proizvodjaci.naziv%TYPE;
        BEGIN
            v_naziv := :NAZIV_PROIZVODJACA;
            FOR v_model IN kursor_modeli(v_naziv) LOOP
                DBMS_OUTPUT.PUT_LINE('Model: '||v_model.oznaka);     
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
            END LOOP;
        END

.. questionnote::

    3. За сваког произвођача приказати његов назив, а затим списак свих његових модела: ознака модела, јачина мотора, број врата, тип горива и назив категорије. 

Упутство: задатак се решава употребом два курсора, од којих је други курсор са параметром. 


.. reveal:: pitanje_11_1z
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::
        
        DECLARE
            CURSOR kursor_proizvodjaci IS SELECT * FROM sa_proizvodjaci;
            CURSOR kursor_modeli(p_naziv sa_proizvodjaci.naziv%TYPE) 
            IS SELECT oznaka, jacina_motora, broj_vrata, tip_goriva, 
            sa_kategorije.naziv AS kategorija
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv=p_naziv;
        BEGIN
            FOR v_proizvodjac IN kursor_proizvodjaci LOOP
                DBMS_OUTPUT.PUT_LINE('PROIZVODJAC: '||v_proizvodjac.naziv);
                DBMS_OUTPUT.PUT_LINE('ADRESA: '||v_proizvodjac.adresa);  
                FOR v_model IN kursor_modeli(v_proizvodjac.naziv) LOOP
                DBMS_OUTPUT.PUT_LINE(' Model: '||v_model.oznaka);
                DBMS_OUTPUT.PUT_LINE('  Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE('  Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE('  Kategorija: '||v_model.kategorija);
                DBMS_OUTPUT.PUT_LINE('  Broj vrata: '||v_model.broj_vrata);
                END LOOP;
            END LOOP;
        END

    .. image:: ../../_images/slika_11_1d.jpg
        :width: 600
        :align: center

Процедуре
----------
.. questionnote::

    1. Написати процедуру која приказује све податке о моделима који имају више од датог броја врата. Написати PL/SQL програм у којем се процедура позива за број врата који се унесе са тастатуре.


.. questionnote::

    2. Написати процедуру која приказује све моделе за дати назив произвођача. За сваки модел приказати ознаку модела, јачину мотора, број врата, тип горива и назив категорије. 
        a.	Написати PL/SQL програм у којем се процедура позива за произвођача са називом Mercedes-Benz.
        b.	Написати PL/SQL програм у којем се процедура позива за све произвођаче. 

.. questionnote::

   3. Написати процедуру која приказује све моделе за дати назив категорије. За сваки модел приказати ознаку модела, назив произвођача, јачину мотора, број врата и тип горива. 
        a.	Написати PL/SQL програм у којем се процедура позива за категорију која се унесе са тастатуре. 
        b.	Написати PL/SQL програм у којем се процедура позива за све категорије. 

Функције
--------

.. questionnote::

    1. Написати функцију која враћа колико имамо у салону модела који имају више од датог броја врата. Написати PL/SQL програм у којем се функција позива за број врата који се унесе са тастатуре.
 
.. questionnote::

    2. Написати функцију која враћа број модела које имамо у салону за дати назив произвођача. 
        a.	Написати PL/SQL програм у којем се функција позива за произвођача са називом Mercedes-Benz.
        b.	Написати PL/SQL програм у којем се функција позива за све произвођаче. 

.. questionnote::

    3. Написати функцију која враћа број модела за дати назив категорије. 
        a.	Написати PL/SQL програм у којем се функција позива за категорију која се унесе са тастатуре. 
        b.	Написати PL/SQL програм у којем се функција позива за све категорије. 


