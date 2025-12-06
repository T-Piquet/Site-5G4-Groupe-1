+++
title = "DÉVELOPPEMENT"
weight = 25
+++

### 1.Comment utiliser NotebookLM

Un des points forts de NotebookLM est la facilité d'utilisation. Dans cette section, on va voir comment créer
une vidéo qui va expliquer nos notes de cours comme si c'était un podcast.


 ### 2.tutoriel

 après avoir rechercher NotebookLM dans votre navigateur préféré, vous cliquez sur le premier lien et arriver sur cette interface ou vous trouverez le bouton "Try NotebookLM":

 ![alt text](try.png)

 ensuite on clique sur "Create a new notebook" et vous pourrez ajouter les sources que vous voulez. 
 dans cet exemple on va créer une feuille aide-mémoir pour un examen de soutien technique.
 on clique sur "Upload a source" et ensuite on selectionne les fichiers que l'on veut utiliser.
 Après avoir ajouter vos documents on va cliquer sur "Audio Overview"

 ![alt text](create.png)


 ### 3.Type d’entraînement

D’habitude, quand on parle de LLM, on se fie à deux modèles d’apprentissage : supervisé ou non supervisé.
Dans le cas de NotebookLM, il s’agit d’apprentissage auto-supervisé (self-supervised learning).

 ### 3.1 Apprentissage supervisé

L’apprentissage supervisé consiste à donner au modèle des exemples avec la bonne réponse fournie.
L’IA apprend en comparant sa prédiction avec la réponse humaine.

Exemple :
On montre 15 000 photos de Pokémon étiquetées comme étant de type Eau ou de type Feu.
Ensuite, l’IA apprend à reconnaître elle-même si un nouveau Pokémon est de type Eau ou de type Feu.


### 3.2 Apprentissage non supervisé

Dans l’apprentissage non supervisé, on donne des données sans aucune réponse associée.
L’IA doit trouver des structures ou groupes par elle-même.

Exemple :
On donne des photos de Pokémon sans labels indiquant leur type.
L’IA doit apprendre à créer ses propres catégories en détectant des similarités.


### 3.3 Apprentissage auto-supervisé

L’apprentissage auto-supervisé une forme d'apprentissage non supervisé :
il n'a pas besoin de données étiquetées par des humains, le modèle va créer ses propre "étiquettes" a partir des milliers de données qu'on lui donne. Par exemple on lui donne une phrase simple comme "je veux un verre de ____"  il devra apprendre a prédire le bon mot manquant. Donc on lui donne des données brutes qu'il devra completer avec ses propres étiquettes. Cependant, si on veut que notre IA soit plus précis(pour une niche spécifique) au niveau de sa reconnaissance on va ajouter une étape a l'entrainement: le fine-tuning. Le fine-tuning consiste a passer en mode supervision pour que notre IA soit meilleur pour notre niche.

L’apprentissage auto-supervisé est un entre-deux :
on fournit des données sans labels humains, mais l’IA génère elle-même les “réponses attendues” à partir du contenu.

Exemple :

“pikachu est un pokemon de type ___.”
L’IA doit deviner electrique.

Dans ce cas, si on veut que notre IA puisse identifier le type de chaque pokemon avec une image on devra surement passer en mode supervision pour qu'il comprenne bien la différence entre chaque pokémon.
Elle s’entraîne toute seule en se testant et en corrigeant ses erreurs.

 ![alt text](difference.png)


### 3.4 l'apprentisage automatique
L’apprentissage auto-supervisé (self-supervised learning, SSL) est basé sur l’apprentissage automatique. L’apprentissage automatique est un champ d’étude de l’intelligence artificielle : il permet aux ordinateurs d’analyser de grandes quantités de données pour y repérer des motifs ou des tendances complexes. Grâce à ce processus, l’IA peut faire des prédictions ou des classifications sur de nouvelles données. Cela permet d’automatiser des tâches complexes sans avoir à programmer manuellement l’IA pour chaque règle ou situation. De nos jours, l'apprentissage automatique est utilisé dans plusieurs domaines, par exemple: pour de la publicité, pour prédire la fluctuations des marchés boursiers ou encore pour la traduction de langue. Souvent, l'apprentissage automatique et l'intelligence artificielle vont être confondu, mais il faut comprendre que l'IA représente l'ensemble des approches qui visent a donner des capacités intellectuelles proche de celle des humains a des machines alors que l'apprentissage automatique est plus précis. C'est l'usage d'algorithmes et de données pour permettre aux machines de s'améliorer et exécuter des tâches sans êtres programmés pour ces taches précisemments.

 ![alt text](schema.png)



### 4. Le source-grounding
 
 Le grounding est un processus qui commence le moment que la requête de l'utilisateur entre dans le système. Le LLM va transformer cette rêquete en vecteur sémantique qui va capturer son sens. Par la suite, le système va capturer le ou les passages les plus important et pertinents à partir de documents, de base de donnée ou de graphe de connaissance puis au final il les combienera avec la requête initial. 

 Le grounding va combler le manque de contexte que les LLM ne possèdent pas uniquement a partir de leur entraînement.


### La séléction de données

Les systèmes d'IA groundée vont exploiter des informations provenant de plusieurs sources différentes chacune avec ses propres caractéristiques:

 - sources internes : des documents et bases de données propre à l'entreprise(contrats, politique, wikis)

 - source externes : des sites web public et des services de données à jour.

 - données structurées : bases de données SQL, graphes de connaissance et point d'accès API offrant des informations précise et factuelles.

 - contenue non structuré : documents, courriels et pages web nécessitant un traitement sémantique pour extraire les passages pertinents. 


 Pour gérer les contenues non structuré, elles vont être "filtré" par `indexation vectorielle` alors que les données structurées passent par des connecteurs API.

 ```txt
L’indexation vectorielle, c’est quand la machine transforme le texte en valeurs numériques afin de
 représenter son sens, un peu comme un traducteur de langage pour les ordinateurs. 

```



### 4.1 Retrieval-Augmented Generation(RAG)

Le RAG(génération à enrichissement contextuel) est une technique qui va permettre l'optimisation de réponses de modèle de langage en intelligence artificielle générative. Cette technique va permettre d'améliorer la qualité des réponses des LLM en exploitant des ressources sans avoir à se re-entrainer. Les chatbots qui utilisent RAG vont être plus précis que ceux qui ne l'utilisent pas. Par contre, la mise en oeuvre de la RAG demande des technologies telles que des bases de données vectorielles qui va coder des nouvelles données rapidement. Ces technologies sont nécessaires parce que les chatbots qui utilisent RAG vont seulement se fier à l'information à laquelle elle a accès donc si les informations ne sont plus récentes l'IA transmettre des informations qui ne sont plus valables.

 ```txt
NotebookLM n’entraîne pas de nouveau modèle : il utilise un LLM existant et améliore ses réponses
grâce au source-grounding et au RAG, en s’appuyant uniquement sur les documents fournis par l’utilisateur.
```

### 5. Les avantages

L'approche RAG présente plusieurs avantages:

-  Les LLM fournissent des réponses précises et à jour: vu que les LLM utilisant RAG utilisent des sources externes et pas seulement ces données d'entrainements, il pourra fournir des réponses claires et à jour.

- moins de chance de donner de fausses informations ou encore des informations imprécises : En se basant sur les données externes pertinentes, la RAG va réduire le risque de produire des informations fabriqués ou faussées.

- Déployer la RAG est rentable : Déployer la RAG ne nécessite pas de personnalisation de modèle. Cela sauve énormément de temps, car les compagnies n'ont pas a ré-entrainer leur machines a chaque fois qu'il y a de nouvelles données.






### Source
- https://fr.wikipedia.org/wiki/Apprentissage_automatique
- https://en.wikipedia.org/wiki/Machine_learning
- https://www.ibm.com/think/topics/self-supervised-learning
- https://www.coursera.org/fr-FR/articles/what-is-machine-learning
- https://fr.wikipedia.org/wiki/G%C3%A9n%C3%A9ration_%C3%A0_enrichissement_contextuel
- https://www.oracle.com/fr/artificial-intelligence/generative-ai/retrieval-augmented-generation-rag/
- https://www.databricks.com/fr/glossary/retrieval-augmented-generation-rag
- https://about.you.com/resources/ai-grounding