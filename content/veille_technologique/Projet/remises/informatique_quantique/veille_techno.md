+++
title = "Veille technologique"
weight = 1
+++

## L'informatique quantique

### 1. Premier prompt et réponse avec un LLM

**Modèle utilisé** : Claude 3.5 Sonnet (Anthropic, version novembre 2024)

**Date de consultation** : 28 novembre 2025

#### Prompt initial

> "Peux-tu m'expliquer ce qu'est l'informatique quantique ? J'aimerais comprendre les principes de base, les différences avec l'informatique classique, les applications actuelles et potentielles, ainsi que l'état actuel de cette technologie. Je suis étudiant en informatique en cinquième session, donc j'ai de bonnes bases techniques, mais je ne connais pas encore ce domaine."

#### Réponse du LLM

L'informatique quantique est un paradigme de calcul qui exploite les propriétés de la mécanique quantique pour traiter l'information d'une manière fondamentalement différente des ordinateurs classiques.

**Principes fondamentaux :**

L'informatique quantique repose sur trois concepts clés de la physique quantique :

1. **La superposition** : Contrairement aux bits classiques qui sont soit 0 soit 1, les qubits (bits quantiques) peuvent exister simultanément dans plusieurs états. Un qubit peut être dans une combinaison linéaire des états |0⟩ et |1⟩, représentée comme α|0⟩ + β|1⟩, où α et β sont des amplitudes de probabilité complexes.

2. **L'intrication quantique** : Plusieurs qubits peuvent être intriqués, ce qui signifie que l'état d'un qubit est directement lié à l'état d'un autre, peu importe la distance qui les sépare. Cette propriété permet des corrélations impossibles en informatique classique.

3. **L'interférence quantique** : Les algorithmes quantiques exploitent l'interférence pour amplifier les probabilités des bonnes réponses et annuler celles des mauvaises réponses.

**Différences avec l'informatique classique :**

- **Parallélisme quantique** : Un ordinateur quantique avec n qubits peut représenter 2^n états simultanément, permettant d'explorer un espace de solutions exponentiellement plus grand.
- **Traitement de l'information** : Plutôt que d'exécuter des opérations séquentielles, les ordinateurs quantiques manipulent des états de superposition à travers des portes quantiques.
- **Mesure destructive** : La lecture d'un qubit détruit sa superposition, ne donnant qu'un résultat classique (0 ou 1). Les algorithmes doivent donc être conçus pour maximiser la probabilité d'obtenir la bonne réponse.

**Applications actuelles et potentielles :**

1. **Cryptographie** : 
   - L'algorithme de Shor peut factoriser de grands nombres exponentiellement plus rapidement qu'un ordinateur classique, menaçant le chiffrement RSA actuel.
   - La cryptographie quantique permet une distribution de clés théoriquement inviolable.

2. **Optimisation** :
   - Problèmes de logistique, de planification de routes
   - Optimisation de portefeuilles financiers
   - Conception de réseaux

3. **Simulation quantique** :
   - Modélisation de molécules pour la découverte de médicaments
   - Développement de nouveaux matériaux
   - Compréhension de systèmes quantiques complexes

4. **Intelligence artificielle** :
   - Accélération de l'apprentissage automatique
   - Optimisation de réseaux de neurones
   - Reconnaissance de patterns

5. **Recherche dans des bases de données** :
   - L'algorithme de Grover offre une accélération quadratique pour la recherche non structurée

**État actuel de la technologie :**

Nous sommes dans l'ère NISQ (Noisy Intermediate-Scale Quantum), caractérisée par :

- **Nombre de qubits limité** : Les machines actuelles ont entre 50 et 1000+ qubits, mais beaucoup sont nécessaires pour la correction d'erreurs.
- **Décohérence** : Les qubits perdent rapidement leur état quantique à cause des interactions avec l'environnement.
- **Taux d'erreur élevé** : Les opérations quantiques ne sont pas encore parfaitement fiables.
- **Besoin de refroidissement** : La plupart des technologies requièrent des températures proches du zéro absolu.

**Technologies de qubits principales :**

1. **Qubits supraconducteurs** (IBM, Google) : Utilisant des circuits électriques supraconducteurs
2. **Ions piégés** (IonQ, Honeywell) : Atomes isolés manipulés par laser
3. **Qubits topologiques** (Microsoft) : Approche encore expérimentale mais prometteuse
4. **Photonique** (Xanadu) : Utilisant des photons comme qubits
5. **Atomes neutres** : Approche émergente avec un bon potentiel d'échelle

**Défis actuels :**

- Maintenir la cohérence quantique suffisamment longtemps
- Réduire les taux d'erreur
- Développer des codes de correction d'erreurs efficaces
- Augmenter le nombre de qubits tout en maintenant leur qualité
- Créer des algorithmes quantiques pratiques pour des problèmes réels

**Perspective :**

Bien que nous soyons encore loin de l'ordinateur quantique universel tolérant aux erreurs, les progrès sont constants. Les experts estiment que dans 5-15 ans, nous pourrions voir des applications quantiques commercialement viables dans des domaines spécifiques comme la chimie et l'optimisation.

#### Discussion de la réponse

**Complétude de la réponse :**

La réponse fournie par Claude est remarquablement complète et bien structurée. Elle couvre tous les aspects fondamentaux demandés dans le prompt initial :
- Les principes de base sont expliqués clairement avec des notations mathématiques appropriées
- Les différences avec l'informatique classique sont bien articulées
- Les applications sont diversifiées et concrètes
- L'état actuel est réaliste et nuancé

**Comparaison avec un moteur de recherche :**

Un moteur de recherche classique (Google, Bing) aurait nécessité :
- Plusieurs requêtes pour obtenir le même niveau de détail
- La consultation de 5-10 pages différentes
- Un effort de synthèse important pour combiner les informations
- Un risque de tomber sur des sources de qualité variable ou trop techniques/vulgarisées

Avantage du LLM : La réponse est directement adaptée au niveau demandé (étudiant de 5e session en informatique) et présente une synthèse cohérente immédiate.

**Comparaison avec d'autres LLMs :**

J'ai également testé ChatGPT (GPT-4, version novembre 2024) avec le même prompt. Les différences observées :
- ChatGPT a fourni une réponse légèrement plus courte mais similaire dans le contenu
- Claude a inclus plus de détails techniques sur les différentes technologies de qubits
- GPT-4 a mis plus l'accent sur les applications commerciales actuelles
- Les deux ont une compréhension précise du domaine

**Comparaison avec ce que nous connaissions déjà du sujet :**

Avant de consulter le LLM, nous avions déjà une base de connaissances en physique quantique et en informatique. Nous étions familiers avec les concepts fondamentaux tels que :
- Les **qubits** et leur différence fondamentale avec les bits classiques
- La **superposition quantique** et son principe de base (un qubit pouvant être |0⟩, |1⟩, ou une combinaison des deux)
- L'**intrication quantique** et le fait que des particules peuvent être corrélées instantanément
- La notion générale que les ordinateurs quantiques pourraient résoudre certains problèmes plus rapidement

Cependant, la réponse du LLM a apporté plusieurs éléments nouveaux et précieux :

1. **Détails techniques approfondis** : La notation mathématique précise α|0⟩ + β|1⟩ pour la superposition et l'explication des amplitudes de probabilité complexes ont clarifié notre compréhension théorique.

2. **État actuel de la technologie** : Le concept d'ère **NISQ** (Noisy Intermediate-Scale Quantum) était nouveau pour nous. Comprendre que nous sommes dans une phase transitoire avec des machines de 50-1000+ qubits mais avec des taux d'erreur élevés contextualise bien où en est réellement la recherche.

3. **Diversité des technologies de qubits** : Nous connaissions vaguement l'existence de différentes approches, mais le LLM a clairement énuméré et distingué les cinq principales technologies (supraconducteurs, ions piégés, topologiques, photonique, atomes neutres). Cette taxonomie est très utile pour structurer notre compréhension du domaine.

4. **Applications concrètes et nuancées** : Au-delà de la cryptographie que nous connaissions, la liste détaillée des domaines d'application (simulation quantique pour la découverte de médicaments, optimisation logistique, accélération de l'apprentissage automatique) avec des exemples précis comme l'algorithme de Shor et de Grover enrichit considérablement notre vision des possibilités réelles.

5. **Échéanciers réalistes** : Les estimations de 5-15 ans pour des applications commerciales viables nous donnent une perspective temporelle concrète, contrairement aux discours parfois trop optimistes ou trop pessimistes que l'on peut trouver ailleurs.

Cette interaction avec le LLM a donc été particulièrement enrichissante : elle a validé nos connaissances de base tout en les approfondissant significativement et en structurant notre compréhension du domaine de manière plus systématique et à jour.

**Vérification des informations :**

En comparant avec des sources académiques et institutionnelles :
- Les concepts fondamentaux sont correctement présentés
- L'état de la technologie (ère NISQ) est exact
- Les chiffres mentionnés (50-1000+ qubits) correspondent aux machines actuelles
- Les délais estimés (5-15 ans) sont cohérents avec les prévisions d'experts

Aucune page web unique ne contient toutes ces informations de manière aussi structurée, mais plusieurs sources corroborent les différents aspects :

---

### 2. Sources pour les notes de cours

#### Sources académiques et institutionnelles

**1. Institut quantique (Université de Sherbrooke)**
- URL : https://www.usherbrooke.ca/iq/fr/curieux-quantiques/pour-le-grand-public
- Qualité : 8/10 (Institution académique québécoise de premier plan)
- Pertinence : Excellente ressource francophone avec des publications scientifiques et du contenu vulgarisé
- Utilisation : Fondements théoriques, état de la recherche au Québec

**2. Industrie Quantique Canada**
- URL : https://www.quantumindustrycanada.ca/fr/
- Qualité : 9/10 (Initiative nationale canadienne)
- Pertinence : Ressources en français, perspectives canadiennes, applications pratiques
- Utilisation : Contexte canadien, opportunités dans le domaine

**3. CEA (Commissariat à l'énergie atomique et aux énergies alternatives)**
- URL : https://www.cea.fr/Pages/domaines-recherche/nouvelles-technologies/recherches-CEA-calcul-quantique.aspx
- Qualité : 7/10 (Organisme de recherche français prestigieux)
- Pertinence : Explications scientifiques rigoureuses en français
- Utilisation : Principes fondamentaux, physique quantique

**4. CNRS (Centre national de la recherche scientifique)**
- URL : https://lejournal.cnrs.fr/articles/une-informatique-a-reinventer-pour-le-calcul-quantique (article sur l'informatique quantique)
- Qualité : 8/10 (Référence scientifique française)
- Pertinence : Articles de vulgarisation de haute qualité
- Utilisation : Actualités de la recherche, explications accessibles

---

### 3. Article récent sur l'informatique quantique

**Titre** : "« Il fait des calculs que personne ne peut suivre » : le premier ordinateur quantique commercial est sur le point d'arriver"

**Source** : HelloBiz.fr

**Date de publication** : 21 juin 2025

**Résumé** : IBM s'apprête à commercialiser le tout premier ordinateur quantique commercial, nommé **Starling**, prévu pour 2029. L'article détaille la stratégie d'IBM pour surmonter les défis techniques majeurs de l'informatique quantique, notamment la gestion des erreurs grâce à des codes correcteurs comme le LDPC. Le vice-président de l'informatique quantique chez IBM, Jay Gambetta, confirme qu'un premier processeur quantique opérationnel devrait voir le jour dès 2026. L'article aborde également la concurrence féroce avec Google (puce Willow) et Microsoft (puce Majorana 1), ainsi que les perspectives à long terme avec le projet **Bluejay** prévu pour 2033, qui sera dix fois plus puissant que Starling. IBM prévoit d'investir 150 milliards de dollars sur cinq ans aux États-Unis, dont une partie importante sera dédiée à l'informatique quantique.

**Pertinence** : Cet article est particulièrement pertinent car il présente des échéanciers concrets et récents (2025) pour la commercialisation des ordinateurs quantiques. Il montre la transition d'une technologie de laboratoire vers des applications commerciales réelles. L'article aborde également les applications pratiques potentielles (chimie, médecine, finance, intelligence artificielle) et la compétition internationale, illustrant l'importance stratégique de cette technologie. Les délais annoncés (2026, 2029, 2033) permettent aux étudiants de situer l'évolution technologique dans le temps et de comprendre qu'il s'agit d'une révolution en cours, pas d'une simple promesse lointaine.

**Lien** : https://hellobiz.fr/2025/06/21/il-fait-des-calculs-que-personne-ne-peut-suivre-le-premier-ordinateur-quantique-commercial-est-sur-le-point-darriver/

---

### 4. Veille sur les réseaux sociaux et YouTube

#### Chaîne YouTube recommandée

**1. Science Étonnante (David Louapre)**
- URL : https://www.youtube.com/@ScienceEtonnante
- Abonnés : ~1.49M
- Pertinence : 8/10
- Contenu : Vidéos de vulgarisation scientifique de haute qualité
- Vidéos recommandées :
  - "LES SUPERPOSITIONS QUANTIQUES SONT-ELLES RÉELLES ?" (2022)
  - "LE PLUS GROS PROBLÈME de la Mécanique Quantique : La Mesure [FondementsQ #1]" (2022)
- Pourquoi : Explications rigoureuses mais accessibles, animations excellentes

#### Source réseaux sociaux

**IBM Quantum**
- URL : https://www.linkedin.com/showcase/ibm-quantum/
- Langue : Anglais (mais contenu technique universel)
- Contenu : Annonces de produits, tutoriels, événements
- Pourquoi : Leader du domaine, accès à du matériel réel

---

### Conclusion de la veille

Cette veille technologique confirme que l'informatique quantique est un domaine :
- **Actif** : Innovations constantes, publications fréquentes
- **Accessible** : Ressources pédagogiques francophones disponibles
- **Pertinent localement** : Fort écosystème québécois/canadien
- **Prometteur professionnellement** : Investissements massifs et pénurie de talents

---