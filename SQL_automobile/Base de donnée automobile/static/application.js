
$(document).ready(function() {
  // Sélectionne tous les éléments de message flash avec la classe "alert-dismissible"
  $(".alert-dismissible").each(function() {
    // Définir une durée d'attente de 5 secondes avant de supprimer l'élément
    setTimeout(function() {
      // Supprimer l'élément parent de l'élément actuel
      $(this).parent().remove();
    // Attendre 5 secondes avant d'exécuter cette fonction
    }, 5000);
  });
});


function addFournisseurPieces() {
// Vérifier si l'utilisateur est connecté
var user_id = session.get('user_id');
console.log(user_id);
if (!session['user_id']) {
  flash('Vous devez être connecté pour accéder à cette page.', {category: 'error'});
  return redirect(url_for('login')); // Rediriger l'utilisateur vers la page de connexion
}

  if (flask.request.method === 'POST') {
    var name = request.form['name'];
    var address = request.form['address'];
    var tel = request.form['tel'];
    var email = request.form['email'];
    var city = request.form['city'];
    var state = request.form['state'];
    var country = request.form['country'];

    if (name.length < 2) {
        flash('Nom invalide', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else if (tel.length < 10) {
        flash('Téléphone invalide', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else if (email.length < 4) {
        flash('E-Mail invalide.', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else if (city.length < 2) {
        flash('Ville invalide', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else if (state.length < 2) {
        flash('État / Province invalide', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else if (country.length < 2) {
        flash('Pays invalide', { category: 'error' });
        return redirect(url_for('addFournisseurPieces'));
    } else {
        var sql = `INSERT INTO glo_2005_Projet_ConcessionnaireNouvelleAuto.Fournisseurspieces 
                    (nomFournisseursPieces, adresseFournisseursPieces, numTelephoneFournisseursPieces, 
                    adresseCourrielFournisseursPieces, villeFournisseursPieces, provinceEtatFournisseursPieces, 
                    paysFournisseursPieces) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)`;

        cursor.execute(sql, [name, address, tel, email, city, state, country]);
        mydb.commit();
        flash('Fournisseur ajouté avec succès', { category: 'success' });
        return redirect(url_for('addFournisseurPieces'));
    }
}
return render_template('ajouterFournisseursPieces.html', { country: (list(pycountry.countries)) });

}

function addFournisseurAuto() {
// Vérifier si l'utilisateur est connecté
var user_id = session.get('user_id');
console.log(user_id);
if (!session['user_id']) {
  flash('Vous devez être connecté pour accéder à cette page.', {category: 'error'});
  return redirect(url_for('login')); // Rediriger l'utilisateur vers la page de connexion
}

  if (flask.request.method === 'POST') {
    var name = request.form['name'];
    var address = request.form['address'];
    var tel = request.form['tel'];
    var email = request.form['email'];
    var city = request.form['city'];
    var state = request.form['state'];
    var country = request.form['country'];

    if (name.length < 2) {
        flash('Nom invalide', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else if (tel.length < 10) {
        flash('Téléphone invalide', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else if (email.length < 4) {
        flash('E-Mail invalide.', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else if (city.length < 2) {
        flash('Ville invalide', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else if (state.length < 2) {
        flash('État / Province invalide', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else if (country.length < 2) {
        flash('Pays invalide', { category: 'error' });
        return redirect(url_for('addFournisseurAuto'));
    } else {
        var sql = `INSERT INTO glo_2005_Projet_ConcessionnaireNouvelleAuto.FournisseursAutomobiles 
                    (nomFournisseursVehicules, adresseFournisseursVehicules, numTelephoneFournisseursVehicules, 
                    adresseCourrielFournisseursVehicules, villeFournisseursVehicules, provinceEtatFournisseursVehicules, 
                    paysFournisseursVehicules) 
                    VALUES (?, ?, ?, ?, ?, ?, ?)`;

        cursor.execute(sql, [name, address, tel, email, city, state, country]);
        mydb.commit();
        flash('Fournisseur ajouté avec succès', { category: 'success' });
        return redirect(url_for('addFournisseurAuto'));
    }
}
return render_template('ajouterFournisseursAuto.html', { country: (list(pycountry.countries)) });

}

