+++
title = "Portainer"
weight = 1
+++

# Portainer - Qu'est-ce que c'est ?

**Portainer** est une plateforme de gestion open-source qui fournit une interface graphique intuitive pour gérer vos environnements.


## C'est quoi un environnement et pourquoi l'utiliser?

Premièrement, il existe des outils d'orchestration de conteneurs, comme Docker Swarm, Kubernetes ou Nomad, ainsi que des moteurs de conteneurs, comme Docker, CRI‑O ou containerd. Tous ces outils sont des environnements qui peuvent créer et contenir des conteneurs.

Deuxièmement, avoir un environnement implique l'utilisation des conteneurs. C'est exactement grâce aux conteneurs que les applications peuvent être initialement développées pour être utilisées dans un conteneur à cause de la facilité de déployer un conteneur. Dans d'autres cas, les conteneurs sont pratiques dans la modernisation d'une application monolithe d'une compagnie.

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

---

# Pourquoi utiliser portainer?

Tout revient à ce que Portainer soit dans un développement actif, utilisé dans le marché du travail, facile à implémenter et avec plusieurs guides accessibles sur l'internet. Donc c'est un outil parfait pour se familiariser avec la plateforme de gestion des environnements. Pour l'instant, Portainer supporte les environnements comme **Docker Standalone**, **Docker Swarm**, **Podman** et **Kubernetes**.

---

## Les environnements supportés par Portainer

### Docker Standalone

**Docker Standalone** est la configuration la plus simple et la plus couramment utilisée pour le développement et les petits déploiements. C'est un moteur de conteneurs qui s'exécute sur un seul serveur ou machine.

Avec Docker Standalone, vous pouvez créer, exécuter et gérer des conteneurs individuels. C'est l'environnement idéal pour :
- **Le développement local :** Les développeurs peuvent tester leurs applications dans un conteneur avant de les pousser en production
- **Les petits projets :** Les applications avec peu de conteneurs n'ont pas besoin d'orchestration complexe
- **L'apprentissage :** Docker Standalone est facile à comprendre et rapidement mettre en place une appllication.

Cependant, Docker Standalone n'offre pas de fonctionnalités d'orchestration avancées. Si un conteneur s'arrête, il ne redémarre pas automatiquement. Si vous avez plusieurs conteneurs interdépendants, vous devez les gérer manuellement. Portainer résout ce problème en groupant les conteneurs interconnectés dans un seul stack.

### Docker Swarm

**Docker Swarm** est le système d'orchestration natif de Docker. Il transforme plusieurs machines (noeuds gestionnaire ou travailleur) en un cluster unique et les gère comme une seule entité nommer swarm. 

Docker Swarm est idéal pour :
- **scaling :** Un service peut avoir plusieurs répliques en cours d'exécution. Le gestionnaire Swarm peut s'adapter en ajoutant ou en enlevant des répliques pour maintenir l'état du cluster souhaité.
- **Réconciliation de l'état souhaité :** Gestionnaire Swarm surveille l'état du cluster pour qu'en cas d'une panne il puisse remplir les répliques manquantes.
-**La facilité d'utilisation :** Swarm est plus simple à apprendre que Kubernetes

Avec Swarm, vous déployez vos applications sous forme de "services", pas de conteneurs individuels. Un service est un groupe de conteneurs identiques qui tournent sur différents noeuds/clusters. Swarm gère automatiquement l'équilibre de charge entre ces conteneurs.

### Podman

**Podman** (Pod Manager) est une alternative à Docker qui gagne en popularité, notamment dans les environnements d'entreprise et open-source. Contrairement à Docker qui utilise un démon centralisé, Podman fonctionne sans démon, ce qui améliore la sécurité et la flexibilité.

Podman est particulièrement intéressant pour :
- **La sécurité renforcée :** Podman n'a pas besoin d'un démon root, ce qui réduit les vulnérabilités potentielles
- **La compatibilité Docker :** Vous pouvez utiliser les mêmes commandes que Docker (`podman` remplace `docker`)
- **La gestion des pods :** Podman peut gérer des pods (groupes de conteneurs partageant des ressources), pas seulement des conteneurs individuels.
- **Compatibilité Kubernetes :** L'utilisation des pods nativement permet une meilleure implémentation avec Kubernetes.

Portainer supporte Podman via sa connexion au API socket de Podman, permettant une gestion complète des conteneurs et des pods Podman à travers l'interface graphique.

### Kubernetes

**Kubernetes** est le système d'orchestration de conteneurs le plus complexe. Développé par Google et maintenant open-source, Kubernetes est devenu le standard de facto pour orchestrer les conteneurs à grande échelle.

Kubernetes est conçu pour :
- **Les déploiements massifs** : Gérer des milliers de conteneurs sur des centaines de noeuds
- **L'auto-scaling** : Augmenter ou diminuer automatiquement le nombre de conteneurs selon la charge
- **Les environnements cloud natifs** : Tous les grands fournisseurs cloud (AWS, Google Cloud, Azure) offrent Kubernetes managé

Cependant, Kubernetes est beaucoup plus complexe à apprendre et à configurer.
Portainer simplifie Kubernetes en fournissant une interface graphique pour visualiser et gérer les déploiements, les services et les pods sans avoir à utiliser la ligne de commande `kubectl`.

Avec Portainer, peu importe l'environnement que vous choisissez, vous pouvez le gérer via une interface unifiée et intuitive.



## Comparaison avec d'autres outils de gestion

### Portainer vs Docker Desktop

Docker Desktop est l'outil parfait pour les développeurs locaux individuels grâce à son interface graphique intuitive et son intégration native à Windows et macOS. Cependant, Docker Desktop est avant tout conçu pour le développement local et l'expérimentation. Portainer, en revanche, offre une solution d'entreprise qui permet de gérer plusieurs environnements Docker, des serveurs distants et même des clusters Kubernetes à partir d'une seule interface centralisée.

Docker Desktop ne propose pas de système de permissions avancé ni de gestion d'équipes. Portainer excelle dans ce domaine en offrant des rôles granulaires (administrateur, opérateur, utilisateur) et la possibilité de restreindre l'accès à certains environnements ou à certains conteneurs.

<div style="display: flex; align-items: center; gap: 20px;">
  <div >

  Portainer, à part d'être un outil pratique de gestion des environnements, permet d'implémenter des équipes avec des rôles différents d'accès à des environnements spécifiques.  
  </div>

  <img src="/images/Permission_roles.png" alt="Permission dans Portainer" width="460px">
</div>


### Portainer vs Kubernetes Dashboard

Kubernetes Dashboard est un outil de gestion natif pour Kubernetes, offrant une visibilité complète sur les déploiements, les services et les ressources. Cependant, Kubernetes est complexe à apprendre et à configurer, particulièrement pour les nouveaux utilisateurs.

Portainer propose une approche plus accessible en supportant à la fois Docker et Kubernetes. Pour les petits projets ou les équipes qui ne nécessitent pas la complexité de Kubernetes, Portainer sur Docker est une excellente alternative. De plus, Portainer peut servir de passerelle pour introduire progressivement Kubernetes dans une organisation sans remplacer complètement les outils existants.


## Cas d'usage réels et exemples pratiques

### Scénario 1 : Déploiement d'applications multi-conteneurs

Imaginez une petite startup ayant une application composée de trois services : un frontend (React), une API REST (Node.js) et une base de données (PostgreSQL). Avec Portainer, vous pouvez facilement définir et déployer tous ces conteneurs ensemble à partir d'une stack Docker Compose, sans avoir à taper une seule commande en ligne de commande.

### Scénario 2 : Gestion de plusieurs environnements

Une agence web ayant plusieurs clients peut utiliser Portainer pour gérer différents serveurs Docker, un pour chaque client ou environnement. L'administrateur peut ajouter plusieurs serveurs Docker distants à Portainer et les gérer tous depuis une seule interface.

### Scénario 3 : Transition vers une architecture moderne

Une entreprise ayant un monolithe legacy souhaite passer progressivement à une architecture microservices. Portainer facilite cette transition en permettant de tester les nouveaux services dans des conteneurs sans impacter l'application existante. Les responsables techniques peuvent facilement orchestrer le déploiement des nouveaux services et former l'équipe sur les concepts de conteneurisation.

### Avantages clés de Portainer

- **Simplicité d'installation** : Un seul conteneur Docker à démarrer
- **Gestion multi-environnements** : Gérez plusieurs serveurs Docker depuis une interface unique
- **Permissions granulaires** : Contrôlez qui a accès à quoi
- **Support multi-plateforme** : Docker, Docker Swarm, Kubernetes et Podman
- **Interface intuitive** : Pas besoin de connaître les commandes CLI Docker
- **Coût** : Version Community gratuite

En bref, Portainer est un outil qui permet de centraliser la gestion des systèmes importants d'une organisation et aussi de former facilement des équipes de spécialistes responsables de la maintenance, de la création et de la gestion de ces mêmes systèmes.


<div style="display: flex; align-items: center; gap: 50px;">

  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/jxPUzn409XU" 
    frameborder="0" 
    allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture" 
    allowfullscreen>
  </iframe>

  <div>
  Un résumé audio et visuel
  </div>

</div>




---
## Préparation de l'environement pour portainer

Pour experimenter avec Portainer, nous allons utiliser une machine virtuelle avec ubuntu server comme systeme d'opération. Elle est plus simple, car demande peu de préparation en comparaison avec l'installation dans WSL de Windows.

### Installer virtualBox
**Passer a ce lien :** https://www.virtualbox.org/wiki/Downloads
<img src="/images/Installation-virtualBox.png" alt="Installation virtualBox" width="700px">
Faites une installation par default de virtualBox

---

### Installer Ubuntu server Iso
**Installer iso de ubuntu server 24.04.3 LTS :** [Get Ubuntu Server | Download | Ubuntu](https://ubuntu.com/download/server)

<img src="/images/Installation_Iso-Ubuntu-serverP1.png" alt="Installation iso Ubuntu server partie 1" width="480px">
<img src="/images/Installation_Iso-Ubuntu-serverP2.png" alt="Installation iso Ubuntu server partie 2" width="480px">

---

### Installer Ubuntu server

<img src="/images/Installer_Ubuntu-serverP1.png" alt="Installation du Ubuntu server partie 1" width="580px">

1. Donner un nom à votre machine virtuelle.
2. Créer un fichier facile à accéder pour votre machine et votre iso file de Ubuntu server.
3. Laisser le reste par default.
---
<img src="/images/Installer_Ubuntu-serverP2.png" alt="Installation du Ubuntu server partie 2" width="580px">


1. **User Name :** Donner un nom a votre user. **Ne l'oublier pas**
2. **Password / Confirm Password :** Créer un mot de passe pour votre user. **Ne l'oublier pas**
3. **Host Name :** Donner un nom qui vous vous souviendrez. 
4. Lesser le reste par default
---
<img src="/images/Installer_Ubuntu-serverP31.png" alt="Installation du Ubuntu server partie 3" width="580px">

1. **Base Memory** Donner au moins 6GB de RAM.
2. **Number of CPUs** Donner au moins quatre coeur.
3. Lesser le reste par default.
---
<img src="/images/Installer_Ubuntu-serverP41.png" alt="Installation du Ubuntu server partie 4" width="580px">

1. Lesser le reste par default.
2. cliquer sur Finish
---
### Activer ssh pour faciliter les manipulations dans le terminal

```bash {lineNos="true" title="Installation du serveur ssh"}

sudo apt update
sudo apt install openssh-server -y
sudo systemctl enable ssh
sudo systemctl start ssh

sudo systemctl status ssh
```
  <img src="/images/systemctl_status_ssh.png" alt="Verifier que ssh est activer/enabled" width="660px">

**Vérifier que tout est activé.**
Ouvrez Windows PowerShell pour acceder à la machine virtuelle.
<img src="/images/ssh_Example.png" alt="Connexion  ssh à la machine virtuelle" width="580px">

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

```bash {lineNos="true" title="Ajouter user dans groupe docker"}
# Ajoutez-vous dans le groupe docker, lancez les commandes avec docker sans sudo.
sudo usermod -aG docker [votre nom]
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

---

## Fonctionnalités avancées de Portainer

### Déploiement via des stacks

Une stack dans Portainer est un ensemble des conteneurs Docker définis dans un fichier Docker Compose. Portainer permet de créer, modifier et déployer ces stacks via l'interface graphique.

### Monitoring et logs

<div style="display: flex; align-items: center; gap: 20px;">
  <div>
    Portainer offre une vue centralisée des performances des conteneurs : utilisation CPU, mémoire, réseau, etc. Les administrateurs peuvent surveiller la santé de leurs applications en temps réel et recevoir des alertes en cas d'anomalie. Les logs de chaque conteneur sont accessibles directement depuis leurs l'interface.
  </div>
    <img src="/images/Monitoring_Conteneurs.png" alt="Les options de surveillance d'un conteneur" width="460px">
</div>

### Gestion des registries et des images

<div >
  <div>
    Portainer permet de visualiser toutes les images Docker disponibles sur un serveur, de les tagger, de les supprimer ou de les pousser vers des registries distants. Cette fonctionnalité est particulièrement utile pour maintenir une hygiène de l'environnement et éviter l'accumulation d'images inutilisées.
  </div>
    <img src="/images/Images_list.png" alt="La liste des images installées" width="660px">
</div>

---


### Navigation dans l'interface

L'interface de Portainer est organisée de manière logique :
- **Dashboard :** Vue d'ensemble de tous les environnements
- **Containers :** Liste et gestion des conteneurs en cours d'exécution
- **Images :** Gestion des images Docker
- **Volumes :** Gestion des volumes pour la persistance des données
- **Networks :** Gestion des réseaux Docker
- **Stacks :** Déploiement de groupes de conteneurs

Prenez le temps d'explorer chaque section pour vous familiariser avec l'outil.

---

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

**Podman :** https://www.youtube.com/watch?v=5ZYGh0vgAbs&t=1118s

**Podman et Docker :** https://www.youtube.com/watch?v=SIvoAOpXZPg&t=4s

**Docker Swarm :** https://docs.docker.com/engine/swarm/

**Kubernetes :** https://kubernetes.io/docs/concepts/workloads/