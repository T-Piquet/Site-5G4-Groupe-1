---
title: "Veille technologique Unreal Engine 5"
weight: 20
---

## 1. Premier prompt et réponse LLM

### Modèle utilisé : Gemini 3
### Prompt : 
"Quels sont les développements importants fait par Unreal Engine 5 dans l'année 2024-2025 ?"

### Réponse obtenue :

Les développements importants d'Unreal Engine 5 (UE5) pour la période 2024-2025 se concentrent sur l'amélioration des fonctionnalités existantes et l'introduction de nouveaux outils pour la performance, la fidélité visuelle et la productivité des créateurs. Ces avancées sont souvent intégrées via des mises à jour comme les versions 5.4 et 5.5 (et ultérieures).

#### Améliorations Clés des Fonctionnalités Fondamentales
Les technologies phares d'UE5 continuent d'être perfectionnées pour des performances accrues, visant notamment les 60 images par seconde (FPS) sur les consoles de nouvelle génération.

- **Nanite et Virtual Shadow Maps** : Ces systèmes de géométrie micropolygonale virtualisée et d'ombres virtuelles sont optimisés pour permettre des mondes encore plus massivement détaillés avec des millions de polygones, tout en conservant une fréquence d'images en temps réel sans perte de fidélité notable.

- **Lumen et MegaLights (Expérimental)** : L'éclairage global dynamique Lumen continue de s'améliorer, notamment en visant les 60 FPS. Le concept de MegaLights est en R&D active et, combiné à Lumen, devrait permettre des scènes richement éclairées avec un grand nombre de lumières sans impacter les performances.

- **Temporal Super Resolution (TSR)** : Ce système d'échantillonnage de haute qualité, indépendant de la plateforme, est affiné pour offrir une fidélité de sortie équivalente aux rendus en haute résolution, mais en permettant au moteur de rendre à une résolution inférieure pour de meilleures performances.

#### Nouveaux Outils et Productivité
Des outils pour simplifier les flux de travail complexes et améliorer la productivité des équipes sont au centre des mises à jour.

- **World Partition et Megaworlds** : Le système World Partition, qui divise automatiquement les mondes en cellules diffusées en continu, est perfectionné pour gérer des mondes ouverts vastes et très fidèles plus facilement. Epic Games développe également l'idée de "Megaworlds" pour l'avenir.

- **Améliorations de l'Animation et du Rigging (UE 5.4)** : De nouvelles fonctionnalités, notamment un "Modular Control Rig" expérimental et un "Automatic Retargeting" amélioré, permettent de gréer et d'animer des personnages directement dans le moteur, réduisant le besoin d'outils externes et rendant l'animation plus rapide et plus conviviale pour les artistes.

- **Substrate (Matériaux)** : Introduit pour permettre le mélange facile de plusieurs matériaux dans un même objet, offrant une plus grande complexité visuelle et un meilleur réalisme des surfaces.

- **Éditeur de Végétation (UE 5.7)** : Un nouvel éditeur permet de créer des plantes et des arbres de manière procédurale dans l'éditeur Unreal, avec des fonctionnalités pour modifier la forme (gravité, sculpture, échelle) et exporter vers des maillages Nanite.

- **Débogueur Visuel Chaos (UE 5.5 - Bêta)** : Amélioration de l'outil de débogage pour le système de destruction et de physique Chaos.

- **Intégration d'outils d'IA** : Une intégration plus poussée d'outils d'IA est prévue pour simplifier et accélérer certaines tâches de développement.

### Analyse critique de la réponse

Cette réponse semble bonne mais incomplète. Gemini a omis plusieurs avancements majeurs :

#### 1. MetaHumans - Manquant dans la réponse
MetaHumans est un avancement important pour le moteur car il est désormais intégré directement dans l'éditeur. MetaHumans permet de créer des personnages humains très réalistes grâce à des visages avec des textures à très hautes résolution et des expressions faciales qui sont naturelles et directement fournis par MetaHumans. De plus, on peut désormais utiliser la webcam pour faire une capture faciale dans les démos.

C'est un avancement majeur car avant, la création de visages demandait des jours/semaines alors que désormais, grâce à la panoplie d'outils et de cadres offerts par MetaHumans, on peut accomplir et intégrer cela en quelques heures.

#### 2. PCG (Procedural Content Generation) - Informations partielles
Un PCG (Procedural Content Generation) est officiellement intégré dans le moteur. Un PCG permet de générer automatiquement du contenu (objets, textures, biomes, etc.) grâce à un ou plusieurs algorithmes au lieu de devoir tout créer manuellement. Cet outil permet de gagner beaucoup de temps lors de la création et permet de générer des mondes beaucoup plus vastes.

**Contexte** : Le concept même de PCG n'est pas nouveau (présent dans Minecraft ou divers Rogue-likes comme Binding of Isaac) mais l'implémentation directement dans le moteur et l'ajout de la plupart des outils majeurs datent de cette année.

#### 3. IA - Mentionné mais sous-estimé
L'implémentation émergente des outils d'IA que Unreal Engine 5 commence à intégrer dans le moteur est plus significative que décrite. Actuellement l'IA peut :
- Améliorer les expressions faciales générées par MetaHumans
- Optimiser les éléments visibles d'une scène pour réduire le rendu inutile
- L'objectif actuel étant d'avoir une PCG guidée principalement par l'IA et la création complète de NPC ou dialogues entre NPC à l'aide de l'IA

**Video** : [Cette vidéo](https://www.youtube.com/watch?v=uwuT8ERswHo) montre l'utilisation de l'IA dans la création de visages humanoïdes dans Unreal Engine lors du Unreal Fest Orlando 2025.

---

## 2. Sources pour les notes de cours

La source principale et la plus fiable que je compte utiliser pour ma recherche est la documentation release-notes de Epic Games, mais je m'appuierais également sur d'autres sites/vidéos :

### Sources officielles :
1. **Documentation Epic Games** - Release notes complètes :
   - [UE5.4 Release Notes](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5.4-release-notes)
   - [UE5.5 Release Notes](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5.5-release-notes)
   - [UE5.6 Release Notes](https://dev.epicgames.com/documentation/en-us/unreal-engine/unreal-engine-5.6-release-notes)

2. **Site officiel Unreal Engine** :
   - [Toutes les annonces du State of Unreal 2025](https://www.unrealengine.com/fr/news/all-the-big-news-and-announcements-from-the-state-of-unreal-2025)

3. **MetaHumans** :
   - [Site officiel MetaHuman](https://www.metahuman.com/en-US)

4. **Documentation IA** :
   - [Intelligence artificielle dans Unreal Engine](https://dev.epicgames.com/documentation/en-us/unreal-engine/artificial-intelligence-in-unreal-engine)

### Sources tierces fiables :
1. **CG Channel** - Analyse technique :
   - [Unreal Engine 5.4 : cinq fonctionnalités clés](https://www.cgchannel.com/2024/04/unreal-engine-5-4-five-key-features-for-cg-artists/)

---

## 3. Article récent

### Titre : "Unreal Engine 5.4 : Révolution dans la création de contenu procédural"
**Date** : Avril 2024  
**Source** : CG Channel  
**Lien** : https://www.cgchannel.com/2024/04/unreal-engine-5-4-five-key-features-for-cg-artists/

**Résumé** : Cet article détaille les cinq fonctionnalités les plus importantes d'Unreal Engine 5.4 pour les artistes CG, mettant particulièrement l'accent sur :
- L'intégration native des outils PCG
- Les améliorations de Nanite pour la géométrie complexe
- Les optimisations de Lumen pour l'éclairage en temps réel
- Les nouveaux outils d'animation directement dans le moteur
- L'implémentation progressive des fonctionnalités d'IA

**Qualité de la source** : CG Channel est une publication reconnue dans l'industrie des effets visuels et de l'animation, offrant des analyses techniques approfondies par des professionnels du domaine.

---

## 4. Sources réseaux sociaux / YouTube

### YouTube :
1. **Unreal Engine** (Chaîne officielle)
   - Contenu : Tutoriels, démos techniques, annonces officielles
   - Qualité : Source première fiable

2. **William Faucher**
   - Spécialité : Tutoriels techniques avancés UE5 pour les développeurs

3. **Unreal Fest 2025 Playlist**
   - Contenu : Présentations complètes des nouvelles fonctionnalités
   - Exemple : [IA pour la création de personnages](https://www.youtube.com/watch?v=uwuT8ERswHo)

### Réseaux sociaux :
 **X** :
   - @UnrealEngine
   - @EpicGames
   - #UnrealEngine5


---

## 5. Comparaison avec d'autres LLMs

### Test complémentaire avec ChatGPT 4 :
**Prompt identique** : "Quels sont les développements importants fait par Unreal Engine 5 dans l'année 2024-2025 ?"

**Différences notées** :
1. ChatGPT a mentionné MetaHumans dès le début
2. Plus de détails sur l'intégration IA
3. Références spécifiques aux versions 5.4, 5.5, 5.6
4. Exemples concrets d'utilisation dans l'industrie

**Conclusion** : Gemini a fourni une bonne base mais ChatGPT a été plus complet sur les certains aspects

---

