Процедуре и функције са упитом SELECT са спајањем табела - вежбање
==================================================================

Решити следеће задатке писањем процедуре или функције и програмског кода у којем се креирана процедура или функција позива. 

Приликом решавања задатака, погледајте претходно решене примере. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, можете да погледате решење које ће се приказати након што кликнете на дугме. 

Детаљно објашњење формирања упита SELECT који треба да буде део процедуре или функције је дато раније у материјалима и по потреби је могуће вратити се на тај део као помоћ у писању комплетног решења. 


Програмски код, као и команде језика SQL, пише се и покреће када се кликне *New Query* након што се покрене систем *SQL Server* и кликне на креирану базу *Biblioteka* у прозору *Object Explorer*. Фајл са упитима *SQLQuery1.sql* може, а и не мора да се сачува.

Након што се унесе програмски код, кликне се на дугме *Execute*. Уколико се у простору за писање команди налази више блокова кода, потребно је обележити онај који желимо да покренемо. Ако имате више база података, обавезно проверите да ли је поред овог дугмета назив базе у којој желите да покрећете програме.  

.. image:: ../../_images/slika_521a.jpg
    :width: 600
    :align: center

Сви приказани задаци су у вези са табелама које чине базу података за библиотеку. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_521b.jpg
    :width: 600
    :align: center

.. questionnote::

    1. Разматра се могућност да се уведу одређена ограничења члановима библиотеке који нередовно враћају књиге. Једна од мера би можда била да се њима не издају ретке књиге које су често тражене, а драстичнија мера би могла да подразумева и укидање чланства. Да би се на добар начин донела одлука, библиотека је одлучила да пажљиво проучи списак чланова који касне са враћањем књига и због тога плаћају казне како би се видело колико има таквих чланова и да ли међу њима има неких који се баш истичу. 

**Задатак**: Приказати имена и презимена чланова, уз датуме и износе плаћених казни. Списак уредити по члановима, тако да све казне једног члана буду приказане једна испод друге. 


.. reveal:: pitanje_524a
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење


    ::

        CREATE PROCEDURE clanovi_sa_kaznama
        AS
        DECLARE kursor_clanovi CURSOR FOR
        SELECT DISTINCT broj_clanske_karte FROM kazne;
        DECLARE @broj_clanske_karte INT;

        OPEN kursor_clanovi;
        FETCH NEXT FROM kursor_clanovi 
        INTO @broj_clanske_karte;

        WHILE @@FETCH_STATUS=0
        BEGIN
            DECLARE @ime VARCHAR(15);
            DECLARE @prezime VARCHAR(15);
            SELECT @ime=ime, @prezime=prezime FROM clanovi
            WHERE broj_clanske_karte=@broj_clanske_karte;
            PRINT 'CLAN: '+@ime+' '+@prezime;

            DECLARE kursor_kazne CURSOR FOR 
            SELECT datum, iznos FROM kazne 
            WHERE broj_clanske_karte=@broj_clanske_karte;
            DECLARE @datum DATE;
            DECLARE @iznos INT;

            OPEN kursor_kazne;
            FETCH NEXT FROM kursor_kazne 
            INTO @datum, @iznos;

            WHILE @@FETCH_STATUS=0
            BEGIN
                PRINT '  Datum kazne: '+CAST(@datum AS VARCHAR);
                PRINT '  Iznos: '+CAST(@iznos AS VARCHAR);
                FETCH NEXT FROM kursor_kazne 
                INTO @datum, @iznos;
            END
            CLOSE kursor_kazne;
            DEALLOCATE kursor_kazne;

            FETCH NEXT FROM kursor_clanovi 
            INTO @broj_clanske_karte;
        END;
        CLOSE kursor_clanovi;
        DEALLOCATE kursor_clanovi;

    Позив процедуре.

    ::

        EXEC clanovi_sa_kaznama

    .. image:: ../../_images/slika_524a.jpg
        :width: 600
        :align: center

.. questionnote::

    2. У току месеца маја је акција и библиотека поклања по једну књигу својим верним члановима који тог месеца дођу да позајме књиге. Тренутно је у библиотеку дошла Милица Зорановић и библиотекар жели да провери како изгледа њена историја чланства, тј. да ли је већ дужи низ година члан библиотеке. 

**Задатак**: Приказати списак година када је члан датог имена и презимена био члан библиотеке, тј. године за које је платио чланарину.  

.. reveal:: pitanje_524b
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        CREATE FUNCTION godine_clanstva (@ime VARCHAR(15), @prezime VARCHAR(15))
        RETURNS TABLE
        AS
        RETURN SELECT god
        FROM clanarine JOIN clanovi
        ON (clanarine.broj_clanske_karte=clanovi.broj_clanske_karte)
        WHERE UPPER(ime)=UPPER(@ime) AND UPPER(prezime)=UPPER(@prezime)

    Позив функције.

    ::

        SELECT * FROM godine_clanstva('Milica', 'Zoranovic')

.. questionnote::

    3. Библиотека разматра да наручи још књига Завода за уџбенике. Да би донели ту одлуку, потребно је да се види колико су књиге овог издавача тражене. 

**Задатак**: Приказати датуме узимања и називе књиге за све позајмице књига датог издавача. 

.. reveal:: pitanje_524c
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        CREATE FUNCTION sve_pozajmice_izdavaca (@naziv_izdavaca VARCHAR(40))
        RETURNS TABLE
        AS
        RETURN SELECT datum_uzimanja, knjige.naziv
        FROM pozajmice JOIN primerci ON (pozajmice.inventarski_broj=primerci.inventarski_broj)
        JOIN knjige ON (primerci.id_knjige=knjige.id_knjige)
        JOIN izdavaci ON (knjige.id_izdavaca=izdavaci.id)
        WHERE izdavaci.naziv=@naziv_izdavaca

    Позив функције.

    ::

        SELECT * FROM sve_pozajmice_izdavaca('Zavod za udzbenike')

.. questionnote::

    4. Члан библиотеке Милица Зорановић је дошла у библиотеку да позајми неку књигу, али нема идеју шта би следеће читала. Библиотекар је предложио да крену од списка аутора чије је књиге већ позајмљивала, па да виде да ли би Милица читала још неку од књига неког од тих аутора. 

**Задатак**: Приказати без понављања имена и презимена аутора чије је књиге читао члан датог имена и презимена. 


.. reveal:: pitanje_524d
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење
    
    ::

        CREATE PROCEDURE autori_citao_clan 
        @ime_clana VARCHAR(15), @prezime VARCHAR(15)
        AS
        DECLARE kursor_autori CURSOR FOR
        SELECT DISTINCT a.ime, a.prezime 
        FROM pozajmice po JOIN clanovi c 
        ON (po.broj_clanske_karte=c.broj_clanske_karte)
        JOIN primerci pr ON (po.inventarski_broj=pr.inventarski_broj)
        JOIN knjige k ON (pr.id_knjige=k.id_knjige)
        JOIN autori_knjige ak ON (ak.id_knjige=k.id_knjige)
        JOIN autori a ON (ak.id_autora=a.id_autora)
        WHERE c.ime=@ime_clana AND c.prezime=@prezime;
        DECLARE @ime_autora VARCHAR(15);
        DECLARE @prezime_autora VARCHAR(15);
        DECLARE @rbr INT = 0;

        OPEN kursor_autori;
        FETCH NEXT FROM kursor_autori 
        INTO @ime_autora, @prezime_autora;

        WHILE @@FETCH_STATUS=0
        BEGIN
            SELECT @rbr = @rbr+1;
            PRINT CAST(@rbr AS VARCHAR)+'. '+@ime_autora+' '+@prezime_autora;
            FETCH NEXT FROM kursor_autori 
            INTO @ime_autora, @prezime_autora;
        END;
        CLOSE kursor_autori;
        DEALLOCATE kursor_autori;

    Позив процедуре.

    ::

        EXEC autori_citao_clan @ime_clana='Milica', @prezime='Zoranovic'

.. questionnote::

    5. Библиотека организује прославу за своје запослене и позивнице планира да пошаље имејлом, али са различитим текстом за различите тимове. Ради слања позивница, потребан је списак имејл адреса по тимовима. 

**Задатак**: Написати упит којим се приказују имејл адреса запосленог и имејл адреса његовог менаџера. Списак уредити по менаџерима, па унутар истог тима по запосленима. 

.. reveal:: pitanje_524e
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    ::

        CREATE PROCEDURE mejlovi_zaposlenih_po_timovima
        AS
        --nisu svi zaposleni menadzeri,
        --menadzeri su u koloni id_menadzera,
        --ali treba ukloniti ako je neka vrednost null
        DECLARE kursor_menadzeri CURSOR FOR
        SELECT DISTINCT id_menadzera FROM zaposleni
        WHERE id_menadzera IS NOT NULL;
        DECLARE @id_menadzera INT;

        OPEN kursor_menadzeri;
        FETCH NEXT FROM kursor_menadzeri INTO @id_menadzera;

        WHILE @@FETCH_STATUS = 0  
        BEGIN  
            DECLARE @mejl_menadzera VARCHAR(50);
            SELECT @mejl_menadzera = mejl
            FROM zaposleni WHERE id = @id_menadzera;
            PRINT 'MENADZER: '+@mejl_menadzera;
            
            --spisak zaposlenih u timu tog menadzera
            DECLARE kursor_zaposleni CURSOR FOR
            SELECT mejl FROM zaposleni 
            WHERE id_menadzera=@id_menadzera;
            DECLARE @mejl_zaposlenog VARCHAR(50);

            OPEN kursor_zaposleni;
            FETCH NEXT FROM kursor_zaposleni INTO @mejl_zaposlenog;

            WHILE @@FETCH_STATUS=0
            BEGIN
                PRINT '  Zaposleni: '+@mejl_zaposlenog;
                FETCH NEXT FROM kursor_zaposleni INTO @mejl_zaposlenog;
            END
            CLOSE kursor_zaposleni;
            DEALLOCATE kursor_zaposleni;
        
            FETCH NEXT FROM kursor_menadzeri INTO @id_menadzera;
        END
        CLOSE kursor_menadzeri;
        DEALLOCATE kursor_menadzeri;

        PRINT 'BEZ MENADZERA'; 
        DECLARE kursor_bez_menadzera CURSOR FOR
        SELECT mejl FROM zaposleni WHERE id_menadzera IS NULL;
        OPEN kursor_bez_menadzera;
        FETCH NEXT FROM kursor_bez_menadzera INTO @mejl_zaposlenog;
        WHILE @@FETCH_STATUS=0
        BEGIN
            PRINT '  Zaposleni: '+@mejl_zaposlenog;
            FETCH NEXT FROM kursor_bez_menadzera INTO @mejl_zaposlenog;
        END
        CLOSE kursor_bez_menadzera;
        DEALLOCATE kursor_bez_menadzera;

    Позив процедуре.

    ::

        EXEC mejlovi_zaposlenih_po_timovima

    .. image:: ../../_images/slika_524b.jpg
        :width: 600
        :align: center

    Друго решење.

    ::

        CREATE PROCEDURE mejlovi_zaposlenih_po_timovima2
        AS
        SELECT z.mejl "Zaposleni", m.mejl "Menadzer"
        FROM zaposleni z LEFT OUTER JOIN zaposleni m ON (z.id_menadzera=m.id)
        ORDER BY m.mejl, z.mejl

    Позив процедуре.

    ::

        EXEC mejlovi_zaposlenih_po_timovima2

    .. image:: ../../_images/slika_524c.jpg
        :width: 600
        :align: center