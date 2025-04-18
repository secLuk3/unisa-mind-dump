CREATE SCHEMA gestionecentrisportivi;
USE  gestionecentrisportivi;

CREATE TABLE centro
(
  Nome VARCHAR(30) NOT NULL,
  Citta VARCHAR(20) NOT NULL,
  Via VARCHAR(20) NOT NULL,
  Cap INT NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  Fax VARCHAR(15) NOT NULL,
  PRIMARY KEY (NOME)
);

CREATE TABLE responsabile
(
  Cf VARCHAR(16) NOT NULL,
  Nome VARCHAR(20) NOT NULL,
  Cognome VARCHAR(20) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  TipoContratto VARCHAR(30) NOT NULL,
  PRIMARY KEY (Cf)
);

CREATE TABLE direzione
(
  CfResponsabile VARCHAR(16) NOT NULL,
  NomeCentro VARCHAR(30) NOT NULL,
  FOREIGN KEY(CfResponsabile) REFERENCES responsabile(Cf)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(NomeCentro) REFERENCES centro(Nome)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(CfResponsabile,NomeCentro)
);

CREATE TABLE struttura
(
  Codice INT NOT NULL,
  NomeCentro VARCHAR(30) NOT NULL,
  Area INT NOT NULL,
  Tipo VARCHAR(20) NOT NULL,
  TipoCampo VARCHAR(15),
  Attrezzatura BIT,
  FOREIGN KEY(NomeCentro) REFERENCES centro(Nome)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(Codice,NomeCentro)
);

CREATE TABLE	segretario
(
  Cf VARCHAR(16) NOT NULL,
  Nome VARCHAR(20) NOT NULL,
  Cognome VARCHAR(20) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  TipoContratto VARCHAR(30) NOT NULL,
  PRIMARY KEY (Cf)
);

CREATE TABLE prenotazione
(
  CodiceStruttura INT NOT NULL,
  NomeCentro VARCHAR(30) NOT NULL,
  CfSegretario VARCHAR(16) NOT NULL,
  Data DATE NOT NULL,
  Ora TIME NOT NULL,
  FOREIGN KEY(CodiceStruttura) REFERENCES struttura(Codice)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(NomeCentro) REFERENCES struttura(NomeCentro)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(CfSegretario) REFERENCES segretario(Cf)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(CodiceStruttura,NomeCentro,CfSegretario)
);

CREATE TABLE attivita
(
  Codice INT NOT NULL,
  Descrizione VARCHAR(50),
  PRIMARY KEY(Codice)
);

CREATE TABLE pianificazione
(
  NomeCentro VARCHAR(30) NOT NULL,
  CodiceAttivita INT NOT NULL,
  FOREIGN KEY(NomeCentro) REFERENCES centro(Nome)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(CodiceAttivita) REFERENCES attivita(Codice)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(NomeCentro,CodiceAttivita)
);

CREATE TABLE svolgimento
(
  CodiceAttivita INT NOT NULL,
  NomeCentro VARCHAR(30) NOT NULL,
  CodiceStruttura Int NOT NULL,
  Data DATE NOT NULL,
  Ora TIME NOT NULL,
  Durata TIME NOT NULL,
  FOREIGN KEY(CodiceAttivita) REFERENCES attivita(Codice)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(NomeCentro) REFERENCES struttura(NomeCentro)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(CodiceStruttura) REFERENCES struttura(Codice)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(CodiceAttivita,NomeCentro,CodiceStruttura)
);

CREATE TABLE corso
(
  CodiceAttivita INT NOT NULL,
  Periodicita VARCHAR(30) NOT	 NULL,
  Durata TIME NOT NULL,
  FOREIGN KEY(CodiceAttivita) REFERENCES attivita(Codice)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(CodiceAttivita)

);

CREATE TABLE allenatore
(
  Cf VARCHAR(16) NOT NULL,
  Nome VARCHAR(20) NOT NULL,
  Cognome VARCHAR(20) NOT NULL,
  Telefono VARCHAR(15) NOT NULL,
  TipoContratto VARCHAR(30) NOT NULL,
  AnniEsperienza INT NOT NULL,
  TipoAllenatore VARCHAR(30) NOT NULL,
  DocumentoSpecializzazione VARCHAR(40),
  TipoSpecializzazione VARCHAR(40),
  PRIMARY KEY(Cf)
);

CREATE TABLE coinvolgimento
(
  CfAllenatore VARCHAR(16) NOT NULL,
  CodiceAttivita INT NOT NULL,
  FOREIGN KEY(CfAllenatore) REFERENCES allenatore(Cf)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  FOREIGN KEY(CodiceAttivita) REFERENCES corso(CodiceAttivita)
  ON UPDATE CASCADE
  ON DELETE CASCADE,
  PRIMARY KEY(CfAllenatore,CodiceAttivita)
);
