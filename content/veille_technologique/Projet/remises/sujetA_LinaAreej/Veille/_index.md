+++
title = "Veille technologique Unity"
weight = 50
+++

### Prompt

« Explique-moi de manière détaillée ce qu’est Unity, comment il fonctionne et dans quels contextes on l’utilise. Parle des points suivants :

L'architecture, ses concepts principaux, ses fonctionnalités importantes, ses avantages et ses limites par rapport aux autres de jeux moteurs, ses tendances actuelles et les nouveautés de sa création à 2025 (Évolution).  
Réponds comme si tu enseignais à des étudiants en informatique du cegep, mais qui ne connaissent pas encore Unity.  
Donne une réponse structurée, technique et complète. »

---

### Réponse du LLM

{{% expand title="Unity - Cliquez pour afficher" %}}

## 1. C'est quoi Unity, en une phrase ?

Unity est un moteur de jeu temps réel multiplateforme qui permet de créer des expériences 2D, 3D, AR/VR et des simulations interactives, en utilisant principalement le langage C#, et en exportant vers presque toutes les plateformes (PC, mobile, console, web, XR…).

## 2. Architecture générale de Unity

On peut simplifier l'architecture de Unity en plusieurs couches :

### Editor (Unity Editor)

Application de bureau (Windows / macOS) où tu :
- importes tes assets (modèles 3D, sprites, sons, scripts…)
- construis des Scenes
- configures les composants
- lances le jeu en Play Mode

L'éditeur lui-même est extensible via des scripts C# (Editor scripts, custom windows, etc.).

### Runtime Engine

**Core C++** : moteur bas niveau (rendu, physique, audio, animation…).

**Scripting C#** : ta logique de jeu, via l'API Unity (MonoBehaviour, coroutines, etc.).

**Systèmes intégrés** :
- **Rendering** : Scriptable Render Pipeline (URP, HDRP), gestion des shaders, post-processing.
- **Physique** : moteurs de physique (3D et 2D), collisions, rigidbodies.
- **Animation** : Animator, state machines, blend trees.
- **Audio** : AudioSource, AudioListener.

### Data-oriented stack (DOTS / ECS)

Nouvelle approche data-oriented parallèle à l'architecture classique GameObject / MonoBehaviour.

**ECS (Entity Component System)** : séparation stricte des données (components), des systèmes (logique) et des entités (identifiants).

**Objectif** : meilleures performances, meilleure scalabilité (des milliers d'entités, simulation massive, etc.).

### Build & déploiement

Unity prend ta scène + tes assets + tes scripts, et génère un exécutable ou un package pour :
- Windows, macOS, Linux
- iOS, Android
- WebGL
- consoles
- casques VR/AR

## 3. Concepts principaux

### 3.1 Scene

Une Scene est comme un niveau ou un "monde" du jeu. C'est un fichier qui contient une hiérarchie d'objets (GameObjects) et tous leurs composants.

### 3.2 GameObject

Un GameObject est une entité "vide" qui ne fait rien par défaut. C'est un conteneur : tu lui ajoutes des Components pour lui donner un comportement (mesh, collider, script, audio…).

### 3.3 Components

Un Component est une "brique" qui contient des données et/ou du comportement.

**Exemples** :
- **Transform** (obligatoire) : position, rotation, échelle.
- MeshRenderer, Collider, Rigidbody, AudioSource, Camera, etc.
- tes scripts C# dérivés de MonoBehaviour.

### 3.4 MonoBehaviour et scripts C#

Pour écrire la logique de jeu, tu crées des classes C# qui héritent de MonoBehaviour. Unity appelle automatiquement certaines méthodes :

- `Start()` → initialisation
- `Update()` → logique par frame
- `FixedUpdate()` → logique physique
- `OnTriggerEnter()`, `OnCollisionEnter()`, etc.

### 3.5 Prefabs

Un Prefab est un modèle d'object préconfiguré (ex : ennemi, projectile, UI element) qu'on peut instancier à l'infini.

### 3.6 Asset Pipeline

Unity gère un pipeline d'import : tu glisses un FBX, un PNG ou un fichier audio dans ton projet, il est importé, converti, compressé et optimisé en fonction de la plateforme cible.

### 3.7 DOTS / ECS (niveau un peu plus avancé)

Tu peux laisser de côté pour débuter, mais pour les jeux très ambitieux :

- **Entities** : identifiants d'objets logiques.
- **Components** : purs conteneurs de données, sans logique.
- **Systems** : fonctions qui parcourent les données et les modifient en parallèle.

## 4. Fonctionnalités importantes

### 4.1 Multi-plateforme

Unity supporte plus de plateformes que la plupart des moteurs : PC, mobile (iOS/Android), consoles, web (WebGL), XR, etc.

### 4.2 2D & 3D

- **2D** : sprites, tilemaps, collisions 2D, animation spritesheet.
- **3D** : modèles 3D, matériaux, shaders, lumière, post-processing, etc.

### 4.3 Pipelines de rendu (URP / HDRP)

**URP (Universal Render Pipeline)** : pipeline polyvalent, optimisé mobile/PC/consoles, supporte des fonctionnalités modernes (post-processing, shader graph, VRS sur certaines plateformes, etc.).

**HDRP (High Definition Render Pipeline)** : ciblé haute qualité graphique (PC haut de gamme / consoles), support de l'éclairage physique, volumétrique, etc.

### 4.4 Outils artistiques

- **Terrain** : édition de terrains, peinture de textures, végétation.
- **Timeline & Cinemachine** : cutscenes, caméras intelligentes, transitions douces.

### 4.5 Physique et animation

- Moteurs de physique 3D/2D intégrés, raycasts, triggers…
- Système d'animation avec Animator Controller, blend trees, inverse kinematics (IK).

### 4.6 UI (User Interface)

Système d'UI (Canvas, TextMeshPro, Buttons, Sliders…) pour menus, HUD, inventaires, etc.

### 4.7 Asset Store & écosystème

**Unity Asset Store** : marketplace où tu peux acheter / télécharger des assets (3D, scripts, systèmes complets, shaders…).

### 4.8 Services en ligne / cloud

Ads, Analytics, relay/multiplayer, services pour monétisation et live ops (selon les offres Unity).

### 4.9 IA générative (Unity Muse, Sentis)

Avec Unity 6, Unity a ajouté :

- **Unity Muse** : outils de génération assistée (assets, code, comportements) avec IA générative.
- **Unity Sentis** : exécution locale de modèles de deep learning dans le runtime Unity.

## 5. Avantages de Unity par rapport aux autres moteurs

Par rapport à Unreal Engine et Godot, par exemple :

### Accessibilité / apprentissage

Interface jugée plus simple pour débuter. C# est souvent perçu comme plus accessible que C++ (Unreal) pour des étudiants de cégep.

### Multi-plateforme très large

Supporte énormément de plateformes avec un pipeline relativement unifié.

### Écosystème et communauté

Énorme communauté, beaucoup de tutoriels, forums, exemples, packages.

### Asset Store très riche

Permet de prototyper très vite (acheter un système d'inventaire, du pathfinding avancé, des packs d'environnements, etc.).

### Polyvalence

Très utilisé hors jeux : architecture, film, visualisation industrielle, XR, serious games, etc.

## 6. Limites et inconvénients

### Modèle commercial / confiance des développeurs

Unity a eu plusieurs controverses, notamment la tentative de Runtime Fee en 2023–2024 (frais par installation), qui a choqué la communauté. Unity a finalement annulé ce modèle après un gros backlash, mais la confiance a été ébranlée.

### Performance vs moteurs spécialisés

Pour des open-world AAA ultra haut de gamme, Unreal Engine (C++ + Nanite, Lumen…) reste souvent mieux optimisé.

Unity peut être très performant, mais il faut connaître DOTS/ECS, profiler, optimiser les allocations, etc.

### Pas open source

Contrairement à Godot, Unity est propriétaire. Tu n'as pas accès au code complet du moteur, et tu dépends des choix business de Unity Technologies.

### Complexité croissante de l'écosystème

Multiplication des packages, changements de pipelines (Builtin vs URP/HDRP), versions parfois instables, gros projets difficiles à migrer.

### Situation financière et organisationnelle

Unity a connu plusieurs vagues de licenciements 2023–2025, ce qui soulève des questions sur la stratégie et la stabilité à long terme.

## 7. Évolution et tendances de Unity (2005 → 2025)

### 7.1 Débuts (Unity 1.x à 4.x)

2005 : première version sur Mac, objectif de "démocratiser" le développement de jeux.

Progressivement étendu à Windows, webplayers, mobiles.

### 7.2 Période Unity 5 → Unity 2017–2021

Passage à un modèle de versionnement par année (Unity 2017, 2018, etc.).

**Introduction de** :
- Scriptable Render Pipelines (HDRP, URP).
- Timeline, Cinemachine.
- Meilleur support VR/AR.

### 7.3 2021–2023 : DOTS, packages, services

- Travail sur DOTS/ECS pour des projets plus ambitieux.
- Multiplication des services live-ops, analytics, monétisation.

### 7.4 2024–2025 : Unity 6, IA générative, roadmap 2025

**Unity 6 (octobre 2024)** : nouvelles fonctionnalités de rendu et de performance, outils IA (Muse, Sentis), améliorations du workflow pour le multi-joueur, focus sur le web et les performances.

**Roadmap 2025** : mise à jour de l'éditeur (ergonomie, productivité), optimisation des builds, support étendu des plateformes (XR, consoles), outillage plus puissant pour le profiling et le travail en équipe.

**Contexte industrie** : Partenariat récent avec Epic pour permettre à des jeux Unity de tourner dans Fortnite (créateur d'économie cross-engine, vision "open metaverse").

## 8. Contextes d'utilisation typiques

### Jeux mobiles (2D/3D)

Casual, hyper-casual, gacha, etc. Unity est ultra dominant sur ce marché.

### Jeux indie sur PC / consoles

Platformers, roguelites, jeux narratifs, etc.

### AR / VR / XR

Projets pour Meta Quest, HoloLens, etc., expériences interactives dans le milieu médical, industriel, éducatif.

### Serious games & simulations

Formation, simulateurs de conduite, simulation industrielle/robotique, visualisation scientifique.

### Architecture / visualisation

Visualisation en temps réel d'immeubles, visites virtuelles, configurateurs 3D pour clients.

### Cinéma / vidéo

Previs, tournage sur fond LED, adaptation similaire à ce qu'on voit avec Unreal, mais Unity commence aussi à se positionner.

## 9. Résumé pour des étudiants de cégep

Unity est un moteur généraliste, très polyvalent, efficace pour apprendre :
- la programmation orientée objet en C#
- la logique de jeu temps réel (boucle de jeu, frame, physique, input)
- les notions de rendu 3D/2D modernes
- la gestion de projets multi-plateforme

Pour un étudiant de 5e session, c'est un excellent moteur pour :
- prototyper rapidement des jeux
- expérimenter avec la physique, l'IA, la génération procédurale
- faire des projets XR ou des serious games

---

*Modèle utilisé : GPT-5.1 Thinking, réponse datée de 2025-11-25*

{{% /expand %}}

### Sources utilisé par le LLM
- https://unity.com/
- https://docs.unity3d.com/
- https://learn.unity.com/

---
## Analyse critique de la réponse du LLM


La réponse du LLM était particulièrement longue et structurée. Elle a plusieurs caractéristiques importantes à discuter dans le cadre d’une veille technologique.

Points forts :

La réponse donnée par le LLM suit un plan qui est bien structuré. Il aborde des sujets importants tel que l’architecture, les concepts les fonctionnalités et les tendances. Les informations qu’il nous a procuré correspondent bien aux notes de cours voulues. Il nous parle des maintes fonctionnalités de Unity comme : GameObjects, Scenes, Components, MonoBehaviour, URP / HDRP, Animation, Physique, UI, Asset Store, DOTS (Entity Component System), Unity Muse / IA générative. Il couvre les aspects techniques et industriels du moteur de jeux vidéo, ainsi le principe de veille technologique est pris en considération.

ChatGPT fait attention de bien suivre l’instruction d’expliquer le cours à des étudiants en informatique du cégep. Il aborde des sujets qu’il considère déjà acquis tel que certains langages de programmation ou des termes techniques (C#, ECS, pipeline, runtime, multi-plateforme) ce qui rend les notes plus légères mais complète et compréhensible.

Le LLM se base sur les notions qui pense utiles pour mieux comprendre Unity au lieu de parler simplement de la théorie. Il parle des scènes, des objets de jeux et bien plus.

Limites de la réponse :

Le LLM répond plus ou moins de façon assez générale. Il est vrai qu’il décrit bien ce qu’est Unity, mais il ne fournit pas vraiment d’exemples concrets qu’on pourrait Integer pour bien comprendre et assimiler le sujet. Il répond avec seulement quelques phrases sans aller en profondeur.Il y a des sections qui ont été passer très rapidement comme la comparaison entre les pipelines de rendu. Il pense peut-être que le sujet est déjà acquis ou qu'il juge cette partie comme non importante. Avec l'utilisation du LLM on peux constater qu'il fournit juste de la théorie et pas d'attributs visuels tel que des images ou des vidéos.
Les sources utiliser peuvent potentiellement être fausse ou hors sujet. C’est un des risques d’utiliser une IA pour générer des notes sur un sujet qui nous est étranger.

---

## Comparaison avec un moteur de recherche

Si on vient comparer ChatGPT à une simple recherche google on remarque très rapidement qu’il faut vraiment en mettre du sien pour parvenir à une réponse complète :

Le LLM génère une réponse avec une vue d’ensemble et propose différents points sur le sujet. Ainsi on reçoit une réponse immédiate avec pas mal d’informations pour comprendre.

D’autre part, un moteur de recherche basique tel que Google, nous retournera que des sites et il est de notre devoir de se renseigner sur le sujet. La collecte d’information se fait de notre côté contrairement à un LLM qui cherche à notre place.

Pour une recherche approfondit et précise il est, mieux d’opter pour un moteur de recherche, mais rien n’empêche de préparer un plan de recherche avec un IA pour peaufiner le travail.

---

## Sources retenues pour les notes de cours

{{% expand title="Cliquez pour afficher" %}}

#####  Documentation officielle Unity (principale source fiable)
Unity Architecture (2022.3)
https://docs.unity3d.com/2022.3/Documentation/Manual/UnityArchitecture.html

GameObject API (Unity 6000.0)
https://docs.unity3d.com/6000.0/Documentation/ScriptReference/GameObject.html

Création de prefabs
https://docs.unity3d.com/2023.2/Documentation/Manual/CreatingPrefabs.html

Sprites et configuration 2D
https://docs.unity3d.com/2022.3/Documentation/Manual/sprites-setup.html

Animation / Animator / State Machines
https://docs.unity3d.com/2022.3/Documentation/ScriptReference/Animation.html

https://docs.unity3d.com/6000.0/Documentation/Manual/class-AnimatorController.html

https://docs.unity3d.com/6000.2/Documentation/Manual/StateMachineTransitions.html

UI : Canvas, Buttons, RectTransform
https://docs.unity3d.com/2020.1/Documentation/Manual/UICanvas.html

https://docs.unity3d.com/6000.0/Documentation/ScriptReference/RectTransform.html

https://docs.unity3d.com/2022.3/Documentation/Manual/UIE-uxml-element-Button.html


###### Justification
Ces documents sont les plus sûrs puisque l'on y voit comment le moteur marche vraiment.
Elles incluent les mises à jour pour les années 2022 jusqu'à 2025, ce qui est crucial pour se tenir au courant des avancées.

---
#####  Articles pédagogiques / tutoriels techniques externes

Comprendre les scenes dans Unity (bob-le-developpeur)
https://www.bob-le-developpeur.com/notions/scenes-unity

Initiation au scripting C# dans Unity
https://voldedk.github.io/EasyLearn/csharp-scripting-unity.html

Comprendre les colliders 2D
https://studios.artanode.com/understanding-2d-colliders-in-unity/

Élément Text dans Unity
https://www.tutorialspoint.com/unity/unity_text_element.htm


###### Justification
Références bien connues dans les cercles francophones et anglophones.
- Cela aide à l'apprentissage grâce à des explications plus claires que celles du manuel de base.
- Je peux y intégrer des cas pratiques directement dans mes notes.

---
#####  Article général pour l’introduction

Qu’est-ce que Unity (créativos online)
https://fr.creativosonline.org/Qu%27est-ce-que-Unity%2C-le-moteur-de-jeu-vid%C3%A9o-le-plus-populaire-et-le-plus-polyvalent-%3F.html

###### Justification
Bon point de départ pour écrire une présentation simple du moteur.
- Fournit un aperçu accessible, pertinent pour positionner Unity dans le secteur.

---
#####  Source algorithmique (pour la section pathfinding de la démo)

Bien que le projet soit axé sur Unity, une portion mineure concerne l’algorithme A, ce qui rend une ressource spécifique appropriée.

Notes de cours:
https://generalistprogrammer.com/tutorials/a-star-pathfinding-algorithm-complete-tutorial


Tutoriels vidéo pour la démo :
   1. “Create a Pathfinding Visualizer in Unity!” – Board To Bits (YouTube)
https://youtu.be/waEsGu--9P8
   2. “A* Pathfinding Visualisation in Unity” – IHeartGameDev (YouTube)
https://youtu.be/alU04hvz6L4

Justification :
- Ces guides facilitent la compréhension de la logique ainsi que des formules à l'algorithme employé dans la présentation Unity.


{{% /expand %}}

## Conclusion

Le LLM est un outil très puissant pour avoir de l’information structuré rapidement, mais il reste important de valider les informations et de compléter avec des recherches personnelles pour un travail académique rigoureux.
