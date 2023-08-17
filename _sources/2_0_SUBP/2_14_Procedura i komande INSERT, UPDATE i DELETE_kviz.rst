Процедуре и команде INSERT, UPDATE, и DELETE - квиз
===================================================

.. quizq::

    .. mchoice:: Pitanje_5_1_3a
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Процедура је именовани блок програмског кода, најчешће узима један или више параметара, остаје сачувана у бази података након креирања помоћу CREATE PROCEDURE, а по потреби се позива за различите вредности. 

.. quizq::

    .. mchoice:: Pitanje_5_1_3b
        :answer_a: SAVED PROCEDURE
        :answer_b: STOP PROCEDURE
        :answer_c: STORED PROCEDURE 
        :answer_d: STORAGE PROCEDURE
        :correct: c

        Који је познати темин на енглеском за процедуре у системима за управљање базама података? 

.. quizq::

    .. mchoice:: Pitanje_5_1_3c
        :answer_a: Процедура не може да има два параметра.
        :answer_b: Потребно је прво написати тип, па назив параметра, нпр. varchar(15) @ime_autora.
        :answer_c: Процедура мора да има назив, а у овом реду немамо назив.
        :answer_d: Све је исправно, нема грешака.
        :correct: c

        Шта је грешка у следећем реду којим се започиње креирања процедуре? 

        ::

            CREATE PROCEDURE @ime_autora varchar(15), @prezime_autora varchar(15) AS 

.. quizq::

    .. mchoice:: Pitanje_5_1_3d
        :answer_a: 1
        :answer_b: 2
        :answer_c: 3
        :answer_d: 4
        :correct: a

        Колико параметара има следећа процедура? 

        ::

            CREATE PROCEDURE unos_izdavaca @naziv varchar(40) AS

.. quizq::

    .. mchoice:: Pitanje_5_1_3e
        :answer_a: EXEC @id=2, @naziv='CET', @adresa='Knez Mihailova 6, Beograd', @sajt='http://cet.rs/'
        :answer_b: EXEC @id=2, @naziv='CET', @sajt='http://cet.rs/'
        :answer_c: EXEC @id=2, @naziv='CET', @adresa='Knez Mihailova 6, Beograd'
        :answer_d: EXEC @id=2, @naziv='CET'
        :correct: d

        Који од следећих позива је испаван за следећу процедуру?

        ::

            CREATE PROCEDURE unos_izdavaca @id int, @naziv varchar(40) AS


.. quizq::

    .. mchoice:: Pitanje_5_1_3f
        :answer_a: Да 
        :answer_b: Не
        :correct: a

        У једној процедури може да буде више команди језика SQL, INSERT, UPDATE, DELETE и SELECT?

.. quizq::

    .. mchoice:: Pitanje_5_1_3g
        :answer_a: @id_knjige и id_knjige су променљиве, @naziv и naziv су колоне у табели.
        :answer_b: @id_knjige и @naziv су променљиве, id_knjige и naziv су колоне у табели. 
        :answer_c: @id_knjige, id_knjige, @naziv и naziv су променљиве.
        :answer_d: @id_knjige, id_knjige, @naziv и naziv су колоне у табели.
        :correct: b

        Које тврђење је тачно када имамо следећи упит који је део процедуре?

        ::

            SELECT @id_knjige = id_knjige FROM knjige WHERE naziv = @naziv_knjige;

.. quizq::

    .. mchoice:: Pitanje_5_1_3h
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Следећа команда ће попунити вредност променљиве @id_knjige идентификационим бројем који се прочита из базе или ће поставити променљиву на null уколико нема одговарајућег податка. 

        ::

            SELECT @id_knjige = id_knjige FROM knjige WHERE naziv = @naziv_knjige;

.. quizq::

    .. mchoice:: Pitanje_5_1_3i
        :answer_a: Да
        :answer_b: Не
        :correct: b

        У процедури не може да се користи наредба гранања IF. 

.. quizq::

    .. mchoice:: Pitanje_5_1_3j
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Процедура не може да се измени након што се креира и остане запамћена у систему. Мора да се скроз обрише и креира поново. 
