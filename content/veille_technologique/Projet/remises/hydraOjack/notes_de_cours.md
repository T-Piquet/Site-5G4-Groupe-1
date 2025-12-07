+++
title = "Notes de cours"
weight = 2
+++

# 1. Introduction
Hydra Ojack est une plateforme pour developper des visuels impressionants en temps reel dans votre navigateur. C'est gratuit, open source et pour tous.

- Hydra est ecrit en **JavaScript** et compile en **[WebGL](#webgl)**.
- Sa syntaxe est inspiree de la **synthese video modulaire et analogique**.
- Tout se passe dans le **navigateur** !

Hydra s'inscrit dans le domaine du "live-coding visuel", une pratique ou l'artiste genere des images en modifiant du code en temps reel. Cette approche permet une experimentation rapide et une exploration creative directe. Hydra se distingue aussi par son accessibilite car tout fonctionne directement dans le navigateur, sans installation ou configuration complexe.

Les notes de cours qui suivent ont pour objectif de presenter les principes fondamentaux de Hydra, ses sources visuelles, ses transformations, son pipeline graphique ainsi que quelques exemples pratiques pour comprendre comment creer des compositions generatives.
*Plusieurs exercices sont disponnibles dans la section [atelier](/veille_technologique/Projet/remises/hydraOjack/atelier/)*


> "Hydra is a system for creating live visuals, inspired by analog video synths and modular synthesis."
> **Olivia Jack (Ojack)**

---

# 2. A propos de la creatrice : Olivia Jack
Originaire de San Francisco, **Olivia Jack** (creatrice de Hydra), est une programmeuse et une artiste qui travaille courament avec des applications "open-source", de la cartegraphie, du "live coding" ou encore avec des interfaces experimentales depuis pres de 15 ans. Elle est fascinee par le "live coding" et ce dernier lui permet d'entrer dans un dialogue continue et stimulant avec la machine. Elle apprecie particulierement, comme le demontre Hydra, l'algorithmie ainsi que le chaos. Elle reside et travaille en ce moment en Colombie.

Elle aime changer les valeurs ainsi que les ordres des choses simplement pour voir leur resultat, elle n'emprunte pas un chemin lineaire et prefere tester plusieures differentes choses avec son code.
Elle n'a pas uniquement cree Hydra, 

En brerf, Olivia est une personne qui adore experimenter !

---
# 3. Contexte et origine de Hydra
Son inspiration viens directement des **synthetiseurs video analogique** des annees 90 (et legerement avant). Un synthetiseur permet de transformer les signaux electriques en forme lumineuses !

Voila donc ce que Olivia a fait, elle a recreer cette approche modulaire mais dans un contexte recent tout au chaud dans notre navigateur web.
La vision de ce projet est que chaque fonction agit comme un module connectable !

## La philosophie d'Hydra
Hydra utilise une philosphie de type **"web-native"** ce qui signifie :
- Il n'y a aucune installation requise,
- il s'execute en JavaScript,
- le rendu est optimise/accelere par [WebGL](#webgl),
- le partage est simple et fait via des [snippets](#snippets)

---

# 4. Pourquoi Hydra ?
Je trouvais tout simplement les resultats agrealbes et impressionnant !

Hydra est largement utilise chez les **live-coders**, les membres de communautes de **musique electronique** et d'**art numerique** :

- Il permet de creer des visuels rapidement pour :
    - des performances live (des concerts ou sets de DJ);
    - de l'art interactif ;
    - des experimentations d'art generatif.
- Il offre une **boucle de feedback courte** : on modifie le code -> l'image change.
- C'est ideal pour **enseigner** :
    - les bases de la synthese visuelle,
    - la programmation GPU sans entrer dans la complexite des shaders.

Hydra se situe donc a la frontiere entre :
- un langage artistique,
- et un framework technique pour exploiter la puissance de la carte graphique

---

# 5. Son architecture generale
Hydra repose sur quelques concepts centraux :

## Sources

Une **source** est un flux video de base a partir duquel Hydra construit une image. Voici les principales :

| Fonction        | Description |
|-----------------|-------------|
| `osc()`         | Genere des oscillations : lignes ondulees, motifs periodiques. |
| `noise()`       | Produit une texture organique aleatoire, comme des nuages. |
| `shape()`       | Cree une forme geometrique (cercle, triangle, polygone). |
| `gradient()`    | Genere un degrade de couleurs anime. |
| `src(o0)`       | Reutilise le contenu d'un buffer pour creer du feedback. |
| `camera()`      | Utilise la webcam comme source video. |


Chaque source genere une image de base qui sera ensuite transformee.

## Buffers
C'est quoi un **buffer** ?

C'est une zone memoire qui stocke une image ... Hydra en a 4 --> `o0`, `o1`, `o2`, `o3`
C'est plus facile avec exemple je vous l'avoue :
```js
osc(10, 0.1, 1).out(o0)
```
-> o0 contient un oscillateur maintenant
```js
src(o0).rotate(0.03).out(o0)
```
-> Hydra prend l'image qu'on fait avant, lui applique une rotation (`rotate()`) et le renvoie dans notre buffer `o0`.
Resultat :
- Rotation s'ajoute petit a petit
- Ca fait un tourbillon **infini**
- Ca donne une tunne completement psychedelique qui se repete en boucle a l'infini et se deforme continuellement !


## Chainage fonctionnel

Hydra utilise un **pipeline fonctionnel** : chaque appel renvoie un objet sur lequel on peut enchainer des transformations.

Exemple : 
```js
osc(10, 0.1, 0.8)
    .rotate(0.2)
    .color(1, 0.5, 0.3)
    .out()
```

dans cet exemple :
- 'osc()' genere la source de base.
- 'rotate()' applique une rotation sur la source.
- 'color()' modifie la couleur du signal visuel.
- 'out()' envoie le resultat final vers la sortie d'affichage.

Ce modele de chainage permet de lire le code visuel comme une suite logique d'operations, un peu comme des modules branches les uns a la suite des autres dans un synthetiseur video. 
Chaque ligne represente une transformation independante qui s'applique sur le resultat de la precedente, ce qui rend Hydra particulierement intuitif pour le live-coding.

---

# 6. Le pipeline graphique : de JavaScript a WebGL
Hydra prend le code que tu ecris en JS et le transforme en images animees.
Hydra est simplement un traducteur !

1- Tu ecris du code simple, par exemple : osc().rotate().out()

2- Hydra comprend ce que tu veux dessiner, comme : fait ca, fait ci

3- Hydra traduit tout ca pour la carte graphique, qui elle ne comprend que des maths compliquees.

4- La carte graphique (via WebGL) dessine l'image a l'ecran.

5- Ce processus recommence 60x par seconde, ce qui donne une animation fluide.

Resultat :
Tu ecris du JavaScript hyper simple, et Hydra s'occupe de toute la partie compliquee pour afficher des visuels en temps reel.

---

# 7. Les sources visuelles
Une **source** c'est l'image qui commence tout dans Hydra. C'est cette source qui est ensuite transformee, combinee ou encore utilise en feedback.

| Source        | Description simple et utile |
|---------------|-----------------------------|
| `osc(freq, sync, offset)` | Genere des oscillations periodiques : lignes, vagues, motifs repetitifs. Tres utilise pour les fonds abstraits. |
| `noise(scale, speed)` | Produit un bruit organique aleatoire, semblable a des nuages ou des textures fluides. |
| `shape(sides, radius, smoothing)` | Cree une forme geometrique : triangle, carre, polygone, cercle (100+ cotes). |
| `gradient(speed)` | Genere un degrade de couleurs anime. Peut servir de fond ou de modulation. |
| `solid(r, g, b, a)` | Produit une couleur unie. Utile comme fond ou comme masque. |
| `voronoi(scale, speed)` | Cree un motif dynamique en cellules, tres populaire pour les effets « generatifs ». |
| `src(o0)` | Reutilise l'image stockee dans un buffer (feedback). Permet des effets de boucle et de deformation infinie. |
| `camera()` | Utilise la webcam comme source video. Parfait pour les performances interactives. |

<sub>Descriptions de la documentation officielle Hydra : https://hydra.ojack.xyz/docs/docs/reference/</sub>

Ces sources constituent la base de Hydra. Les sections suivantes (8 et 9) presentent les transformations et operations utilisees pour construire des visuels plus complexes.

---

# 8. Transformations visuelles
Les **transformations** modifient une **source** pour lui donner un effet visuel particulier : rotation, zoom, effet kaleidoscope...

| Transformation | Description |
|----------------|-------------|
| `rotate(angle)` | Fait tourner l'image. Plus l'angle augmente, plus la rotation est rapide. |
| `scale(valeur)` | Agrandit ou retrecit l'image. Utile pour zoomer ou creer des effets de pulsation. |
| `pixelate(x, y)` | Rend l'image pixelisee pour un effet rétro ou stylise. |
| `kaleid(n)` | Cree un effet de kaléidoscope avec *n* repetitions. Tres utilise en art generatif. |
| `invert()` | Inverse les couleurs (négatif). |
| `posterize(n)` | Reduit le nombre de couleurs, donnant un effet cartoon. |

Exemple :
```js
osc(20).kaleid(6).scale(0.5).invert().out()
```

---

# 9. Operations entre sources
Hydra permet de melanger plusieurs images ensemble. Ces operations creent des visuels complexes en combinant les couches.

| Operation | Description |
|----------|-------------|
| `add(src)` | Additionne deux images. Rend le resultat plus lumineux et plus dense. |
| `mult(src)` | Multiplie les couleurs pixel par pixel. Donne un effet d'ombre ou de texture. |
| `blend(src, amount)` | Melange deux sources selon un pourcentage (0 = rien, 1 = totalement la seconde). |
| `diff(src)` | Affiche les differences entre deux images, creant un effet de contours ou de glitch. |
| `mask(src)` | Utilise une image comme masque pour révéler ou cacher certaines zones. |

Exemple :
```js
osc(10).add(noise(3)).blend(shape(3), 0.3).out()
```

---

# 10. Feedback et buffers
Comme aborde dans la section 5, le feedback est super important. Ce derniere permet de reutiliser une image pour la deformer d'avantage. C'est grace a cela qu'il est possible de creer des spirales, des tunnels ou des effets infinis caracteristique de cette technologie.

---

# 11. Interaction en temps reel
Hydra permet de creer des visuels qui reagissent. Au temps, a votre souris ou meme a l'audio. C'est ce genre d'interactions qui rendent vos creations encore plus vivantes !

| Interaction | Description |
|------------|-------------|
| `time` | Variable qui augmente en continu. Permet d'animer automatiquement les effets (rotation, couleur, frequence). |
| `mouse.x` / `mouse.y` | Coordonnees de la souris. Elles permettent de controler la rotation, la taille ou la couleur du visuel en bougeant simplement la souris. |
| Audio | Avec des extensions, Hydra peut reagir au son. Les basses, les aigus et d'autres facteurs sonores peuvent influencer les formes et couleurs. |

Exemple d'une rotation controlee par votre curseur :
```js
osc(10, 0.1, 1)
    .rotate(() => mouse.x * 0.005)
    .out()
```
Voici un autre exemple grace a l'interaction de temps :
```js
shape(67)
    .scale(() => 0.5 + 0.2 * Math.sin(time))
    .out()
```
*testez les ;)*


---

# 12. Exemples de compositions Hydra (code explique)
## Exemple simple
```js
osc(8, 0.1, 1)
.out()
```
- `osc(8, 0.1, 1)` cree un oscillateur -> une serie de lignes ondulees
- `8` -> c'est la frequence, le nombre de lignes visibles
- `0.1` -> c'est la vitesse du mouvement de vague
- `1` -> c'est l'intensite
- `.out()` -> c'est l'affichage du resultat
## Exemple avance
```js
osc(20, 0.05)
    .kaleid(6)
    .color(1, 0.3, 0.8)
    .out()
```
- `osc(20, 0.05)` -> Frequence elevee = motifi serre et l'oscillateur bouge doucement (vitesse de 0.05)
- `kaleid(6)` -> Effet kaleidoscope de 6 miroirs
- `color(1, 0.3, 0.8)` -> RGB, rose
## Exemple utilisant feedback
```js
osc(10, 0.1, 1).out(o0)

src(o0)
    .rotate(0.03)
    .scale(1.01)
    .out(o0)
```
- `osc(10, 0.1, 1)` -> l'oscillateur est envoye dans le buffer o0
- `src(o0)` -> renvoie l'image precedente
- `rotate(0.03)` -> fait tourner legerement l'image
- `scale(1.01)` -> agrandit de 1% a chaque frame
*En bref, on prend l'image precedente, on la modifie et on eccrit par-dessus*
## Exemple interactif
```js
shape(4)
    .scale(() => 0.5 + mouse.y * 0.002)
    .rotate(() => mouse.x * 0.01)
    .color(0.2, 1, 0.6)
    .out()
```
- `shape(4)` -> 4 cotes donc un carre
- `scale(() => 0.5 + mouse.y * 0.002)` -> la souris descend vers le bas = forme grandit
- `rotate(() => mouse.x * 0.01)` -> en bougeant la souris sur l'axe de x la forme tourne
---

# 13. Cas d'usage de Hydra dans l'industrie
Hydra donne des resultats tellement impressionnants d'un point de vue artistique voici quelques videos interessantes le demontrant !
Ce n'est pas seulement Hydra bien entendu mais les evenements de live coding se deroulent presque tous de la meme maniere en voici quelques exemples. Il vous aideront a mieux comprendre cette *hype* du live coding et sa communaute !

<div style="text-align:center;">
  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/RkInFdN_rGI"
    title="Live Coding Performance"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen>
  </iframe>
</div>

<div style="text-align:center;">
  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/oR5r3mk58BI"
    title="Hydra Live Coding Performance"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen>
  </iframe>
</div>

### Ou encore voici des videos de musique crees avec Hydra :

<div style="text-align:center;">
  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/Uzf6uhTrc_8"
    title="Hydra music video 1"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen>
  </iframe>
</div>

### Et pour finir, mon prefere :
<div style="text-align:center;">
  <iframe width="560" height="315" 
    src="https://www.youtube.com/embed/sTPQ0-dWhlg"
    title="Hydra music video 2"
    frameborder="0"
    allow="accelerometer; autoplay; encrypted-media; gyroscope; picture-in-picture"
    allowfullscreen>
  </iframe>
</div>

--- 

Je vous invite a cliquer [ICI](https://hydra.ojack.xyz/docs/docs/community/) si vous desirez explorer d'avantage les projets de la communaute

---

# 14. Forces et limites de Hydra
Hydra est un outil puissant pour creer des visuels en temps reel, mais comme toute technologie, il presente a la fois des avantages et des contraintes. Cette section vise a comprendre ce qui rend Hydra efficace, mais aussi dans quelles situations il atteint ses limites.

---

## 14.1 Forces techniques

### **1. Retour visuel instantane**
Hydra affiche le rendu visuel **des qu'une ligne de code est modifiee**, sans compilation ni rechargement.  
Cela permet une demarche d'experimentation rapide et intuitive.

### **2. Execution GPU via WebGL**
Meme si l'utilisateur ecrit du JavaScript tres simple, Hydra transforme les operations en **shaders executes sur la carte graphique**.  
Avantages :
- animations tres fluides,
- tres bonne performance,
- rendu en temps reel, même avec des effets complexes.

### **3. Architecture modulaire et fonctionnelle**
Le chainage d'operations (`osc().color().rotate().out()`) rend Hydra :
- lisible,
- logique,
- flexible,
- proche de l'approche des synthetiseurs video analogiques.

Chaque transformation s'applique sur la precedente, ce qui facilite la creation artistique en direct.

### **4. Accessibilite et simplicite**
Hydra fonctionne **directement dans le navigateur**, sans installation ni configuration.  
Cela en fait un outil ideal pour :
- un enseignement,
- les ateliers debutants ;
- les performances improvisees ;
- les environnements ou l'installation de logiciels est limitee.

---

## 14.2 Forces artistiques

### **1. Approche experimentale**
Hydra encourage fortement l'exploration.  
Modifier un parametre peut produire un effet inattendu, ce qui pousse a la creativite et a la decouverte.

### **2. Style visuel unique**
Hydra permet de produire facilement des visuels :
- psychedeliques ;
- organiques ;
- geometriques ;
- abstraits.

Les modulations, feedbacks et oscillations creent une esthetique visuelle distincte.

### **3. Parfait pour le live-coding**
Grace a la mise a jour instantanee, l'artiste peut "jouer" avec l'image comme avec un instrument.  
Hydra est tres utilise dans le mouvement **algorave** et dans les performances multimedias.

---

## 14.3 Limites techniques (navigateur)

### **1. Dependance a WebGL**
Hydra repose entierement sur [WebGL](#webgl), ce qui implique :
- limitations au niveau des textures ;
- restrictions selon la carte graphique ;
- compatibilite variable selon les navigateurs.

### **2. Performances variables selon l'appareil**
- Sur un PC recent → rendu fluide.  
- Sur un vieux portable → baisse importante de FPS.  
- Sur telephone → parfois incompatible ou instable.

### **3. Pas ideal pour des pipelines professionnels**
Hydra n'est pas un outil de production comme :
- **TouchDesigner**
- **Unreal Engine**
- **After Effects**

Des que le projet devient complexe ou doit être exporte, Hydra atteint rapidement ses limites.

---

## 14.4 Complexite des shaders : abstraite mais non contrôlee

Hydra masque toute la complexite de **GLSL**, ce qui est a la fois :
- un enorme avantage pour les debutants,
- une limite pour les utilisateurs avances.

### **Avantage : simplicite**
L'utilisateur n'a pas besoin de comprendre :
- matrices,
- buffers memoire,
- compilation GLSL,
- optimisation GPU.

### **Inconvenient : manque de contrôle avance**
Hydra ne permet pas :
- d'ecrire ses propres shaders personnalises ;
- d'optimiser manuellement la pipeline graphique ;
- d'acceder a toutes les capacites de WebGL.

L'outil reste donc volontairement abstrait, ce qui le rend simple mais moins flexible que d'autres environnements professionnels.

---

## **Resume rapide**

**Forces :**
- Tres rapide a experimenter  
- Fonctionne sur GPU  
- Accessible a tous  
- Excellent pour le live-coding  
- Esthetique visuelle forte  

**Limites :**
- Depend du navigateur  
- Performances variables  
- Pas ideal pour des projets complexes  
- Pas de contrôle shader avance  

---

# 15. Conclusion
En conclusion, Hydra vous permet de generer des visuels impressionnants et originaux dans votre navigateur. Grace a son architecture modulaire et sa syntaxe tres simple, cette technologie est extremement accessible. En quelques lignes simples il est possible de creer des animations complexes et interactives !

Hydra est particulierement pertinent dans le monde de l'art generatif et la monte de cette tendance dans les performances audiovisuelles ainsi que la creation numerique pour tous. Sans installation, Hydra est accessible autant pour les enseignants, les ateliers stimulants ou pour des artistes qui souhaitent experimenter sans se casser la tete. 

Au final, Hydra n'est pas seulement un outil de programmation, c'est une maniere d'explorer la creativite a travers le code. Comprendre les differentes combinaisons et les transformations afin de produire des compositions impressionnantes. Grace a Hydra, de Olivia Jack, le code devient un instrument et chaque ligne ouvre la porte a une experience visuelle completement differente.

---

# 16. References

- [Site officiel d'Hydra](https://hydra.ojack.xyz)
- [Presentation d'Olivia Jack](https://www.youtube.com/watch?v=lxLqcl-8GZE)
- [GitHub du projet](https://github.com/hydra-synth/hydra)
- [Documentation officielle](https://hydra.ojack.xyz/docs/docs/learning/getting-started/) 

---

# 17. Quelques definitions pratiques
## webgl
WebGL est une API graphique pour le navigateur qui permet de dessiner en 2D/3D en utilisant la carte graphique (GPU). Hydra utilise WebGL pour executer ses shaders et afficher les visuels en temps reel.

## snippets
Un "snippet" est un petit bout de code reutilisable. Dans Hydra, les snippets sont des exemples de code pre-ecrits que l'on peut charger pour comprendre comment certaines fonctions fonctionnent.

## live-coding
Le live-coding est une pratique ou l'on ecrit et modifie du code en temps reel pendant une performance, souvent accompagnee de musique et de visuels generes en direct.