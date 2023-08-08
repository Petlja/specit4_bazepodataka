Наредбе гранања - нерешени задаци
=================================

.. suggestionnote::

    У програмима можемо да користимо наредбе гранања:

    - наредба IF
    - наредба CASE

    Наредбе гранања ће бити објашњене кроз конкретне задатке. 

Програми се пишу у едитору у оквиру онлајн окружења *Oracle APEX*, а покрећу се кликом на дугме **Run**:

- https://apex.oracle.com/en/ (обавезно логовање на креирани налог)
- SQL Workshop
- SQL Commands

.. image:: ../../_images/slika_65a.jpg
   :width: 600
   :align: center

.. questionnote::

    1. Креирати PL/SQL програм у којем се уносе поени које су два такмичара освојила на такмичењу из математике. Такмичари имају различит број поена. Приказати ко је од такмичара освојио већи број поена. 

Услов не мора да се ставља у заграде, али је после навођења услова обавезна реч THEN. Цела наредба се завршава са END IF. 

::


    DECLARE
        poeni1 INT;
        poeni2 INT;
    BEGIN
        poeni1 := :poeni_prvog_takmicara;
        poeni2 := :poeni_drugog_takmicara;
        IF poeni1 > poeni2 THEN
            DBMS_OUTPUT.PUT_LINE('Prvi takmicar ima vise poena');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Drugi takmicar ima vise poena');
        END IF;
    END

.. questionnote::

    2. Креирати PL/SQL програм у којем се уносе поени које је такмичар освојио на такмичењу из програмирања (од 0 до 300). Прва награда се добија са 250 поена или више, друга награда са 200 поена или више, трећа са 150 поена или више. Приказати коју награду је добио такмичар или поруку ако није освојио награду. 

Први начин: Можемо да употребимо наредбу IF. 

::


    DECLARE
        poeni NUMBER(3);
    BEGIN
        poeni := :poeni_takmicara;
        IF poeni >= 250 THEN
            DBMS_OUTPUT.PUT_LINE('Prva nagrada');
        ELSIF poeni >= 200 THEN
            DBMS_OUTPUT.PUT_LINE('Druga nagrada');
        ELSIF poeni >= 150 THEN
            DBMS_OUTPUT.PUT_LINE('Treca nagrada');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Bez nagrade');
        END IF;
    END

Други начин: Можемо да употребимо наредбу вишеструког гранања CASE. Свака грана садржи један услов.  

::


    DECLARE
        poeni NUMBER(3);
    BEGIN
        poeni := :poeni_takmicara;
        CASE 
        WHEN poeni >= 250 THEN
            DBMS_OUTPUT.PUT_LINE('Prva nagrada');
        WHEN poeni >= 200 THEN
            DBMS_OUTPUT.PUT_LINE('Druga nagrada');
        WHEN poeni >= 150 THEN
            DBMS_OUTPUT.PUT_LINE('Treca nagrada');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Bez nagrade');
        END CASE;
    END

Трећи начин: Можемо да употребимо у решењу помоћну текстуалну променљиву коју ћемо на крају да испишемо. 

::


    DECLARE
        poeni NUMBER(3);
        poruka VARCHAR2(20);
    BEGIN
        poeni := :poeni_takmicara;
        CASE 
        WHEN poeni >= 250 THEN
            poruka := 'Prva nagrada';
        WHEN poeni >= 200 THEN
            poruka := 'Druga nagrada';
        WHEN poeni >= 150 THEN
            poruka := 'Treca nagrada';
        ELSE 
            poruka := 'Bez nagrade';
        END CASE;
        DBMS_OUTPUT.PUT_LINE(poruka);
    END

Четврти начин: Поред наредбе вишеструког гранања CASE постоји и израз CASE. Овај израз има вредност која може да се додели некој променљивој, у овом случају помоћној променљивој која садржи текстуалну поруку која ће бити приказана на крају програма.  

::


    DECLARE
        poeni NUMBER(3);
        poruka VARCHAR2(20);
    BEGIN
        poeni := :poeni_takmicara;
        poruka := CASE 
        WHEN poeni >= 250 THEN 'Prva nagrada'
        WHEN poeni >= 200 THEN 'Druga nagrada'
        WHEN poeni >= 150 THEN 'Treca nagrada'
        ELSE 'Bez nagrade'
        END;
        DBMS_OUTPUT.PUT_LINE(poruka);
    END

.. questionnote::

    3. Креирати PL/SQL програм у којем се уноси редни број дана у недељи, а приказује се назив тог дана. 

::


    DECLARE
        dan NUMBER(1);
    BEGIN
        dan := TO_NUMBER(:redni_broj_dana_u_nedelji);
        CASE 
        WHEN dan = 1 THEN
            DBMS_OUTPUT.PUT_LINE('Ponedeljak');
        WHEN dan = 2 THEN
            DBMS_OUTPUT.PUT_LINE('Utorak');
        WHEN dan = 3 THEN
            DBMS_OUTPUT.PUT_LINE('Sreda');
        WHEN dan = 4 THEN
            DBMS_OUTPUT.PUT_LINE('Cetvrtak');
        WHEN dan = 5 THEN
            DBMS_OUTPUT.PUT_LINE('Petak');
        WHEN dan = 6 THEN
            DBMS_OUTPUT.PUT_LINE('Subota');
        WHEN dan = 7 THEN
            DBMS_OUTPUT.PUT_LINE('Nedelja');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Neispravan redni broj dana u nedelji');
        END CASE;
    END

Када имамо скуп вредности неке променљиве, можемо да користимо CASE на следећи начин:

::


  CASE naziv_promenljive
  WHEN vrednost1 THEN ...
  WHEN vrednost2 THEN ...

::


    DECLARE
        dan NUMBER(1);
    BEGIN
        dan := TO_NUMBER(:redni_broj_dana_u_nedelji);
        CASE dan
        WHEN 1 THEN
            DBMS_OUTPUT.PUT_LINE('Ponedeljak');
        WHEN 2 THEN
            DBMS_OUTPUT.PUT_LINE('Utorak');
        WHEN 3 THEN
            DBMS_OUTPUT.PUT_LINE('Sreda');
        WHEN 4 THEN
            DBMS_OUTPUT.PUT_LINE('Cetvrtak');
        WHEN 5 THEN
            DBMS_OUTPUT.PUT_LINE('Petak');
        WHEN 6 THEN
            DBMS_OUTPUT.PUT_LINE('Subota');
        WHEN 7 THEN
            DBMS_OUTPUT.PUT_LINE('Nedelja');
        ELSE 
            DBMS_OUTPUT.PUT_LINE('Neispravan redni broj dana u nedelji');
        END CASE;
    END

Трећи начин: употребом наредбе CASE и текстуалне променљиве.

::


    DECLARE
        dan NUMBER(1);
        naziv_dana VARCHAR2(10);
    BEGIN
        dan := TO_NUMBER(:redni_broj_dana_u_nedelji);
        CASE dan
        WHEN 1 THEN
            naziv_dana := 'Ponedeljak';
        WHEN 2 THEN
            naziv_dana := 'Utorak';
        WHEN 3 THEN
            naziv_dana := 'Sreda';
        WHEN 4 THEN
            naziv_dana := 'Cetvrtak';
        WHEN 5 THEN
            naziv_dana := 'Petak';
        WHEN 6 THEN
            naziv_dana := 'Subota';
        WHEN 7 THEN
            naziv_dana := 'Nedelja';
        ELSE 
            naziv_dana := 'Neispravan redni broj dana u nedelji';
        END CASE;
        DBMS_OUTPUT.PUT_LINE(naziv_dana);
    END

Можемо да погледамо још једно решење – програм у којем користимо израз CASE.
::


    DECLARE
        dan NUMBER(1);
        naziv_dana VARCHAR2(10);
    BEGIN
        dan := TO_NUMBER(:redni_broj_dana_u_nedelji);
        naziv_dana := CASE dan
        WHEN 1 THEN 'Ponedeljak'
        WHEN 2 THEN 'Utorak'
        WHEN 3 THEN 'Sreda'
        WHEN 4 THEN 'Cetvrtak'
        WHEN 5 THEN 'Petak'
        WHEN 6 THEN 'Subota'
        WHEN 7 THEN'Nedelja'
        ELSE 'Neispravan redni broj dana u nedelji' END;
        DBMS_OUTPUT.PUT_LINE(naziv_dana);
    END
