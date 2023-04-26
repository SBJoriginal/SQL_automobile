-- this procedure is only useful to set our time variables as they will be used in most of our following procedures
DROP PROCEDURE IF EXISTS set_timeframe_variables;
DELIMITER //
CREATE PROCEDURE set_timeframe_variables()
BEGIN
    -- Set the variables that will be used to choose the desired timeframe in any procedure.
    SET @now_date := UTC_DATE(), @last_week := DATE_SUB(@now_date, INTERVAL 7 DAY), @last_month := DATE_SUB(@now_date, INTERVAL 1 MONTH),
        @last_trimester := DATE_SUB(@now_date, INTERVAL 3 MONTH), @last_semester := DATE_SUB(@now_date, INTERVAL 6 MONTH),
        @last_year := DATE_SUB(@now_date, INTERVAL 1 YEAR), @all_date := DATE_SUB(@now_date, INTERVAL 6 YEAR);
END//
DELIMITER ;


#PROCEDURE 1 STATISTICSPIECES
DROP PROCEDURE IF EXISTS statisticsPieces;
DELIMITER //
    -- this procedures takes in 8 inputs. The first will be the desired timeframe and the 7 others are the colums we want to see in the Pieces table. Creates a Temporary table called Date.
CREATE PROCEDURE statisticsPieces(IN timeframe VARCHAR(10), IN VoirIDPiece integer(1), IN VoirNomPiece integer(1),
                             IN VoirDescription integer(1), IN VoirPrix integer(1), IN Voircategorie integer(1),
                             IN VoirpoidsPiece integer(1), IN VoirdatePiece integer(1))
BEGIN
    -- Declare the variables that will be used to choose the desired timeframe.
    call set_timeframe_variables();

    -- Drops the temporary "date" table if it exists, then creates it as a copy of the "Pieces" table.
    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE Pieces;

    -- Inserts rows from the "Pieces" table into the "date" table based on the selected timeframe.
    INSERT INTO date
    SELECT *
    FROM Pieces P
    WHERE (timeframe = 'semaine' AND P.datePiece BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND P.datePiece BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND P.datePiece BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND P.datePiece BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND P.datePiece BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND P.datePiece BETWEEN @all_date AND @now_date);

    -- Drops columns from the "date" table based on the input parameters.
    IF VoirIDPiece = 0 THEN ALTER TABLE date DROP COLUMN idPiece; END IF;
    IF VoirNomPiece = 0 THEN ALTER TABLE date DROP COLUMN nomPiece; END IF;
    IF Voircategorie = 0 THEN ALTER TABLE date DROP COLUMN categorie; END IF;
    IF VoirpoidsPiece = 0 THEN ALTER TABLE date DROP COLUMN poidsPiece; END IF;
    IF VoirDescription = 0 THEN ALTER TABLE date DROP COLUMN descriptionPiece; END IF;
    IF VoirPrix = 0 THEN ALTER TABLE date DROP COLUMN prixPiece; END IF;
    IF VoirdatePiece = 0 THEN ALTER TABLE date DROP COLUMN datePiece; END IF;

    -- Selects all columns from the "date" table and returns the result.
    SELECT * FROM date;

END //
DELIMITER ;

#test with statisticsPieces
#
 call statisticsPieces('all_date', 1, 1, 0, 1, 0, 0, 0);
# call statisticsPieces('mois', 0, 0, 0, 0, 0, 0, 0);
# call statisticsPieces('year', 0, 0, 0, 0, 0, 0, 0);


#PROCEDURE 2 STATISTICSAUTOMOBILES
DROP PROCEDURE IF EXISTS statisticsAutomobiles;
DELIMITER //
    -- this procedures takes in 13 inputs. The first will be the desired timeframe and the 12 others are the colums we want to see in the Automobile table. Creates a Temporary table called Date.
CREATE PROCEDURE statisticsAutomobiles(IN timeframe VARCHAR(10), IN voirniv integer(1), IN voirmarque integer(1),
                             IN voirmodele integer(1), IN voirannee integer(1), IN voircouleur integer(1),
                             IN voirodometre integer(1), IN voirnbPlaces integer(1), IN voirprixAuto integer(1),
                             IN voirlocationVente integer(1), IN voirsousCategorie integer(1), IN voirpoidsAuto integer(1),
                             IN voirdateAuto integer(1))
BEGIN
    -- Declare the variables that will be used to choose the desired timeframe.
    call set_timeframe_variables();

    -- Drops the temporary "date" table if it exists, then creates it as a copy of the "Pieces" table.
    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE automobile;

    -- Inserts rows from the "Pieces" table into the "date" table based on the selected timeframe.
    INSERT INTO date
    SELECT *
    FROM Automobile A
    WHERE (timeframe = 'semaine' AND A.dateAuto BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND A.dateAuto BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND A.dateAuto BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND A.dateAuto BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND A.dateAuto BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND A.dateAuto BETWEEN @all_date AND @now_date);

    -- Drops columns from the "date" table based on the input parameters.
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

    -- Selects all columns from the "date" table and returns the result.
    SELECT * FROM date;

END //
DELIMITER ;

call statisticsAutomobiles('semaine',0,0,0,0,0,0,0,0,0,0,0,1);



#PROCEDURE 3 STATISTICSLAVAGEAUTO
DROP PROCEDURE IF EXISTS statisticsLavageAuto;
DELIMITER //
    -- this procedures takes in 8 inputs. The first will be the desired timeframe and the 7 others are the colums we want to see in the LavageAuto table. Creates a Temporary table called Date.
CREATE PROCEDURE statisticsLavageAuto(IN timeframe VARCHAR(10), IN VoiridLavage integer(1), IN VoirtypeLavage integer(1),
                             IN VoirprixLavage integer(1), IN Voirniv integer(1), IN VoiridClient integer(1),
                             IN VoiridEmploye integer(1), IN VoirdateLavage integer(1))
BEGIN
    -- Declare the variables that will be used to choose the desired timeframe.
    call set_timeframe_variables();

    -- Drops the temporary "date" table if it exists, then creates it as a copy of the "Pieces" table.
    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE lavageauto;

    -- Inserts rows from the "Pieces" table into the "date" table based on the selected timeframe.
    INSERT INTO date
    SELECT *
    FROM lavageauto L
    WHERE (timeframe = 'semaine' AND L.dateLavage BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND L.dateLavage BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND L.dateLavage BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND L.dateLavage BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND L.dateLavage BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND L.dateLavage BETWEEN @all_date AND @now_date);

    -- Drops columns from the "date" table based on the input parameters.
    IF VoiridLavage = 0 THEN ALTER TABLE date DROP COLUMN idLavage; END IF;
    IF VoirtypeLavage = 0 THEN ALTER TABLE date DROP COLUMN typeLavage; END IF;
    IF VoirprixLavage = 0 THEN ALTER TABLE date DROP COLUMN prixLavage; END IF;
    IF Voirniv = 0 THEN ALTER TABLE date DROP COLUMN niv; END IF;
    IF VoiridClient = 0 THEN ALTER TABLE date DROP COLUMN idClient; END IF;
    IF VoiridEmploye = 0 THEN ALTER TABLE date DROP COLUMN idEmploye; END IF;
    IF VoirdateLavage = 0 THEN ALTER TABLE date DROP COLUMN dateLavage; END IF;

    -- Selects all columns from the "date" table and returns the result.
        SELECT * FROM date;

    END //
DELIMITER ;


#test with statisticsLavageAuto
call statisticsLavageAuto('mois', 0,1,0,0,0,0,0);




#PROCEDURE 4 STATISTICSREPARATION
DROP PROCEDURE IF EXISTS statisticsReparation;
DELIMITER //
    -- this procedures takes in 9 inputs. The first will be the desired timeframe and the8 others are the colums we want to see in the Reparation table. Creates a Temporary table called Date.
CREATE PROCEDURE statisticsReparation(IN timeframe VARCHAR(10), IN voiridReparation integer(1), IN voirniv integer(1),
                             IN voiridClient integer(1), IN voiridEmploye integer(1), IN voiridPiece integer(1),
                             IN voirtempsDeTravail integer(1), IN voircoutReparation integer(1), IN voirdateReparation integer(1))
BEGIN
    -- Declare the variables that will be used to choose the desired timeframe.
    call set_timeframe_variables();

    -- Drops the temporary "date" table if it exists, then creates it as a copy of the "Pieces" table.
    DROP TEMPORARY TABLE IF EXISTS date;
    CREATE TEMPORARY TABLE IF NOT EXISTS date LIKE reparation;

    -- Inserts rows from the "Pieces" table into the "date" table based on the selected timeframe.
    INSERT INTO date
    SELECT *
    FROM reparation R
    WHERE (timeframe = 'semaine' AND R.dateReparation BETWEEN @last_week AND @now_date)
       OR (timeframe = 'mois' AND R.dateReparation BETWEEN @last_month AND @now_date)
       OR (timeframe = 'trimestre' AND R.dateReparation BETWEEN @last_trimester AND @now_date)
       OR (timeframe = 'semestre' AND R.dateReparation BETWEEN @last_semester AND @now_date)
       OR (timeframe = 'year' AND R.dateReparation BETWEEN @last_year AND @now_date)
       OR (timeframe = 'all' AND R.dateReparation BETWEEN @all_date AND @now_date);

    -- Drops columns from the "date" table based on the input parameters.
    IF voiridReparation = 0 THEN ALTER TABLE date DROP COLUMN idReparation; END IF;
    IF voirniv = 0 THEN ALTER TABLE date DROP COLUMN niv; END IF;
    IF voiridClient = 0 THEN ALTER TABLE date DROP COLUMN idClient; END IF;
    IF voiridEmploye = 0 THEN ALTER TABLE date DROP COLUMN idEmploye; END IF;
    IF voiridPiece = 0 THEN ALTER TABLE date DROP COLUMN idPiece; END IF;
    IF voirtempsDeTravail = 0 THEN ALTER TABLE date DROP COLUMN tempsDeTravail; END IF;
    IF voircoutReparation = 0 THEN ALTER TABLE date DROP COLUMN coutReparation; END IF;
    IF voirdateReparation = 0 THEN ALTER TABLE date DROP COLUMN dateReparation; END IF;

    -- Selects all columns from the "date" table and returns the result.
        SELECT * FROM date;

    END //
DELIMITER ;


#test with statisticsReparation
call statisticsReparation('all_date', 0,1,0,0,0,0,0,0)