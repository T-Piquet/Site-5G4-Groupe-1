+++
title = "Mathématiques"
weight = 2
[params]
  author = 'Youssef Birji'
+++

Nous allons tout d'abord survoler les concepts mathématiques nécessaires pour les bases de la programmation graphique.

## Les vecteur

![Vecteur](/img/vecteur.png)

Le vecteur est un objet mathematique qui possede une longueur et une direction. Cet objet peut servire a demontrer un mouvement quelconque.

Le vecteur peut etre representer en tant que:
- **Point A -> point B** : représente le vecteur allant du point A au point B
![math1](/img/math1.png)

- **Une ligne d'une longeur specifique avec un point d'origin**
![math2](/img/math2.png)

![math3](/img/math3.png)

De plus, nous pouvons représenter la longueur d'un vecteur avec le symbole suivant:
![math4](/img/math4.png)

## Opérations sur les vecteurs

**Addition de vecteurs** :
![math7](/img/math7.png)

**Multiplication scalaire** : où k est un scalaire
![math8](/img/math8.png)

**Magnitude (longueur)** : en 2D ou en 3D
![math9](/img/math9.png)

![math10](/img/math10.png)

**Vecteur unitaire** : (vecteur de longueur 1 dans la même direction)
![math11](/img/math11.png)

---

## Les matrices
Une matrice est un arrangement de lignes et de colonnes de chifres.

Dans une matrice:
- m represente le nombre de lignes de la matrice
- n represente le nombre de colonnes de la matrice
- a represente une valeur dans la matrice

![math12](/img/math12.png)

### Opérations sur les matrices

**Addition de matrices** 

![math13](/img/math13.png)
{{< notice info >}}
Pour qu'on puisse les additionner, nos matrices doivent avoir le même m et le même n.
{{< /notice >}}

**Multiplication scalaire** : On multiplie chaque élément de la matrice par k.

![math14](/img/math14.png)

**Multiplication de matrices** :

![math15](/img/math15.png)
{{< notice info >}}
Pour qu'on puisse les multiplier, notre première matrice doit avoir un n qui est égal au m de notre deuxième matrice.
{{< /notice >}}

**Transposée d'une matrice** : inverser les ligne et les colonnes d'une matrice.

![math16](/img/math16.png)

### Les matrices de transformation

Les matrices de transformation sont des matrices qui nous permettent de déplacer, agrandir/réduire ou faire pivoter des objets. Elles sont primordiales dans la programmation graphique car elles sont fondamentales au fonctionnement des [vertex shaders](../shaders/).

#### Transformations 2D

**Translation** (déplacement de tx, ty) :
![math17](/img/math17.png)

**Mise à l'échelle** (facteurs sx, sy) :
![math18](/img/math18.png)

**Rotation** (angle θ autour de l'origine) :
![math19](/img/math19.png)

#### Transformations 3D

**Translation** (déplacement de tx, ty, tz) :
![math20](/img/math20.png)

**Mise à l'échelle** (facteurs sx, sy, sz) :
![math21](/img/math21.png)

**Rotation** : On utilise des matrices différentes selon l'axe de rotation (X, Y ou Z). Chaque rotation fait tourner l'objet autour de cet axe en utilisant cos(θ) et sin(θ) dans le plan perpendiculaire.

---

Par Youssef Birji.
