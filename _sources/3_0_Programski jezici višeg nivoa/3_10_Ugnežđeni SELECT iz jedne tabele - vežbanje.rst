Програм са угнежђеним упитом SELECT из једне табеле - вежбање
=============================================================


Решити следеће задатке писањем програма у развојном окружењу *Visual Studio Community* и употребом програмског језика C#. 

Приликом решавања задатака, погледајте претходно решене примере. Након што решите неки задатак па желите да проверите да ли је решење добро или видите да не можете да га решите, погледајте решење које ће се приказати након што кликнете на дугме. 

Детаљно објашњење формирања упита SELECT који треба да буде део програма је објашњен раније у материјалима и по потреби је могуће вратити се на тај део као помоћ у писању комплетног решења. 

Сви приказани задаци су у вези са табелама које чине део базе података за библиотеку. Следи списак свих табела са колонама. Примарни кључеви су истакнути болд, а страни италик. 

.. image:: ../../_images/slika_310a.jpg
    :width: 300
    :align: center

Када се покрене развојно окружење *Visual Studio Community*, потребно је да се креира нови пројекат избором опције *Create a new project*. Изабрани језик треба да буде С#, а врста пројекта *Windows Forms App*, апликација са графичким коирсничким интерфејсом. 

У следећем кораку је потребно да се пројекат именује и да се изабере локација на којој ће се пројекат чувати. Може да остане и предложена локација. Кликнути на дугме *Create* и прелазимо у простор за креирање апликације, тј. програма. 

Први корак је додавање раније креиране базе података новом пројекту. У прозору *Solution Explorer* је потребно да се кликне десни тастер миша над називом пројекта, а затим да се изабере *Add/Existing Item...* са менија који се појави. База података коју смо креирали се већ налази на рачунару и потребно је пронаћи и изабрати фајл *Biblioteka_knjige.mdf* у којем је сачувана. Тачна локација може да се провери у систему *SQL Server Management Studio* у којем смо креирали базу. 

.. image:: ../../_images/slika_37a.jpg
    :width: 300
    :align: center

Класе које су нам потребне за читање података из базе и њихов приказ у програму се налазе у именском простору *System.Data.SqlClient* који није аутоматски укључен у нови пројекат. Потребно је да додамо следећи ред на врх документа са програмским кодом. 

.. code-block:: Csharp

    using System.Data.SqlClient;

Приликом писања програма, потребно је да се употреби конекциони стринг који је формиран у ранијим примерима, а односи се на повезивање програма на базу података *Biblioteka_knjige.mdf*. У решењима задатака стоји *KONEKCIONI_STRING* на местима где се очекује конекциони стринг.  

.. questionnote::
    
    1. Библиотеци је потребан списак свих аутора чије књиге поседује. Ради лакшег прегледања списка, важно је да списак буде уређен абецедно.  

**Задатак:** Написати програм који приказује имена и презимена аутора, уређено абецедно по презимену, а ако имају исто презиме, по имену. 

.. reveal:: pitanje_310a
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.
    ::

        SELECT ime, prezime
        FROM autori
        ORDER BY prezime, ime

    Програмски код. 

    .. code-block:: Csharp

        private void button1_Click(object sender, EventArgs e)
        {
            try
            {
                string conText = KONEKCIONI_STRING;
                string cmd = "SELECT ime, prezime FROM autori ORDER BY prezime, ime";
                SqlDataAdapter da = new SqlDataAdapter(cmd, conText);
                DataTable dt = new DataTable();
                da.Fill(dt);
                dataGridView1.DataSource = dt;
            }
            catch (Exception exception)
            {
                MessageBox.Show(exception.Message);
            }
        }

    .. image:: ../../_images/slika_310b.jpg
        :width: 450
        :align: center

.. questionnote::

    2. Библиотека повремено планира набавке још књига у издањима различитих издавачких кућа. Када планирају једну одређену набавку књига у издању једног издавача, да би могли да пошаљу наруџбеницу, потребна им је адреса те издавачке куће.  

**Задатак:** Написати програм која приказује адресу издавачке куће са датим називом. 

.. reveal:: pitanje_310b
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак за једног конкретног издавача.
    ::

        SELECT adresa
        FROM izdavaci
        WHERE naziv = 'CET'

    Програмски код.
    
    .. code-block:: Csharp

        private void button1_Click(object sender, EventArgs e)
        { 
            string conText = KONEKCIONI_STRING;
            string izdavac = textBox1.Text;
            string cmd;
            cmd = "SELECT adresa FROM izdavaci WHERE naziv = '" + izdavac + "'";
            SqlDataAdapter da = new SqlDataAdapter(cmd, conText);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

    .. image:: ../../_images/slika_310c.jpg
        :width: 450
        :align: center

    Други начин је да позовемо функцију коју имамо. Да се подсетимо како изгледа скаларна функција која враћа адресу. У овом случају изглед апликације може да се разликује. Није нам потребан DataGridView за приказ резултата.

    ::

        CREATE FUNCTION adresa_izdavaca3(@naziv VARCHAR(40))
        RETURNS VARCHAR(50)
        AS
        BEGIN
            DECLARE @adresa VARCHAR(50);
            SELECT @adresa = adresa
            FROM izdavaci 
            WHERE naziv = @naziv;
            RETURN @adresa;
        END

    Програмски код. 

    .. code-block:: Csharp

         private void button1_Click(object sender, EventArgs e)
        {
            string conText = KONEKCIONI_STRING;
            SqlConnection con = new SqlConnection(conText);
            string cmdText;
            cmdText = "SELECT dbo.adresa_izdavaca3('" + textBox1.Text + "')";
            SqlCommand cmd = new SqlCommand(cmdText, con);
            con.Open();
            string adresa = Convert.ToString(cmd.ExecuteScalar());
            textBox2.Text = adresa;
        }

    .. image:: ../../_images/slika_310d.jpg
        :width: 450
        :align: center

.. questionnote::

    3. Члан је дошао у библиотеку и жели да узме неку књигу из рачунарства. Не зна тачан назив књиге која му треба, па пита библиотекара које све књиге имају на тему рачунарства.  

**Задатак:** Написати програм који приказује називе књига које у наслову садрже дату реч. 


.. reveal:: pitanje_310c
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак за једну конкретну реч која треба да буде садржана у називу.

    ::

        SELECT naziv
        FROM knjige
        WHERE naziv LIKE 'Racunarstvo%' OR naziv LIKE '%racunarstvo%'

    Програмски код. 

    .. code-block:: Csharp

        private void button1_Click(object sender, EventArgs e)
        {
            string conText = KONEKCIONI_STRING;
            string rec = textBox1.Text;
            string cmd = "SELECT naziv FROM knjige ";
            cmd += "WHERE naziv LIKE '%" + rec + "%'";
            SqlDataAdapter da = new SqlDataAdapter(cmd, conText);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

    .. image:: ../../_images/slika_310e.jpg
        :width: 40
        :align: center

    Други начин је да позовемо процедуру коју имамо. Да се подсетимо како изгледа процедура. 

    ::

        CREATE PROCEDURE knjige_na_temu @tekst VARCHAR(50)
        AS
          SELECT naziv
          FROM knjige
          WHERE naziv LIKE '%'+@tekst+'%'

    Програмски код. 

    .. code-block:: Csharp

                private void button1_Click(object sender, EventArgs e)
        {
            string conText = KONEKCIONI_STRING;
            SqlConnection con = new SqlConnection(conText);
            SqlDataAdapter da = new SqlDataAdapter();
            SqlCommand cmd = new SqlCommand("dbo.knjige_na_temu ", con);
            cmd.CommandType = CommandType.StoredProcedure;
            SqlParameter param = new SqlParameter("@tekst", textBox1.Text);
            param.Direction = ParameterDirection.Input;
            param.DbType = DbType.String;
            cmd.Parameters.Add(param);
            da.SelectCommand = cmd;
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

.. questionnote::

    4. Библиотека жели да допуни своју базу података и унесе адресе и веб-сајтове за све издавачке куће са којима сарађује, па је важно да се провери који им подаци недостају да би знали које издавачке куће да контактирају да би набавили потребне податке. 

**Задатак:** Написати програм који приказује називе издавача за које немамо унету адресу или адресу веб-сајта. 

.. reveal:: pitanje_310d
    :showtitle: Прикажи решење
    :hidetitle: Сакриј решење

    Упит којим смо решили овај задатак.

    ::

        SELECT naziv
        FROM izdavaci
        WHERE adresa IS NULL OR veb_sajt IS NULL

    Програмски код. 

    .. code-block:: Csharp

        private void button1_Click(object sender, EventArgs e)
        {
            string conText = KONEKCIONI_STRING;
            string cmd = "SELECT naziv FROM izdavaci WHERE " +
                "adresa IS NULL OR veb_sajt IS NULL";            
            SqlDataAdapter da = new SqlDataAdapter(cmd, conText);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }

    .. image:: ../../_images/slika_310f.jpg
        :width: 40
        :align: center
        
    Други начин је да позовемо функцију коју имамо. Да се подсетимо како изгледа функција која враћа табелу. 

    ::

        CREATE FUNCTION nedostaje_podatak_o_izdavacu()
        RETURNS TABLE
        AS
            RETURN SELECT naziv
            FROM izdavaci
            WHERE adresa IS NULL OR veb_sajt IS NULL;

    Програмски код

    .. code-block:: Csharp

        private void button1_Click(object sender, EventArgs e)
        {
            string conText = KONEKCIONI_STRING;
            string cmd = "SELECT naziv FROM dbo.nedostaje_podatak_o_izdavacu()";            
            SqlDataAdapter da = new SqlDataAdapter(cmd, conText);
            DataTable dt = new DataTable();
            da.Fill(dt);
            dataGridView1.DataSource = dt;
        }
