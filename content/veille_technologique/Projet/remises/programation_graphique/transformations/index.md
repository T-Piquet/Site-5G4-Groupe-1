+++
title = "Transformations"
weight = 4
[params]
  author = 'Youssef Birji'
+++

Le processus de transformation des coordonnées est essentiel pour convertir les objets 3D de l'espace du modèle vers l'écran 2D. Ce processus implique plusieurs espaces de coordonnées :

![Espaces de coordonnées](/img/NDC.png)

## Espace Modèle (Model Space)

L'espace de l'objet en tant que tel par rapport à son centre. Par exemple, les différents points d'un triangle représentés par leur distance du centre du triangle.

## Espace Monde (World Space)

Après application de la **matrice de modèle**, les objets sont positionnés dans un espace commun où tous les objets de la scène coexistent. Ici, les objets auront comme coordonnées le centre du monde.

## Espace Vue (View Space)

La **matrice de vue** transforme les coordonnées du monde pour les placer par rapport à la caméra. La caméra devient l'origine de ce système de coordonnées.

## Espace Clip (Clip Space)

La **matrice de projection** (perspective ou orthographique) transforme les coordonnées en clip space. C'est ici que le GPU détermine quels sommets sont visibles.

## Coordonnées Normalisées (NDC - Normalized Device Coordinates)

Après division par la composante w (perspective divide), les coordonnées sont normalisées dans un cube allant de -1 à 1 dans toutes les dimensions.

## Coordonnées Écran (Screen Space)

La transformation finale convertit les NDC en coordonnées de pixels sur l'écran, en utilisant les dimensions de la fenêtre (viewport).

---

Par Youssef Birji.
