Процедуре и функције са упитом SELECT - квиз
============================================

.. quizq::

    .. mchoice:: Pitanje_5_1_8a
        :answer_a: Приказује податке о издавачу за књигу датог назива. 
        :answer_b: Приказује податке о издавачу за књигу датог идентификационог броја.
        :answer_c: Приказује податке о примерцима за књигу датог назива. 
        :answer_d: Приказује податке о примерцима за књигу датог идентификационог броја.
        :correct: d

        Шта ради следећа процедура?

        ::

            CREATE PROCEDURE svi_primerci_knjige @id_knjige INT
            AS SELECT inventarski_broj FROM primerci WHERE id_knjige = @id_knjige;


.. quizq::

    .. mchoice:: Pitanje_5_1_8b
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Уколико желимо да прођемо појединачно ред по ред кроз више редова које враћа неки упит, неопходно је да користимо курсор? 
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8c
        :answer_a: DECLARE kursor_knjige FOR SELECT naziv FROM knjige;
        :answer_b: DECLARE kursor_knjige FOR naziv FROM knjige; 
        :answer_c: DECLARE CURSOR kursor_knjige FOR SELECT naziv FROM knjige; 
        :answer_d: DECLARE kursor_knjige CURSOR FOR SELECT naziv FROM knjige; 
        :correct: d

        Шта је од следећег исправна декларација курсора? 
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8d
        :answer_a: 1
        :answer_b: 2
        :answer_c: 3
        :answer_d: нема ограничења
        :correct: d

        Колико највише курсора можемо да употребимо у неком програму? 
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8e
        :answer_a: Курсор се отвори, покушамо читање једног реда, у циклусу се помоћу курсора чита један по један ред, курсор се затвори 
        :answer_b: Курсор се отвори, курсор се затвори, покушамо читање једног реда, у циклусу се помоћу курсора чита један по један ред.
        :answer_c:  Покушамо читање једног реда, курсор се отвори, у циклусу се помоћу курсора чита један по један ред, курсор се затвори.
        :answer_d: Курсор се отвори, у циклусу се помоћу курсора чита један по један ред, курсор се затвори, покушамо читање једног реда.
        :correct: a

        Који је исправан редослед корака?
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8f
        :answer_a: WHILE @@READ_STATUS != 0  
        :answer_b: WHILE @@READ_STATUS = 0   
        :answer_c: WHILE @@FETCH_STATUS != 0    
        :answer_d: WHILE @@FETCH_STATUS = 0  
        :correct: d

        Како изгледа циклус у којем проверавамо да ли је читање било успешно и да ли настављамо да читамо ред по ред док се не прочитају сви редови резултата одговарајућег SELECT упита?
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8g
        :answer_a: Да
        :answer_b: Не
        :correct: a

        За разлику од процедуре, када креирамо функцију, морамо да додамо RETURNS и тип података који функција враћа непосредно пре речи AS и тела функције?
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8h
        :answer_a: Database Diagrams  
        :answer_b: Tables  
        :answer_c: Programmability 
        :answer_d: Storage  
        :correct: c

        Када креирамо процедуре и функције, оне се појаве у прозору Object Explorer у оквиру одговарајуће базе података у групи са називом:
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8i
        :answer_a: Да
        :answer_b: Не 
        :correct: b

        Функцију позивамо као и процедуру навођењем EXEC. 
        
.. quizq::

    .. mchoice:: Pitanje_5_1_8j
        :answer_a: Да
        :answer_b: Не 
        :correct: a


        Креиране функције и процедуре можемо да користимо у другим програмима које креирамо. 