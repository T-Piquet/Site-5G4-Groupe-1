+++
title = "Atelier"
weight = 7
[params]
  author = 'Youssef Birji'
+++

Voici 3 exercices simples pour mettre en pratique les bases de GLSL. Essayez de les réaliser dans l'ordre pour progresser étape par étape.

> [!Warning] **Dev Container**
> N'oubliez pas d'utiliser le dev container et de suivre les instructions sur comment l'utiliser dans la [page d'explication OpenGL](../glsl/)
>
> lien: https://github.com/2176587/OpenGL-devcontainer/tree/master

## Exercice 1 : Triangle coloré avec dégradé

**Objectif** : Créer un triangle où chaque sommet a une couleur différente (rouge, vert, bleu), et observer l'interpolation automatique des couleurs.

**Ce que vous devez faire** :

1. Créer un vertex shader qui :
   - Accepte une position (`vec3 aPos`)
   - Accepte une couleur (`vec3 aColor`)
   - Passe la couleur au fragment shader

2. Créer un fragment shader qui :
   - Reçoit la couleur interpolée
   - L'utilise comme couleur finale du pixel

3. Définir 3 vertex avec leurs couleurs :
   - Vertex 1 : position (-0.5, -0.5, 0.0), couleur (1.0, 0.0, 0.0) - Rouge
   - Vertex 2 : position (0.5, -0.5, 0.0), couleur (0.0, 1.0, 0.0) - Vert
   - Vertex 3 : position (0.0, 0.5, 0.0), couleur (0.0, 0.0, 1.0) - Bleu

**Résultat attendu** : Un triangle avec un dégradé de couleurs du rouge au vert au bleu.

---

## Exercice 2 : Animation de rotation

**Objectif** : Faire tourner un carré autour de son centre en utilisant une matrice de transformation.

**Ce que vous devez faire** :

1. Créer un vertex shader qui :
   - Accepte une position (`vec3 aPos`)
   - Accepte un uniform `float time` (temps écoulé)
   - Calcule une rotation autour de l'axe Z basée sur le temps
   - Applique la rotation à la position

2. Créer un fragment shader simple qui :
   - Donne une couleur unie au carré (par exemple, orange)

3. Dans votre code application :
   - Mettre à jour l'uniform `time` à chaque frame
   - Dessiner un carré (2 triangles)

**Aide** : Matrice de rotation 2D autour de Z :
```
cos(angle)  -sin(angle)  0  0
sin(angle)   cos(angle)  0  0
0            0           1  0
0            0           0  1
```

**Résultat attendu** : Un carré qui tourne continuellement sur lui-même.

---

## Exercice 3 : Effet de pulsation

**Objectif** : Créer un cercle dont la couleur pulse entre deux couleurs différentes.

**Ce que vous devez faire** :

1. Créer un vertex shader simple qui :
   - Passe la position au fragment shader

2. Créer un fragment shader qui :
   - Accepte un uniform `float time`
   - Accepte deux uniforms `vec3 color1` et `vec3 color2`
   - Utilise `sin(time)` pour créer une valeur oscillante entre 0 et 1
   - Mélange les deux couleurs avec la fonction `mix()`
   - Dessine uniquement les pixels dans un rayon donné (créer un cercle)

3. Dans votre code application :
   - Définir color1 = (1.0, 0.0, 0.5) - Rose
   - Définir color2 = (0.0, 0.5, 1.0) - Bleu clair
   - Mettre à jour `time` à chaque frame

**Aide** : Pour créer un cercle dans le fragment shader, utilisez la distance du centre :
```glsl
vec2 center = vec2(0.5, 0.5);
float dist = distance(gl_FragCoord.xy / resolution, center);
if (dist > 0.3) discard;  // Jeter les pixels en dehors du cercle
```

**Résultat attendu** : Un cercle dont la couleur alterne doucement entre rose et bleu clair.

---

Par Youssef Birji.
