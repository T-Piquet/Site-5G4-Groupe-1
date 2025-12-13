+++
title = "Pipeline Graphique"
weight = 3
[params]
  author = 'Youssef Birji'
+++

Le pipeline graphique dans OpenGL consiste en plusieurs étapes qui transforment les données 3D en pixels affichés à l'écran.

![Pipeline Graphique](/img/graphics-pipeline.png)

## Application

Dans cette étape, on prépare à travers l'application (C++ ou autre) les données et les configurations nécessaires. L'application envoie ces données et demande leur render au GPU.

## Vertex Processor

Reçoit les Vertex (un à la fois) et le positionne dans le _clip space_ et par la suite dans un NDC. Le _clip space_ est un espace 3D où les sommets sont placés après une projection, cela permet au GPU de décider quelle partie est visible et laquelle ne l'est pas. Cette étape est la première de notre pipeline qui soit programmable. Elle peut appliquer les matrices de transformation reçues de l'application pour systématiquement modifier les positions des vertex.

## Geometry Processor

Cette étape, qui est la deuxième qui soit programmable de notre pipeline, n'est pas obligatoire. Elle permet d'appliquer des modifications à ce qu'on appelle des _primitives_.

Un _primitive_ est la forme la plus fondamentale qu'une carte graphique puisse dessiner. Contrairement au vertex processor, le geometry processor applique ses modifications à des formes complètes.

## Clipping/Rasterization

Tout d'abord cette étape va couper et retirer ce qui ne va pas être visible à l'écran (Clipping). Par la suite elle va transformer le monde 3D en 2D pour l'afficher à l'écran avec des pixels (Rasterization). Cette étape n'est pas programmable.

## Fragment Processor

Cette dernière étape programmable du pipeline nous permet de modifier la couleur des pixels. Cela nous servira à appliquer des textures, ajouter les ombrages, ajouter les éclairages, etc.

## Framebuffer

Le framebuffer est une mémoire vidéo qui préserve la valeur des couleurs de chaque pixel sur l'écran.

---

Par Youssef Birji.
