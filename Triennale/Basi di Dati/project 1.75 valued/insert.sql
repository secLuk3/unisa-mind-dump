INSERT INTO Centro(Nome, Citta, Telefono, Via, Cap, Fax)
VALUES("Gold Gym", "Roma", "3242222222", "Via Forza,6 ", "84323", "232133123");

INSERT INTO Centro(Nome, Citta, Telefono, Via, Cap, Fax)
VALUES("Atletic Sport Center", "Sala Consilina", "097591786", "Via Roma, 8 ", "84037", "097523541");

INSERT INTO Centro(Nome, Citta, Telefono, Via, Cap, Fax)
VALUES("Verdi's Fitness Center", "Napoli", "097356431", "Via Verdi , 6 ", "84923", "097391456");


INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("1", "Atletic Sport Center", "Campo", "All'aperto", "" , "134.56");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("2", "Atletic Sport Center", "Sala", "", 1 , "150");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("3", "Verdi's Fitness Center", "Sala", "", 0 , "674.56");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("4", "Atletic Sport Center", "Sala", "", 1 , "234.56");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("5", "Atletic Sport Center", "Campo", "Al chiuso", "" , "894.56");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("6", "Verdi's Fitness Center", "Campo", "Al chiuso", "" , "324.56");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("7", "Gold Gym", "Campo", "Al chiuso", 1 , "1653");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("8", "Gold Gym", "Campo", "All` aperto", "" , "1000");

INSERT INTO Struttura(Codice, NomeCentro, Tipo, TipoCampo, Attrezzatura, Area)
VALUES("9", "Gold Gym", "Sala", "Al chiuso", 1 , "678");


INSERT INTO Attivita(Codice, Descrizione)
VALUES("1111", "Scherma");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("2222", "Basket");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("3333", "Calcio");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("4444", "Ginnastica Correttiva");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("5555", "Nuoto");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("6666", "Karate");

INSERT INTO Attivita(Codice, Descrizione)
VALUES("7777", "calcetto");

INSERT INTO Responsabile(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("RSSVLNT46","Valentino", "Rossi", "Tempo indeterminato" , "3463560976");

INSERT INTO Responsabile(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("GBLDGSPP12","Giuseppe", "Garibaldi", "Tempo determinato" , "3463576074" );

INSERT INTO Responsabile(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("NZRRNLD9","Ronaldo ", "Nazario de Lima ", "Tempo indeterminato" , "3463546950");

INSERT INTO Responsabile(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("MRDNDGRDO10","Diego Armando", "Maradona", "Tempo indeterminato" ,"3463457239");


INSERT INTO Segretario(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("ANGLALBT75","Alberto", "Angela", "Tempo determinato" , "3463568054");

INSERT INTO Segretario(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("CR7RNDL","Cristiano", "Ronaldo", "Tempo indeterminato", "3453487456");

INSERT INTO Segretario(Cf, Nome, Cognome, TipoContratto , Telefono)
VALUES("LWSHMLT44","Lewis", "Hamilton", "Tempo indeterminato" , "3463568074");

INSERT INTO Segretario(Cf, Nome, Cognome, TipoContratto, Telefono )
VALUES("CBNKRT87","Kurt", "Cobain", "Tempo determinato" , "3463568074");

INSERT INTO allenatore(Cf, Nome, Cognome, TipoContratto, AnniEsperienza, TipoAllenatore, DocumentoSpecializzazione , Telefono)
VALUES("CNTANT74","Antonio", "Conte", "Tempo indeterminato", "6", "Allenatore Calcistico", "" , "345740203");

INSERT INTO allenatore(Cf, Nome, Cognome, TipoContratto, AnniEsperienza, TipoAllenatore, DocumentoSpecializzazione , Telefono)
VALUES("BFFFDRC76","Federico ", "Buffa", "Tempo indeterminato", "30", "Allenatore Basket", "" , "3402367389");

INSERT INTO allenatore(Cf, Nome, Cognome, TipoContratto, AnniEsperienza, TipoAllenatore, DocumentoSpecializzazione , Telefono )
VALUES("SRRMRZ85","Maurizio", "Sarri", "Tempo determinato", "2", "", "", "3463512367" );

INSERT INTO allenatore(Cf, Nome, Cognome, TipoContratto, AnniEsperienza, TipoAllenatore, DocumentoSpecializzazione , Telefono)
VALUES("ANCLTTCRL23","Carlo", "Ancelotti", "Tempo indeterminato", "15", "Ginnastica Correttiva", "Laurea Scienze Motorie" , "346356086");

INSERT INTO allenatore(Cf, Nome, Cognome, TipoContratto, AnniEsperienza, TipoAllenatore, DocumentoSpecializzazione , Telefono)
VALUES("SMNNZG04","Simone", "Inzaghi", "Tempo indeterminato", "9", "Nuoto", "" , "3463523613");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("3333", "01:30:00", "3/settimana");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("4444", "02:30:00", "5/settimana");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("2222", "02:00:00", "2/settimana");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("1111", "04:30:00", "1/settimana");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("7777", "01:00:00", "3/settimana");

INSERT INTO Corso(CodiceAttivita, Durata, Periodicita)
VALUES("5555", "02:30:00", "2/settimana");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("CNTANT74", "3333");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("BFFFDRC76", "2222");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("ANCLTTCRL23", "4444");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("SRRMRZ85", "1111");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("SMNNZG04", "5555");

INSERT INTO Coinvolgimento(CfAllenatore, CodiceAttivita)
VALUES("CNTANT74", "7777");

INSERT INTO Direzione(CfResponsabile, NomeCentro)
VALUES("RSSVLNT46", "Gold Gym");

INSERT INTO Direzione(CfResponsabile, NomeCentro)
VALUES("NZRRNLD9", "Atletic Sport Center");

INSERT INTO Direzione(CfResponsabile, NomeCentro)
VALUES("MRDNDGRDO10", "Gold Gym");

INSERT INTO Direzione(CfResponsabile, NomeCentro)
VALUES("MRDNDGRDO10", "Atletic Sport Center");

INSERT INTO Direzione(CfResponsabile, NomeCentro)
VALUES("GBLDGSPP12", "Verdi's Fitness Center");

INSERT INTO Pianificazione(CodiceAttivita, NomeCentro)
VALUES("2222", "Verdi's Fitness Center" );

INSERT INTO Pianificazione(CodiceAttivita, NomeCentro)
VALUES("5555", "Atletic Sport Center" );

INSERT INTO Pianificazione(CodiceAttivita, NomeCentro)
VALUES("6666", "Atletic Sport Center" );

INSERT INTO Pianificazione(CodiceAttivita, NomeCentro)
VALUES("7777", "Gold Gym" );

INSERT INTO Pianificazione(CodiceAttivita, NomeCentro)
VALUES("1111", "Gold Gym" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("CR7RNDL", "2", "Atletic Sport Center", "20:30:00","2019-11-20" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("CR7RNDL", "7", "Gold Gym", "15:30:00","2019-08-20" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("ANGLALBT75", "8", "Gold Gym", "18:45:00","2019-04-01" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("ANGLALBT75", "3", "Verdi's Fitness Center", "13:30:00", "2019-11-22" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("CBNKRT87", "3", "Verdi's Fitness Center", "22:30:00","2019-10-25" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data )
VALUES("CBNKRT87", "4", "Atletic Sport Center", "19:10:00","2019-06-06" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data )
VALUES("LWSHMLT44", "6", "Verdi's Fitness Center", "17:15:00","2018-11-15" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data )
VALUES("LWSHMLT44", "1", "Atletic Sport Center", "09:0:00","2019-05-13" );

INSERT INTO Prenotazione(CfSegretario, CodiceStruttura, NomeCentro, Ora, Data)
VALUES("CR7RNDL", "4", "Atletic Sport Center", "21:30:00","2018-02-26" );

INSERT INTO Svolgimento(CodiceStruttura, NomeCentro, CodiceAttivita, Ora, Data, Durata)
VALUES("4", "Atletic Sport Center", "3333", "15:30:00", "2019-11-16", "01:30:00" );

INSERT INTO Svolgimento(CodiceStruttura, NomeCentro, CodiceAttivita, Ora, Data, Durata)
VALUES("3", "Verdi's Fitness Center", "5555", "12:30:00", "2019-08-16", "02:30:00"  );

INSERT INTO Svolgimento(CodiceStruttura, NomeCentro, CodiceAttivita, Ora, Data, Durata)
VALUES("6", "Verdi's Fitness Center", "7777", "11:30:00", "2019-11-13", "01:30:00"  );

INSERT INTO Svolgimento(CodiceStruttura, NomeCentro, CodiceAttivita, Ora, Data, Durata)
VALUES("7", "Gold Gym", "6666", "16:00:00", "2019-04-10", "03:00:00"  );
