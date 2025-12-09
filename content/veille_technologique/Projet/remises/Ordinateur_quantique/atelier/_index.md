---
title: "Atelier Q# : Premiers pas en informatique quantique"
date: 2025-12-02
draft: false
---


Ce document est pensé pour que même un·e débutant·e puisse suivre l’atelier sans être perdu·e.

Tu vas apprendre à :
- Installer un environnement Q# basé sur .NET et Docker.
- Créer, exécuter et modifier des programmes Q#.
- Découvrir les concepts suivants : qubit, superposition, mesure, statistiques, intrication (états de Bell) et une mini-version de Grover.

Documentation officielle : https://learn.microsoft.com/en-us/azure/quantum/

---

## 1. Mise en place de l’environnement Q#

### 1.1 Prérequis
Installe sur ta machine (ou vérifie qu’ils sont présents) :
1. Docker (Docker Desktop ou Docker Engine)
2. Visual Studio Code (VS Code)
3. Extension VS Code : Dev Containers (`ms-vscode-remote.remote-containers`)
4. Connexion Internet pour le premier build du conteneur

> Nous travaillons dans un devcontainer contenant .NET et les outils Q#.

### 1.2 Contenu du ZIP fourni
Le ZIP contient le devcontainer prêt à l'emploi avec :
- `.devcontainer/devcontainer.json` — configuration du conteneur (fichier dans le repo : [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json))
- `.devcontainer/Dockerfile` — image Docker utilisée (fichier dans le repo : [`.devcontainer/Dockerfile`](.devcontainer/Dockerfile))
- Un dossier `examples/` contenant des programmes Q# d'exemple
- Un README local expliquant les commandes de base

### 1.3 Télécharger et placer le ZIP
1. Dépose le fichier ZIP nommé `.devcontainer.zip` dans le répertoire suivant du dépôt 

[Télécharger le devcontainer Q# (ZIP)](/fichiers/.devcontainer.zip)

---

## 2. Ouvrir le projet dans VS Code (Dev Container)

1. Ouvre VS Code.
2. Ouvre le dossier racine du projet contenant `.devcontainer/`.
3. Clique sur l'icône "><" (Remote - Containers) et choisis "Reopen in Container".
4. VS Code va builder l'image et ouvrir l'atelier dans le conteneur. Les outils .NET et Q# seront disponibles.

Si tu préfères utiliser le ZIP téléchargé :
- Décompresse `qsharp-devcontainer.zip` dans un dossier local `qsharp-ateliers/`.
- Ouvre ce dossier dans VS Code et choisis "Reopen in Container".

---

## 3. Contenu essentiel et commandes

Fichiers clés dans le dépôt (liens pour ouvrir) :
- Devcontainer config : [`.devcontainer/devcontainer.json`](.devcontainer/devcontainer.json)
- Dockerfile : [`.devcontainer/Dockerfile`](.devcontainer/Dockerfile)
- Ce guide : [`content/veille_technologique/Projet/remises/Ordinateur quantique/arelier.md`](content/veille_technologique/Projet/remises/Ordinateur\ quantique/arelier.md)

Commandes utiles (dans le terminal du conteneur) :
```bash
# Créer un projet Q# console
dotnet new console -lang Q# -o MonProjetQSharp
cd MonProjetQSharp

# Exécuter
dotnet run
```
