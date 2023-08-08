Језик PL/SQL – квиз
===================

.. quizq::

    .. mchoice:: Pitanje_6_3a
        :answer_a: Програмски језик PL/SQL је процедурални језик у СУБП-а компаније Oracle.
        :answer_b: Програмски језик PL/SQL је проширење упитног језика SQL.
        :answer_c: Програмски језик PL/SQL је осетљив на мала и велика слова. 
        :answer_d: У програму који је писан у језику PL/SQL можемо да креирамо променљиве
        :correct: c

        Koja реченица је нетачна?

.. quizq::

    .. mchoice:: Pitanje_6_3b
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Програм написан у језику PL/SQL мора да има део за декларацију DECLARE.

.. quizq::

    .. mchoice:: Pitanje_6_3c
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Да ли је следећа декларација исправна? DECLARE test INT


.. quizq::

    .. mchoice:: Pitanje_6_3d
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Резервисане речи могу да се користе као називи променљивих. 

.. quizq::

    .. mchoice:: Pitanje_6_3e
        :answer_a: Блок нема део за декларацију DECLARE.
        :answer_b: Блок нема део за обраду изузетака EXCEPTION.
        :answer_c: Блок нема ознаку за крај END. 
        :answer_d: Ништа није погрешно, овај програм је исправан.  
        :correct: c

        Шта је грешка у следећем програму због које програм неће радити? 
    
        BEGIN 

        DBMS_OUTPUT.PUT_LINE('Dobar dan'); 
        
        DBMS_OUTPUT.PUT_LINE(' i dovidjenja');



.. quizq::

    .. mchoice:: Pitanje_6_3f
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Коментари утичу на извршавање програма и могу да узрокују грешку. 


.. quizq::

    .. mchoice:: Pitanje_6_3g
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Функције из језика SQL, као што су UPPER или SUBSTR, могу да се користе у PL/SQL програмима. 


.. quizq::

    .. mchoice:: Pitanje_6_3h
        :answer_a: := 
        :answer_b: :== 
        :answer_c: =
        :answer_d: == 
        :correct: a

        Наредба доделе је:


.. quizq::

    .. mchoice:: Pitanje_6_3i
        :answer_a: null 
        :answer_b: 9
        :answer_c: 7
        :answer_d: 14
        :correct: a

        Која је коначна вредност променљиве of v_promenljiva? 

        DECLARE 

        v_promenljiva NUMBER; 

        BEGIN 

        v_promenljiva := v_promenljiva * 2; 

        END

.. quizq::

    .. mchoice:: Pitanje_6_3j
        :answer_a: null
        :answer_b: 9 
        :answer_c: 7
        :answer_d: 14
        :correct: d

        Која је коначна вредност променљиве of v_promenljiva?

        DECLARE 

        v_promenljiva NUMBER; 

        BEGIN 

        v_promenljiva := 1 + 2 * 3; 

        v_promenljiva := v_promenljiva * 2; 

        END



