Упит SELECT са спајањем табела - квиз
=====================================

.. quizq::

    .. mchoice:: Pitanje_1_1_7a
        :answer_a: SELECT
        :answer_b: FROM 
        :answer_c: WHERE 
        :answer_d: ORDER BY 
        :correct: b

        Табеле из којих узимамо податке се набрајају у _______ делу упита SELECT.

.. quizq::

    .. mchoice:: Pitanje_1_1_7b
        :answer_a: Да
        :answer_b: Не 
        :correct: a

        Уколико у две табеле које спајамо постоје колоне које имају исти назив, неопходно је да испред назива колоне додамо назив табеле, на пример *primerci.id_knjige* и *knjige.id_knjige*.
.. quizq::

    .. mchoice:: Pitanje_1_1_7c
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Можемо да повежемо највише три табеле. 

.. quizq::

    .. mchoice:: Pitanje_1_1_7d
        :answer_a: 4
        :answer_b: 3
        :answer_c: 2
        :answer_d: 1
        :correct: c

        Колико речи JOIN треба да имамо уколико треба да повежемо три табеле

.. quizq::

    .. mchoice:: Pitanje_1_1_7e
        :answer_a: Да  
        :answer_b: Не
        :correct: a

        Уколико су нам потребни подаци из само две табеле које нису директно повезане, морамо да видимо преко којих других табела постоји веза између њих и да све те табеле правилно повежемо у WHERE делу упита. 

.. quizq:: 

    .. mchoice:: Pitanje_1_1_7f
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Редослед набрајања табела и кључева у услову спајања није важан тако да следећа два реда дају идентичан резултат:

        ::

            FROM izdavaci JOIN knjige ON (knjige.id_izdavaca=izdavaci.id)
            FROM knjige JOIN izdavaci ON (izdavaci.id=knjige.id_izdavaca) 

.. quizq::

    .. mchoice:: Pitanje_1_1_7g
        :answer_a: FROM knjige, izdavaci ON (knjige.id_izdavaca=izdavaci.id)
        :answer_b: FROM knjige JOIN izdavaci ON (knjige.id_izdavaca=izdavaci.id) 
        :answer_c: FROM knjige JOIN izdavaci ON (id_izdavaca.knjige=id.izdavaci)
        :answer_d: FROM knjige, izdavaci ON (id_izdavaca.knjige=id.izdavaci)
        :correct: b

        У табели *knjige* постоји страни кључ *id_izdavaca* који показује на примарни кључ, колону *id* табеле *izdavaci*. Како правилно изгледа спајање ове две табеле?

