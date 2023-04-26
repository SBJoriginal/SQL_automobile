# ConcessionnaireNouvelleAuto

Dans ce projet nous avons décidé de créer un intranet pour un concessionnaire automobile. Dans ce site le concessionnaire 
pourra consulter des informations sur les employés, vérifier si les stocks des piéeces, régarder les voitures en stock. 
Il pourra également chercher les informations sur les fournisseurs et les produits qu'ils offrent. Il pourra ajouter/chercher des informations sur un fournisseur. Ajouter des données sur une pieces, une voiture ou un emplyé.

faciliter la gestion d'une Concession Automobile. 

### Requirements

##### 1. MySQL 8.0

- Le projet est réalisé sur **MySQL 8.0** comme la base de données. Installer MySQL dépuis [cette page](https://dev.mysql.com/downloads/installer/).

- Dans les fichiers database, console1, main remplacer les infos ci-dessous :

  ```
    host="localhost",
    user="root",
    password="your_password",  # à remplacer par le password de votre ordinateur pour les tests
    db="glo_2005_Projet_ConcessionnaireNouvelleAuto",
    autocommit=True,

  ```

##### 2. Installer les librairies du project en entrant ce commande dans le terminale de votre application Python:

```
 pip install -r requirements.txt
```

#### 3. Utilisation

1. Assurer vous tout d'abord d'utiliser un interpreteur récent de Python.
2. Commencer par exécuter le code SQL dans le fichier : creationDeRequete.sql
3. Connecter votre base de données et mettez le Shema sur 'glo_2005_Projet_ConcessionnaireNouvelleAuto.
4. Puis exécuter le fichier database pour charger les données dans votre base de données
5. Une fois la données crées et les données entrées, exécuter le fichier main ou z simplement dans le terminal : 

   ```
   $ pyton main.py
   ```

6. Allez [ici](http://localhost:5000/home) pour accéder au site!

### Bonus : créer un compte ou entrer simplement ses infos
    
        
   ```
   Email : janedoe@gmail.com
   Mot de passe : 123456
   ```