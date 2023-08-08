Језик PL/SQL и наредба SELECT INTO – квиз
=========================================

.. quizq::

    .. mchoice:: Pitanje_7_4a
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Када се упит SELECT, који враћа податке из једног реда, укључује у PL/SQL програм, мора да има део INTO са списком променљивих у које се уписују прочитане вредности из базе податка. 


.. quizq::

    .. mchoice:: Pitanje_7_4b
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Следећи упит може да се са SELECT INTO угради у PL/SQL програм уколико знамо да сигурно има више књига траженог издавача. 

            SELECT naziv FROM knjige WHERE id_izdavaca=2
        
.. quizq::

    .. mchoice:: Pitanje_7_4c
        :answer_a: SELECT naziv FROM knjige WHERE id_knjige=414
        :answer_b: SELECT id_knjige FROM primerci WHERE inventarski_broj=12345
        :answer_c: SELECT inventarski_broj FROM knjige WHERE id_knjige=414
        :correct: c

        Који од наредних упита сигурно не може да се угради у PL/SQL програм са SELECT INTO? У табели primeci је колона inventarski_broj примарни кључ, а колона id_knjige   је страни кључ који показује на примарни кључ табеле knjige. Од једне књиге имамо сигурно и по неколико примерака у библиотеци. 
        
.. quizq::

    .. mchoice:: Pitanje_7_4d
        :answer_a: SELECT naziv, id_izdavaca INTO v_naziv, v_id_izdavaca 
        :answer_b: SELECT naziv, id_izdavaca INTO v_naziv
        :answer_c: SELECT naziv, id_izdavaca INTO v_id_izdavaca
        :answer_d: SELECT naziv INTO v_naziv, v_id_izdavaca
        :correct: a

        Који почетак команде SELECT INTO је исправан?
        
.. quizq::

    .. mchoice:: Pitanje_7_4e
        :answer_a: v_naziv izdavaci.naziv%ROWTYPE
        :answer_b: v_naziv ROWTYPE%izdavaci.naziv
        :answer_c: v_naziv izdavaci.naziv%TYPE
        :answer_d: v_naziv TYPE%izdavaci.naziv
        :correct: c

        Која од следећих декларација је исправна? 
        
.. quizq::

    .. mchoice:: Pitanje_7_4f
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Следећа променљива је сложена и има онолико поља колико колона има табела autori.  
        
        v_autor autori%ROWTYPE; 

.. quizq::

    .. mchoice:: Pitanje_7_4g
        :answer_a: OTHERS
        :answer_b: NO_DATA_FOUND
        :answer_c: ZERO_DIVIDE
        :answer_d: TOO_MANY_ROWS 
        :correct: d

        Уколико упит који је употребљен са SELECT INTO у PL/SQL програму враћа више редова, који изузетак ће бити испаљен?