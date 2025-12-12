+++
title = "Notes de cours"
weight = 2
+++

## Introduction à l'informatique quantique

L'informatique quantique est une technologie souvent incomprise par le grand public. Dans l'imaginaire collectif, un ordinateur quantique ressemble à un ordinateur classique, mais en beaucoup plus rapide. Pourtant, la réalité est beaucoup plus complexe et fascinante.

![](/images/ordinateurQuantique.jpeg)

### Un exemple concret : la recherche dans une liste

Prenons l'exemple d'une liste de vingt éléments dans laquelle on souhaite trouver un élément précis. 

**Approche classique :**  
Il suffit de parcourir chaque élément de la liste pour vérifier s'il correspond à celui recherché. Dans le pire des cas, cela prendra vingt étapes si l'élément recherché est à l'index 19. Autrement dit, l'ordinateur classique a besoin d'effectuer **n étapes**, où n représente le nombre d'éléments dans le tableau.

**Approche quantique :**  
Dans la même situation, un ordinateur quantique n'aura besoin que de la **racine carrée de n** étapes pour trouver l'élément. Ainsi, pour un tableau d'un million d'éléments :
- Ordinateur classique : jusqu'à **1 000 000 étapes**
- Ordinateur quantique : environ **1 000 étapes**

### Mais comment est-ce possible ?

Comment peut-on savoir où se trouve un élément sans regarder chaque élément individuellement ? Est-ce de la magie ?

Non. C'est de la **physique quantique**.

---

## Rappel : fonctionnement d'un ordinateur classique

Avant d'explorer l'informatique quantique, effectuons un bref rappel sur le fonctionnement d'un ordinateur classique.

### Les bits et l'électricité

L'ordinateur classique utilise le courant électrique comme moyen de manipuler l'information :
- Si le courant passe → **1**
- Si le courant ne passe pas → **0**

C'est pour cette raison que le langage des ordinateurs est **binaire**.

### Représentation de l'information

Chaque 0 ou 1 s'appelle un **bit**. Les bits sont utilisés pour représenter des nombres, et les nombres peuvent représenter toutes sortes d'informations :
- **Une couleur** : en donnant une valeur numérique de rouge, bleu et vert (RGB)
- **Une coordonnée** : valeurs x, y, z
- **Un caractère** : avec l'encodage ASCII ou Unicode
- **Etc.**

### Les transistors

On utilise des **transistors** pour déterminer si le courant passe ou ne passe pas. Avec ces deux éléments (l'électricité et les transistors), on peut créer toutes les portes logiques nécessaires pour effectuer les opérations dont un ordinateur a besoin pour fonctionner.

![](/images/transistorAndGate.png)

### La course à la miniaturisation

Cela signifie également que **plus un ordinateur contient de transistors, plus il sera rapide** pour effectuer des calculs. Depuis les débuts de l'informatique, les transistors n'ont cessé de se miniaturiser afin d'en intégrer de plus en plus dans les processeurs.

**Aujourd'hui :**
- Un processeur moyen contient **des milliards de transistors**
- Ces transistors ont la taille de quelques **nanomètres** (comparable à l'ADN humain)

### La limite physique

Nous avons atteint un point où nous sommes à la **limite physique** et ne pouvons plus miniaturiser davantage les transistors sans rencontrer des problèmes de mécanique quantique (effet tunnel, dissipation de chaleur, etc.).

Il est donc nécessaire d'explorer d'autres technologies pour continuer à améliorer les performances de calcul des ordinateurs.

---

## Qu'est-ce qu'un ordinateur quantique ?

### Les fondements : la physique quantique

La **physique quantique** est l'étude du comportement des atomes et des particules subatomiques. Elle décrit un monde où les règles diffèrent radicalement de celles de la physique classique que nous observons au quotidien.

### Le qubit : l'unité de base

Contrairement à l'ordinateur classique qui utilise l'électricité, l'ordinateur quantique exploite une **propriété quantique** d'un atome ou d'une particule pour manipuler l'information.

**Exemple concret :**  
Le **spin d'un électron** crée un champ magnétique qui possède une orientation :
- Orientation **vers le haut** → **0**
- Orientation **vers le bas** → **1**

![](/images/spinElectron.jpg)

Ces bits spéciaux qui utilisent les propriétés quantiques portent le nom de **qubits** (quantum bits).

### Différentes implémentations physiques

Le spin d'électrons n'est pas la seule propriété quantique utilisable dans un ordinateur quantique. Voici quelques exemples d'implémentations :

- **Spin d'électrons** (utilisé par IBM, Google)
- **Spin de noyaux atomiques** (RMN quantique)
- **Polarisation de photons** (calcul quantique photonique)
- **Chemin optique** (qubits topologiques)
- **Ions piégés** (technologie IonQ)
- **Supraconducteurs** (qubits de phase)

### Pourquoi utiliser des atomes ?

Au-delà de la taille (un atome est encore plus petit que le plus petit transistor fabricable), ce sont les **propriétés spéciales de la physique quantique** qui constituent le véritable intérêt de cette technologie.

En effet, la physique quantique possède des règles et des comportements qui sont **radicalement différents** de la physique classique. Cela rend les manipulations de qubits fondamentalement différentes de celles des bits classiques, ouvrant la porte à de nouveaux types d'algorithmes.

---

## Les propriétés spéciales de la physique quantique

Les qubits possèdent trois propriétés fondamentales qui les différencient radicalement des bits classiques.

### 1. La superposition

{{% notice style="info" title="Définition" %}}
Grâce à la **superposition**, un qubit peut exister dans **plusieurs états simultanément**. Le qubit n'est pas *soit* 0 *soit* 1, mais représente les deux à la fois jusqu'à ce qu'il soit mesuré.
{{% /notice %}}

**Analogie classique : le chat de Schrödinger**

On compare souvent cette propriété au célèbre paradoxe du chat de Schrödinger : avant d'ouvrir la boîte, le chat est à la fois vivant *et* mort. De la même manière, avant la mesure, un qubit est simultanément 0 *et* 1.

**Point crucial à comprendre :**

Ce n'est **pas** simplement une question d'incertitude ou de manque de connaissance. L'atome est **physiquement** dans l'état 0 *et* l'état 1 en même temps. C'est une propriété réelle de la matière à l'échelle quantique, pas un artefact de mesure.

**Représentation mathématique :**

Un qubit en superposition peut s'écrire :  
$$|\psi\rangle = \alpha|0\rangle + \beta|1\rangle$$

où $\alpha$ et $\beta$ sont des nombres complexes tels que $|\alpha|^2 + |\beta|^2 = 1$

### 2. La mesure

{{% notice style="info" title="Définition" %}}
La **mesure** est l'acte d'observer un qubit, ce qui le force à « choisir » un état définitif (0 ou 1). Cette observation **détruit la superposition**.
{{% /notice %}}

**Avant la mesure :**  
Le qubit existe dans une superposition : il n'est pas 0, il n'est pas 1, il est dans un état quantique qui combine les deux possibilités.

**Après la mesure :**  
Le qubit « s'effondre » vers un état classique (0 ou 1).

**Les probabilités**

Ce qui est fondamental à comprendre, c'est que le résultat de la mesure est **probabiliste**. Ces probabilités sont déterminées par l'environnement et la préparation du qubit.

**Exemple avec le spin d'un électron :**

Avec un champ magnétique, on peut ajuster les probabilités que la mesure de l'électron donne 0 ou 1. Autrement dit, on peut **préparer l'état quantique** pour influencer les probabilités de la mesure :
- Probabilité de mesurer 0 : $|\alpha|^2$
- Probabilité de mesurer 1 : $|\beta|^2$

**Conséquence importante :**

Une fois mesuré, le qubit perd toute son information quantique. On ne peut pas « revenir en arrière ». C'est pourquoi les algorithmes quantiques doivent être conçus soigneusement pour extraire l'information utile avant la mesure finale.

### 3. L'intrication

{{% notice style="info" title="Définition" %}}
L'**intrication** est une corrélation quantique entre deux ou plusieurs qubits. Leurs états deviennent liés de telle sorte que la mesure de l'un affecte instantanément l'état de l'autre, **quelle que soit leur distance physique**.
{{% /notice %}}

**Exemple simple :**

Imaginons que l'on prépare deux qubits de façon qu'ils soient toujours mesurés dans des états **opposés** :

1. Tant qu'aucune mesure n'est effectuée, les deux qubits sont chacun en superposition.
2. Au moment où on mesure le premier qubit, sa valeur devient 0 ou 1.
3. **Instantanément**, le second qubit prend la valeur opposée, même s'il est à des kilomètres de distance.

**Ce que l'intrication n'est PAS :**

- Ce n'est **pas** de la communication plus rapide que la lumière (on ne peut pas transmettre d'information ainsi)
- Ce n'est **pas** simplement de la corrélation classique (les qubits n'ont pas d'état « caché » prédéterminé)

**Distance et intrication :**

Il est important de comprendre que la **distance entre les qubits n'a aucun impact** sur leur intrication. Ils pourraient être séparés de plusieurs kilomètres et la corrélation persisterait. Cette propriété a été vérifiée expérimentalement et a valu le prix Nobel de physique 2022 à Alain Aspect, John Clauser et Anton Zeilinger.

**Utilité en calcul quantique :**

Cette propriété est essentielle pour plusieurs algorithmes d'un ordinateur quantique. Elle donne à l'ordinateur quantique une forme de **« coopération »** entre qubits qu'un ordinateur classique ne peut pas reproduire. C'est notamment ce qui permet :
- La téléportation quantique
- La cryptographie quantique
- Certains algorithmes de correction d'erreurs

---

## Les portes quantiques

Maintenant que nous avons vu les propriétés particulières des qubits, il est temps de s’intéresser à la façon dont on les manipule réellement. En informatique classique, on utilise des portes logiques (ET, OU, NON, etc.) pour transformer des bits. En informatique quantique, on fait la même chose, mais avec des portes quantiques qui transforment des qubits.

Une porte quantique est une opération physique (par exemple une impulsion électromagnétique ou un laser) qui modifie l’état d’un qubit ou d’un groupe de qubits. Mathématiquement, on peut voir cela comme une rotation dans l’« espace des états » du qubit. Dans ce cours, nous n’entrerons pas dans les détails mathématiques, mais il est important de savoir que :

- les portes quantiques sont réversibles (on peut en principe revenir en arrière),
- elles préservent la norme (la somme des probabilités reste égale à 1),
- elles peuvent agir sur un ou plusieurs qubits à la fois.

Voici quelques portes importantes.

### Portes à un qubit

**Porte X (NOT quantique)**  
C’est l’équivalent quantique de la porte NON. Elle échange les états 0 et 1 :

- si le qubit était dans l’état 0, il devient 1 ;
- s’il était dans l’état 1, il devient 0.

**Porte Z**  
La porte Z ne change pas les probabilités d’obtenir 0 ou 1, mais elle modifie la « phase » de l’état 1. Pour une introduction, il suffit de retenir qu’elle est utile pour manipuler la façon dont les amplitudes interfèrent entre elles. Elle joue un rôle important dans de nombreux algorithmes.

**Porte Hadamard (H)**  
C’est probablement la porte la plus importante pour débuter. Elle permet de créer une superposition équilibrée :

- appliquée à un qubit en état 0, elle le met dans un état qui donnera environ 50 % de chances de mesurer 0 et 50 % de chances de mesurer 1 ;
- appliquée à un qubit en état 1, elle crée aussi une superposition, mais avec une phase différente.

En pratique, on utilise souvent la porte H pour « préparer » un qubit avant de lancer un algorithme.

![](/images/hadamardGate.png)

### Porte à deux qubits : CNOT

En plus des portes à un qubit, il existe des portes qui agissent sur deux qubits à la fois. La plus importante est la porte CNOT (Controlled-NOT).

La porte CNOT fonctionne ainsi :

- elle a un qubit de contrôle et un qubit cible ;
- si le qubit de contrôle vaut 0, la porte ne fait rien ;
- si le qubit de contrôle vaut 1, la porte applique une porte X sur le qubit cible (elle inverse son état).

La combinaison « Hadamard + CNOT » permet de créer un état intriqué, ce qui sera très utile dans les exemples qui suivent.

![](/images/cnotGate.png)

---

## Les circuits quantiques

Un programme quantique se représente généralement sous la forme d’un circuit quantique. Un circuit est simplement une suite de portes appliquées à un ensemble de qubits.

On peut le comparer à un circuit logique en informatique classique, mais avec quelques différences importantes :

- les fils représentent des qubits ;
- les blocs représentent des portes quantiques (H, X, CNOT, etc.) ;
- à la fin, on ajoute souvent des opérations de mesure pour convertir l’état des qubits en bits classiques (0 ou 1) que l’ordinateur classique peut lire.

Visuellement, un circuit quantique ressemble à ceci (exemple simplifié) :

- une ligne par qubit,
- des portes dessinées de gauche à droite,
- les mesures à la fin des lignes.

Un exemple de circuit simple :

1. On part d’un qubit en état 0.
2. On applique une porte H → le qubit passe en superposition.
3. On applique une mesure → on obtient 0 ou 1, avec des probabilités d’environ 50/50.

En ajoutant plusieurs qubits et plusieurs portes, on peut construire des algorithmes quantiques plus complexes.

---

## Quelques algorithmes quantiques simples

Dans l’atelier pratique, vous allez implémenter plusieurs circuits quantiques dans Qiskit. Dans cette section, nous donnons une brève intuition de quelques exemples que vous verrez.

### Superposition : « lancer de pièce quantique »

Le premier exercice consiste à créer un qubit en superposition avec une porte Hadamard, puis à le mesurer plusieurs fois.

- Avant la mesure, le qubit est à la fois 0 et 1 (superposition).
- Après la mesure, il devient soit 0, soit 1.
- En répétant plusieurs fois le même circuit (par exemple 1000 fois), on obtient un histogramme montrant qu’on mesure environ 50 % de 0 et 50 % de 1.

Cela illustre directement les notions de superposition et de mesure.

### Intrication : l’état de Bell

Ensuite, on peut créer un état de Bell, un état intriqué très simple mais fondamental :

1. On crée deux qubits en état 0.
2. On applique une porte H sur le qubit 0 (superposition).
3. On applique une porte CNOT avec le qubit 0 comme contrôle et le qubit 1 comme cible.

Le résultat est un état dans lequel les deux qubits sont intriqués. À la mesure, on obtient :

- soit 00,
- soit 11,

mais jamais 01 ou 10. Les deux qubits donnent toujours le même résultat, même si on les imagine séparés spatialement. C’est un exemple concret d’intrication.

### Algorithme de Deutsch (version très simplifiée)

L’algorithme de Deutsch est un petit algorithme quantique qui montre comment un ordinateur quantique peut résoudre un problème avec moins d’évaluations qu’un ordinateur classique.

Le problème est le suivant :  
on a une fonction f(x) qui prend un bit d’entrée (0 ou 1) et retourne un bit en sortie.  
On veut savoir si la fonction est :

- **constante** (renvoie toujours 0 ou toujours 1), ou
- **équilibrée** (renvoie 0 pour une entrée et 1 pour l’autre).

Classiquement, il faut tester les deux entrées (0 et 1) pour en être sûr.  
Quantiquement, l’algorithme de Deutsch permet de répondre à cette question avec une seule évaluation de la fonction, en utilisant la superposition et l’interférence.

Dans l’atelier, vous implémenterez une version simple de cet algorithme avec Qiskit, ce qui montre un premier exemple d’« avantage quantique ».

### Téléportation quantique (intuition)

Un autre exemple spectaculaire est la téléportation quantique.  
L’idée est de transférer l’état quantique d’un qubit A vers un qubit B, sans déplacer physiquement la particule.

Le protocole utilise :

- un état intriqué partagé entre deux personnes (souvent appelées Alice et Bob),
- deux mesures classiques effectuées par Alice,
- et deux corrections effectuées par Bob en fonction des résultats d’Alice.

Ce qui est important de comprendre :

- on ne téléporte pas la matière, seulement l’information quantique ;
- on a besoin à la fois de l’intrication et de communication classique ;
- ce protocole ne permet pas de communiquer plus vite que la lumière.

Dans l’atelier, vous verrez une implémentation simplifiée de ce protocole sous forme de circuit.

---

## Conclusion

Dans ces notes, nous avons présenté les idées de base de l’informatique quantique :

- la différence entre un ordinateur classique et un ordinateur quantique ;
- le rôle des qubits et leurs propriétés particulières (superposition, mesure, intrication) ;
- les portes quantiques et les circuits ;
- quelques exemples d’algorithmes simples (superposition, intrication, Deutsch, téléportation) ;
- et un aperçu de la programmation quantique avec Qiskit.

L’objectif n’est pas de faire de vous des experts en physique quantique, mais de vous donner une intuition claire de ce qui distingue l’informatique quantique de l’informatique classique, et de vous montrer qu’il est possible, dès maintenant, de programmer et d’expérimenter avec de vrais circuits quantiques, au moins sur simulateur.

L’atelier pratique qui accompagne ces notes vous permettra de mettre en application ces concepts et de voir, par l’expérience, comment se comportent réellement les qubits dans des circuits quantiques simples.