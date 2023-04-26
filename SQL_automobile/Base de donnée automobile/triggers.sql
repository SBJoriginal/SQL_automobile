
#gachette pour s'assurer de ne pas commander une piece si il y en a au moins 3 encore en stock
DROP TRIGGER IF EXISTS MaximumDePieces;
DELIMITER //
CREATE TRIGGER MaximumDePieces
    BEFORE INSERT ON Pieces
    FOR EACH ROW
    BEGIN
        DECLARE nmbDePiece INTEGER;
        IF ((SELECT COUNT(*) FROM Pieces  WHERE nomPiece = NEW.nomPiece) >=3)
        THEN
            SIGNAL SQLSTATE '45000'
            SET MESSAGE_TEXT = 'Nous avons déjà cette pieces au moins 3 fois.';
        end if ;
    end //

#TEST#
# INSERT INTO pieces (idPiece, nomPiece, categorie, poidsPiece, descriptionPiece, prixPiece, datePiece) VALUES (99999,'Courroie de distribution','Moteur', 0.5,'La courroie de distribution synchronise la rotation de larbre à cames et du vilebrequin dans le moteur à combustion interne', 80,'2023-03-07');



#intercept un insert d'un numero de telephone identique dans le tableau FournisseursAutomobiles
DROP TRIGGER IF EXISTS FournisseursAutomobilesDup;
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
            SET MESSAGE_TEXT = 'Vous avez deja un fournisseur dautomobile avec ce numero de telephone';
        end if ;
    end //
DELIMITER ;
#test
# insert into fournisseursautomobiles (nomFournisseursVehicules, adresseFournisseursVehicules, numTelephoneFournisseursVehicules, adresseCourrielFournisseursVehicules, villeFournisseursVehicules, provinceEtatFournisseursVehicules, paysFournisseursVehicules) VALUES ('Noé Dubois','21 Rue des Cerisiers','819-555-0492','noe.dubois@business.com','Rouyn-Noranda','Québec','Canada');


#intercept un insert d'un numero de telephone identique dans le tableau FournisseursPieces
DROP TRIGGER IF EXISTS FournisseursPiecesDup;
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
            SET MESSAGE_TEXT = 'Vous avez deja un fournisseur de piece avec ce numero de telephone';
        end if ;
    end //
DELIMITER ;
#test
# INSERT INTO FournisseursPieces      (nomFournisseursPieces, adresseFournisseursPieces, numTelephoneFournisseursPieces, adresseCourrielFournisseursPieces, villeFournisseursPieces, provinceEtatFournisseursPieces, paysFournisseursPieces) VALUES ('Sophie ','4848 Rue Sherbrooke','819-555-5678','sophie.thibault@business.com','Sherbrooke','Québec','Canada');

