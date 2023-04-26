import pymysql
import flask
from flask import request, render_template, flash, redirect, session, url_for
import pycountry


app = flask.Flask(__name__)

mydb = pymysql.connect(
    host="localhost",
    user="root",
    password="lennyplante5@Sql.com",  # à remplacer par le password de votre ordinateur pour les tests
    db="glo_2005_Projet_ConcessionnaireNouvelleAuto",
    autocommit=True,
)

cursor = mydb.cursor()


@app.route('/')
def home():
    if 'user_id' in session:
        return render_template('home_signed_in.html')
    else:
        return render_template('home.html')


@app.route('/search-auto', methods=['GET', 'POST'])
def searchAuto():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':
        # Récupérer la requête de l'utilisateur
        queryAuto = flask.request.form['queryAuto']
        print(queryAuto)

        # Requête SQL pour sélectionner les données dans la table "articles"
        cursor = mydb.cursor()
        sql = "SELECT * FROM glo_2005_projet_concessionnairenouvelleauto.Automobile " \
              "WHERE niv LIKE %s " \
              "OR marque LIKE %s " \
              "OR modele LIKE %s " \
              "OR annee LIKE %s " \
              "OR couleur LIKE %s " \
              "OR odometre LIKE %s " \
              "OR nbPlaces LIKE %s " \
              "OR prixAuto LIKE %s " \
              "OR locationVente LIKE %s " \
              "OR sousCategorie LIKE %s " \
              "OR poidsAuto LIKE %s " \
              "OR dateAuto LIKE %s " \
              "ORDER BY prixAuto"
        cursor.execute(sql, ('%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%',
                             '%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%',
                             '%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%',
                             '%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%'))
        resultsAuto = cursor.fetchall()

        return flask.render_template('searchAuto.html', results=resultsAuto, query=queryAuto)

    return render_template('barre_recherche_Auto.html')


@app.route('/search-employe', methods=['GET', 'POST'])
def searchEmploye():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':
        # Récupérer la requête de l'utilisateur
        queryEmploye = flask.request.form['queryEmploye']

        # Requête SQL pour sélectionner les données dans la table "articles"
        cursor = mydb.cursor()
        sql = "SELECT * FROM glo_2005_projet_concessionnairenouvelleauto.employe " \
              "WHERE prenomEmploye LIKE %s " \
              "OR nomEmploye LIKE %s " \
              "OR ageEmploye LIKE %s " \
              "OR numCellEmploye LIKE %s " \
              "OR numPoste LIKE %s " \
              "OR titreEmploi LIKE %s " \
              "OR salaireAnnuel LIKE %s " \
              "OR anciennete LIKE %s " \
              "ORDER BY anciennete"
        cursor.execute(sql, ('%' + queryEmploye + '%', '%' + queryEmploye + '%', '%' + queryEmploye + '%',
                             '%' + queryEmploye + '%', '%' + queryEmploye + '%', '%' + queryEmploye + '%',
                             '%' + queryEmploye + '%', '%' + queryEmploye + '%'))
        resultsEmploye = cursor.fetchall()

        return flask.render_template('searchemploye.html', results=resultsEmploye, query=queryEmploye)

    return render_template('barre_recherche_Employes.html')

@app.route('/profil-employe/<int:id>')
def profilEmploye(id):
    employe = getEmployeById(id)
    # print(employe)
    if employe:
        return render_template('profil_Employes.html', employe=employe)
    else:
        return 'Employé non trouvé'

def getEmployeById(id):
    # Requête SQL pour sélectionner les données dans la table "employes"
    cursor = mydb.cursor()
    sql = "SELECT * FROM glo_2005_projet_concessionnairenouvelleauto.employe WHERE idEmploye =%s"
    cursor.execute(sql, (id,))
    resultsEmploye = cursor.fetchone()

    return resultsEmploye


@app.route('/add-fournisseur-auto', methods=['GET', 'POST'])
def addFournisseurAuto():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')

    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':
        name = request.form['name']
        address = request.form['address']
        tel = request.form['tel']
        email = request.form['email']
        city = request.form['city']
        state = request.form['state']
        country = request.form['country']

        if len(name) < 2:
            flash('Nom invalide', category='error')
            return redirect(url_for('addFournisseurAuto'))
        if len(tel) < 10:
            flash('Téléphone invalide', category='error')
            return redirect(url_for('addFournisseurAuto'))
        if len(email) < 4:
            flash('E-Mail invalide.', category='error')
            return redirect(url_for('addFournisseurAuto'))
        if len(city) < 2:
            flash('Ville invalide', category='error')
            return redirect(url_for('addFournisseurAuto'))
        if len(state) < 2:
            flash('État / Province invalide', category='error')
            return redirect(url_for('addFournisseurAuto'))
        if len(country) < 2:
            flash('Pays invalide', category='error')
            return redirect(url_for('addFournisseurAuto'))
        else:
            cursor = mydb.cursor()

            try:

                sql = "INSERT INTO glo_2005_Projet_ConcessionnaireNouvelleAuto.FournisseursAutomobiles " \
                      "(nomFournisseursVehicules, adresseFournisseursVehicules, numTelephoneFournisseursVehicules, " \
                      "adresseCourrielFournisseursVehicules, villeFournisseursVehicules, " \
                      "provinceEtatFournisseursVehicules, paysFournisseursVehicules) " \
                      "VALUES (%s, %s, %s, %s, %s, %s, %s)"
                cursor.execute(sql, (name, address, tel, email, city, state, country))
                mydb.commit()
                flash('Fournisseur ajouté avec succès', category='success')
                return redirect(url_for('addFournisseurAuto'))

            except pymysql.Error as exception:
                # Obtenir le SQLSTATE
                sqlstate = exception.args[0]

                # Manipuler l'erreur basé sur le SQLSTATE
                if sqlstate == '50000':
                    message = 'Trigger error: ' + str(exception)
                else:
                    message = 'Erreur d\'insertion : ' + str(exception)

                # Flash un message d'erreur
                flash(message, 'error')

    return render_template('ajouterFournisseursAuto.html', country=(list(pycountry.countries)))


@app.route('/search-fournisseur-auto', methods=['GET', 'POST'])
def searchFournisseurAuto():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion
    if flask.request.method == 'POST':
        # Récupérer la requête de l'utilisateur
        queryAuto = flask.request.form['queryAuto']
        print(queryAuto)

        # Requête SQL pour sélectionner les données dans la table "articles"
        cursor = mydb.cursor()
        sql = "SELECT * FROM glo_2005_Projet_ConcessionnaireNouvelleAuto.FournisseursAutomobiles " \
              "WHERE idFournisseursVehicules LIKE %s " \
              "OR nomFournisseursVehicules LIKE %s " \
              "OR adresseFournisseursVehicules LIKE %s " \
              "OR numTelephoneFournisseursVehicules LIKE %s " \
              "OR adresseCourrielFournisseursVehicules LIKE %s " \
              "OR villeFournisseursVehicules LIKE %s " \
              "OR provinceEtatFournisseursVehicules LIKE %s " \
              "OR paysFournisseursVehicules LIKE %s " \
              "ORDER BY idFournisseursVehicules"
        cursor.execute(sql, ('%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%',
                             '%' + queryAuto + '%', '%' + queryAuto + '%', '%' + queryAuto + '%',
                             '%' + queryAuto + '%', '%' + queryAuto + '%'))
        resultsAuto = cursor.fetchall()

        return flask.render_template('searchFournisseurAuto.html', results=resultsAuto, query=queryAuto)

    return render_template('trouverFournisseursAuto.html')


@app.route('/add-fournisseur-pieces', methods=['GET', 'POST'])
def addFournisseurPieces():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':
        name = request.form["name"]
        address = request.form["address"]
        tel = request.form["tel"]
        email = request.form["email"]
        city = request.form["city"]
        state = request.form["state"]
        country = request.form["country"]

        if len(name) < 2:
            flash('Nom invalide', category='error')
            return redirect(url_for('addFournisseurPieces'))
        if len(tel) < 10:
            flash('Téléphone invalide', category='error')
            return redirect(url_for('addFournisseurPieces'))
        if len(email) < 4:
            flash('E-Mail invalide.', category='error')
            return redirect(url_for('addFournisseurPieces'))
        if len(city) < 2:
            flash('Ville invalide', category='error')
            return redirect(url_for('addFournisseurPieces'))
        if len(state) < 2:
            flash('État / Province invalide', category='error')
            return redirect(url_for('addFournisseurPieces'))
        if len(country) < 2:
            flash('Pays invalide', category='error')
            return redirect(url_for('addFournisseurPieces'))
        else:
            cursor = mydb.cursor()

            try:

                sql = f"""INSERT INTO glo_2005_Projet_ConcessionnaireNouvelleAuto.Fournisseurspieces 
                                        (nomFournisseursPieces, adresseFournisseursPieces, numTelephoneFournisseursPieces, 
                                        adresseCourrielFournisseursPieces, villeFournisseursPieces, provinceEtatFournisseursPieces, 
                                        paysFournisseursPieces) 
                                        VALUES (%s, %s, %s, %s, %s, %s, %s)"""

                cursor.execute(sql, (name, address, tel, email, city, state, country))
                mydb.commit()
                flash('Fournisseur ajouté avec succès', category='success')
                return redirect(url_for('addFournisseurPieces'))

            except pymysql.Error as exception:
                # Obtenir le SQLSTATE
                sqlstate = exception.args[0]

                # Manipuler l'erreur basé sur le SQLSTATE
                if sqlstate == '50000':
                    message = 'Trigger error: ' + str(exception)
                else:
                    message = 'Erreur d\'insertion : ' + str(exception)

                # Flash un message d'erreur
                flash(message, 'error')



    return render_template('ajouterFournisseursPieces.html', country=(list(pycountry.countries)))


@app.route('/search-fournisseur-pieces', methods=['GET', 'POST'])
def searchFournisseurPieces():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')

    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':
        # Récupérer la requête de l'utilisateur
        querySearchFournPieces = flask.request.form['querySearchFournPieces']
        print(querySearchFournPieces)

        # Requête SQL pour sélectionner les données dans la table "articles"
        cursor = mydb.cursor()
        sql = "SELECT * FROM glo_2005_Projet_ConcessionnaireNouvelleAuto.Fournisseurspieces " \
              "WHERE idFournisseursPieces LIKE %s " \
              "OR nomFournisseursPieces LIKE %s " \
              "OR adresseFournisseursPieces LIKE %s " \
              "OR numTelephoneFournisseursPieces LIKE %s " \
              "OR adresseCourrielFournisseursPieces LIKE %s " \
              "OR villeFournisseursPieces LIKE %s " \
              "OR provinceEtatFournisseursPieces LIKE %s " \
              "OR paysFournisseursPieces LIKE %s " \
              "ORDER BY idFournisseursPieces"
        cursor.execute(sql, (
            '%' + querySearchFournPieces + '%', '%' + querySearchFournPieces + '%', '%' + querySearchFournPieces + '%',
            '%' + querySearchFournPieces + '%', '%' + querySearchFournPieces + '%', '%' + querySearchFournPieces + '%',
            '%' + querySearchFournPieces + '%', '%' + querySearchFournPieces + '%'))
        resultsSearchFournPieces = cursor.fetchall()

        return flask.render_template('searchFournisseurPieces.html', results=resultsSearchFournPieces,
                                     query=querySearchFournPieces)

    return render_template('trouverFournisseursPieces.html')


@app.route('/login', methods=['POST', 'GET'])
def login():
    user_id = session.get('user_id')

    if request.method == 'POST':
        email = request.form['email']
        password = request.form['password']

        cursor = mydb.cursor()
        sql = "SELECT passe,email from glo_2005_projet_concessionnairenouvelleauto.users WHERE email = %s"
        cursor.execute(sql, (email,))
        resultat = cursor.fetchone()

        if resultat is None:
            flash("Identifiants incorrects. Veuillez réessayer.", category='error')
            return redirect(url_for('login'))

        else:
            row = resultat[0].strip()
            if row == password:

                session['user_id'] = email  # ajout du code de la session
                return redirect(url_for('utilisateur'))
            else:
                flash("Identifiants incorrects. Veuillez réessayer.", category='error')

    return render_template('login.html')


@app.route('/logout', methods=['POST', 'GET'])
def logout():
    session.pop('user_id', None)

    return render_template('home.html')


@app.route('/page_utilisateur', methods=['POST', 'GET'])
def utilisateur():
    return render_template('page_utilisateur.html')


@app.route('/sign-up', methods=['GET', 'POST'])
def sign_up():
    user_id = session.get('user_id')
    if request.method == 'POST':
        email = request.form['email']
        firstName = request.form['firstName']
        Name = request.form['lastName']
        sex = request.form['gender']
        Date = request.form['birthdate']
        country = request.form['country']
        phone = request.form['phone']
        password1 = request.form['password1']
        password2 = request.form['password2']

        if len(email) < 4:
            flash('Email invalide', category='error')
        if len(firstName) < 2:
            flash('Le nom doit être plus grand qu\'un caractère', category='error')
        elif password1 != password2:
            flash('Les mot de passe ne correspondent pas', category='error')
        elif len(password1) < 8:
            flash('Le mot de passe doit faire au moins 8 caracteres.', category='error')
        elif not country:
            flash('Veuillez sélectionner votre pays.', category='error')
        elif not sex:
            flash('Veuillez sélectionner votre pays.', category='error')
        else:
            cursor = mydb.cursor()

            sql = "SELECT * FROM glo_2005_projet_concessionnairenouvelleauto.users WHERE email = %s"
            cursor.execute(sql, (email,))
            result = cursor.fetchone()
            if result:
                # L'adresse e-mail existe déjà, renvoyer un message d'erreur
                flash('Ce compte existe déjà. Veuillez vous connecter ou choisir un autre email.', category='error')
                return redirect(url_for('login'))
            else:
                sql = "INSERT INTO glo_2005_projet_concessionnairenouvelleauto.users (email, passe, first_name, last_name,  gender, birthdate, region, phone ) VALUES(%s, %s, %s,%s,%s,%s,%s,%s)"
                cursor.execute(sql, (email, password1, firstName, Name, sex, Date, country, phone))
                mydb.commit()
                flash('Compte crée avec succès', category='success')
                return redirect(url_for('login'))

    return render_template("sign-up.html", country=(list(pycountry.countries)))


@app.route('/appropos', methods=['GET', 'POST'])
def appropos():
    return render_template("a_propos.html")


@app.route('/searchPiece', methods=['GET', 'POST'])
def searchPiece():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':

        query = flask.request.form['query']
        # Récupérer la requête de l'utilisateur
        id = 0
        nom = 1
        prix = 0
        category = 0
        description = 0
        poid = 0
        date = 0

        piece = request.form.getlist('piece')
        time = request.form.getlist('time')

        if "ID" in piece:
            id = 1
        if "PRIX" in piece:
            prix = 1

        if "CATEGORY" in piece:
            category = 1

        if "DESCRIPTION" in piece:
            description = 1

        if "POID" in piece:
            poid = 1

        if "DATE" in piece:
            date = 1

        if "last_week" in time:
            Time = "semaine"

        if "last_month" in time:
            Time = "mois"

        if "last_year" in time:
            Time = "year"
        if "all_date" in time:
            Time = "all"

        sql = "call statisticsPieces(%s, %s, %s, %s, %s, %s, %s, %s);"

        cursor.execute(sql, (Time, id, nom, description, prix, category,  poid, date,))

        headers = [col[0] for col in cursor.description]
        data = []
        for row in cursor.fetchall():
            row_data = {}
            for i, value in enumerate(row):
                if value:
                    row_data[headers[i]] = value
            if query in row_data.values():
                data.append(row_data)

        return flask.render_template('searchPiece.html', data=data, query=query, headers=headers)

    return render_template('barre_searchPiece.html')


@app.route('/searchLavageAuto', methods=['GET', 'POST'])
def searchLavageAuto():
    # Vérifier si l'utilisateur est connecté
    user_id = session.get('user_id')
    if 'user_id' not in session:
        flash('Vous devez être connecté pour accéder à cette page.', category='error')
        return redirect(url_for('login'))  # Rediriger l'utilisateur vers la page de connexion

    if flask.request.method == 'POST':

        query = flask.request.form['query']
        # Récupérer la requête de l'utilisateur
        id = 0
        type = 1
        prix = 0
        niv = 0
        id_client = 0
        id_employe = 0
        date = 0

        lavage = request.form.getlist('lavage')
        time = request.form.getlist('time')

        if "ID" in lavage:
            id = 1
        if "TYPE" in lavage:
            type = 1

        if "PRIX" in lavage:
            prix = 1

        if "NIV" in lavage:
            niv = 1

        if "ID_CLIENT" in lavage:
            id_client = 1

        if "ID_EMPLOYE" in lavage:
            id_employe = 1

        if "DATE" in lavage:
            date = 1

        if "last_week" in time:
            Time = "semaine"

        if "last_month" in time:
            Time = "mois"

        if "last_year" in time:
            Time = "year"
        if "all_date" in time:
            Time = "all"

        sql = "call statisticsLavageAuto(%s, %s, %s, %s, %s, %s, %s, %s);"

        cursor.execute(sql, (Time, id, type, prix, niv, id_client, id_employe, date))

        headers = [col[0] for col in cursor.description]
        data = []
        for row in cursor.fetchall():
            row_data = {}
            for i, value in enumerate(row):
                if value:
                    row_data[headers[i]] = value
            if query in row_data.values():
                data.append(row_data)

        return flask.render_template('searchLavageAuto.html', data=data, query=query, headers=headers)

    return render_template('barre_searchLavageAuto.html')


if __name__ == '__main__':
    app.config['SECRET_KEY'] = 'hjshjhdjahhhhhhhhhhhhhhhkjshkjdhjs'  # ne pas enléver important
    app.run(debug=True)
