Упит SELECT из једне табеле - квиз
==================================

.. quizq::

    .. mchoice:: Pitanje_1_1_3a
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Да ли је следећи упит исправан? 
        
        ::
            
            FROM clanovi SELECT ime, prezime ORDER BY ime

.. quizq::

    .. mchoice:: Pitanje_1_1_3b
        :answer_a: SELECT ime, prezime
        :answer_b: SELECT Ime autora, Prezime autora
        :answer_c: SELECT ime "Ime autora", prezime "Prezime autora" 
        :answer_d: SELECT "Ime autora" ime, "Prezime autora" prezime
        :correct: c

        Уколико треба да се прикажу име и презиме, али да у заглављима колона редом пише “Ime autora” и “Prezime autora”, потребно је да упит почне са:

.. quizq::

    .. mchoice:: Pitanje_1_1_3c
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Да ли ће подаци бити уређени абецедно након покретања следећег упита? 
        
        ::
            
            SELECT ime FROM autori

.. quizq::

    .. mchoice:: Pitanje_1_1_3d
        :answer_a: ORDER BY izdavaci.naziv DESC, knjige.naziv
        :answer_b: ORDER BY izdavaci.naziv, knjige.naziv DESC 
        :answer_c: ORDER BY knjige.naziv, izdavaci.naziv 
        :answer_d: ORDER BY knjige.naziv DESC, izdavaci.naziv
        :correct: b

        Уколико је потребно уредити податке по називу издавача, па опадајуће по називу књиге, потребно је на крај упита додати: 

.. quizq::

    .. mchoice:: Pitanje_1_1_3e
        :answer_a: WHEN inventarski_broj>12001
        :answer_b: WHEN inventarski_broj<12001
        :answer_c: WHERE inventarski_broj>12001
        :answer_d: WHERE inventarski_broj<12001 
        :correct: d

        Уколико је потребно да издвојимо инвентарске бројеве који су мањи од 12001, потребно је да упиту додамо:

.. quizq::

    .. mchoice:: Pitanje_1_1_3f
        :answer_a: Да
        :answer_b: Не
        :correct: b

        Да ли следећи упит враћа више редова (id је примарни кључ)? 
        
        ::
            
            SELECT * FROM izdavaci WHERE id=4

.. quizq::

    .. mchoice:: Pitanje_1_1_3g
        :answer_a: WHERE ime LIKE 'S%' 
        :answer_b: WHERE ime LIKE "S%"
        :answer_c: WHERE ime = 'S%'
        :answer_d: WHERE ime LIKE "S" 
        :correct: a

        Уколико је потребно да издвојимо ауторе чије име почиње словом С, потребно је да упиту додамо:
.. quizq::

    .. mchoice:: Pitanje_1_1_3h
        :answer_a: WHERE adresa = NULL
        :answer_b: WHERE adresa <> NULL
        :answer_c: WHERE adresa IS NULL
        :answer_d:  WHERE adresa IS NOT NULL 
        :correct: d

        Колона adresa може да има NULL вредности, тј. адреса не мора да се унесе. Уколико хоћемо да издвојимо само оне адресе које су унете у базу, потребно је да упиту додамо:

.. quizq::

    .. mchoice:: Pitanje_1_1_3i
        :answer_a: Да
        :answer_b: Не
        :correct: a

        Следећи упит може да врати више редова (id_izdavaca је страни кључ)? 
        ::
            
            SELECT * FROM knjige WHERE id_izdavaca=1

.. quizq::

    .. mchoice:: Pitanje_1_1_3j
        :answer_a: Да
        :answer_b: Не
        :correct: a
    
        Следећа два упита враћају исти резултат уколико је колона *id* примарни кључ.
        ::
            
            SELECT * FROM izdavaci 
            SELECT * FROM izdavaci WHERE id IS NOT NULL

