+++
title = "Veille technologique"
weight = 1
+++

## Veille technologique

### 1. Premier prompt et réponse d’un LLM

**Prompt utilisé avec ChatGPT-4.1 :**  
« Explique-moi simplement ce qu’est un ordinateur quantique : comment ils fonctionnent, leurs différences avec les ordinateurs classiques, leurs applications actuelles et leurs limitations. »

**Réponse du LLM :**  
Un ordinateur quantique est un type d’ordinateur qui utilise les principes de la mécanique quantique pour traiter l’information. Contrairement aux ordinateurs classiques qui utilisent des bits (0 ou 1), les ordinateurs quantiques utilisent des qubits, qui peuvent être dans plusieurs états à la fois grâce à la superposition. Cela leur permet de résoudre certains problèmes beaucoup plus rapidement, comme la factorisation de grands nombres ou la simulation de molécules complexes. Les applications principales incluent la cryptographie, la recherche pharmaceutique, l’optimisation et l’intelligence artificielle. Les défis actuels sont la stabilité des qubits (décohérence), la correction d’erreurs, la mise à l’échelle des machines et le coût de fabrication.

### 2. Discussion de la réponse
La réponse du LLM est très bonne : elle explique les bases du fonctionnement des ordinateurs quantiques, leurs différences avec les ordinateurs classiques, leurs applications et leurs limitations. Cependant, elle reste assez générale et n’aborde pas certains points plus spécifique comme l’intrication quantique ou des exemples d’algorithmes spécifiques (ex. : Shor, Grover).

Commençons par analyser la réponse:
## La réponse est-elle factuelle?
D'abord, séparons l'analyse en plusieurs parties, d'abord, la différence entre les ordinateurs classiques et les quantiques.

L'analyse du LLM de cette partie est vraie. Dans les grandes lignes, il est dit qu'un ordinateur quantique fonctionne différament d'un ordinateur classique car là où le second utilise des bits de valeurs 0 ou 1, les ordinateurs quantiques utilisent des qubits, ou bits quantiques, qui ont la particularité d'être dans les deux états à la fois. Ce fait est majoritairement approuvé par la communauté scientifiques et cette analyse simple de la différence entre les deux types d'ordinateurs est largement répandue. Preuve ici de l'article Wikipedia sur les ordinateurs quantiques: https://fr.wikipedia.org/wiki/Ordinateur_quantique

Ensuite, parlons un peu des avantages et des applications des ordinateurs quanitques. Le LLM affirme que les méthodes empruntés de la méchaniques quantiques permetteraient aux ordinateurs quantiques de résoudre certaines problèmes beaucoup plus rapidement, il cite ensuite quelques domaines tels que la factorisation de grands nombres, la cryptographie, l'optimisation et l'intelligence artificelle où les ordinateurs quantiques auraient l'avantage sur les ordinateurs classiques. 

Cette analyse n'est pas fausse, mais ne dit pas non plus toute la vérité. En théorie, les avantages des ordinateurs quantiques sont non-mesurable, mais cela n'est qu'en théorie. En pratique, nous sommes encore loin d'obtenir un réel avantage. IBM, l'un des principaux acteurs du secteur de l'ingénérie quantique, utilise le terme "avantage quantique". Simplifier, cela veut dire qu'un "système quantique peut fournir une meilleure solution, qui est aussi plus rapide ou moins coûteuse que toutes les méthodes classiques connues." Cependant, "IBM estime que les premiers avantages quantiques pourraient être atteints d’ici la fin de 2026, à condition que les communautés du quantique et du calcul haute performance collaborent étroitement." - Qu'est-ce que l'informatique quantique, IBM, https://www.ibm.com/fr-fr/think/topics/quantum-computing, Josh Schneider, Staff Writer & Ian Smalley, Staff Editor. Un autre avantage théorique des ordinateurs quantiques est la certitude ainsi que la précision des calculs effectués, mais encore fois, selon Polytechnique Paris, nous sommes encore loins de ce réel avantage car pour se faire, nous devrions utiliser une technique qui consiste à utiliser un grand nombre de qubits pour créer un « qubit logique ». Hors, "Selon les experts, un véritable « avantage », ou « suprématie » quantique ne pourra être atteint que lorsque les ordinateurs quantiques fonctionneront avec un million de qubits. Et comme le record actuel est encore inférieur à 100 qubits, il reste encore beaucoup de chemin à parcourir." L’ordinateur quantique : tout comprendre en 15 minutes, https://www.polytechnique-insights.com/tribunes/science/lordinateur-quantique-tout-comprendre-en-15-minutes/, par Loïc Henriet, CTO de Pasqal & Landry Bretheau, professeur en physique quantique à l'École polytechnique au sein du Laboratoire de Physique de la Matière Condensée (PMC*)

Pour ce qui est des défis, le LLM présente brièvement les contraintes auquels font face les ordinateurs quantiques. Plusieurs sources confirment que le taux d'erreurs est excécissevemnt élevé pour ce genre d'appareil. Dans un article de Inria paru en avril 2025, les auteurs affirment, et je cite: "
Pour ce qui est des défis, le LLM présente brièvement les contraintes auquels font face les ordinateurs quantiques. Plusieurs sources confirment que le taux d'erreurs est excécissevemnt élevé pour ce genre d'appareil. Dans un article de Inria paru en avril 2025, les auteurs affirment, et je cite: "Or, aujourd’hui, au mieux, une opération sur 1 000 se révèle erronée." Le LLM propose aussi quelques autres défis qui sont tout à fait vrai, tel que le coût de fabrication et les dimensions de ce genre d'appareil.


## Comparaison avec GEMINI 3 Rapide
Comparons maintenant avec un un second LLM pour voir la différence:

Tout d'abord, l'analyse de Gemini est davantage structuré, il débute avec une petite mise en contexte:
Un ordinateur quantique n'est pas seulement un ordinateur plus rapide ; c'est une machine qui utilise les lois de la physique quantique (la science de l'infiniment petit) pour calculer. Il permet de traiter simultanément un nombre astronomique de possibilités, ce qui le rend potentiellement capable de résoudre des problèmes qui sont actuellement impossibles, même pour les supercalculateurs les plus puissants.

Puis aborde point par point mes demandes:
1. Comment fonctionnent-ils ? Le secret des Qubits
L'informatique quantique repose sur des phénomènes physiques uniques :

Le Qubit (Bit Quantique) : C'est l'unité d'information. Contrairement au bit classique qui est soit un 0 soit un 1, le qubit exploite le principe de superposition. Cela signifie qu'il peut être 0 et 1 en même temps. Imaginez une pièce de monnaie qui tourne en l'air : tant qu'elle tourne, elle est à la fois Pile et Face.
La Superposition : Grâce à la superposition, un ordinateur quantique avec seulement quelques centaines de qubits peut représenter plus d'informations que tous les bits de tous les ordinateurs classiques réunis. Il peut ainsi explorer toutes les solutions d'un problème simultanément.

L'Intrication : C'est le deuxième pilier. Si deux qubits sont intriqués, ils sont liés de manière spéciale : mesurer l'état de l'un vous donne instantanément l'état de l'autre, peu importe la distance. C'est ce qui permet une coordination massive des calculs.

2. Différences avec les Ordinateurs Classiques
La différence fondamentale réside dans la manière de traiter l'information :
Caractéristique,Ordinateur Classique,Ordinateur Quantique
Unité de base,Bit (0 ou 1),Qubit (0 et 1 simultanément)
Méthode de calcul,Séquentielle (une opération après l'autre),Massivement Parallèle (toutes les opérations en même temps)
Rôle,"Calculs quotidiens, bureautique",Résolution de problèmes extrêmement complexes
Environnement,Température ambiante,Extrêmement froid (proche du zéro absolu)

3. Applications Actuelles et Futures
Ces machines ne sont pas destinées à remplacer votre PC, mais à résoudre des problèmes spécifiques dans des domaines où les milliards de variables paralysent les machines classiques.
Domaine,Application (Potentiel Quantique)
Chimie & Matériaux,"Simulation moléculaire pour concevoir de nouveaux médicaments (plus rapidement) ou des matériaux révolutionnaires (par exemple, des batteries plus efficaces)."
Optimisation,"Résoudre des problèmes de logistique (itinéraires de livraison, gestion du trafic) ou de finance (modélisation de portefeuilles, gestion des risques) avec une efficacité maximale."
Intelligence Artificielle,Accélérer l'apprentissage machine en traitant des jeux de données massifs pour la reconnaissance de formes et l'analyse.
Cybersécurité,"À terme, un ordinateur quantique pourrait briser les méthodes de chiffrement actuelles (d'où l'urgence de développer la cryptographie ""post-quantique"")."

4. Les Limitations Actuelles
Le quantique est une technologie encore très jeune, et elle fait face à des défis majeurs :

La Fragilité (Décohérence) : Les qubits sont incroyablement sensibles. La moindre perturbation (bruit, chaleur, vibration) fait perdre au qubit son état quantique (la pièce qui tourne tombe). C'est le principal obstacle.

Les Conditions Extrêmes : Pour maintenir la cohérence des qubits, la plupart des systèmes nécessitent une infrastructure cryogénique (un réfrigérateur géant) maintenant le processeur à des températures avoisinant -273 °C.

Le Taux d'Erreur : Les calculs quantiques sont truffés d'erreurs dues à la décohérence. Les chercheurs doivent utiliser de nombreux qubits pour le contrôle d'erreur, ce qui limite le nombre de qubits réellement utilisables pour le calcul (les qubits logiques).

Nombre de Qubits Limité : Les machines actuelles ne disposent pas encore du nombre de qubits stables et fiables nécessaires pour surpasser les ordinateurs classiques sur des applications pratiques à grande échelle.

# Analyse de la réponse de Gemini
L'analyse de Gemini est beaucoup plus appronfidi, on donne ici des images, des statistiques, des comparaisons, etc. Gemini parle également de l'intrication, chose que ChatGPT n'a pas fait, et qui est selon moi un manque, car c'est un phénomène plutôt important de la méchanique quanitque, et donc par extension les ordinateurs quantiques. **À noter cependant que j'utilise la version payante de Gemini avec la version pro, la différence d'analyse peut provenir de cela.**

## En résumé : ##  
La réponse des LLM sont de bonne synthèse pour débuter, mais elle gagnerait à être complétée par des exemples concrets et des liens vers des sources de qualité. Les moteurs de recherche et certains sites spécialisés offrent des contenus plus détaillés et adaptés à différents niveaux de compréhension.


### 3. Choix des sources pour les notes de cours

- Wikipédia - Synthèse simple avec un langage compréhensible pour tous
  https://en.wikipedia.org/wiki/Quantum_computing
- IBM et Windows - Analyse détaillée par l'un des principaux acteurs du domaine. Documentation, articles et vidéos complémentaire disponibles.
  https://www.ibm.com/fr-fr/think/topics/quantum-computing

  https://learn.microsoft.com/en-us/azure/quantum/overview-understanding-quantum-computing

- Polytechnique (Paris) Insights - Vulgarisation scientifique en français
  https://www.polytechnique-insights.com/tribunes/science/lordinateur-quantique-tout-comprendre-en-15-minutes/

- Amazon - Définition et utilisation des services AWS en lien avec les technologies quantiques
  https://aws.amazon.com/what-is/quantum-computing/

### 4. Article récent sur le sujet

- « Google hails breakthrough as quantum computer surpasses ability of supercomputers » (The Guardian, 22 octobre 2025)  
  Lien : https://www.theguardian.com/technology/2025/oct/22/google-hails-breakthrough-as-quantum-computer-surpasses-ability-of-supercomputers

### 5. Sources réseaux sociaux / chaînes YouTube
