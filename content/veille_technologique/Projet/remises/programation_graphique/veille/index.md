+++
title = "Veille Technologique"
weight = -1
+++

## Veille Technologique

J'ai envoyé ce prompt à **ChatGPT** 5: J'aimerais en savoir plus sur la programmation graphique (graphics programming) et sa pertinence dans le contexte moderne.

Et voici sa reponse:
```
La programmation graphique (graphics programming) est la discipline qui consiste à contrôler précisément le GPU pour générer des images — souvent en temps réel — à partir de données mathématiques (géométrie, lumière, matériaux). Elle est à la fois fondamentale, transversale et plus pertinente que jamais dans le contexte moderne.


---

1. Qu’est-ce que la programmation graphique, concrètement ?

À un niveau bas, c’est :

Définir des données géométriques (sommets, primitives)

Les transformer à travers une pipeline GPU (vertex → clip space → rasterisation → fragment)

Calculer la couleur finale des pixels à l’aide de shaders

Exploiter le parallélisme massif du GPU


Techniquement, cela implique :

APIs : OpenGL, Vulkan, DirectX, Metal, WebGPU

Langages : GLSL, HLSL, WGSL

Mathématiques : algèbre linéaire, géométrie 3D, optique



---

2. Pourquoi c’est toujours (et encore plus) pertinent aujourd’hui

Contrairement à une idée reçue, la programmation graphique ne se limite pas aux jeux vidéo.

a) Jeux vidéo et moteurs 3D

Toujours centrale pour :

Le rendu temps réel

L’optimisation GPU

Les moteurs (Unity, Unreal, moteurs maison)


Même avec des moteurs modernes, ceux qui comprennent le GPU vont plus loin.


---

b) Cinéma, VFX et rendu hors ligne

Path tracing

Shading physique (PBR)

Simulation de lumière réaliste


👉 Pixar, Disney, Weta, etc. reposent sur des concepts directement issus du graphics programming.


---

c) Réalité virtuelle / augmentée

Contraintes fortes :

90–120 FPS

Latence minimale

Distorsions optiques complexes


Sans maîtrise du pipeline graphique → expérience médiocre.


---

d) Visualisation scientifique & industrielle

Médecine (IRM, scanners)

Architecture

CAO

Simulation physique


Ici, la précision et la performance sont critiques.


---

e) Web moderne

Avec WebGL / WebGPU :

Sites interactifs

Data visualization avancée

Expériences artistiques (ShaderToy, Three.js)


👉 Le GPU devient un outil créatif sur le web.


---

f) IA, GPGPU et calcul parallèle

C’est un point clé moderne :

Les GPUs sont utilisés pour :

Machine learning

Simulation

Traitement d’image



La programmation graphique est une porte d’entrée naturelle vers le GPGPU.


---

3. Pourquoi apprendre le graphics programming aujourd’hui est stratégique

a) Tu apprends à penser “bas niveau mais moderne”

Tu comprends :

Le coût réel des opérations

La mémoire GPU

Le parallélisme


👉 Ces compétences sont rares et très recherchées.


---

b) Tu développes une intuition mathématique visuelle

Tu vois directement :

Les matrices

Les espaces (model, world, view, clip)

Les erreurs


C’est l’un des meilleurs terrains pour solidifier les maths appliquées.


---

c) Tu deviens indépendant des moteurs

Même si tu utilises Unreal ou Unity :

Tu comprends ce qu’ils font

Tu peux les étendre

Tu peux débugger ce que les autres ne comprennent pas



---

4. Est-ce encore utile avec les moteurs et abstractions modernes ?

Oui — et c’est même encore plus important.

> Les abstractions augmentent la productivité,
mais elles pénalisent ceux qui ne comprennent pas ce qu’elles cachent.



Les meilleurs profils :

savent utiliser les moteurs

et savent descendre dans le shader / le GPU



---

5. À qui ça s’adresse particulièrement ?

La programmation graphique est idéale si tu aimes :

Comprendre comment les choses fonctionnent

Les maths appliquées

Le rendu visuel

L’optimisation

La création d’outils techniques



---

6. Perspective moderne et future

Tendances actuelles :

Ray tracing matériel

WebGPU

Rendu hybride (raster + ray)

Compute shaders partout

Convergence graphics ↔ compute ↔ IA


👉 La frontière entre “graphics programmer” et “GPU programmer” disparaît.


---

7. En résumé

La programmation graphique aujourd’hui, c’est :

🔹 Une compétence fondamentale

🔹 Un levier énorme de performance

🔹 Un pont entre maths, code et art

🔹 Une base solide pour le futur (GPU, IA, XR)


Si tu veux, je peux :

te proposer un parcours d’apprentissage moderne

relier ça à OpenGL / ShaderToy / WebGPU

ou expliquer comment devenir graphics programmer aujourd’hui (études, projets, profils)


Dis-moi dans quelle direction tu veux aller.
```

J'ai également fait plusieurs recherches sur Google telles que:
- opengl obsolete
- what is graphics programing
- graphics programing intro
- new rendering technology
    - cette recherche m'a d'ailleurs permis de trouver [cet article](https://gpuopen.com/learn/amd-fsr-redstone-developers-neural-rendering/) au sujet de la "super-resolution" d'AMD, une technologie qui leur permet de faciliter à la carte graphique le processus de rasterization.

Ce que j'ai remarqué c'est que la nature des 2 recherches a été très différente. Ce que je veux dire par cela, c'est qu'il me paraît que la recherche avec l'intelligence artificielle et la recherche avec un moteur de recherche sont 2 cas d'utilisation différents.

Dans le cas de l'intelligence artificielle, elle me permet de lui présenter une question ouverte et très extensive et l'IA me présentera une réponse qui est vaste et variée et qui, malgré ce fait, est relativement satisfaisante étant donné le fait qu'elle me permet de découvrir des sujets m'ouvre des portes pour mes futures recherches plus spécifiques.

Google quant à lui, est beaucoup plus utile pour trouver des réponses spécifiques et claires par rapport à certains sujets théoriques ou pratiques. La raison pour laquelle j'ai été obligé de rechercher plusieurs petites phrases, c'est simplement parce que Google ne donne jamais de résultat satisfaisant lorsqu'on lui pose des questions qui sont trop vastes pour avoir des réponses qui peuvent être unifiées sur une seule page web. 

Dans le cas de ma recherche pour ce projet, j'ai principalement utilisé ChatGPT pour établir la structure de mes notes de cours et j'ai par la suite recherché les différentes catégories avec Google. 

Cela m'a ramené vers les sources suivantes:
- https://nicolbolas.github.io/oldtut/index.html (Ma source principale. Excellente source avec une grande variété d'informations sur la programmation graphique)
- https://www.youtube.com/playlist?list=PLlrATfBNZ98foTJPJ_Ev03o2oq3-GGOS2 (Pour la programmation avec OpenGL)
- https://learnopengl.com/Getting-started/Coordinate-Systems (Pour les transformations de coordonnées)
- https://www.songho.ca/opengl/gl_transform.html (Pour les transformations de coordonnées)
- https://www.youtube.com/watch?v=brDJVEPOeY8 (Explication du pipeline)
- https://www.youtube.com/watch?v=mLtiBjLq5Lc (La différence entre les 2 types de shaders)
- https://www.alloprof.qc.ca/ (Mathématiques de base)


---

Par Youssef Birji.
