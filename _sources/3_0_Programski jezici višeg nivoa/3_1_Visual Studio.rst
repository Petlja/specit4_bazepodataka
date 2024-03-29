Писање програма у развојном окружењу Visual Studio
==================================================

.. suggestionnote::

    Базе података су увек део неког већег информационог система и приступа им се помоћу програма, тј. апликација за рачунаре и мобилне уређаје, који имају графички кориснички интерфејс. Важно је да видимо како се пишу такви програми. 

    Програми које ћемо креирати обрађују податке из база података па је неопходно да се темељно разуме концепт релационе базе и језик SQL, а посебно упит SELECT. У програмима ћемо приступати базама података које смо до сада креирали. 

    Постоји више програмских језика и развојних окружења у којима је могуће креирати програме који приступају бази података и омогућавају да се они складиште, користе и обрађују подаци. У овим материјалима је изабран програмски језик C# и развојно окружење **Visual Studio Community**, које може бесплатно да се преузме са следеће адресе:

    https://visualstudio.microsoft.com/vs/community/ 

    Постоји неколико предмета у гимназији за ученике са посебним способностима за рачунарство и информатику који се баве програмирањем и за детаљније упознавање са процесом креирања програма може да се приступи доступним курсевима на Петљи:

    - `Програмирање за први разред специјализованих ИТ одељења <https://petlja.org/kurs/369/>`_
    - `Програмирање за други разред специјализованих ИТ одељења <https://petlja.org/kurs/370/>`_
    - `Програмирање за трећи разред специјализованих ИТ одељења <https://petlja.org/kurs/7831>`_
    - `Објектно оријентисано програмирање за трећи разред специјализованих ИТ одељења <https://petlja.org/kurs/11202>`_

Програми се пишу у развојном окружењу *Visual Studio Community* и помоћу програмког језика C#. Сви приказани примери су у вези са табелама које чине део базе података за библиотеку. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_31a.jpg
    :width: 350
    :align: center

Када се покрене развојно окружење *Visual Studio Community*, потребно је да се креира нови пројекат избором опције *Create a new project*. 

.. image:: ../../_images/slika_31b.jpg
    :width: 300
    :align: center

Изабрани језик треба да буде С#, а врста пројекта *Windows Forms App*, апликација са графичким корисничким интерфејсом. 

.. image:: ../../_images/slika_31c.jpg
    :width: 450
    :align: center

У следећем кораку је потребно да се пројекат именује и да се изабере локација на којој ће се пројекат чувати. Може да остане и предложена локација. Кликнути на дугме *Create* и прелазимо у простор за креирање апликације, тј. програма. 

.. image:: ../../_images/slika_31d.jpg
    :width: 450
    :align: center

У централном делу окружења се појављује простор за рад на изгледу програма. Као помоћ у раду, било би добро да буду видљиви следећи помоћни прозори:

- *Toolbox*,
- *Solution Explorer*,
- *Properties*. 

Уколико неки од ових помоћних прозора није укључен, може да се дода помоћу падајућег менија View. Овај падајући мени се разликује од верзије до верзије, али увек садржи опције којима можемо да утичемо на то који су нам помоћни прозори доступни. 

.. image:: ../../_images/slika_31e.jpg
    :width: 790
    :align: center

Први корак је додавање раније креиране базе података новом пројекту. У прозору *Solution Explorer* је потребно да се кликне десни тастер миша над називом пројекта, а затим да се изабере *Add/Existing Item...* са менија који се појави. 

.. image:: ../../_images/slika_31f.jpg
    :width: 00
    :align: center

База података коју смо креирали се већ налази на рачунару и потребно је пронаћи и изабрати фајл у којем је сачувана. Тачна локација може да се провери у систему *SQL Server Management Studio* у којем смо креирали базу. База података има екстензију *mdf*. На следећој слици може да се види да је база података *Biblioteka_knjige.mdf* успешно додата у пројекат. 

.. image:: ../../_images/slika_31g.jpg
    :width: 300
    :align: center

За приказ садржаја табеле из релационе базе података је најбоље да се користи контрола *DataGridView* коју можемо из прозора *Toolbox* да превучемо у наш програм. 

.. image:: ../../_images/slika_31h.jpg
    :width: 300
    :align: center

Када додамо објекат класе *DataGridView*, његов подразумевани назив је исти само са почетним малим словом и бројем један *dataGridView1*. Исто правило именовања важи и када додајемо у програм објекте других класа, на пример, класе *Button*. Редом како их додајемо, објекти класе *Button* ће добијати називе *button1*, *button2*, *button3*...

Неопходно је да изаберемо податке који ће бити приказани у програму у оквиру табеле *DataGridView*. У горњем десном углу постоји мала стрелица која води до падајућег менија *Choose Data Source*. Са падајућег менија изабрати *Add Project Data Source...*

.. image:: ../../_images/slika_31i.jpg
    :width: 450
    :align: center

У наредна два корака изабрати *Database* и *Dataset*. 

.. image:: ../../_images/slika_31j.jpg
    :width: 450
    :align: center

Следећи корак је веома значајан зато што се формира конекција са базом података. 

.. image:: ../../_images/slika_31k.jpg
    :width: 450
    :align: center

Након што се кликне на дугме *New Connection...*, потребно је да се изабере опција *Microsoft SQL Server Database File*, а затим и да се на рачунару пронађе и дода фајл који садржи базу података. 

.. image:: ../../_images/slika_31l.jpg
    :width: 450
    :align: center

Када се изабере фајл, значајно је да се штиклира опција која приказује **конекциони стринг** (енг. *connection string*). Конекциони стринг садржи информације о извору података, у овом случају бази података, као и информације које су неопходне да програм може да се повеже на базу. 

.. image:: ../../_images/slika_31m.jpg
    :width: 450
    :align: center

.. infonote::

    Стринг који добијете неће бити идентичан овоме који је овде приказан. Значајно је да запамтите конекциони стринг који ви добијете на вашем рачунару за вашу базу података. Тај стринг ће се користити у свим наредним програмима које креирамо и који се повезују на ову базу података. 

Стринг је потребно мало прилагодити. На почетак и крај се додају наводници. Наводници у средини, на почетку и крају назива фајла са путањом се бришу. Испред сваке обрнуте косе црте треба додати још по једну, зато што је то посебан карактер. 

::

    "Data Source=(LocalDB)\\MSSQLLocalDB;
    AttachDbFilename=C:\\Users\\Dusa\\Documents
    \\SQL Server Management Studio\\Biblioteka_knjige.mdf;
    Integrated Security=True;Connect Timeout=30"

.. image:: ../../_images/slika_31o.jpg
    :width: 395
    :align: center

У наредном кораку је потребно изабрати табелу *knjige* са списка свих објеката који се налазе у бази података на коју смо се повезали. 

Контрола *DataGridView* је након свих ових корака повезана са табелом *knjige* и виде се заглавља колона ове табеле. 

.. image:: ../../_images/slika_31p.jpg
    :width: 450
    :align: center

Све је спремно да се покрене апликација кликом на дугме *Start*. 

.. image:: ../../_images/slika_31q.jpg
    :width: 450
    :align: center

Када се покрене програм, приказује се комплетан садржај табеле из базе података. Оно што се види у програму је копија података из базе. 

.. image:: ../../_images/slika_31r.jpg
    :width: 450
    :align: center