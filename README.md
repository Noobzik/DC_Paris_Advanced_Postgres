# Sujet du projet rapide : Trigger et Fonctions stockés

## Une école !

## Consigne de rapport générale

Testez l'ensemble des commandes, documentez vos commandes avec les résultats en sortie.
Le rendu attendu est un fichier Markdown.

### Contraintes

Lien vers le fichier SQL en question : ecole.sql (postgres.sql)

Context : Vous avez en votre possession une base de donnée qui simule le fonctionnement d'une école lambda. Prenez connaissance ce cette base de donnée et répondez aux questions suivantes. 

1. Essayez de modifier les tables pour ajouter les contraintes suivantes en SQL : 

    * La note d'un étudiant doit être comprise entre 0 et 20.
    * Le sexe d'un étudiant doit être dans la liste: 'm', 'M', 'f', 'F' ou Null.
    * Contrainte horizontale : Le salaire de base d’un professeur doit être inférieur au salaire actuel.
    * Contrainte verticale : Le salaire d'un professeur ne doit pas dépasser le double de la moyenne des salaires des enseignants de la même spécialité.


2. Que constatez-vous ?


### Triggers

1. Créez un trigger permettant de vérifier la contrainte : « Le salaire d'un Professeur ne peut pas diminuer ».
2. Gestion automatique de la redondance
    * Créez la table suivante : 
    ```sql= 
    CREATE TABLE PROF_SPECIALITE 
    (
        SPECIALITE VARCHAR(20), 
        NB_PROFESSEURS INTEGER
    );
    ```
    * Créez un trigger permettant de remplir et mettre à jour automatiquement cette table suite à chaque opération de MAJ (insertion, suppression, modification) sur la table des professeurs.
    * Testez le trigger sur des exemples de mise à jour.
3. Mise à jour en cascade : Créez un trigger qui met à jour la table CHARGE lorsqu’on supprime un professeur dans la table PROFESSEUR ou que l’on change son numéro.


### Sécurité : enregistrement des accès
* Créez la table audit_resultats :
```sql=
CREATE TABLE audit_resultats (
    utilisateur VARCHAR(50),
    date_maj DATE,
    desc_maj VARCHAR(20),
    num_eleve INT NOT NULL,
    num_cours INT NOT NULL,
    points INT
);
```

* Créez un trigger qui met à jours la table audit_resultats à chaque modification de la table `RÉSULTAT`. Il faut donner l’utilisateur qui a fait la modification `(USER)`, la date de la modification et une description de la modification `(‘INSERT’, ‘DELETE’, ‘NOUVEAU’, ‘ANCIEN’)`. Par exemple pour une insertion :
```sql=
INSERT INTO audit_resultats
VALUES (USER_NAME(), GETDATE(), 'INSERT', INSERTED.NUM_ELEVE, INSERTED.NUM_COURS, INSERTED.POINTS);
```

5. Confidentialité: On souhaite que seul l'utilisateur 'GrandChef' puisse augmenter les salaires des professeurs de plus de 20%. Le trigger doit retourner une erreur (No -20002) et le message 'Modification interdite' si la condition n’est pas respectée.

#### Fonctions et procédures
* Créez une fonction `fn_moyenne` calculant la moyenne d’un étudiant passé en paramètre.
* Créez une procédure `pr_resultat` permettant d’afficher la moyenne de chaque élève avec la mention adéquate : échec, passable, assez bien, bien, très bien.

#### Création de vue

Créez une vue sur une requête assez complexe de votre choix. (Attendu : Multiples aggrégations)

