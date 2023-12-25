Курсори - квиз
==============

.. quizq::

    .. mchoice:: Pitanje_8_8a
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Када упит највероватније узима податке из више редова, у PL/SQL програму мора да се користи курсор. 
        
.. quizq::

    .. mchoice:: Pitanje_8_8b
        :answer_a: Да
        :answer_b: Не
        :correct: a

        За следећи упит мора да се креира курсор уколико желимо да га уградимо у PL/SQL програм. Знамо да сигурно има више књига траженог издавача. 
            
            SELECT naziv FROM knjige WHERE id_izdavaca=2

        

        
.. quizq::

    .. mchoice:: Pitanje_8_8c
        :answer_a: Да
        :answer_b: Не
        :correct: b

        За следећи упит мора да се креира курсор уколико желимо да га уградимо у PL/SQL програм. Колона id_knjige је примарни кључ. 
        
            SELECT naziv FROM knjige WHERE id_knjige=2

        
.. quizq::

    .. mchoice:: Pitanje_8_8d
        :answer_a: SELECT inventarski_broj FROM knjige WHERE id_knjige=414 
        :answer_b: SELECT naziv FROM knjige WHERE id_knjige=414
        :answer_c: SELECT id_knjige FROM primerci WHERE inventarski_broj=12345
        :correct: a

        За који од наредних упита нам сигурно треба курсор ако желимо да га уградимо у PL/SQL програм? У табели primeci је колона inventarski_broj примарни кључ, а колона id_knjige је страни кључ који показује на примарни кључ табеле knjige. Од једне књиге имамо сигурно и по неколико примерака у библиотеци. 
        
.. quizq::

    .. mchoice:: Pitanje_8_8e
        :answer_a: Приказати адресу издавача са идентификационим бројем 2.
        :answer_b: Приказати адресе свих издавача.
        :answer_c: Приказати телефон члана са бројем чланске карте 11. 
        :answer_d: Приказати назив примерка књиге са инвентарским бројем 12345.
        :correct: b

        За који од следећих задатака морамо да употребимо курсор?
        
.. quizq::

    .. mchoice:: Pitanje_8_8f
        :answer_a: v_red kursor_izdavaci%ROWTYPE 
        :answer_b: v_red ROWTYPE%kursor_izdavaci
        :answer_c: v_red kursor_izdavaci%TYPE 
        :answer_d: v_red TYPE%kursor_izdavaci
        :correct: a

        Уколико имамо kursor_izdavaci, која од следећих декларација је исправна за променљиву која нам служи да у њу прочитамо један ред на који показује курсор? 

        
.. quizq::

    .. mchoice:: Pitanje_8_8g
        :answer_a: затварање курсора, отварање курсора, читање ред по ред, провера да ли се стигло до краја
        :answer_b: отварање курсора, затварање курсора, читање ред по ред, провера да ли се стигло до краја
        :answer_c: читање ред по ред, отварање курсора, провера да ли се стигло до краја, затварање курсора 
        :answer_d: читање ред по ред, отварање курсора, провера да ли се стигло до краја, затварање курсора 
        :correct: b

        Који је исправан редослед корака?
        
        
.. quizq::

    .. mchoice:: Pitanje_8_8i
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Следећи курсор има параметар.
        
            CURSOR kursor_autori IS select ime, prezime FROM autori; 

        
.. quizq::

    .. mchoice:: Pitanje_8_8j
        :answer_a: Приказати све књиге издавача СЕТ.
        :answer_b: Приказати све позајмице члана Оливере Стошић. 
        :answer_c: Приказати све позајмице члана чије се име и презиме уноси са тастатуре. 
        :answer_d: Приказати све позајмице књига издавача СЕТ.
        :correct: c

        За који од следећих задатака морамо да употребимо курсор са параметром?
                                                                        