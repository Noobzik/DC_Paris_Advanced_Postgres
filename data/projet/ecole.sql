-- Drop foreign key constraints before deleting tables
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'resultats') THEN
        ALTER TABLE resultats DROP CONSTRAINT IF EXISTS fk_resultats_eleves;
        ALTER TABLE resultats DROP CONSTRAINT IF EXISTS fk_resultats_cours;
    END IF;
END $$;

-- Drop tables if they exist
DO $$
BEGIN
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'activites_pratiquees') THEN
        DROP TABLE activites_pratiquees;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'charge') THEN
        DROP TABLE charge;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'resultats') THEN
        DROP TABLE resultats;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'activites') THEN
        DROP TABLE activites;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'professeurs') THEN
        DROP TABLE professeurs;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'cours') THEN
        DROP TABLE cours;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'eleves') THEN
        DROP TABLE eleves;
    END IF;
    IF EXISTS (SELECT 1 FROM information_schema.tables WHERE table_name = 'agglomeration') THEN
        DROP TABLE agglomeration;
    END IF;
END $$;

-- =========================================
-- Create tables for the ELEVE database
-- =========================================

-- Table : ELEVES
CREATE TABLE eleves
(
    num_eleve       INT PRIMARY KEY,
    nom             VARCHAR(25) NOT NULL,
    prenom          VARCHAR(25) NOT NULL,
    date_naissance  DATE,
    poids           INT,
    annee           INT,
    sexe            CHAR(1),
    CONSTRAINT nn_eleve_nom CHECK(nom IS NOT NULL),
    CONSTRAINT nn_eleve_prenom CHECK(prenom IS NOT NULL)
);

-- Table : COURS
CREATE TABLE cours
(
    num_cours       INT PRIMARY KEY,
    nom             VARCHAR(20) NOT NULL,
    nbheures        INT,
    annee           INT,
    CONSTRAINT nn_cours_nom CHECK(nom IS NOT NULL)
);

-- Table : PROFESSEURS
CREATE TABLE professeurs
(
    num_prof        INT PRIMARY KEY,
    nom             VARCHAR(25) NOT NULL,
    specialite      VARCHAR(20),
    date_entree     DATE,
    der_prom        DATE,
    salaire_base    INT,
    salaire_actuel  INT,
    CONSTRAINT nn_professeurs_nom CHECK(nom IS NOT NULL)
);

-- Table : ACTIVITES
CREATE TABLE activites
(
    niveau          INT,
    nom             VARCHAR(20),
    equipe          VARCHAR(32),
    PRIMARY KEY(niveau, nom)
);

-- Table : RESULTATS
CREATE TABLE resultats
(
    num_eleve       INT,
    num_cours       INT,
    points          INT,
    PRIMARY KEY(num_eleve, num_cours),
    FOREIGN KEY (num_eleve) REFERENCES eleves(num_eleve),
    FOREIGN KEY (num_cours) REFERENCES cours(num_cours)
);

-- Table : CHARGE
CREATE TABLE charge
(
    num_prof       INT NOT NULL,
    num_cours      INT NOT NULL,
    PRIMARY KEY(num_cours, num_prof),
    FOREIGN KEY (num_prof) REFERENCES professeurs(num_prof),
    FOREIGN KEY (num_cours) REFERENCES cours(num_cours)
);

-- Table : ACTIVITES_PRATIQUEES
CREATE TABLE activites_pratiquees
(
    num_eleve       INT,
    niveau          INT,
    nom             VARCHAR(20),
    PRIMARY KEY(num_eleve, niveau, nom),
    FOREIGN KEY (num_eleve) REFERENCES eleves(num_eleve),
    FOREIGN KEY (niveau, nom) REFERENCES activites(niveau, nom)
);

-- Insertion

INSERT INTO eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (1, 'Brisefer', 'Benoit', TO_DATE('10-12-1978', 'DD-MM-YYYY'), 35, 1, 'M');

INSERT INTO eleves (Num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (2, 'Génial', 'Olivier', TO_DATE('10-04-1978', 'DD-MM-YYYY'), 42, 1, 'M');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (3, 'Jourdan', 'Gil', TO_DATE('28-06-1974', 'DD-MM-YYYY'), 72, 2, 'F');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (4, 'Spring', 'Jerry', TO_DATE('16-02-1974', 'DD-MM-YYYY'), 78, 2, 'M');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (5, 'Tsuno', 'Yoko', TO_DATE('29-10-1977', 'DD-MM-YYYY'), 45, 1, 'F');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (6, 'Lebut', 'Marc', TO_DATE('29-04-1974', 'DD-MM-YYYY'), 75, 2, 'M');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (7, 'Lagaffe', 'Gaston', TO_DATE('08-04-1975', 'DD-MM-YYYY'), 61, 1, 'M');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (8, 'Dubois', 'Robin', TO_DATE('20-04-1976', 'DD-MM-YYYY'), 60, 2, 'M');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (9, 'Walthéry', 'Natacha', TO_DATE('07-09-1977', 'DD-MM-YYYY'), 59, 1, 'F');

INSERT INTO eleves (num_eleve, nom, prenom, date_naissance, Poids, annee, sexe)
VALUES (10, 'Danny', 'Buck', TO_DATE('15-02-1973', 'DD-MM-YYYY'), 82, 2, 'M');


Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (1, 'Réseau', 15, 1);

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (2, 'Sgbd', 30, 1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (3, 'Programmation', 15,1) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (4, 'Sgbd', 30,2 ) ;

Insert into cours (Num_cours, Nom, Nbheures, annee)
Values (5, 'Analyse', 60,2) ;


INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (1, 'Bottle', 'poésie', TO_DATE('01-10-1970', 'DD-MM-YYYY'), TO_DATE('01-10-1988', 'DD-MM-YYYY'), 2000000, 2600000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (2, 'Bolenov', 'réseau', TO_DATE('15-11-1968', 'DD-MM-YYYY'), TO_DATE('01-10-1998', 'DD-MM-YYYY'), 1900000, 2468000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (3, 'Tonilaclasse', 'poo', TO_DATE('01-10-1979', 'DD-MM-YYYY'), TO_DATE('01-01-1989', 'DD-MM-YYYY'), 1900000, 2360000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (4, 'Pastecnov', 'sql', TO_DATE('01-10-1975', 'DD-MM-YYYY'), NULL, 2500000, 2500000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (5, 'Selector', 'sql', TO_DATE('15-10-1982', 'DD-MM-YYYY'), TO_DATE('01-10-1988', 'DD-MM-YYYY'), 1900000, 1900000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (6, 'Vilplusplus', 'poo', TO_DATE('25-04-1990', 'DD-MM-YYYY'), TO_DATE('05-06-1994', 'DD-MM-YYYY'), 1900000, 2200000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (7, 'Francesca', '', TO_DATE('01-10-1975', 'DD-MM-YYYY'), TO_DATE('11-01-1998', 'DD-MM-YYYY'), 2000000, 3200000);

INSERT INTO PROFESSEURS (Num_prof, nom, specialite, Date_entree, Der_prom, Salaire_base, Salaire_actuel)
VALUES (8, 'Pucette', 'sql', TO_DATE('06-12-1988', 'DD-MM-YYYY'), TO_DATE('29-02-1996', 'DD-MM-YYYY'), 2000000, 2500000);

Insert into CHARGE (Num_prof, Num_cours)
Values(1,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(1,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(2,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(3,5) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(4,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(7,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,1) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,2) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,3) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,4) ;

Insert into CHARGE (Num_prof, Num_cours)
Values(8,5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1,1, 15 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1,2 ,10.5 ) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1, 4, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(1, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 1, 13.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 2, 12) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(2, 5, 1.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 1, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 2, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(3, 5, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 1, 16.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 2, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(4, 5, 8) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 1, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 2, 6.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 4, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(5, 5, 13) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 1, 15) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 2, 3.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 4, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(6, 5, 5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 1, 2.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 2, 18) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 4, 11) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(7, 5, 10) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 1, 16) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 2, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 4, 6) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(8, 5, 11.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 1, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 2, 20) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 4, 14) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(9, 5, 9.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 1, 3) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 2, 12.5) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 4, 0) ;

Insert into RESULTATS (Num_eleve, Num_cours, points)
Values(10, 5, 16) ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Mini foot','Amc Indus') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
values (1,'Surf','Les planchistes ...') ;


Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(3,'Tennis','Ace Club') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(1,'Volley ball', 'Avs80') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Mini foot', 'Les as du ballon') ;

Insert into ACTIVITES (Niveau, Nom, equipe)
Values(2,'Volley ball', 'smash') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (1, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (2, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (3, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (4, 2, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Surf') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (5, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 1, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (8, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (9, 2, 'Volley ball') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 1, 'Mini foot') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Tennis') ;

Insert into ACTIVITES_PRATIQUEES (Num_eleve, Niveau, Nom)
Values (10, 2, 'Volley ball') ;