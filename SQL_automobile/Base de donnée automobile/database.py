import pymysql.cursors
import csv

connection = pymysql.connect(
    host="localhost",
    user="root",
    password="lennyplante5@Sql.com",  # à remplacer par le password de votre ordinateur pour les tests
    db="glo_2005_Projet_ConcessionnaireNouvelleAuto",
    autocommit=True,
)

cursor = connection.cursor()

def import_Users_from_csv():
    with open("Les tuples/tuples utilisateurs/users.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            email, passe, first_name, last_name,  birthdate, region, phone =\
            line[0], line[1], line[2], line[3], line[4], line[5], line[6],


            request = f"INSERT INTO users (email, passe, first_name, last_name,  birthdate, region, phone )" \
                      f"VALUES " \
                      f"('{email}', '{passe}', '{first_name}', '{last_name}'," \
                      f"'{birthdate}', '{region}', '{phone}');"

            cursor.execute(request)


def import_Concessionnaire_from_csv():
    with open("Les tuples/tuples de base/tuples_concessionnaire.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            nomConcessionnaire, adresseConcessionnaire, numTelephoneConcessionnaire, \
                adresseCourrielConcessionnaire, siteWeb = line[0], line[1], line[2], line[3], line[4]

            request = f"INSERT INTO Concessionnaire (nomConcessionnaire, adresseConcessionnaire, " \
                      f"numTelephoneConcessionnaire, adresseCourrielConcessionnaire, siteWeb) VALUES " \
                      f"('{nomConcessionnaire}', '{adresseConcessionnaire}', '{numTelephoneConcessionnaire}'," \
                      f"'{adresseCourrielConcessionnaire}', '{siteWeb}');"

            cursor.execute(request)


def import_Employe_from_csv():
    with open("Les tuples/tuples de base/tuples_employe.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            prenomEmploye, nomEmploye, ageEmploye, numCellEmploye, \
                numPoste, titreEmploi, salaireAnnuel, anciennete = line[0], \
                line[1], line[2], line[3], line[4], line[5], line[6], \
                line[7]

            request = f"INSERT INTO Employe (prenomEmploye, nomEmploye, ageEmploye, numCellEmploye, " \
                      f"numPoste, titreEmploi, salaireAnnuel, anciennete) VALUES " \
                      f"('{prenomEmploye}', '{nomEmploye}', '{ageEmploye}', '{numCellEmploye}', '{numPoste}', " \
                      f"'{titreEmploi}', '{salaireAnnuel}', '{anciennete}');"

            cursor.execute(request)


def import_Client_from_csv():
    with open("Les tuples/tuples de base/tuples_client.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            prenomClient, nomClient, numTelephoneClient, \
                adresseClient, codePostaleClient, ageClient = line[0], \
                line[1], line[2], line[3], line[4], line[5]

            request = f"INSERT INTO Client (prenomClient, nomClient, numTelephoneClient, " \
                      f"adresseClient, codePostaleClient, ageClient) VALUES " \
                      f"('{prenomClient}', '{nomClient}', '{numTelephoneClient}', '{adresseClient}'," \
                      f"'{codePostaleClient}', '{ageClient}');"

            cursor.execute(request)


def import_Automobile_from_csv():
    with open("Les tuples/tuples de base/tuples_automobile.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            niv, marque, modele, annee, couleur, odometre, nbPlaces, \
                prixAuto, locationVente, sousCategorie, poidsAuto, dateAuto = \
                line[0], line[1], line[2], line[3], line[4], line[5], line[6], line[7], line[8], line[9], line[10], \
                line[11]

            request = f"INSERT INTO Automobile (niv, marque, modele, annee, couleur, odometre, " \
                      f"nbPlaces, prixAuto, locationVente, sousCategorie, poidsAuto, dateAuto) VALUES " \
                      f"('{niv}', '{marque}', '{modele}', '{annee}', '{couleur}', '{odometre}', '{nbPlaces}'," \
                      f"'{prixAuto}', '{locationVente}', '{sousCategorie}', '{poidsAuto}', '{dateAuto}');"

            cursor.execute(request)


def import_Pieces_from_csv():
    with open("Les tuples/tuples de base/tuples_piece.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            idPiece, nomPiece, categorie, poidsPiece, \
                descriptionPiece, prixPiece, datePiece = line[0], line[1], line[2], line[3], line[4], line[5], line[6]

            request = f"INSERT INTO Pieces (idPiece, nomPiece, categorie, " \
                      f"poidsPiece, descriptionPiece, prixPiece, datePiece) VALUES " \
                      f"('{idPiece}', '{nomPiece}', '{categorie}', '{poidsPiece}', '{descriptionPiece}', '{prixPiece}', '{datePiece}');"

            cursor.execute(request)


def import_FournisseurAutomobiles_from_csv():
    with open("Les tuples/tuples de fournisseur/tuples_fournisseursAutomobiles.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            nomFournisseursVehicules, adresseFournisseursVehicules, \
                numTelephoneFournisseursVehicules, adresseCourrielFournisseursVehicules, villeFournisseursVehicules, \
                provinceEtatFournisseursVehicules, paysFournisseursVehicules = \
                line[0], line[1], line[2], line[3], line[4], line[5], line[6]

            request = f"INSERT INTO FournisseursAutomobiles (" \
                      f"nomFournisseursVehicules, adresseFournisseursVehicules, " \
                      f"numTelephoneFournisseursVehicules, adresseCourrielFournisseursVehicules, " \
                      f"villeFournisseursVehicules, provinceEtatFournisseursVehicules, paysFournisseursVehicules)" \
                      f"VALUES ('{nomFournisseursVehicules}', " \
                      f"'{adresseFournisseursVehicules}', '{numTelephoneFournisseursVehicules}', " \
                      f"'{adresseCourrielFournisseursVehicules}', '{villeFournisseursVehicules}', " \
                      f"'{provinceEtatFournisseursVehicules}', '{paysFournisseursVehicules}');"

            cursor.execute(request)


def import_FournisseursPieces_from_csv():
    with open("Les tuples/tuples de fournisseur/tuples_fournisseursPieces.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            nomFournisseursPieces, adresseFournisseursPieces, \
                numTelephoneFournisseursPieces, adresseCourrielFournisseursPieces, villeFournisseursPieces, \
                provinceEtatFournisseursPieces, paysFournisseursPieces = \
                line[0], line[1], line[2], line[3], line[4], line[5], line[6]

            request = f"INSERT INTO FournisseursPieces (" \
                      f"nomFournisseursPieces, adresseFournisseursPieces , " \
                      f"numTelephoneFournisseursPieces, adresseCourrielFournisseursPieces, " \
                      f"villeFournisseursPieces, provinceEtatFournisseursPieces, paysFournisseursPieces)" \
                      f"VALUES ('{nomFournisseursPieces}', " \
                      f"'{adresseFournisseursPieces}', '{numTelephoneFournisseursPieces}', " \
                      f"'{adresseCourrielFournisseursPieces}', '{villeFournisseursPieces}', " \
                      f"'{provinceEtatFournisseursPieces}', '{paysFournisseursPieces}');"

            cursor.execute(request)


def import_FourniPieces_from_csv():
    with open("Les tuples/tuples de fournisseur/tuples_fourniPieces.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            idFournisseursPieces, idPiece = line[0], line[1]

            request = f"INSERT INTO FourniPieces (idFournisseursPieces, idPiece)" \
                      f"VALUES ('{idFournisseursPieces}', '{idPiece}');"

            cursor.execute(request)


def import_FourniAutomobiles_from_csv():
    with open("Les tuples/tuples de fournisseur/tuples_fourniAutomobiles.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            idFournisseursVehicules, niv = line[0], line[1]

            request = f"INSERT INTO FourniAutomobiles (idFournisseursVehicules, niv)" \
                      f"VALUES ('{idFournisseursVehicules}', '{niv}');"

            cursor.execute(request)


def import_LavageAuto_from_csv():
    with open("Les tuples/tuples de services/tuples_lavageAuto.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            typeLavage, prixLavage, niv, idClient, idEmploye, dateLavage = line[0], line[1], line[2], line[3], line[4], \
            line[5]

            request = f"INSERT INTO LavageAuto (typeLavage, prixLavage, niv, idClient, idEmploye, dateLavage)" \
                      f"VALUES ('{typeLavage}', '{prixLavage}', '{niv}', '{idClient}', '{idEmploye}', '{dateLavage}');"

            cursor.execute(request)


def import_Vente_from_csv():
    with open("Les tuples/tuples de services/tuples_vente.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            niv, idClient, idEmploye, dureeFinancement, tauxInteret, dateVente = line[0], line[1], line[2], line[3], \
            line[4], line[5]

            request = f"INSERT INTO Vente (niv, idClient, idEmploye, dureeFinancement, tauxInteret, dateVente)" \
                      f"VALUES ('{niv}', '{idClient}', '{idEmploye}', '{dureeFinancement}', '{tauxInteret}', '{dateVente}');"

            cursor.execute(request)


def import_Reparation_from_csv():  # enlever le typeReparation et descriptionREP (line[6], line[7])
    with open("Les tuples/tuples de services/tuples_reparation.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            niv, idClient, idEmploye, idPiece, tempsDeTravail, coutReparation, dateReparation = line[0], line[1], line[
                2], line[3], \
                line[4], line[5], line[6]

            request = f"INSERT INTO Reparation (niv, idClient, idEmploye, idPiece, tempsDeTravail, coutReparation, dateReparation)" \
                      f"VALUES ('{niv}', '{idClient}', '{idEmploye}', '{idPiece}', '{tempsDeTravail}', '{coutReparation}', '{dateReparation}');"

            cursor.execute(request)


def import_Location_from_csv():
    with open("Les tuples/tuples de services/tuples_location.csv") as file:
        reader = csv.reader(file)

        for line in reader:
            niv, idClient, idEmploye, dureeLocation, tauxInteret, dateLocation = line[0], line[1], line[2], line[3], \
            line[4], line[5]

            request = f"INSERT INTO Location (niv, idClient, idEmploye, dureeLocation, tauxInteret, dateLocation)" \
                      f"VALUES ('{niv}', '{idClient}', '{idEmploye}', '{dureeLocation}', '{tauxInteret}', '{dateLocation}');"

            cursor.execute(request)


def import_tuples():
    import_Users_from_csv()
    import_Concessionnaire_from_csv()
    import_Employe_from_csv()
    import_Client_from_csv()
    import_Automobile_from_csv()
    import_Pieces_from_csv()
    import_FournisseurAutomobiles_from_csv()
    import_FournisseursPieces_from_csv()
    import_FourniPieces_from_csv()
    import_FourniAutomobiles_from_csv()
    import_LavageAuto_from_csv()
    import_Vente_from_csv()
    import_Reparation_from_csv()
    import_Location_from_csv()


if __name__ == '__main__':
    import_tuples()
