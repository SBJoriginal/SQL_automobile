drop database IF EXISTS glo_2005_Projet_ConcessionnaireNouvelleAuto; #comme cela on peut run le fichier au complet sans dupliquer l'info

CREATE DATABASE IF NOT EXISTS glo_2005_Projet_ConcessionnaireNouvelleAuto;

USE glo_2005_Projet_ConcessionnaireNouvelleAuto;

CREATE TABLE IF NOT EXISTS Users
(
    id         int AUTO_INCREMENT,
    email  varchar(254)                 UNIQUE NOT NULL,
    passe  varchar(254)                     NOT NULL,
    first_name varchar(50)                      NOT NULL,
    last_name  varchar(50)                      NOT NULL,
    gender     enum ('Male', 'Female', 'Other') NOT NULL,
    birthdate  char(10),
    region     varchar(50),
    phone      varchar(25)                      NOT NULL,
    primary key (id)
);

CREATE TABLE IF NOT EXISTS Concessionnaire
(

    idConcessionnaire              integer NOT NULL AUTO_INCREMENT,
    nomConcessionnaire             varchar(100),
    adresseConcessionnaire         varchar(200) UNIQUE,
    numTelephoneConcessionnaire    varchar(15) UNIQUE,
    adresseCourrielConcessionnaire varchar(100) UNIQUE,
    siteWeb                        varchar(100) UNIQUE,
    PRIMARY KEY (idConcessionnaire)
);
ALTER TABLE Concessionnaire
    AUTO_INCREMENT = 100;

CREATE TABLE IF NOT EXISTS Employe
(
    idEmploye      integer NOT NULL AUTO_INCREMENT,
    prenomEmploye  varchar(100),
    nomEmploye     varchar(100),
    ageEmploye     integer,
    numCellEmploye varchar(15),
    numPoste       integer,
    titreEmploi    varchar(30),
    salaireAnnuel  integer,
    anciennete     integer,
    PRIMARY KEY (idEmploye)

);
ALTER TABLE Employe
    AUTO_INCREMENT = 10000;

CREATE TABLE IF NOT EXISTS Client
(
    idClient           integer NOT NULL AUTO_INCREMENT,
    prenomClient       varchar(100),
    nomClient          varchar(100),
    numTelephoneClient varchar(15),
    adresseClient      varchar(200),
    codePostaleClient  varchar(7),
    ageClient          integer,
    PRIMARY KEY (idClient)
);

ALTER TABLE Client
    AUTO_INCREMENT = 20000;

CREATE TABLE IF NOT EXISTS Automobile
(
    niv           varchar(17),
    marque        varchar(50),
    modele        varchar(50),
    annee         integer,
    couleur       varchar(50),
    odometre      integer,
    nbPlaces      integer,
    prixAuto      double,
    locationVente enum ('Location', 'Vente'),
    sousCategorie varchar(20),
    poidsAuto     integer,
    dateAuto      date,
    PRIMARY KEY (niv)
);

CREATE TABLE IF NOT EXISTS Pieces
(
    idPiece          integer NOT NULL,
    nomPiece         varchar(100),
    categorie        varchar(100),
    poidsPiece       double,
    descriptionPiece varchar(1000),
    prixPiece        double,
    datePiece        date,
    PRIMARY KEY (idPiece)
);

CREATE TABLE IF NOT EXISTS LavageAuto
(
    idLavage   integer NOT NULL AUTO_INCREMENT,
    typeLavage varchar(50),
    prixLavage double,
    niv        varchar(17),
    idClient   integer,
    idEmploye  integer,
    dateLavage date,
    PRIMARY KEY (idLavage),
    FOREIGN KEY (idClient)
        REFERENCES Client (idClient)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idEmploye)
        REFERENCES Employe (idEmploye)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (niv)
        REFERENCES automobile (niv)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
ALTER TABLE LavageAuto
    AUTO_INCREMENT = 30000;

CREATE TABLE IF NOT EXISTS Vente
(
    idVente          integer NOT NULL AUTO_INCREMENT,
    niv              varchar(17),
    idClient         integer,
    idEmploye        integer,
    dureeFinancement integer,
    tauxInteret      double,
    dateVente        date,
    PRIMARY KEY (idVente),
    FOREIGN KEY (niv)
        REFERENCES automobile (niv)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idClient)
        REFERENCES Client (idClient)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idEmploye)
        REFERENCES employe (idEmploye)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
ALTER TABLE Vente
    AUTO_INCREMENT = 40000;

CREATE TABLE IF NOT EXISTS Reparation
(
    idReparation   integer NOT NULL AUTO_INCREMENT,
    niv            varchar(17),
    idClient       integer,
    idEmploye      integer,
    idPiece        integer,
    tempsDeTravail integer, #heures
    coutReparation double,
    dateReparation date,
    PRIMARY KEY (idReparation),
    FOREIGN KEY (niv)
        REFERENCES automobile (niv)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idClient)
        REFERENCES Client (idClient)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idEmploye)
        REFERENCES employe (idEmploye)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idPiece)
        REFERENCES Pieces (idPiece)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
ALTER TABLE Reparation
    AUTO_INCREMENT = 50000;

CREATE TABLE IF NOT EXISTS Location
(
    idLocation    integer NOT NULL AUTO_INCREMENT,
    niv           varchar(17),
    idClient      integer,
    idEmploye     integer,
    dureeLocation integer,
    tauxInteret   double,
    dateLocation  date,
    PRIMARY KEY (idLocation),
    FOREIGN KEY (niv)
        REFERENCES automobile (niv)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idClient)
        REFERENCES Client (idClient)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (idEmploye)
        REFERENCES employe (idEmploye)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);
ALTER TABLE Location
    AUTO_INCREMENT = 60000;

CREATE TABLE IF NOT EXISTS FournisseursPieces
(
    idFournisseursPieces              integer NOT NULL AUTO_INCREMENT,
    nomFournisseursPieces             varchar(50),
    adresseFournisseursPieces         varchar(200),
    numTelephoneFournisseursPieces    varchar(15),
    adresseCourrielFournisseursPieces varchar(100),
    villeFournisseursPieces           varchar(100),
    provinceEtatFournisseursPieces    varchar(50),
    paysFournisseursPieces            varchar(50),
    PRIMARY KEY (idFournisseursPieces)
);
ALTER TABLE Fournisseurspieces
    AUTO_INCREMENT = 70000;

CREATE TABLE IF NOT EXISTS FournisseursAutomobiles
(
    idFournisseursVehicules              integer NOT NULL AUTO_INCREMENT,
    nomFournisseursVehicules             varchar(50),
    adresseFournisseursVehicules         varchar(200),
    numTelephoneFournisseursVehicules    varchar(15),
    adresseCourrielFournisseursVehicules varchar(100),
    villeFournisseursVehicules           varchar(100),
    provinceEtatFournisseursVehicules    varchar(50),
    paysFournisseursVehicules            varchar(50),
    PRIMARY KEY (idFournisseursVehicules)
);
ALTER TABLE FournisseursAutomobiles
    AUTO_INCREMENT = 80000;

CREATE TABLE IF NOT EXISTS FourniPieces
(
    idFournisseursPieces int,
    idPiece              int,
    FOREIGN KEY (idFournisseursPieces)
        REFERENCES FournisseursPieces (idFournisseursPieces)
        ON UPDATE CASCADE
        ON DELETE RESTRICT,
    FOREIGN KEY (idPiece)
        REFERENCES Pieces (idPiece)
        ON UPDATE CASCADE
        ON DELETE RESTRICT
);

CREATE TABLE IF NOT EXISTS FourniAutomobiles
(
    idFournisseursVehicules int,
    niv                     varchar(17),
    FOREIGN KEY (idFournisseursVehicules)
        REFERENCES FournisseursAutomobiles (idFournisseursVehicules)
        ON UPDATE CASCADE
        ON DELETE NO ACTION,
    FOREIGN KEY (niv)
        REFERENCES automobile (niv)
        ON UPDATE CASCADE
        ON DELETE NO ACTION
);

#intercepte un insert d'un numéro de telephone identique dans le tableau FournisseursAutomobiles
DELIMITER //
CREATE TRIGGER FournisseursAutomobilesDup
    BEFORE INSERT ON FournisseursAutomobiles
    FOR EACH ROW
    BEGIN
        IF (SELECT numTelephoneFournisseursVehicules
            FROM FournisseursAutomobiles
            WHERE numTelephoneFournisseursVehicules = NEW.numTelephoneFournisseursVehicules)
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Vous avez deja un fournisseur avec ce numero de telephone';
        end if ;
    end //

# intercepte un insert d'un numéro de telephone identique dans le tableau FournisseursPieces
DELIMITER //
CREATE TRIGGER FournisseursPiecesDup
    BEFORE INSERT ON FournisseursPieces
    FOR EACH ROW
    BEGIN
        IF (SELECT numTelephoneFournisseursPieces
            FROM FournisseursPieces
            WHERE numTelephoneFournisseursPieces = NEW.numTelephoneFournisseursPieces)
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Vous avez deja un fournisseur avec ce numero de telephone';
        end if ;
    end //

# #gachette pour s'assurer de ne pas commander une piece si il y en a au moins 3 encore en stock
# DROP TRIGGER IF EXISTS MaximumDePieces;
# DELIMITER //
# CREATE TRIGGER MaximumDePieces
#     BEFORE INSERT ON Pieces
#     FOR EACH ROW
#     BEGIN
#         DECLARE nmbDePiece INTEGER;
#         IF ((SELECT COUNT(*) FROM Pieces  WHERE nomPiece = NEW.nomPiece) >=3)
#         THEN
#             SIGNAL SQLSTATE '45000'
#             SET MESSAGE_TEXT = 'Nous avons déjà cette pieces au moins 3 fois.';
#         end if ;
#     end //

-- Cette procédure est utile uniquement pour définir nos variables de temps telles
-- qu'elles seront utilisées dans la plupart de nos procédures suivantes.
DROP PROCEDURE IF EXISTS set_timeframe_variables;
DELIMITER //
CREATE PROCEDURE set_timeframe_variables()
BEGIN

    SET @now_date := UTC_DATE(), @last_week := DATE_SUB(@now_date, INTERVAL 7 DAY), @last_month := DATE_SUB(@now_date, INTERVAL 1 MONTH),
        @last_trimester := DATE_SUB(@now_date, INTERVAL 3 MONTH), @last_semester := DATE_SUB(@now_date, INTERVAL 6 MONTH),
        @last_year := DATE_SUB(@now_date, INTERVAL 1 YEAR), @all_date := DATE_SUB(@now_date, INTERVAL 6 YEAR);
END//
DELIMITER ;


#PROCEDURE 1 STATISTICSPIECES
DROP PROCEDURE IF EXISTS statisticsPieces;
DELIMITER //

CREATE PROCEDURE statisticsPieces(IN timeframe VARCHAR(10), IN VoirIDPiece integer(1), IN VoirNomPiece integer(1),
                             IN VoirDescription integer(1), IN VoirPrix integer(1), IN Voircategorie integer(1),
                             IN VoirpoidsPiece integer(1), IN VoirdatePiece integer(1))
BEGIN

    call set_timeframe_variables();


    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE Pieces;

    INSERT INTO date
    SELECT *
    FROM Pieces P
    WHERE (timeframe = 'semaine' AND P.datePiece BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND P.datePiece BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND P.datePiece BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND P.datePiece BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND P.datePiece BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND P.datePiece BETWEEN @all_date AND @now_date);

    IF VoirIDPiece = 0 THEN ALTER TABLE date DROP COLUMN idPiece; END IF;
    IF VoirNomPiece = 0 THEN ALTER TABLE date DROP COLUMN nomPiece; END IF;
    IF Voircategorie = 0 THEN ALTER TABLE date DROP COLUMN categorie; END IF;
    IF VoirpoidsPiece = 0 THEN ALTER TABLE date DROP COLUMN poidsPiece; END IF;
    IF VoirDescription = 0 THEN ALTER TABLE date DROP COLUMN descriptionPiece; END IF;
    IF VoirPrix = 0 THEN ALTER TABLE date DROP COLUMN prixPiece; END IF;
    IF VoirdatePiece = 0 THEN ALTER TABLE date DROP COLUMN datePiece; END IF;

    SELECT * FROM date;

END //
DELIMITER ;

#PROCEDURE 2 STATISTICSAUTOMOBILES
DROP PROCEDURE IF EXISTS statisticsAutomobiles;
DELIMITER //

CREATE PROCEDURE statisticsAutomobiles(IN timeframe VARCHAR(10), IN voirniv integer(1), IN voirmarque integer(1),
                             IN voirmodele integer(1), IN voirannee integer(1), IN voircouleur integer(1),
                             IN voirodometre integer(1), IN voirnbPlaces integer(1), IN voirprixAuto integer(1),
                             IN voirlocationVente integer(1), IN voirsousCategorie integer(1), IN voirpoidsAuto integer(1),
                             IN voirdateAuto integer(1))
BEGIN

    call set_timeframe_variables();

    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE automobile;

    INSERT INTO date
    SELECT *
    FROM Automobile A
    WHERE (timeframe = 'semaine' AND A.dateAuto BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND A.dateAuto BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND A.dateAuto BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND A.dateAuto BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND A.dateAuto BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND A.dateAuto BETWEEN @all_date AND @now_date);

    IF voirniv = 0 THEN ALTER TABLE date DROP COLUMN niv; END IF;
    IF voirmarque = 0 THEN ALTER TABLE date DROP COLUMN marque; END IF;
    IF voirmodele = 0 THEN ALTER TABLE date DROP COLUMN modele; END IF;
    IF voirannee = 0 THEN ALTER TABLE date DROP COLUMN annee; END IF;
    IF voircouleur = 0 THEN ALTER TABLE date DROP COLUMN couleur; END IF;
    IF voirodometre = 0 THEN ALTER TABLE date DROP COLUMN odometre; END IF;
    IF voirnbPlaces = 0 THEN ALTER TABLE date DROP COLUMN nbPlaces; END IF;
    IF voirprixAuto = 0 THEN ALTER TABLE date DROP COLUMN prixAuto; END IF;
    IF voirlocationVente = 0 THEN ALTER TABLE date DROP COLUMN locationVente; END IF;
    IF voirsousCategorie = 0 THEN ALTER TABLE date DROP COLUMN sousCategorie; END IF;
    IF voirpoidsAuto = 0 THEN ALTER TABLE date DROP COLUMN poidsAuto; END IF;
    IF voirdateAuto = 0 THEN ALTER TABLE date DROP COLUMN dateAuto; END IF;

    SELECT * FROM date;

END //
DELIMITER ;

#PROCEDURE 3 STATISTICSLAVAGEAUTO
DROP PROCEDURE IF EXISTS statisticsLavageAuto;
DELIMITER //

CREATE PROCEDURE statisticsLavageAuto(IN timeframe VARCHAR(10), IN VoiridLavage integer(1), IN VoirtypeLavage integer(1),
                             IN VoirprixLavage integer(1), IN Voirniv integer(1), IN VoiridClient integer(1),
                             IN VoiridEmploye integer(1), IN VoirdateLavage integer(1))
BEGIN
    call set_timeframe_variables();

    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE lavageauto;

    INSERT INTO date
    SELECT *
    FROM lavageauto L
    WHERE (timeframe = 'semaine' AND L.dateLavage BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND L.dateLavage BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND L.dateLavage BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND L.dateLavage BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND L.dateLavage BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND L.dateLavage BETWEEN @all_date AND @now_date);

    IF VoiridLavage = 0 THEN ALTER TABLE date DROP COLUMN idLavage; END IF;
    IF VoirtypeLavage = 0 THEN ALTER TABLE date DROP COLUMN typeLavage; END IF;
    IF VoirprixLavage = 0 THEN ALTER TABLE date DROP COLUMN prixLavage; END IF;
    IF Voirniv = 0 THEN ALTER TABLE date DROP COLUMN niv; END IF;
    IF VoiridClient = 0 THEN ALTER TABLE date DROP COLUMN idClient; END IF;
    IF VoiridEmploye = 0 THEN ALTER TABLE date DROP COLUMN idEmploye; END IF;
    IF VoirdateLavage = 0 THEN ALTER TABLE date DROP COLUMN dateLavage; END IF;

    SELECT * FROM date;

    END //
DELIMITER ;

#PROCEDURE 4 STATISTICSREPARATION
DROP PROCEDURE IF EXISTS statisticsReparation;
DELIMITER //

CREATE PROCEDURE statisticsReparation(IN timeframe VARCHAR(10), IN voiridReparation integer(1), IN voirniv integer(1),
                             IN voiridClient integer(1), IN voiridEmploye integer(1), IN voiridPiece integer(1),
                             IN voirtempsDeTravail integer(1), IN voircoutReparation integer(1), IN voirdateReparation integer(1))
BEGIN

    call set_timeframe_variables();

    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE reparation;

    INSERT INTO date
    SELECT *
    FROM reparation R
    WHERE (timeframe = 'semaine' AND R.dateReparation BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND R.dateReparation BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND R.dateReparation BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND R.dateReparation BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND R.dateReparation BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND R.dateReparation BETWEEN @all_date AND @now_date);

    IF voiridReparation = 0 THEN ALTER TABLE date DROP COLUMN idReparation; END IF;
    IF voirniv = 0 THEN ALTER TABLE date DROP COLUMN niv; END IF;
    IF voiridClient = 0 THEN ALTER TABLE date DROP COLUMN idClient; END IF;
    IF voiridEmploye = 0 THEN ALTER TABLE date DROP COLUMN idEmploye; END IF;
    IF voiridPiece = 0 THEN ALTER TABLE date DROP COLUMN idPiece; END IF;
    IF voirtempsDeTravail = 0 THEN ALTER TABLE date DROP COLUMN tempsDeTravail; END IF;
    IF voircoutReparation = 0 THEN ALTER TABLE date DROP COLUMN coutReparation; END IF;
    IF voirdateReparation = 0 THEN ALTER TABLE date DROP COLUMN dateReparation; END IF;

    SELECT * FROM date;

    END //
DELIMITER ;