+++
title = "Notes de cours"
weight = 2
+++

## Installations nécessaire

Aller sur ce site et installer la version x64 de Rust : [ici](https://rust-lang.org/fr/learn/get-started/)

Ensuite faire le commande suivant pour vérifier que l'installation à bien fonctionnée :

![alt text](../rust_version.png)

## Information sur l'installation :

![alt text](../info_installation.png)

- **Cargo** est le gestionnaire de paquets officiel de Rust. Il permet non seulement d’installer et de mettre à jour des dépendances externes, mais aussi de compiler le projet, de lancer des tests automatisés et de générer des exécutables. En pratique, c’est l’outil central qui simplifie la gestion de projets Rust, car il automatise des tâches qui seraient longues à réaliser manuellement.

- **Clippy** est un outil d'analyse statique spécialisé pour Rust. Il analyse le code source afin de détecter des erreurs courantes, des mauvaises pratiques ou des constructions qui ne suivent pas les conventions de style propres à Rust. En plus de signaler les problèmes, il propose des améliorations pour rendre le code plus lisible, plus efficace et conforme aux standards de la communauté Rust. C’est un outil précieux pour progresser et écrire du code robuste.

- **Rust-docs** correspond à une copie locale de la documentation officielle de Rust. Elle est installée avec la chaîne d'outils Rust(c'est à dire l'ensemble des programmes nécessaires pour compiler, gérer et documenter le code) et permet de consulter toutes les références, guides et explications sans connexion internet. Cela facilite l’apprentissage et le dépannage, car tu peux accéder rapidement aux descriptions des fonctions, des modules et des concepts du langage.

- **Rust-std** est la bibliothèque standard de Rust. Elle contient les fonctionnalités de base nécessaires à la plupart des programmes : gestion des chaînes de caractères, collections (vecteurs, hashmaps), entrées/sorties, gestion des threads, etc. Sans cette librairie, il serait impossible d’écrire du code Rust pratique, car elle fournit les fondations essentielles du langage.

- **Rustc** est le compilateur officiel de Rust. C’est lui qui traduit ton code source écrit en Rust vers du code machine exécutable par ton ordinateur. Il s’assure également du respect des règles de sécurité mémoire et du contrôle rigoureux des types qui font la réputation de Rust. En général, tu n’appelles pas directement rustc, car Cargo s’en charge pour toi, mais il reste le coeur du processus de compilation.

- **Rustfmt** est un outil de formatage automatique du code. Il applique des règles de style standardisées afin que le code soit propre, lisible et cohérent, peu importe qui l’écrit. Cela évite les débats sur la mise en forme et permet de se concentrer sur la logique du programme. En équipe, Rustfmt garantit une uniformité qui facilite la maintenance et la collaboration.

## Extensions VS Code pour Rust

- **Rust-analyzer** : Cette extension est essentielle pour travailler efficacement avec Rust dans Visual Studio Code. Elle fournit une aide intelligente à l’écriture du code grâce à l’autocomplétion, la coloration syntaxique avancée, la navigation entre les définitions et les suggestions contextuelles. Rust-analyzer permet aussi de lancer le compilateur directement depuis l’interface de VS Code, mais il est recommandé de ne pas utiliser cette fonction pour exécuter vos projets. La méthode correcte et idiomatique consiste à utiliser la commande cargo run dans le terminal intégré. Cela garantit que le projet est compilé et exécuté dans son environnement complet, en respectant la configuration du Cargo.toml et les dépendances définies.

![alt text](../extension_rust-analyzer.png)

- **CodeLLDB** : Cette extension ajoute un débogueur puissant pour Rust (et C/C++). Elle permet de placer des points d’arrêt, d’inspecter les variables, de suivre l’exécution pas à pas et de comprendre le comportement interne du programme. Grâce à CodeLLDB, vous pouvez analyser les erreurs logiques ou les comportements inattendus de votre code Rust directement dans VS Code, ce qui facilite énormément le processus de correction et d’optimisation.

![alt text](../extension_codelldb.png)

## Changement de settings

Il est possible que Visual Studio Code ne reconnaisse pas automatiquement les commandes rustc et cargo après l’installation de Rust. Dans ce cas, il faut configurer manuellement le PATH afin que l’éditeur puisse accéder aux outils de compilation et de gestion de projets.

![alt text](../settings.png)

Sélectionnez les paramètres utilisateur. Ensuite ajoutez ce code à la fin :

```json
"terminal.integrated.env.windows": {
    "PATH": "C:\\Users\\Antoi\\.cargo\\bin;${env:PATH}"
  }
```

Cette configuration indique au terminal intégré de VS Code où trouver les exécutables de Rust. Le dossier .cargo/bin contient les outils essentiels comme cargo et rustc, et ${env:PATH} permet de conserver les autres chemins déjà définis dans votre système.

Pour garantir que vous utilisez une version stable et compatible de Rust, il est recommandé d’installer et de définir la version stable par défaut avec rustup :

```cmd
rustup install stable-x86_64-pc-windows-gnu
rustup default stable-x86_64-pc-windows-gnu
```

Ces commandes assurent que votre environnement Rust est cohérent et que VS Code utilise toujours la bonne version du compilateur.

## Création et lancement d'un projet rust

Une fois le PATH configuré, vous pouvez créer un nouveau projet Rust directement depuis le terminal intégré de VS Code. La commande est :

```cmd
cargo new projet_rust
```

Ensuite pour lancer le projet, il faut faire cette commande :

```cmd
cargo run
```

Ensuite pour lancer le débogueur, il faut faire quelque étapes supplémentaire :

- Faite Ctrl + Shift + D dans vs code. Cela ouvre directement la section Exécuter et déboguer dans VS Code
- Cliquez sur Exécuter et déboguer. Cela permet de créer une configuration de débogage adaptée à votre projet Rust. Le fichier launch.json est créé automatiquement :
  ![alt text](../deboguer.png)
- Lorsque VS Code vous propose différents environnements, sélectionnez CodeLLDB. C’est l’extension qui permet de déboguer du code Rust (et aussi C/C++). Elle vous donnera accès aux points d’arrêt, à l’inspection des variables et au suivi pas à pas de l’exécution. Nous l'avons installer un peu plus tôt :
  ![alt text](../choix_debogue.png)
- Dans la configuration générée, il est nécessaire d’ajouter le chemin correct vers vos exécutables Rust. Cela garantit que le débogueur sait où trouver le binaire compilé par Cargo. Sans cette étape, le débogage risque de ne pas fonctionner correctement :
  ![alt text](../chemin.png)

## Source

- https://www.youtube.com/watch?v=ZhedgZtd8gw
- https://rust-lang.org/fr/learn/get-started/
- https://certiquizz.com/fr/cours/programmation/rust/rust-de-zero-a-operationnel/installation-et-configuration-de-l-environnement-de-developpement#:~:text=C%27est%20un%20installateur%20de%20toolchains%20Rust%20qui%20vous,versions%20de%20Rust%20%28stable%2C%20beta%2C%20nightly%29%20si%20n%C3%A9cessaire.
- https://learn.microsoft.com/fr-fr/windows/dev-environment/rust/overview
