РЕЛАЦИОНЕ БАЗЕ ПОДАТАКА - КВИЗ
==============================

.. quizq::

    .. mchoice:: Pitanje_1_2_1
        :answer_a: Да
        :answer_b: Не
        :correct: a

        База података је појам који у рачунарству користимо да назовемо систем који најчешће има велики број корисника, а служи за ефикасно и сигурно чување и обраду података.

.. quizq::
    
    .. mchoice:: Pitanje_1_2_2
        :answer_a: ucenici, roditelji, automobili, proizvodi
        :answer_b: ucenici, nastavnici, predmeti, ocene, casovi
        :answer_c: nastavnici, kuvari, vaspitaci, pisci, novinari
        :answer_d: nastavnici, racunari, misevi, mikrofoni, zvucnici
        :correct: b

        Неке од добрих табела за базу података школе су:

.. quizq::

    .. mchoice:: Pitanje_1_2_3
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Приликом пројектовања предвидимо ентитет за сваку табелу коју ћемо имати у релационој бази података. Атрибути тог ентитета ће бити колоне табеле у бази.

.. quizq::

    .. mchoice:: Pitanje_1_2_4
        :answer_a: CREATE TABLE – унос података, INSERT INTO – креирање табеле
        :answer_b: CREATE TABLE – брисање података, INSERT INTO – брисање табеле
        :answer_c: CREATE TABLE – брисање табеле, INSERT INTO – брисање података
        :answer_d: CREATE TABLE – креирање табеле, INSERT INTO – унос података
        :correct: d

        Који списак садржи тачан опис команди?

.. quizq::

    .. mchoice:: Pitanje_1_2_5
        :answer_a: INT, NOT NULL
        :answer_b: INT, UNIQUE
        :answer_c: INT, VARCHAR 
        :answer_d: NOT NULL, UNIQUE 
        :correct: c

        Који списак садржи типове података које колона може да има у табели?

.. quizq:: 

    .. mchoice:: Pitanje_1_2_6
        :answer_a: INT, NOT NULL
        :answer_b: INT, UNIQUE
        :answer_c: INT, VARCHAR
        :answer_d: NOT NULL, UNIQUE
        :correct: d

        Који списак садржи ограничења која можемо да доделимо колонама у табели?

.. quizq::

    .. mchoice:: Pitanje_1_2_7
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Ограничење PRIMERY KEY покрива или NOT NULL или UNIQUE, али не мора оба. 

.. quizq::

    .. mchoice:: Pitanje_1_2_8
        :answer_a: naziv VARCHAR(40) 
        :answer_b: naziv VARCHAR(40) NOT NULL UNIQUE
        :answer_c: naziv VARCHAR(40) NOT NULL
        :answer_d: naziv VARCHAR(40) UNIQUE 
        :correct: b

        Уколико назив издавача, текстуални податак, мора да се унесе и два издавача не могу да имају исти назив, за дефиницију одговарајуће колоне морамо да напишемо:

.. quizq::

    .. mchoice:: Pitanje_1_2_9
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Добро је правило да назив, који мора да се унесе и мора да буде јединствен буде примарни кључ. 

.. quizq::

    .. mchoice:: Pitanje_1_2_10
        :answer_a: INSERT INTO autori VALUES (105, 'Vidojkovic')
        :answer_b: INSERT INTO autori VALUES (105, 102, 'Vidojkovic')
        :answer_c: INSERT INTO autori VALUES (105, 'Marko', 'Vidojkovic')
        :answer_d: INSERT INTO autori VALUES
        :correct: c 

        Уколико табела autori има три колоне (id, ime, prezime) која команда за унос података је исправна?