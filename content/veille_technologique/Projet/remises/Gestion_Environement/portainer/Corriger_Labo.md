+++
title = "Corriger du Labo portainer"
weight = 3
+++

---

<img src="/images/Atelier_PortainerP2.png" alt="Le dashboard du premier environnement" width="680px">

En cliquant sur l'environement, Portainer vous affiche les informations suivantes :

###  Stacks
Contient une liste des stacks qui représentent des applications multiconteneurs déployées à partir de fichiers Docker Compose. Elles permettent de gérer plusieurs conteneurs liés ensemble comme une seule unité, facilitant le déploiement et la gestion d'applications complexes. Par exemple, une application Gitea qui a le Web UI et la base de données dans des conteneurs différents sera affichée seulement comme Gitea.

###  Images
Contient une liste des images installées pour construire un conteneur selon le Docker Compose file d'une application. Portainer permet aussi de télécharger, construire et gérer ces images Docker manuellement.

[Explication de s'est quoi une image](../../../../../cours/docker/_index.md/##Les-images)

###  Containers
Contient la liste de tous les conteneurs disponibles dans le système. Portainer permet de démarrer, arrêter, redémarrer et surveiller vos conteneurs.

[Explication de s'est quoi un conteneur](../../../../../cours/docker/_index.md/##Les-conteneurs)

###  Networks
Contient une liste des réseaux qui permettent la communication entre conteneurs et avec l'extérieur. Portainer permet de créer et gérer les différents types de réseaux Docker (bridge, overlay, host, etc.).

###  Volumes
Contient une liste des volumes créés qui sont des espaces de stockage persistants pour vos conteneurs. Contrairement aux données dans un conteneur qui disparaissent quand il est supprimé, les volumes conservent les données. Ils sont essentiels pour les bases de données et les applications avec état.


---

<img src="/images/Atelier_PortainerP3.png" alt="La liste des stacks présentes dans l'environnement" width="480px">

Nous n'avons aucun stack, car nous n'avons pas encore installé d'application. Pour commencer, il faut cliquer sur le bouton "+ Add stack" dans le coin haut droit.

---

<img src="/images/Atelier_PortainerP4.png" alt="Entrez le code du fichier du Docker Compose dans le Web editor." width="480px">

Ici nous avons 3 facons principal de deployer une application.

###  Web editor
Il faut seulement écrire ou copier-coller le code du fichier Docker Compose dans l'éditeur.

###  Upload
Télécharger le fichier Docker Compose à Portainer

###  Reposity
Donner le lien Git de l'application avec une route vers le fichier Docker Compose. Possible aussi d'indiquer une référence à une branche précise de l'application.

{{% notice style="warning" title="Custom template" %}}
Custom template de plus pour personnaliser le processus de création d'un stack en utilisant des templates personnels.
{{% /notice%}}


---

<img src="/images/Atelier_PortainerP5.png" alt="Remplir les champs nécessaires pour installer l'application" width="480px">

{{% notice style="warning" title="Champ manquante" %}}
N'oubliez pas de remplir le champ Nom qui serait le nom du stack et de respecter le format YAML dans la création du fichier Docker Compose.{{% /notice%}}

Utiliser le code ci-dessous pour installer la première application.
```bash {lineNos="true" title="Fichier Docker Compose"}
networks:
  gitea:
    external: false

services:
  server:
    image: docker.gitea.com/gitea:1.25.2
    container_name: gitea
    environment:
      - USER_UID=1000
      - USER_GID=1000
      - GITEA__database__DB_TYPE=mysql
      - GITEA__database__HOST=db:3306
      - GITEA__database__NAME=gitea
      - GITEA__database__USER=gitea
      - GITEA__database__PASSWD=gitea
    restart: always
    networks:
      - gitea
    volumes:
      - ./gitea:/data
      - /etc/timezone:/etc/timezone:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - "3000:3000"
      - "222:22"
    depends_on:
      - db

  db:
    image: docker.io/library/mysql:8
    restart: always
    environment:
      - MYSQL_ROOT_PASSWORD=gitea
      - MYSQL_USER=gitea
      - MYSQL_PASSWORD=gitea
      - MYSQL_DATABASE=gitea
    networks:
      - gitea
    volumes:
      - ./mysql:/var/lib/mysql
```
---

<img src="/images/Atelier_PortainerP6.png" alt="Vous pouvez cliquer sur Deploy the stack" width="700px">

Cliquer sur **"Deploy the stack"**

---

<img src="/images/Atelier_PortainerP7.png" alt="Le stack créé est dans la liste des stacks" width="700px">
Après que l'application est installée, vous devriez voir votre application dans la liste des stacks.

---

<img src="/images/Atelier_PortainerP8.png" alt="Le stack contient deux conteneurs." width="700px">
Vous pouvez cliquer sur votre premier stack pour voir ses détails comme les conteneurs liés à l'application et aussi rédiger le code du Docker Compose utilisé.

---

<img src="/images/Atelier_PortainerP9.png" alt="Initialisation du Gitea" width="700px">
Laisser tout par défaut, car la section "Database Settings" contient les informations pour se connecter à la base de données créée dans le fichier Docker Compose entre les lignes 28 et 40.

---

<img src="/images/Atelier_PortainerP10.png" alt="Cliquer sur install Gitea" width="700px">
Vous pouvez cliquer sur "Install Gitea"

---

<img src="/images/Atelier_PortainerP111.png" alt="La page principale de Gitea" width="700px">
La page principale de Gitea

Accéder au site par le lien https://[IP du serveur]:[Port]

---

<img src="/images/Atelier_PortainerP122.png" alt="Création d'un répertoire dans Gitea" width="400px">
Pour créer un répertoire Gitea, vous pouvez cliquer sur le petit signe de plus.

---

<img src="/images/Atelier_PortainerP133.png" alt="Remplir le formulaire" width="700px">
Vous pouvez juste donner un nom au répertoire, remplir les autres champs si vous voulez. Autrement, les autres champs peuvent rester vides.

<img src="/images/Atelier_PortainerP14.png" alt="Création d'un répertoire dans Gitea" width="300px">
Vous pouvez continuer  en cliquant sur le bouton "Create Repertory" dans le bas du formulaire.

---

<img src="/images/Atelier_PortainerP15.png" alt="Page principale du répertoire" width="700px">
Voici le répertoire créé. Gitea doit être intuitivement facile à comprendre. Vous pouvez donc faire les mêmes procédures qu'avec GitHub pour cloner, pousser un changement.

Si vous voulez, vous pouvez aussi juste "Upload File" de votre print hello world au lieu de faire un clone avec l'adresse HTTP.

---

<img src="/images/Atelier_PortainerP16.png" alt="Le final du labo" width="700px">

Voici à quoi devrait ressembler la fin du labo.
