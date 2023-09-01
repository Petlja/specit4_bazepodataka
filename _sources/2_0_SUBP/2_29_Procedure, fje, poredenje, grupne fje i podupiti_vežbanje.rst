Процедуре и функције са упитом и групним функцијама и подупитима - вежбање
==========================================================================

Решити следеће задатке писањем процедуре или функције и програмског кода у којем се креирана процедура или функција позива. 

Приликом решавања задатака, погледајте претходно решене примере. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, можете да погледате решење које ће се приказати након што кликнете на дугме. 

Детаљно објашњење формирања упита SELECT који треба да буде део процедуре или функције је дато раније у материјалима и по потреби је могуће вратити се на тај део као помоћ у писању комплетног решења. 


Програмски код, као и команде језика SQL, пише се и покреће када се кликне *New Query* након што се покрене систем *SQL Server* и кликне на креирану базу *Biblioteka* у прозору *Object Explorer*. Фајл са упитима *SQLQuery1.sql* може, а и не мора да се сачува.

Након што се унесе програмски код, кликне се на дугме *Execute*. Уколико се у простору за писање команди налази више блокова кода, потребно је обележити онај који желимо да покренемо. Ако имате више база података, обавезно проверите да ли је поред овог дугмета назив базе у којој желите да покрећете програме.  

.. image:: ../../_images/slika_521a.jpg
    :width: 350
    :align: center

Сви приказани задаци су у вези са табелама које чине базу података за библиотеку. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_521b.jpg
    :width: 780
    :align: center

.. questionnote::

    1. Разматра се могућност да се уведу одређена ограничења члановима библиотеке који нередовно враћају књиге. Једна од мера би можда била да се њима не издају ретке књиге које су често тражене, а драстичнија мера би могла да подразумева и укидање чланства. Да би се на добар начин донела одлука, библиотека је одлучила да пажљиво проучи списак чланова који касне са враћањем књига и због тога плаћају казне да би се видело колико има таквих чланова и да ли има неких међу њима који се баш истичу. 

**Задатак 1**: Приказати број до сада плаћених казни и укупан износ. 

.. reveal:: pitanje_525a
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT COUNT(*) "Broj kazni", SUM(iznos) "Ukupan iznos"
        FROM kazne

    Прво решење – процедура. 

    ::

        CREATE PROCEDURE kazne_info
        AS
        SELECT COUNT(*) AS broj_kazni, SUM(iznos) AS ukupan_iznos
        FROM kazne

    Позив процедуре. 

    ::

        EXEC kazne_info

    Друго решење – две функције. 

    ::

        CREATE FUNCTION broj_kazni()
        RETURNS INT
        AS
        BEGIN
        DECLARE @broj INT;
        SELECT @broj = COUNT(*) FROM kazne;
        RETURN @broj;
        END

        CREATE FUNCTION ukupan_iznos_kazni()
        RETURNS INT
        AS
        BEGIN
        DECLARE @broj INT;
        SELECT @broj = SUM(iznos) FROM kazne;
        RETURN @broj;
        END

    Позив функција.

    ::

        PRINT 'Broj kazni: '+CAST(dbo.broj_kazni() AS VARCHAR);
        PRINT 'Ukupan iznos: '+CAST(dbo.ukupan_iznos_kazni() AS VARCHAR);

**Задатак 2**: Приказати број чланова који су до сада каснили са враћањем књига и због тога плаћали казне. 

.. reveal:: pitanje_525b
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT COUNT(DISTINCT broj_clanske_karte)
        FROM kazne

    За овај проблем има највише смисла написати скаларну функцију. 

    ::

        CREATE FUNCTION broj_clanova_sa_kaznama()
        RETURNS INT
        AS
        BEGIN
        DECLARE @broj INT;
        SELECT @broj = COUNT(DISTINCT broj_clanske_karte) 
        FROM kazne;
        RETURN @broj;
        END

    Позив функције.

    ::

        PRINT dbo.broj_clanova_sa_kaznama()


**Задатак 3**: Приказати имена и презимена чланова, уз број плаћених казни. Списак уредити по члановима.

.. reveal:: pitanje_525c
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT ime, prezime, COUNT(*)
        FROM kazne JOIN clanovi
        ON (kazne.broj_clanske_karte=clanovi.broj_clanske_karte)
        GROUP BY ime, prezime
        ORDER BY ime, prezime

    Прво решење – процедура. 

    ::

        CREATE PROCEDURE clanovi_kazne
        AS
        SELECT ime, prezime, COUNT(*) AS broj_kazni
        FROM kazne JOIN clanovi
        ON (kazne.broj_clanske_karte=clanovi.broj_clanske_karte)
        GROUP BY ime, prezime
        ORDER BY ime, prezime

    Позив процедуре. 

    ::

        EXEC clanovi_kazne

    .. image:: ../../_images/slika_525a.jpg
        :width: 400
        :align: center


    Друго решење – лепше форматиран приказ тражених података. 

    ::


        CREATE PROCEDURE clanovi_kazne2
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
            SELECT @ime=ime, @prezime=prezime 
            FROM clanovi WHERE broj_clanske_karte=@broj_clanske_karte;
            PRINT 'CLAN: '+@ime+' '+@prezime;
            DECLARE @broj_kazni INT;
            SELECT @broj_kazni = COUNT(*) 
            FROM kazne WHERE broj_clanske_karte=@broj_clanske_karte;
            PRINT 'Broj kazni: '+CAST(@broj_kazni AS VARCHAR);

            FETCH NEXT FROM kursor_clanovi 
            INTO @broj_clanske_karte;
        END
        CLOSE kursor_clanovi;
        DEALLOCATE kursor_clanovi;

    Позив процедуре. 

    ::

        EXEC clanovi_kazne2

    .. image:: ../../_images/slika_525b.jpg
        :width: 400
        :align: center

**Задатак 4**: Приказати имена и презимена чланова, уз број плаћених казни, који имају више од једне плаћене казне.

.. reveal:: pitanje_525d
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT ime, prezime, COUNT(*)
        FROM kazne JOIN clanovi
        ON (kazne.broj_clanske_karte=clanovi.broj_clanske_karte)
        GROUP BY ime, prezime
        HAVING COUNT(*)>1
        ORDER BY ime, prezime

    Процедура са курсором. 

    ::

        CREATE PROCEDURE clanovi_kazne3
        AS
        DECLARE kursor_clanovi CURSOR FOR
        SELECT DISTINCT broj_clanske_karte FROM kazne;
        DECLARE @broj_clanske_karte INT;

        OPEN kursor_clanovi;
        FETCH NEXT FROM kursor_clanovi 
        INTO @broj_clanske_karte;

        WHILE @@FETCH_STATUS=0
        BEGIN
            DECLARE @broj_kazni INT;
            SELECT @broj_kazni = COUNT(*) 
            FROM kazne WHERE broj_clanske_karte=@broj_clanske_karte;

            IF @broj_kazni>1
            BEGIN
                DECLARE @ime VARCHAR(15);
                DECLARE @prezime VARCHAR(15);
                SELECT @ime=ime, @prezime=prezime 
                FROM clanovi WHERE broj_clanske_karte=@broj_clanske_karte;
                PRINT 'CLAN: '+@ime+' '+@prezime;
                PRINT 'Broj kazni: '+CAST(@broj_kazni AS VARCHAR);
            END;

            FETCH NEXT FROM kursor_clanovi 
            INTO @broj_clanske_karte;
        END
        CLOSE kursor_clanovi;
        DEALLOCATE kursor_clanovi;

    Позив процедуре.

    ::

        EXEC clanovi_kazne3

**Задатак 5**: Приказати име и презиме члана који је платио највећи износ казне до сада. 

Под претпоставком да висина износа казне зависи од броја дана колико се каснило са враћањем књиге, решење овог упита може да издвоји члана или чланове који се неодговорно понашају. 

.. reveal:: pitanje_525e
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT DISTINCT ime, prezime
        FROM kazne JOIN clanovi
        ON (kazne.broj_clanske_karte=clanovi.broj_clanske_karte)
        WHERE iznos = (SELECT MAX(iznos) FROM kazne)

    Функција која враћа највећи износ плаћење казне. 

    ::

        CREATE FUNCTION najveca_placena_kazna ()
        RETURNS INT
        AS
        BEGIN
        DECLARE @iznos INT;
        SELECT @iznos = MAX(iznos) FROM kazne;
        RETURN @iznos;
        END

    Процедура која је решење задатка и позива креирану функцију.
    
    ::

        CREATE PROCEDURE clan_sa_najvecom_kaznom
        AS
        SELECT DISTINCT ime, prezime
        FROM kazne JOIN clanovi
        ON (kazne.broj_clanske_karte=clanovi.broj_clanske_karte)
        WHERE iznos = dbo.najveca_placena_kazna();

    Позив процедуре.

    ::

        EXEC clan_sa_najvecom_kaznom

.. questionnote::

    2. У току месеца маја је акција и библиотека поклања по једну књигу својим верним члановима који тог месеца дођу да позајме књиге. Тренутно је у библиотеку дошла Милица Зорановић и библиотекар жели да провери како изгледа њена историја чланства, тј. да ли је већ дужи низ година члан библиотеке. 

**Задатак**: Приказати број година када је члан датог имена и презимена био члан библиотеке, тј. године за које је платио чланарину.  

.. reveal:: pitanje_525f
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак за једног конкретног члана.

    ::

        SELECT COUNT(god)
        FROM clanovi JOIN clanarine
        ON (clanovi.broj_clanske_karte=clanarine.broj_clanske_karte)
        WHERE ime='Milica' AND prezime='Zoranovic'

    За овај проблем има највише смисла написати скаларну функцију. 

    ::

        CREATE FUNCTION broj_godina_clanstva (@ime VARCHAR(15), @prezime VARCHAR(15))
        RETURNS INT
        AS
        BEGIN
            DECLARE @broj INT;
            SELECT @broj = COUNT(god)
            FROM clanovi JOIN clanarine
            ON (clanovi.broj_clanske_karte=clanarine.broj_clanske_karte)
            WHERE ime=@ime AND prezime=@prezime;
            RETURN @broj;
        END

    Позив функције.

    ::

        PRINT dbo.broj_godina_clanstva('Milica', 'Zoranovic')

    Када имамо функцију, по потреби можемо да је позовемо и за друге чланове. 

    ::

        PRINT dbo.broj_godina_clanstva('Olivera', 'Stosic')

.. questionnote::

    3. Тренутно се размишља о корекцији износа за чланарине и корекцији попуста у ситуацијама где се остварује попуст на чланарину. Да би се донела добра одлука, потребно је проучити како се кретао износ просечне чланарине до сада. 

**Задатак 1**: Написати упит којим се приказује просечна висина чланарине. 

.. reveal:: pitanje_525g
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT AVG(iznos) FROM clanarine

    За овај проблем има највише смисла написати скаларну функцију. 

    ::

        CREATE FUNCTION prosecna_clanarina()
        RETURNS INT
        AS
        BEGIN
            DECLARE @iznos INT;
            SELECT @iznos = AVG(iznos) FROM clanarine;
            RETURN @iznos;
        END

    Позив функције.

    ::

        PRINT dbo.prosecna_clanarina()

**Задатак 2**: Написати упит којим се приказује просечна висина чланарине за сваку годину. 

.. reveal:: pitanje_525h
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT god, AVG(iznos)
        FROM clanarine
        GROUP BY god

    Процедура.

    ::

        CREATE PROCEDURE prosecna_clanarina_po_god
        AS
        SELECT god, AVG(iznos)
        FROM clanarine
        GROUP BY god

    Позив процедуре.

    ::

        EXEC prosecna_clanarina_po_god
