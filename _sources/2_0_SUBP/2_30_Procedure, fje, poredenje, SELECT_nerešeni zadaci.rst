База података за библиотеку - процедуре и функције са упитом SELECT - нерешени задаци
=====================================================================================

Решити следеће задатке писањем процедуре или функције, као и програмског кода у којем се позива написана процедура или функција. Приликом решавања нерешених задатака, погледајте претходно решене примере који узимају податке из исте базе. 

Где год резултат треба уредити и има смисла употребити курсор или курсоре, решити задатак на такав начин. На пример, уколико треба приказати назив књиге и име, односно имена аутора, а резултат треба уредити по називу књиге, има смисла да имамо један курсор који пролази кроз списак књига, а у циклусу имамо још један курсор који пролази кроз списак аутора једне књиге. 

Тамо где има смисла, задатке решити на више начина и упоредити решења.

Програмски код, као и команде језика SQL, пише се и покреће када се кликне *New Query* након што се покрене систем *SQL Server* и кликне на креирану базу *Biblioteka* у прозору *Object Explorer*. Фајл са упитима *SQLQuery1.sql* може, а и не мора да се сачува.

Након што се унесе програмски код, кликне се на дугме *Execute*. Уколико се у простору за писање команди налази више блокова кода, потребно је обележити онај који желимо да покренемо. Ако имате више база података, обавезно проверите да ли је поред овог дугмета назив базе у којој желите да покрећете програме.  

.. image:: ../../_images/slika_521a.jpg
    :width: 350
    :align: center

.. infonote::

    Упити који могу да буду део решења наредне групе задатака могу се пронаћи у лекцијама посвећеним пројекцији и селекцији у упиту SELECT из једне табеле у оквиру материјала за предмет Базе података у трећем разреду гимназије за ученике са посебним способностима за рачунарство и информатику. Лекције се налазе на следећим адресама:

    https://petlja.org/kurs/7963/11/6714
    
    https://petlja.org/kurs/7963/11/6717

.. questionnote::

    1. Приказати презимена запослених, њихове плате и који би износ плате имали након повећања за дати проценат. Приликом позива процедуре или функције нека проценат буде 10. 

.. questionnote::

    2. Приказати имена, презимена и имејл адресе запослених уређене абецедно по презимену и имену. 

.. questionnote::

    3. Приказати презиме, име, имејл адресу и износ плате свих запослених сортиран у опадајућем редоследу према висини примања. Уколико неколико запослених има исту плату, сортирати их абецедно по презимену и имену. 

.. questionnote::

    4. Приказати идентификационе бројеве запослених који су менаџери. 

.. questionnote::

    5. Приказати запослене који зарађују више од датог износа новца. Приликом позива процедуре или функције нека износ буде 60.000 динара.

.. questionnote::

    6. Приказати запослене који зарађују тачно одређен износ новца. Приликом позива процедуре или функције нека износ буде 50.000 динара.

.. questionnote::

    7. Приказати запослене који зарађују између два дата износа новца, укључујући и те износе. Приликом позива процедуре или функције нека износи буду 40.000 динара и 50.000 динара.

.. questionnote::

    8. Приказати запослене који би након повећања плате за дати проценат зарађивали више од одређеног износа новца, а сада зарађују мање. Приликом позива процедуре или функције нека износ буде 70.000 динара, а проценат 20.

.. questionnote::

    9. Приказати запослене који зарађују више од датог износа новца и презиме им почиње на дато слово. Приликом позива процедуре или функције нека износ буде 60.000 динара, а слово П.

.. questionnote::

    10. Приказати запослене чије име има тачно четири слова.

.. questionnote::

    11. Приказати све податке о запосленима који у оквиру своје имејл адресе имају дату реч. Приликом позива процедуре или функције нека реч буде „petrovic“. 

.. questionnote::

    12. Приказати све податке о запосленом датог имена и презимена. Приликом позива процедуре или функције нека запослени буде Маја Петровић.  

.. questionnote::

    13. Приказати запослене чији су менаџери са идентификационим бројевима 1, 2 и 3. 

.. questionnote::

    14. Приказати запослене чији менаџери нису запослени са идентификационим  бројевима 1 и 3. 

.. questionnote::

    15. Приказати запослене који немају менаџера. 

.. questionnote::

    16. Приказати уређено абецедно по презимену и имену све запослени који имају менаџера. 

.. questionnote::

    17. Приказати запослене који су почели да раде пре одређеног датума. Приликом позива процедуре или функције нека датум буде 1. јануар 2015. године. 

.. infonote::

    Упити који могу да буду део решења наредне групе задатака могу се пронаћи у лекцији посвећеној спајању табела у упиту SELECT у оквиру материјала за предмет Базе података у трећем разреду гимназије за ученике са посебним способностима за рачунарство и информатику. Лекција се налази на следећој адреси:

    https://petlja.org/kurs/7963/12/6723 

.. questionnote::

    1. Приказати, уз презиме члана, износ и годину плаћене чланарине.

.. questionnote::

    2. Приказати, уз презиме и имејл адресу члана, износ и годину плаћене чланарине, али само за чланове који имају имејл адресу. Податке приказати уређене абецедно по презимену.

.. questionnote::

    3. Приказати назив књиге и назив њеног издавача.

.. questionnote::

    4. Приказати презиме запосленог и презиме његовог менаџера.

.. questionnote::

    5. Приказати име и презиме члана, датум позајмице, инвентарски број примерка и идентификациони број књиге за све позајмице између два датума. Приликом позива процедуре или функције нека се прикажу позајмице током месеца маја 2019. године.

.. questionnote::

    6. Приказати податке о тренутно издатим књигама (текуће позајмице): име и презиме члана, датум позајмице, инвентарски број примерка и идентификациони број књиге.

.. questionnote::

    7. Приказати податке о свим позајмицама: име и презиме члана, датум позајмице, инвентарски број узетог примерка и назив књиге.

.. questionnote::

    8. Приказати назив књиге и име аутора. Резултат уредити по називу књиге.

.. questionnote::

    9. Приказати називе књигa чији је један од аутора датог имена и презимена. Приликом позива процедуре или функције нека аутор буде Мијодраг Ђуришић.

.. questionnote::

    10. Приказати називе књига које је из библиотеке узимао члан са датим бројем чланске карте, али без понављања. Дакле, уколико је члан током година колико је члан библиотеке узимао исту књигу неколико пута, назив те књиге треба да се прикаже само једном. Приликом позива процедуре или функције нека број чланске карте буде 22.

.. questionnote::

    11. Приказати имена чланова и имена аутора чије су књиге читали, без понављања (исти члан је могао да чита неколико књига истог аутора).

.. questionnote::

    12. Приказати називе издавача и називе њихових књига. Приказати и издаваче чијих књига нема у библиотеци.

.. questionnote::

    13. Приказати називе издавача и називе њихових књига. Приказати и издаваче чијих књига нема у библиотеци. Уредити списак абецедно по називу издавача.

.. infonote::

    Упити који могу да буду део решења наредне групе задатака могу се пронаћи у лекцијама посвећеним упиту SELECT са употребом групних функција и подупита у оквиру материјала за предмет Базе података у трећем разреду гимназије за ученике са посебним способностима за рачунарство и информатику. Лекције се налазе на следећим адресама:

    https://petlja.org/kurs/7963/13/6728

    https://petlja.org/kurs/7963/13/6730



.. questionnote::

    1. Приказати најмању, највећу и просечну плату свих запослених.

.. questionnote::

    2. Приказати број позајмица члана са датим бројем чланске карте. Приликом позива процедуре или функције нека број чланске карте буде 22.

.. questionnote::

    3. Приказати датум када се прва особа запослила у библиотеци.

.. questionnote::

    4. Приказати просечну плату оних запослених који зарађују више или једнако од одређеног износа. Приликом позива процедуре или функције нека износ буде 50.000 динара. 

.. questionnote::

    5. Приказати за сваког менаџера просечну плату његових запослених.

.. questionnote::

    6. Приказати за сваког менаџера просечну плату његових запослених. Издвојити само менаџере чији запослени имају просек плата већи од одређеног износа. Приликом позива процедуре или функције нека износ буде 50.000 динара.

.. questionnote::

    7. Приказати за сваког менаџера просечну плату његових запослених. Издвојити само менаџере који имају више од одређеног броја запослених. Приликом позива процедуре или функције издвојити менаџере са више од двоје запослених.

.. questionnote::

    8. Приказати за сваког издавача број његових књига у библиотеци.

.. questionnote::

    9. Приказати укупан број плаћених чланарина.

.. questionnote::

    10. Приказати укупан износ плаћених чланарина за сваку годину.

.. questionnote::

    11. Приказати за сваког аутора број издавача за које је радио.

.. questionnote::

    12. Приказати запослене који зарађују исто као запослени са датим презименом. Приликом позива процедуре или функције нека презиме буде Лазовић.

.. questionnote::

    13. Приказати све чланове који током дате године плаћају исти износ чланарине као члан са датим бројем чланске карте. Приликом позива процедуре или функције нека година буде 2019, а број чланске карте 33.

.. questionnote::

    14. Приказати све чланове који су у неком тренутку плаћали исти износ чланарине као члан са датим бројем чланске карте. Приликом позива процедуре или функције нека број чланске карте буде 33.

.. questionnote::

    15. Приказати све књиге које је објавио исти издавач који је објавио и књигу са датим називом. Приликом позива процедуре или функције нека назив буде „PROGRAMIRANJE – klase i objekti“. 

.. questionnote::

    16. Приказати податке о запосленом који најмање зарађује.

.. questionnote::

    17. Приказати податке о запосленима који зарађују више од просека.

.. questionnote::

    18. Приказати назив књиге која је издата као најстарија позајмица.

.. questionnote::

    19. Приказати чланове библиотеке који су позајмили бар једну књигу исту као члан са датим бројем чланске карте. Приликом позива процедуре или функције нека број чланске карте буде 33.

