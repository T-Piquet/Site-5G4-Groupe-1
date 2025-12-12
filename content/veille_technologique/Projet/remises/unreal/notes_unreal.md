---
title: "Notes de Cours : Fondations et Architecture d'Unreal Engine 5"
---
**Points Cibles :**
* Comprendre l'environnement UE5 comme étant le logiciel de création 3D d'Epic Games, conçu pour développer des jeux et des expériences interactives.
* Maîtriser les concepts fondamentaux du moteur : Actor, Component, Translation/Scale, et Matériaux.
* Saisir le rôle des outils clés de l'interface : Outliner, Details, Content Drawer.
* Distinguer la logique C++ et la logique des Blueprints.
* Présenter l'impact des technologies modernes (Nanite, Lumen) sorties ou modifiées récemment.

---

## Introduction et Architecture Unreal

### 1.1. UE5 : Un Framework de Développement 3D

Pour un programmeur, Unreal Engine 5 est un **Framework** conçu pour gérer la complexité de la 3D en temps réel. Au lieu d'écrire du code pour le rendu graphique, la physique, la gestion des entrées et la mémoire, Unreal fournit une infrastructure complète et optimisée.

Le **Rôle du Moteur** est de s'occuper de la **Boucle de Jeu (Game Loop)**, le processus répétitif qui gère l'entrée, met à jour la logique de jeu et dessine l'image à l'écran à chaque frame.

**La Boucle de Jeu se décompose typiquement comme suit :**
* **Gestion des Entrées (Input) :** Le moteur écoute les événements bruts du système d'exploitation (clavier, souris, manette).
* **Mise à Jour de la Logique (Tick) :** Le moteur parcourt tous les Actors et les Components pour exécuter leur logique de mise à jour (simulation physique, IA, Blueprints) pour la frame en cours.
* **Rendu (Render) :** Le moteur calcule la position finale de tous les éléments 3D, applique les matériaux et les lumières (en utilisant des systèmes comme Lumen et Nanite), et projette l'image 2D finale sur l'écran.

### 1.2. L'Architecture UObject

UE5 est écrit en C++, mais il utilise son propre système d'objets, le **UObject System**. C'est une extension du C++ qui ajoute des fonctionnalités cruciales pour un moteur graphique.

* **Introspection et Éditeur :** Ce système permet à l'éditeur de "lire" le code.
    * C'est ce qui permet au panneau **Details** d'afficher et de modifier des variables (comme l'Intensité d'une lumière ou l'Échelle d'un mur) sans recompiler le moteur.
    * C'est aussi ce qui permet aux **Blueprints** d'accéder aux fonctions C++.
* **Gestion de la Mémoire :** Le système UObject aide à la **Garbage Collection** en suivant les références des objets du moteur, ce qui simplifie la gestion de la mémoire pour le développeur.

### 1.3. Les Unités de Base : Actor, Component et Level

Dans UE5, toute la réalité du monde 3D se construit avec trois concepts simples:
* **Actor :** Toute entité/objet qui existe dans le monde 3D.
* **Component :** Une fonctionnalité ou un module attaché à un Actor.
* **Level :** Le fichier conteneur de la scène 3D.

L'architecture se complète avec des composants : au lieu d'avoir un Actor très complexe, on attache des modules (**Components**) à un Actor de base pour lui donner des capacités (physique, rendu, son, couleur, etc.).

---

## L'Interface et la Manipulation 3D

L'éditeur Unreal Engine est un environnement de développement puissant, mais nous nous concentrerons sur les plus basiques et importants.

### 2.1. Les Panneaux Clés
* **Viewport :** Fenêtre 3D où l’on peut manipuler et voir le monde.
* **Outliner/Explorateur de monde :** Liste contenant tout les Actors présents dans le niveau.
* **Details :** Donne la possibilité d’afficher et modifier toutes les propriétés d’un Actor (translation, matériaux, intensité, etc.).
* **Content Drawer/Tiroir à contenu :** Navigateur de fichiers/ressources utilisé pour le projet (matériaux, textures, modèles, squelettes, etc.).

### 2.2. Types de Components Fondamentaux

Il existe des centaines de Components, mais ils se regroupent tous en catégories logiques et précises.
* **Scene Components (USceneComponent) :** Ce sont les plus basiques. Ils définissent une transformation (position, rotation, échelle) dans le monde 3D. Un **Static Mesh Component** dérive de celui-ci.
* **Primitive Components (UPrimitiveComponent) :** Dérivent des **Scene Components**. Ce sont des composants qui ont une géométrie à des fins de rendu ou de collision (le Cube, la Sphère, le Cylindre).
* **Actor Components (UActorComponent) :** Ce sont des composants de logique pure qui n'ont pas de position dans le monde par défaut. Par exemple, un **Inventory Component** qui gère l'inventaire des objets du joueur. Il s'exécute mais n'apparairrait pas.

**Importance de l'Héritage dans les components :** Comprendre l'héritage des Components est essentiel.  Lorsque vous placez un Cube, l'Actor crée un **Static Mesh Component** pour afficher le maillage, un type de **Primitive Component** qui a les capacités de **Scene Component** (position) et d'**Actor Component** (logique de base).

### 2.3. Manipulation des Actors
Un Actor est une entité dans l’espace du niveau mais c’est avant et surtout un conteneur qui ne possède aucune fonctionnalité de lui-même. N’importe quelle fonctionnalité doit être emboîtée dans un Component.
* La principale caractéristique d’un Component est la **réutilisation**.
* La seule exception étant les Components statiques qui par exemples permettent de rendre visible une forme comme un Cube.

Toutes les formes pouvant être importées dans le projet peuvent être modifiées et modulées à la guise grâce aux détails.
* **Translation (Position / Location) :** C'est le vecteur (X, Y, Z) qui définit où l'Actor se trouve dans l'espace de notre niveau. *Exemple :* Mettre un mur à Z=100 va le surélever verticalement de 100 unités par rapport au sol.
* **Rotation :** Les angles autour des axes (en degrés) qui définissent l'orientation. *Exemple :* Régler la rotation Z à 70 pour faire tourner l’acteur vers une direction spécifique.
* **Échelle (Scale) :** Le facteur multiplicateur définissant la taille de l’Actor dans les 3 dimensions (X, Y, Z). *Exemple :* Utiliser Scale X=4.0 pour obtenir un Actor de 400 unités de long.

### 2.4. Unités et Accrochage
* **Unités :** Par défaut, Unreal Engine utilise le centimètre (cm) comme unité de mesure de base.
* **Duplication :** Lorsque la fonction de duplication est utilisée (Clic Droit > modifier > Dupliquer ou Ctrl + W), elle permet de recréer exactement un Actor avec les mêmes paramètres et détails que celui d’origine.

---

## Rendu et Éclairage

### 3.1. L'Éclairage
Dans Unreal Engine 5, la lumière est un Actor qui détermine non seulement la luminosité, mais aussi l'ambiance et la direction des ombres. Il existe quatre types de lumière primaire dans Unreal Engine qui imitent des sources lumineuses :

1.  **Point Light (Point lumineux) :** Émet la lumière dans toutes les directions à partir d'un seul point. C'est la lumière la plus courante pour simuler une ampoule basique.
2.  **Directional Light (Lumière directionnelle) :** Simule la lumière venant d'une source infiniment lointaine, émettant des rayons lumineux parallèles. Sa position n'a pas d'importance, seule son orientation (**Rotation**) compte.Peut s'avérer utile pour simuler un Soleil.
3.  **Spot Light (Projecteur) :** Émet la lumière à partir d'un point, mais uniquement dans un cône ou un angle défini. Utile pour simuler un projecteur ou un phare
4.  **Sky Light (Lumière du ciel) :** Capture l'éclairage de l'environnement lointain (le ciel, le terrain lointain) et le projette sur la scène. Ne représente pas une source de lumière directe.

### 3.2. Les Matériaux
Un Matériau est un programme (appelé *shader*) qui définit comment la lumière interagit avec un objet.

* **Couleur de Base (Base Color) :** L'entrée principale. Elle reçoit la couleur fondamentale de l'objet.
* **Le Nœud Constant3Vector :** C'est un nœud qui stocke une valeur vectorielle à trois composantes (R, V, B). *Exemple :* Rouge (R)=1, Vert (V)=0, Bleu (B)=0 donne une couleur rouge éclatante. 
* **Compilation :** Après avoir relié le nœud de couleur à **Base Color**, il est obligatoire de cliquer sur **Appliquer (Apply)** pour compiler le *shader* sur le GPU, puis sur **Sauvegarder (Save)**.

### 3.3. L'Émissivité
* **Couleur Émissive (Emissive Color) :** Cette entrée rend un Matériau lumineux, le faisant agir comme une source de lumière. *Exemple :* Une valeur élevée de 100 rendra un objet très lumineux.

---

## Logique de Jeu (C++ vs. Blueprints)

### 4.1. Blueprints
Les **Blueprints** sont le langage de *scripting* visuel par défaut. Ils sont essentiels pour le prototypage rapide et l'assemblage de la logique sans toucher au C++.
* **Fonctionnement :** Ils utilisent des nœuds pour représenter des fonctions, des événements (comme "le joueur touche ce mur" ou "le joueur appuie sur cette touche") ou des variables. L'ordre d'exécution est défini par des fils de connexion. 
* **Rôle :** Un développeur peut utiliser des Blueprints pour dire : "Événement : Le bouton est pressé, Action : le joueur saute, Données : La vitesse de saut du joueur”.

### 4.2. C++
Il est important de noter que tout ce qui est performant (le moteur de rendu, le moteur physique) est écrit en **C++**.
* **Rôle :** Le C++ est réservé aux systèmes complexes, aux calculs lourds, aux classes de base (comme AActor) et à la performance pure.
* **Interaction :** Les programmeurs écrivent le code C++ rapide, puis l'exposent aux Blueprints pour que ceux qui utilisent les Blueprints n’aient pas besoin d’écrire de code.

---

## Les Avancées Majeures d'UE5

### 5.1. Nanite : Simplification de la Géométrie
* **Problèmatique :** Avant Nanite, un modèle très détaillé (millions de polygones) rendait le jeu lent. Il fallait créer des versions simplifiées pour les objets éloignés.
* **Solution Nanite :** Nanite gère des géométries extrêmement complexes sans pénalité de performance. Il ne dessine que les polygones strictement nécessaires pour chaque pixel visible à l'écran, gérant l'optimisation automatiquement.
* **Impact :** Les versions simplifiées ne sont plus nécessaires pour empecher des pertes de performances. Un mur par exemple peut etre importé avec chaque morceau de béton modélisé et détaillé.

### 5.2. Lumen : Éclairage Global Dynamique
* **Problématique :** Pour un éclairage réaliste (lumière indirecte et rebonds), il fallait précalculer la lumière. Si on déplaçait la lumière, il fallait tout recommencer ce qui faisait perdre énormément de temps et de ressources.
* **Solution Lumen :** Lumen calcule l'illumination globale et les réflexions en temps réel de lui-meme.
* **Impact :** Si nous déplacions notre point de lumière, les ombres s'ajusteraient instantanément et la teinte des couleurs des Actors se refléterait légèrement sur le sol par exemple.Cela accélère énormément le travail d'éclairage. 

### 5.3. Création de Contenu Procédural
* **Principe :** Au lieu de placer manuellement des centaines d'objets (arbres, roches, ruines) dans un monde ouvert, les outils de création de contenu procédural (**PCG**) utilisent des règles et algorithmes pour générer ces éléments automatiquement.
* **Impact :** Rend la création de "Megaworlds" (mondes gigantesques) gérés par **World Partition** possible en automatisant la distribution de la végétation ou des structures sur tout le niveau.

---

## Exemples Concrets d'Utilisation

Plusieurs acteurs de l’industrie utilisent ces concepts clés et fondamentaux afin de créer leurs projets.
* **Production Virtuelle (Cinéma/TV) :** L'éclairage Lumen et la géométrie Nanite sont projetés sur d'énormes écrans LED sur les plateaux de tournage, créant des décors virtuels en temps réel qui interagissent physiquement avec les acteurs.
* **Visualisation Architecturale :** Les Architectes utilisent les Actors (Murs, Portes) et les Matériaux pour créer des visites virtuelles photoréalistes de bâtiments non construits.
* **MetaHumans :** Le système permet de créer des personnages humains ultra-réalistes en quelques heures, utilisant les mêmes principes de Components pour les cheveux, le squelette et la logique d'animation.

---

## Conclusion

Notre exploration des fondations d'Unreal Engine 5, allant de la construction de base à la gestion de l'éclairage et des matériaux, révèle l'essence de ce moteur : un environnement qui vise à simplifier la complexité de la 3D. Le socle C++/UObject assure la performance et la structure, tandis que les outils visuels (Blueprints, Éditeur de Matériaux) offrent l'accessibilité et la rapidité d'itération. L’union des deux permet de pouvoir créer et moduler les projets que l’on désire même si nos compétences en programmation sont moins développées que ce qu’il faut.

L'objectif actuel étant d'avoir une **PCG guidée principalement par l'IA** et la création complète de NPC ou dialogues entre NPC à l'aide de l'IA. Cette évolution continue assure qu'UE5 restera à la pointe de la création de contenu interactif.

---
### 7. Sources

Les sources suivantes ont été utilisées pour créer et développer le contenu des notes de cours :

* [Notes de version Unreal Engine 5.4](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5.4-release-notes?application_version=5.4)
* [Notes de version Unreal Engine 5.5](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5-5-release-notes)
* [Notes de version Unreal Engine 5.7](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5-7-release-notes)
* [Éclairage de l'environnement dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/lighting-the-environment-in-unreal-engine)
* [Les Actors dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/actors-in-unreal-engine)
* [Tutoriel : Introduction à la génération de contenu procédural (PCG) UE 5.5](https://dev.epicgames.com/community/learning/tutorials/LP6b/unreal-engine-5-5-introduction-to-pcg)
* [Nanite : Géométrie virtualisée dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/nanite-virtualized-geometry-in-unreal-engine)
* [Introduction aux Blueprints (Unreal Engine Blog)](https://www.unrealengine.com/fr/blog/introduction-to-blueprints)
* [Programmation en C++ dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/programming-with-cplusplus-in-unreal-engine)
* [Matériaux dans Unreal Engine](https://dev.epicgames.com/documentation/fr-fr/unreal-engine/unreal-engine-materials)
* [Site Officiel MetaHuman](https://www.metahuman.com/en-US)
* [Qu'est-ce que l'architecture basée sur les composants ? (Mendix)](https://www.mendix.com/fr/blog/what-is-component-based-architecture/#:~:text=L'architecture%20%C3%A0%20base%20de,sans%20modification%20des%20autres%20composants.)
* [Expressions de matériaux 'Constant' dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/constant-material-expressions-in-unreal-engine)
* Contenu de l'atelier et de la veille technologique.