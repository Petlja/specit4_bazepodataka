База података за салон аутомобила у СУБП-у *Oracle Apex* - пројектни рад - 2. део
=======================================================================================

.. suggestionnote::

    Пројектни задатак се састоји од три веће целине:

    1.	Креирати базу података за **салон аутомобила** на основу датог модела и података. 
    2.	Написати PL/SQL програме који су решења датих задатака. 
    3.	Креирати апликацију помоћу алата *App Builder*. 

    Значај база података је могућност да брзо и ефикасно добијемо информације из података које чувамо. На пример, у салон је дошао потенцијални купац и потребан нам је списак свих модела које имамо у салону, а прави их одређени произвођач. 

    Други део пројекта подразумева да се креирају PL/SQL програми који решавају одређене захтеве. 

Приликом рада на било ком делу пројекта, погледајте претходно решене примере и лекције. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, можете да погледате решење које ће се приказати након што кликнете на дугме. 

Команде за креирање базе података и програми се пишу у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

Креирати PL/SQL програме који узимају податке из базе података за салон аутомобила. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

::

    sa_kategorije(id_kategorije, naziv, opis)
    sa_proizvodjaci(pib, maticni_broj, naziv, adresa)
    sa_modeli (id_modela, oznaka, jacina_motora, broj_vrata, tip_goriva, pib, id_kategorije)

Задаци су груписани у неколико целина.

Наредба SELECT INTO
-------------------

.. questionnote::

    1. Приказати у два реда са одговарајућим порукама матични број и адресу произвођача са називом Mercedes-Benz.

.. reveal:: pitanje_11_2a
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::

        DECLARE
            v_maticni_broj sa_proizvodjaci.maticni_broj%TYPE;
            v_adresa sa_proizvodjaci.adresa%TYPE;
        BEGIN
            SELECT maticni_broj, adresa INTO v_maticni_broj, v_adresa
            FROM sa_proizvodjaci WHERE naziv = 'Mercedes-Benz';
            DBMS_OUTPUT.PUT_LINE('Maticni broj: '||v_maticni_broj);
            DBMS_OUTPUT.PUT_LINE('Adresa: '||v_adresa);
        END

.. questionnote::

    2. Приказати назив произвођача, назив категорије и остале податке о моделу са ознаком C300. Постоји само један модел са овом ознаком. Сваки податак приказати са одговарајућим порукама у засебном реду. 

.. reveal:: pitanje_11_2b
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::


        DECLARE
            v_jacina_motora sa_modeli.jacina_motora%TYPE;
            v_broj_vrata sa_modeli.broj_vrata%TYPE;
            v_tip_goriva sa_modeli.tip_goriva%TYPE;
            v_proizvodjac sa_proizvodjaci.naziv%TYPE;
            v_kategorija sa_kategorije.naziv%TYPE;
        BEGIN
            SELECT jacina_motora, broj_vrata, tip_goriva, 
            sa_proizvodjaci.naziv, sa_kategorije.naziv 
            INTO v_jacina_motora, v_broj_vrata, v_tip_goriva, 
            v_proizvodjac, v_kategorija
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije)
            JOIN sa_proizvodjaci USING (pib)
            WHERE oznaka = 'C300';
            DBMS_OUTPUT.PUT_LINE('Proizvodjac: '||v_proizvodjac);
            DBMS_OUTPUT.PUT_LINE('Kategorija: '||v_kategorija);
            DBMS_OUTPUT.PUT_LINE('Jacina motora: '||v_jacina_motora);
            DBMS_OUTPUT.PUT_LINE('Broj vrata: '||v_broj_vrata);
            DBMS_OUTPUT.PUT_LINE('Tip goriva: '||v_tip_goriva);
        END

.. questionnote::

    3. Приказати назив произвођача, назив категорије и остале податке о моделу са датом ознаком. Ознака се уноси са тастатуре. Свака ознака модела је јединствена, тј. не постоје два модела са истом ознаком. Сваки податак приказати са одговарајућим порукама у засебном реду. Уколико је модел хибрид (тип горива), приказати поруку да је модел тренутно на снижењу 20%. 

.. reveal:: pitanje_11_2c
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::


        DECLARE
            v_oznaka sa_modeli.oznaka%TYPE;
            v_jacina_motora sa_modeli.jacina_motora%TYPE;
            v_broj_vrata sa_modeli.broj_vrata%TYPE;
            v_tip_goriva sa_modeli.tip_goriva%TYPE;
            v_proizvodjac sa_proizvodjaci.naziv%TYPE;
            v_kategorija sa_kategorije.naziv%TYPE;
        BEGIN
            v_oznaka := :OZNAKA_MODELA;
            SELECT jacina_motora, broj_vrata, tip_goriva, sa_proizvodjaci.naziv, sa_kategorije.naziv 
            INTO v_jacina_motora, v_broj_vrata, v_tip_goriva, v_proizvodjac, v_kategorija
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije)
            JOIN sa_proizvodjaci USING (pib)
            WHERE oznaka = v_oznaka;
            DBMS_OUTPUT.PUT_LINE('Proizvodjac: '||v_proizvodjac);
            DBMS_OUTPUT.PUT_LINE('Kategorija: '||v_kategorija);
            DBMS_OUTPUT.PUT_LINE('Jacina motora: '||v_jacina_motora);
            DBMS_OUTPUT.PUT_LINE('Broj vrata: '||v_broj_vrata);
            DBMS_OUTPUT.PUT_LINE('Tip goriva: '||v_tip_goriva);
            IF v_tip_goriva = 'hibrid' THEN
                DBMS_OUTPUT.PUT_LINE('MODEL JE TRENUTNO NA SNIZENJU 20%');
            END IF;
        END

    .. image:: ../../_images/slika_11_2a.jpg
        :width: 600
        :align: center

Курсор
-------

.. questionnote::

    1. Приказати све податке о моделима који имају више од троја врата. Задатак урадити на два начина, експлицитним и имплицитним радом са курсором. 

.. reveal:: pitanje_11_2d
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


    .. image:: ../../_images/slika_11_2b.jpg
        :width: 600
        :align: center

.. questionnote::

    2. Приказати ознаку модела, јачину мотора, број врата, тип горива и назив категорије, за сва возила произвођача *Mercedes-Benz*. Уколико је број врата већи од три, приказати поруку да је реч о возилу за већи број путника. Задатак урадити на два начина, експлицитним и имплицитним радом са курсором. 

.. reveal:: pitanje_11_2e
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
---------------------

.. questionnote::

    1. Приказати све податке о моделима који имају више од унетог броја врата. Број врата се уноси са тастатуре.

.. reveal:: pitanje_11_2f
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Како и категорија и произвођач имају назив, има смисла да у курсору одговарајућа поља преименујемо, тако да ће *sa_kategorije.naziv* бити *k*ategorija*, а *sa_proizvodjaci.naziv* ће бити *proizvodjac*.

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

.. reveal:: pitanje_11_2g
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

.. reveal:: pitanje_11_2h
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


    .. image:: ../../_images/slika_11_2c.jpg
        :width: 600
        :align: center

Процедуре
---------

.. questionnote::

    1. Написати процедуру која приказује све податке о моделима који имају више од датог броја врата. Написати PL/SQL програм у којем се процедура позива за број врата који се унесе са тастатуре.

.. reveal:: pitanje_11_2i
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Задатак може да се реши преправљањем програмског кода који је решење првог задатка за базу података за салон аутомобила који користи курсор са параметром. Разлика је што је сада број врата параметар процедуре коју креирамо, курсор нема параметар већ у услову селекције користи параметар процедуре, а унос броја са тастатуре се премешта у програм у којем процедуру позивамо. 

    ::

        CREATE OR REPLACE PROCEDURE modeli_vise_vrata(p_broj_vrata sa_modeli.broj_vrata%TYPE) IS
            CURSOR kursor_modeli IS SELECT oznaka, jacina_motora, broj_vrata, tip_goriva, 
            sa_kategorije.naziv AS kategorija, sa_proizvodjaci.naziv AS proizvodjac
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE broj_vrata>p_broj_vrata;
        BEGIN
            FOR v_model IN kursor_modeli LOOP
                DBMS_OUTPUT.PUT_LINE('Model: '||v_model.oznaka||' - '||v_model.proizvodjac);
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
            END LOOP;
        END

        Следи нови програм у којем позивамо ову процедуру.

        DECLARE
            vrata sa_modeli.broj_vrata%TYPE;
        BEGIN
            v_broj_vrata := :broj_vrata;
            modeli_vise_vrata(v_broj_vrata);
        END

.. questionnote::

    2. Написати процедуру која приказује све моделе за дати назив произвођача. За сваки модел приказати ознаку модела, јачину мотора, број врата, тип горива и назив категорије. 
        a.	Написати PL/SQL програм у којем се процедура позива за произвођача са називом Mercedes-Benz.
        b.	Написати PL/SQL програм у којем се процедура позива за све произвођаче. 

.. reveal:: pitanje_11_2j
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    Задатак може да се реши преправљањем програмског кода који је решење одговарајућег задатка који користи курсор са параметром. Разлика је што је сада назив произвођача параметар процедуре коју креирамо, а курсор нема параметар већ у услову селекције користи параметар процедуре. 

    ::


        CREATE OR REPLACE PROCEDURE modeli_proizvodjaca(p_naziv sa_proizvodjaci.naziv%TYPE) IS
            CURSOR kursor_modeli 
            IS SELECT oznaka, jacina_motora, broj_vrata, tip_goriva, 
            sa_kategorije.naziv AS kategorija
            FROM sa_modeli JOIN sa_kategorije USING (id_kategorije) 
            JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv=p_naziv;
        BEGIN
            FOR v_model IN kursor_modeli LOOP
                DBMS_OUTPUT.PUT_LINE('Model: '||v_model.oznaka);     
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Kategorija: '||v_model.kategorija);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
            END LOOP;
        END

    Следи PL/SQL програм у којем се процедура позива за произвођача са називом *Mercedes-Benz*.

    ::

        BEGIN
            modeli_proizvodjaca('Mercedes-Benz');
        END

    Следи PL/SQL програм у којем се процедура позива за све произвођаче. 

    ::

        DECLARE
            CURSOR kursor_proizvodjaci IS SELECT * FROM sa_proizvodjaci;
        BEGIN
            FOR v_proizvodjac IN kursor_proizvodjaci LOOP
                DBMS_OUTPUT.PUT_LINE('PROIZVODJAC: '||v_proizvodjac.naziv);
                DBMS_OUTPUT.PUT_LINE(' *** ');
                modeli_proizvodjaca(v_proizvodjac.naziv);
                DBMS_OUTPUT.PUT_LINE(' *** ');
            END LOOP;
        END

.. questionnote::

    3. Написати процедуру која приказује све моделе за дати назив категорије. За сваки модел приказати ознаку модела, назив произвођача, јачину мотора, број врата и тип горива. 
        a.	Написати PL/SQL програм у којем се процедура позива за категорију која се унесе са тастатуре. 
        b.	Написати PL/SQL програм у којем се процедура позива за све категорије. 


.. reveal:: pitanje_11_2k
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор


    ::

        CREATE OR REPLACE PROCEDURE modeli_kategorije(p_naziv sa_kategorije.naziv%TYPE) IS
            CURSOR kursor_modeli IS SELECT oznaka, sa_proizvodjaci.naziv AS proizvodjac, jacina_motora, 
            broj_vrata, tip_goriva FROM sa_modeli JOIN sa_proizvodjaci USING (pib)
            JOIN sa_kategorije USING (id_kategorije)
            WHERE sa_kategorije.naziv=p_naziv;
        BEGIN
            FOR v_model IN kursor_modeli LOOP
                DBMS_OUTPUT.PUT_LINE('Model: '||v_model.oznaka);  
                DBMS_OUTPUT.PUT_LINE(' Proizvodjac: '||v_model.proizvodjac);   
                DBMS_OUTPUT.PUT_LINE(' Jacina motora: '||v_model.jacina_motora);
                DBMS_OUTPUT.PUT_LINE(' Tip goriva: '||v_model.tip_goriva);
                DBMS_OUTPUT.PUT_LINE(' Broj vrata: '||v_model.broj_vrata);
            END LOOP;
        END

        Следи PL/SQL програм у којем се процедура позива за категорију која се унесе са тастатуре. 

        DECLARE
            v_kategorija sa_kategorije.naziv%TYPE;
        BEGIN
            v_kategorija := :NAZIV_KATEGORIJE;
            modeli_kategorije(v_kategorija);
        END

    .. image:: ../../_images/slika_11_2d.jpg
        :width: 600
        :align: center

    Следи PL/SQL програм у којем се процедура позива за све категорије. 

    ::

        
        DECLARE
            CURSOR kursor_kategorije IS
            SELECT * FROM sa_kategorije; 
        BEGIN
            FOR v_kategorija IN kursor_kategorije LOOP
                DBMS_OUTPUT.PUT_LINE('KATEGORIJA: '||v_kategorija.naziv);
                DBMS_OUTPUT.PUT_LINE(' *** ');
                modeli_kategorije(v_kategorija.naziv);
                DBMS_OUTPUT.PUT_LINE(' *** ');
            END LOOP;
        END

Функције
---------

.. questionnote::

    1. Написати функцију која враћа колико имамо у салону модела који имају више од датог броја врата. Написати PL/SQL програм у којем се функција позива за број врата који се унесе са тастатуре.

.. reveal:: pitanje_11_2l
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::

        CREATE OR REPLACE FUNCTION modeli_vise_vrata_fja(p_broj_vrata sa_modeli.broj_vrata%TYPE) 
            RETURN NUMBER IS
            v_broj NUMBER;
        BEGIN
            SELECT COUNT(*) INTO v_broj FROM sa_modeli 
            WHERE broj_vrata>p_broj_vrata;
            RETURN v_broj;
        END

        Следи PL/SQL програм у којем се функција позива за број врата који се унесе са тастатуре.


        DECLARE
            v_broj_vrata sa_modeli.broj_vrata%TYPE;
        BEGIN
            v_broj_vrata := :broj_vrata;
            DBMS_OUTPUT.PUT_LINE(modeli_vise_vrata_fja(v_broj_vrata));
        END

.. questionnote::

    2. Написати функцију која враћа број модела које имамо у салону за дати назив произвођача. 
        a.	Написати PL/SQL програм у којем се функција позива за произвођача са називом *Mercedes-Benz*.
        b.	Написати PL/SQL програм у којем се функција позива за све произвођаче. 


.. reveal:: pitanje_11_2m
    :showtitle: Прикажи одговор
    :hidetitle: Сакриј одговор

    ::
        
        CREATE OR REPLACE FUNCTION 
            broj_modela_proizvodjaca(p_naziv sa_proizvodjaci.naziv%TYPE) 
            RETURN NUMBER IS
            v_broj NUMBER;
        BEGIN
            SELECT COUNT(oznaka) INTO v_broj 
            FROM sa_modeli JOIN sa_proizvodjaci USING (pib)
            WHERE sa_proizvodjaci.naziv=p_naziv;
            RETURN v_broj;
        END

    Следи PL/SQL програм у којем се функција позива за произвођача са називом *Mercedes-Benz*.

    ::
        
        DECLARE
            v_broj_modela NUMBER;
        BEGIN
            v_broj_modela := broj_modela_proizvodjaca('Mercedes-Benz');
            DBMS_OUTPUT.PUT_LINE(v_broj_modela);
        END

    Следи PL/SQL програм у којем се функција позива за све произвођаче. 

    ::

        
        DECLARE
            CURSOR kursor_proizvodjaci IS SELECT * FROM sa_proizvodjaci;
        BEGIN
            FOR v_proizvodjac IN kursor_proizvodjaci LOOP
                DBMS_OUTPUT.PUT_LINE('PROIZVODJAC: '||v_proizvodjac.naziv);
                DBMS_OUTPUT.PUT_LINE('BROJ MODELA: ');
                DBMS_OUTPUT.PUT_LINE(broj_modela_proizvodjaca(v_proizvodjac.naziv));
            END LOOP;
        END

.. questionnote::

    3. Написати функцију која враћа број модела за дати назив категорије. 
        a.	Написати PL/SQL програм у којем се функција позива за категорију која се унесе са тастатуре. 
        b.	Написати PL/SQL програм у којем се функција позива за све категорије. 

