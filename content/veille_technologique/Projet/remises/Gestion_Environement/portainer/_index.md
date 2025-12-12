+++
title = "Portainer"
weight = 1
+++

# Portainer - Qu'est-ce que c'est ?

**Portainer** est une plateforme de gestion open-source qui fournit une interface graphique intuitive pour gérer vos environnements.


## C'est quoi un environements et pourquoi l'utiliser?

Premierement, il existe des outils d’orchestration de conteneurs, comme Docker Swarm, Kubernetes ou Nomad, ainsi que des moteurs de conteneurs, comme Docker, CRI‑O ou containerd. Tous ces outils sont des environnements qui peuvent crée et contenir des conteneurs.

Deuxiemement, avoir un environement implique l'utilisation des containeurs. C'est exactement grace au containeurs que les application peuvent être initialement développée pour être utilisée dans un conteneur à cause de la facilité de deployer un conteneur. Dans d'autres cas, les conteneurs sont pratique dans la modernization d'une application monolithe d'une compagnie.

[Explication de s'est quoi un conteneur](../../../../../cours/docker/_index.md/##Les-conteneurs)

### Architecture monolithique

<img src="/images/Monolithic-Architecture.png" alt="Architecture Monolithique" width="500px">

**Image credit: Moon Technolabs (2025)**

Une architecture monolithique traditionnelle contient toutes les couches de l'application dans un seul bloc : l'interface utilisateur (UI), la logique métier (Business Logic), la couche d'accès aux données (Data Access Layer) et la base de données. Cette approche peut devenir complexe à maintenir et à faire évoluer à mesure que l'application grandit.

### Il existe plusieurs approches connues pour moderniser une application.

#### 1. Du monolithe aux microservices <br>
<div style="display: flex; align-items: center; gap: 20px;">
  <div>
Une des approches connues est le "strangler pattern" qui consiste à démanteler le monolithe petit à petit. En commençant par les plus simples et les plus utiles.
</div>
    <img src="/images/Strangler-Pattern.png" alt="Strangler Pattern" width="400px">
    
</div>

**Image credit: altexsoft (2024)**
#### 2. Migration vers le nuage
Le besoin de s'élargir pour combler au besoin d'une application peut être un processus long, compliqué et couteux. Car il faudrait acheter, assembler, configurer et maintenir ces serveurs. Une des meilleures solutions serait plutôt d'émigrer dans le cloud, ce qui libère plus de ressources utilisables en développement.

#### 3.  Exposer des fonctionnalités via des API
Dans ce cas, les développeurs vont exposer les fonctions ou l'information de l'application principale via des API sans grand changement dans le code. Autrement dit, l'application principale qui peut être de nature monolithique devient le cœur autour duquel des nouvelles fonctionnalités plus flexibles apparaissent.

## Pourquoi utiliser portainer?
Tout revient a que portainer est dans un développement actif, facile à implémenter et avec plusieurs guides accessibles dans l'internet. Donc c'est un outils parfait pour se familiariser avec la platform de gestion des environements. Pour l'instant, Portainer supporte les environements comme **Docker Standalone**, **Docker Swarm**, **Podman** et **Kubernetes**.

<div style="display: flex; align-items: center; gap: 20px;">
  <div >

  De plus, Portainer a part d'etre un outils pratique de gestion des environements, il permet d'implementer des équipes avec des differente role d'acces à des environements spécific
  </div>

  <img src="/images/Permission_roles.png" alt="Strangler Pattern" width="460px">
</div>

En bref, Portainer est un outil qui permet de centraliser la gestion des systèmes importants d'une organisation et aussi de former facilement des équipes de spécialistes responsables de la maintenance, de la création et de la gestion de ces mêmes systèmes.


<div style="display: flex; align-items: center; gap: 50px;">

  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/jxPUzn409XU" 
    frameborder="0" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
    allowfullscreen>
  </iframe>

  <div>
  Un résumer audio et visuel
  </div>

</div>




---
## Préparation de l'environement pour portainer

Pour experimenter avec Portainer, nous allons utiliser une machine virtuelle avec ubuntu server comme systeme d'opération. Elle est plus simple, car demande peu de préparation en comparaison avec l'installation dans WSL de Windows.

### Installer virtualBox
**Passer a ce lien :** https://www.virtualbox.org/wiki/Downloads
<img src="/images/Installation-virtualBox.png" alt="Choisir Windows hosts" width="700px">
Faite une installation par default de virtualBox

---

### Installer Ubuntu server Iso
**Installer iso de ubuntu server 24.04.3 LTS :** [Get Ubuntu Server | Download | Ubuntu](https://ubuntu.com/download/server)

<img src="/images/Installation_Iso-Ubuntu-serverP1.png" alt="Choisir Windows hosts" width="480px">
<img src="/images/Installation_Iso-Ubuntu-serverP2.png" alt="Choisir Windows hosts" width="480px">

---

### Installer Ubuntu server

<img src="/images/Installer_Ubuntu-serverP1.png" alt="Choisir Windows hosts" width="580px">

1. Donner un nom à votre machine virtuelle.
2. Créer un fichier facile à accéder pour votre machine et votre iso file de Ubuntu server.
3. Lesser le reste par default.
---
<img src="/images/Installer_Ubuntu-serverP2.png" alt="Choisir Windows hosts" width="580px">


1. **User Name :** Donner un nom a votre user. **Ne l'oublier pas**
2. **Password / Confirm Password :** Créer un mot de passe pour votre user. **Ne l'oublier pas**
3. **Host Name :** Donner un nom qui vous vous souviendrez. 
4. Lesser le reste par default
---
<img src="/images/Installer_Ubuntu-serverP31.png" alt="Choisir Windows hosts" width="580px">

1. **Base Memory** Donner au moins 6GB de RAM.
2. **Number of CPUs** Donner au moins quatre coeur.
3. Lesser le reste par default.
---
<img src="/images/Installer_Ubuntu-serverP41.png" alt="Choisir Windows hosts" width="580px">

1. Lesser le reste par default.
2. cliquer sur Finish
---
### Activer ssh pour faciliter les manipulations dans le terminal

1. sudo apt update
2. sudo apt install openssh-server -y
3. sudo systemctl enable ssh
3. sudo systemctl start ssh
**Vérifier que tout est activé.**
Ouvrez Windows PowerShell pour acceder à la machine virtuelle.
<img src="/images/ssh_Example.png" alt="Choisir Windows hosts" width="580px">

**ssh [Nom du user]@[IP adresse de la machine]**

---

## Installation du Docker

**N'oubliez pas de vous connecter par SSH pour pouvoir copier les commandes et de vous authentifier dans l'écran de la machine virtuelle, car certaines commandes vont vous dénier le droit d'exécution.**

### Ajouter les certificates pour permettre de verifier les packages Docker
```bash {lineNos="true" title="Installation pour augmenter la sécurité"}
# Mettre a jour les packages
sudo apt update

# Installer les clé publique de Docker pour Ubuntu
sudo apt install ca-certificates curl

# Donner les droits au répertoire keyrings (Stockage des clé)
sudo install -m 0755 -d /etc/apt/keyrings

# Installer la clé officielle de Docker dans le fichier docker.asc
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc

# Donner le droit de lecture à tout le monde.
sudo chmod a+r /etc/apt/keyrings/docker.asc

# Cherche l'architecture du système et sa version, demande d'utiliser la clé GPG pour vérifier le package
# Finaliser par une mise a jour des packages
echo \
"deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
$(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update
```
---
## Installation de Portainer

{{% notice style="tip" title="Installation en 2 minutes" %}}
Portainer s'installe lui-même comme un simple conteneur Docker !
{{% /notice %}}

### Installation Standard

```bash {lineNos="true" title="Installation Portainer CE"}
# Créer un volume pour persister les données
docker volume create portainer_data

# Démarrer Portainer
docker run -d -p 8000:8000 \ 
    -p 9443:9443 \
    --name portainer --restart=always \
    -v /var/run/docker.sock:/var/run/docker.sock \
    -v portainer_data:/data \
    portainer/portainer-ce:latest
```

{{% expand title="Voir l'explication détaillée des paramètres" %}}

- `-d` : Exécute le conteneur en arrière-plan
- `-p 8000:8000` : port pour l'utilisation des Edge Agents
- `-p 9443:9443` : Port HTTPS pour l'interface web sécurisée
- `--name portainer` : Nom du conteneur
- `--restart=always` : Redémarre automatiquement le conteneur
- `-v /var/run/docker.sock:/var/run/docker.sock` : Permet à Portainer de communiquer avec Docker
- `-v portainer_data:/data` : Volume pour sauvegarder la configuration

{{% /expand %}}

### Accès à l'interface

Une fois installé, accédez à Portainer via :
- **HTTPS** : `https://localhost:9443`
- **Remplacer le localhost avec le IP du Ubuntu server** 

{{% notice style="warning" title="Première connexion" %}}
Lors de la première connexion, vous devrez créer un compte administrateur. Assurez-vous d'utiliser un mot de passe fort de 12 caractères.
{{% /notice %}}

## Source

**Pourquoi la conteneurisation des logiciels est pratique :** 
https://www.cloudoptimo.com/blog/everything-you-need-to-know-about-containerization-benefits-use-cases-and-best-practices/

**Modernization des logiciels monolithe :** https://www.ibm.com/think/topics/application-modernization

**Introduction a portainer directement des develippeur de portainer :** https://www.youtube.com/watch?v=jxPUzn409XU

**Application monolithe :** https://www.moontechnolabs.com/blog/software-architecture-patterns/

**Image - Monolithic Architecture :** Moon Technolabs. (2025). Monolithic Architecture diagram [Image]. Retrieved December 5, 2025, from https://www.moontechnolabs.com/blog/software-architecture-patterns/

**Image - Strangler fig pattern :** altexsoft. (2024). Strangler fig pattern diagram [Image]. Retrieved December 5, 2025, from https://www.moontechnolabs.com/blog/software-architecture-patterns/

**Cloud Migration :** https://aws.amazon.com/what-is/cloud-migration/


**Guide d'installation Portainer :** https://www.learnlinux.tv/easy-portainer-setup-run-your-first-docker-container/


**Installation Docker usr Linux :** https://docs.docker.com/engine/install/ubuntu/

**Keyrings :** https://itsfoss.com/ubuntu-keyring/

