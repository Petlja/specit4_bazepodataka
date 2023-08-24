Програм са угнежђеним командама у развојном окружењу Visual Studio - квиз
=========================================================================

.. quizq::

    .. mchoice:: pitanje_39a
        :answer_a: System.Data
        :answer_b: System.Data.SqlClient 
        :answer_c: System.Drawing
        :answer_d: System.Data.SqlTypes
        :correct: b


        Који именски простор треба да придружимо пројекту ако за повезивање са базом података желимо да користимо објекат класе SqlDataAdapter? 

.. quizq::

    .. mchoice:: pitanje_39b
        :answer_a: Само објекту класе SqlDataAdapter
        :answer_b: Само објекту класе SqlCommand
        :answer_c: Објекту класе SqlDataAdapter или објекту класе SqlCommand 
        :answer_d: Не можемо да текст упита користимо унутар С# програма 
        :correct: c


        Којим објектима можемо да доделимо текст упита SELECT? 

.. quizq::

    .. mchoice:: pitanje_39c
        :answer_a: Методом Fill класе SqlDataAdapter се попуни објекат класе DataTable, садржај објекта класе DataTable се преко својства DataSource упише у DataGridView, објекат SqlDataAdapter добије упит SELECT.
        :answer_b: Објекат SqlDataAdapter добије упит SELECT, садржај објекта класе DataTable се преко својства DataSource упише у DataGridView, методом Fill класе SqlDataAdapter се попуни објекат класе DataTable.
        :answer_c: Објекат SqlDataAdapter добије упит SELECT, методом Fill класе SqlDataAdapter се попуни објекат класе DataTable, садржај објекта класе DataTable се преко својства DataSource упише у DataGridView. 
        :answer_d: Методом Fill класе SqlDataAdapter се попуни објекат класе DataTable, објекат SqlDataAdapter добије упит SELECT, садржај објекта класе DataTable се преко својства DataSource упише у DataGridView.
        :correct: c
 
        Који је исправан редослед?

.. quizq::

    .. mchoice:: pitanje_39d
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Текст упита можемо да сместимо прво у променљиву типа string, а онда да тај стринг доделимо објекту класе SqlDataAdapter, као у примеру који следи. 

        .. code-block:: Csharp

            string cmd = "SELECT * FROM knjige";
            SqlDataAdapter da = new SqlDataAdapter(cmd, con);

.. quizq::

    .. mchoice:: pitanje_39e
        :answer_a: string cmd = "SELECT * FROM knjige WHERE naziv = '" + naziv + "'";
        :answer_b: string cmd = "SELECT * FROM knjige WHERE naziv = '" + naziv;
        :answer_c: string cmd = "SELECT * WHERE naziv = '" + naziv + "'";;
        :answer_d: string cmd = "SELECT * WHERE = '" + naziv;
        :correct: a

        Који од следећих угњеждених упита нема грешку?

.. quizq::

    .. mchoice:: pitanje_39f
        :answer_a: Унутар C# програма не можемо да позовемо ни процедуре, ни функције које смо креирали и које су сачуване у бази.
        :answer_b: Унутар C# програма можемо да позовемо само процедуре, али не можемо да позовемо функције које смо креирали и које су сачуване у бази.
        :answer_c: Унутар C# програма можемо да позовемо процедуре и креиране функције које враћају табеле, али не можемо да позовемо скаларне функције које смо креирали и које су сачуване у бази.
        :answer_d: Унутар C# програма можемо да позовемо процедуре, као и скаларне функције и функције које враћају табеле које смо креирали и које су сачуване у бази.
        :correct: d

        Која од следећих реченица је тачна? 
