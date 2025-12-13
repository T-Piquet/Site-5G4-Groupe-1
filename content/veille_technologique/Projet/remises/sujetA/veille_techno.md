+++
title = "Veille technologique"
weight = 1
+++

## LLM utilisé

Copilote : Smart (GPT-5)

Un LLM est vraiment mieux qu'un moteur de recherche pour apprendre de nouveaux sujets. Un moteur de recherche va simplement prendre un prompte à la fois et répondre avec des liens, tandis qu'un LLM va te l'expliquer et tu peux lui préciser ce que tu veux qu'il te dise. Avec un LLM c'est une discussion et non plusieurs demandes sans historique. En plus, mon moteur de recherche me donne parfois des réponses par LLM directement aussi, donc même dans mon moteur de recherche, il y a un LLM qui me répond parfois.

Le seul point qui est moins bien des LLM c'est qu'ils vont donner ce que tu demandes, mais tu ne peux pas demander ce que tu ne sais pas, comme le site suivant qui contient tous les informations nécessaire à comprendre Rust, tu ne peux pas savoir et demander d'expliquer des conceptes en lien avec Rust sans savoir et comprendre Rust.

**Ce site contient tous les informations à propos de Rust** : [Rust](https://doc.rust-lang.org/book/)

**Article concernant Rust** : [article](https://www.ambient-it.net/rust-guide-complet/)

**Puisque je ne connais pas Rust, je vais demander à copilote de m'en parler**

**Premier prompt** :
Donne-moi une vue d’ensemble et à jour du langage Rust pour des étudiants de 5e session en informatique qui ne connaissent pas Rust.

## Réponse

Rust est aujourd’hui (décembre 2025) un langage de programmation moderne, compilé et multi‑paradigme, conçu pour offrir à la fois performance, sécurité mémoire et gestion efficace de la concurrence. Il est particulièrement pertinent pour des étudiants en informatique qui veulent comprendre comment un langage peut concilier rapidité et robustesse sans sacrifier la productivité

**Origines et évolution** :

- Créé en 2006 par Graydon Hoare, soutenu par Mozilla dès 2009.
- Première version stable en 2015, et aujourd’hui la version 1.91.1 (novembre 2025) est disponible
- Inspiré par des langages comme C++, Haskell, Scala, mais avec une approche unique centrée sur la sûreté mémoire

**Caractéristiques principales** :

- Performance : Rust est compilé en code machine, sans ramasse‑miettes (garbage collector). Il est aussi rapide que C/C++ et adapté aux systèmes embarqués
- Sécurité mémoire : grâce au modèle d’ownership et au borrow checker, Rust garantit que toutes les références pointent vers une mémoire valide, évitant les erreurs classiques comme les fuites ou les accès concurrents dangereux
- Concurrence : Rust permet d’écrire du code multi‑thread sûr, en éliminant dès la compilation les risques de data races
- Typage fort et statique : les erreurs sont détectées tôt, ce qui renforce la fiabilité.
- Multi‑paradigme : supporte l’impératif, le fonctionnel et la programmation orientée objet légère

**Outils et écosystème** :

- Cargo : gestionnaire de paquets et outil de compilation intégré.
- Rustup : gestion des versions du compilateur.
- [Crates.io](https://crates.io/) : dépôt officiel des bibliothèques Rust.
- Rust Analyzer : extension pour IDE avec auto‑complétion et analyse de type.
- Documentation officielle et tutoriels comme Rustlings ou le Rust Book (traduit en français)

**Domaine d'application** :

- Développement système : OS, pilotes, logiciels bas niveau.
- Web et serveurs : frameworks comme Actix ou Rocket.
- Applications embarquées : IoT, microcontrôleurs.
- Jeux vidéo et VR : moteurs performants grâce à la gestion mémoire sûre
- Interopérabilité : Rust peut s’intégrer avec C/C++ et d’autres langages.

**Popularité et avenir** :

- Rust est régulièrement classé parmi les langages les plus appréciés des développeurs (Stack Overflow Developer Survey).
- De grandes entreprises (Microsoft, Amazon, Google) l’utilisent pour des projets critiques.
- En 2025, Rust est considéré comme un langage stratégique pour la cybersécurité et les systèmes haute performance

**Pour des étudiants de 5e session** :

- Rust est une excellente occasion de comprendre la gestion mémoire sans garbage collector, un sujet clé pour les cours de systèmes et de programmation avancée.
- Il permet de relier théorie et pratique : concepts de typage, concurrence, optimisation.
- La courbe d’apprentissage est exigeante, mais les outils pédagogiques (Rustlings, documentation interactive) facilitent la prise en main

**Résumé** :

- En résumé : Rust est un langage moderne qui combine la vitesse du C++ avec une sécurité mémoire inégalée. Pour des étudiants en informatique, c’est une porte d’entrée vers la programmation système et concurrente, tout en restant accessible grâce à son écosystème riche et sa communauté active.

**Deuxième prompt** :
Peux tu me dire les forces et les faiblesses de Rust

## Forces de Rust

- Sécurité mémoire sans garbage collector : grâce au système d’ownership et au borrow checker, Rust élimine les erreurs classiques (segfaults, data races) dès la compilation
- Performances de bas niveau : Rust rivalise avec C et C++ en vitesse, tout en offrant des abstractions modernes
- Concurrence sûre : le compilateur empêche les accès concurrents dangereux, ce qui rend le code multi‑thread plus fiable
- Interopérabilité avec C : Rust peut s’intégrer dans des projets existants, ce qui facilite son adoption progressive
- Écosystème moderne : Cargo (gestionnaire de paquets), [crates.io](https://crates.io/) (dépôt de bibliothèques), et Rust Analyzer (IDE) améliorent la productivité
- Communauté active : Rust est régulièrement classé parmi les langages les plus appréciés par les développeurs (Stack Overflow Survey)
- Polyvalence : utilisé dans les systèmes embarqués, le développement web (Actix, Rocket), la cybersécurité et les infrastructures cloud

## Faiblesse de Rust

- Courbe d’apprentissage abrupte : le modèle d’ownership et le borrow checker sont difficiles à maîtriser pour les débutants
- Temps de compilation longs : comparé à C ou Go, Rust peut ralentir le cycle de développement
- Écosystème encore jeune : bien que dynamique, il reste moins mature que celui de Java, Python ou C++
- Adoption progressive en entreprise : Rust est surtout utilisé dans des projets critiques ou innovants, mais reste minoritaire dans les systèmes historiques
- Moins adapté aux scripts rapides : Rust est compilé et typé statiquement, ce qui le rend moins pratique pour des tâches simples ou exploratoires

**Conclusion**:
Conclusion : Rust est un langage puissant et sûr, idéal pour des projets critiques où la performance et la fiabilité sont essentielles. Pour des étudiants en informatique, il représente un défi stimulant qui permet de comprendre en profondeur la gestion mémoire et la programmation concurrente, mais il demande une rigueur et un investissement initial plus importants que des langages plus accessibles.

## Source

- https://www.realite-virtuelle.com/decouvrir-rust-un-langage-de-programmation-revolutionnaire/
- https://www.silkhom.com/langages-programmation/rust/
- https://rust-lang.org/fr/
- https://fr.wikipedia.org/wiki/Rust_%28langage%29
- https://fr.linkedin.com/pulse/from-c-rust-programming-language-shift-every-developer-gowda-uxmme?tl=fr
- https://jetbrains.developpez.com/tutoriel/guide-complet-aider-debutants-maitriser-programmation-rust/
- https://blog.openreplay.com/fr/apprendre-les-bases-de-rust-2025/
- https://rotek.fr/rust/
- https://www.geeksforgeeks.org/blogs/future-of-rust/
- https://content.techgig.com/technology-guide/should-you-learn-rust-in-2025/articleshow/123073599.cms
