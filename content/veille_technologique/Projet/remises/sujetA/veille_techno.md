+++
title = "Veille technologique"
weight = 1
+++

## Utilisation de LLM :

**Question poser : Peut tu m'expliquer ce que est Unity DOTS?**

Réponse de Chat GPT-5.1 :

🌐 Unity DOTS – C’est quoi ?
Unity DOTS (Data-Oriented Technology Stack) est une nouvelle façon de programmer des jeux dans Unity, pensée pour être extrêmement performante, surtout quand il y a beaucoup d’objets en même temps (milliers ou millions). Au lieu de programmer comme d’habitude en orienté objet (OOP) avec des GameObjects et MonoBehaviours, DOTS utilise une méthode différente : le Data-Oriented Design (DOD).

🔍 Pourquoi Unity a créé DOTS ?

Avec les jeux modernes, il y a souvent :
énormément d’ennemis, particules ou projectiles,
des calculs physiques complexes,
des simulations (explosions, foule, météo…).
Le modèle classique GameObject/MonoBehaviour devient lent quand on dépasse quelques milliers d’objets. DOTS règle ce problème.

⚙️ Les 3 piliers de DOTS
Unity DOTS est composé de trois technologies principales :


**1️⃣ ECS – Entity Component System :**

- **C’est le cœur de DOTS**
- **Entity = un ID (comme un numéro).** :  Pas un GameObject
- **Component** : juste des données (ex : position, vitesse, santé)
- **System** : du code qui modifie les données (ex : déplacer tous les objets qui ont position + vitesse)
- **Exemple** : Dans ECS, si 5000 ennemis doivent se déplacer, un seul système s’occupe de tous en même temps → super performant

ECS te permet d’avoir 200 000 entités en jeu sans lag, ce qui est impossible avec des GameObjects classiques.

2️⃣ C# Job System
Permet d’envoyer ton code sur plusieurs cœurs de processeur en même temps (multithreading).
Sans Jobs : ton code tourne sur un seul cœur.
Avec Jobs : le travail est divisé → ex : un job calcule les mouvements, un autre gère la physique, etc.

3️⃣ Burst Compiler
Transforme ton code C# en code machine ultra optimisé.

➡️ Résultat :
ton script peut devenir 10x à 100x plus rapide avec Burst activé.

🎯 À quoi ça te sert dans un projet ?
DOTS est parfait si tu veux créer :
une simulation avec beaucoup d’unités (RTS, tower defense)
un jeu avec foule (crowd simulation)
du multiplayer performant
des particules custom
une IA en masse
un open world optimisé
Si ton jeu a seulement 20–50 objets → DOTS n’est pas nécessaire.

💬 Exemple concret ultra simple
Avec GameObject classique

Tu aurais :
Enemy.cs, MonoBehaviour, Update() → 1000 scripts qui tournent.
Avec DOTS
un component Position
un component Speed
un system MoveSystem qui déplace TOUTES les entités en une seule boucle.
→ gros gain de performance.

👍 Est-ce que DOTS remplace GameObjects ?
Non.
Unity garde les GameObjects, mais DOTS est une alternative pour les jeux nécessitant beaucoup de performances.

Beaucoup de studios mélangent les deux :
GameObjects pour le UI / menus
DOTS pour la vraie simulation

⭐ Veux-tu aller plus loin ?

Je peux t'expliquer :

✔ Comment installer DOTS dans Unity
✔ Comment créer ta première entité
✔ Comment convertir un GameObject en DOTS
✔ Comment faire un petit projet DOTS complet (par exemple un “boids / flocking” ou une simulation de particules)

Dis-moi ce que tu veux !

______________________________________________________________________________________________________________________________________

**Retour sur la Réponse de ChatGPT**

La réponse me semble relativement complète, elle ne vas pas en détaille sur le sujet trop, mais vient expliquer la base du DOTS et illustre quelques utilisations possible avec cette technologie.