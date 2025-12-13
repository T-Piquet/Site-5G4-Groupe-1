+++
title = "Exemples GLSL"
weight = 0
[params]
  author = 'Youssef Birji'
+++

Cette page présente des exemples pratiques de shaders GLSL utilisant [Shadertoy](https://www.shadertoy.com/new).

## Exemple 1: Forme Simple Sans Couleur

Ce premier exemple montre comment dessiner un simple cercle.

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // On transforme les coordonnées de pixel en valeurs entre 0 et 1
    vec2 uv = fragCoord / iResolution.xy;

    // On déplace l'origine au centre de l'écran
    uv = uv - 0.5;

    // On calcule la distance entre ce pixel et le centre
    float distance = length(uv);

    // Si la distance est plus petite que 0.2, on dessine en blanc
    if (distance < 0.2) {
        fragColor = vec4(1.0, 1.0, 1.0, 1.0); // Blanc
    } else {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0); // Noir
    }
}
```

**Explication**:
- Le programme ici boucle à travers tous les pixels (uv est un pixel singulier) de notre écran et exécute mainImage pour décider quoi faire avec le pixel.
- On vérifie si le pixel est à l'endroit où on souhaite dessiner un cercle.
- Si oui > blanc, sinon > noir.
- Résultat : un cercle blanc.

## Exemple 2: Ajouter de la Couleur (Fragment Shader)

Maintenant on ajoute des couleurs grace au Fragment Shader.

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Même chose qu'avant : on normalise les coordonnées
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - 0.5;

    float distance = length(uv);

    // On dessine un cercle
    if (distance < 0.2) {
        // On crée une couleur RGB
        // Rouge = 1.0, Vert = 0.5, Bleu = 0.8
        fragColor = vec4(1.0, 0.5, 0.8, 1.0); // Rose
    } else {
        // Fond bleu
        fragColor = vec4(0.1, 0.1, 0.3, 1.0);
    }
}
```

**Explication**:

- Le programme est le même qu'avant sauf que cette fois-ci on applique des couleurs (rose pour le cercle et bleu pour l'extérieur du cercle) à nos pixels.

## Exemple 3: Simple Animation (Vertex Shader)

Nous allons utiliser le Vertex shader pour faire tourner un cercle.

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - 0.5;

    // On fait tourner notre forme avec le temps
    float angle = iTime; // iTime = temps écoulé en secondes

    // Rotation mathématique
    float cosA = cos(angle);
    float sinA = sin(angle);

    // On applique la rotation aux coordonnées
    vec2 uvRotated;
    uvRotated.x = uv.x * cosA - uv.y * sinA;
    uvRotated.y = uv.x * sinA + uv.y * cosA;

    // On décale un peu pour mieux voir la rotation
    uvRotated.x = uvRotated.x + 0.2;

    float distance = length(uvRotated);

    if (distance < 0.15) {
        fragColor = vec4(1.0, 0.8, 0.2, 1.0); // Orange
    } else {
        fragColor = vec4(0.0, 0.0, 0.0, 1.0); // Noir
    }
}
```

**Explication**:

- `iTime` nous donne le temps qui passe
- On utilise cette valeur pour calculer un angle
- On positionne les couleurs de nos pixels basé sur cet angle
- Le vertex shader modifie la POSITION de la forme

## Exemple 4: Dégradé de Couleur (Fragment Shader)

On peut aussi créer des transitions de couleur avec le fragment Shader.

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    vec2 uv = fragCoord / iResolution.xy;

    // On utilise directement la position pour la couleur
    // De gauche (0) à droite (1)
    float rouge = uv.x;

    // De bas (0) à haut (1)
    float vert = uv.y;

    // Bleu constant
    float bleu = 0.5;

    // Chaque pixel a une couleur différente selon sa position
    fragColor = vec4(rouge, vert, bleu, 1.0);
}
```

**Explication**:

- La position X du pixel détermine la quantité de rouge
- La position Y détermine la quantité de vert
- Résultat : un dégradé arc-en-ciel
- Le rôle du fragment shader ici est de calculer la couleur de chacun de nos pixels.

## Exemple 5: Render 3D - Sphère avec Éclairage

Ici, nous allons créer notre premier rendu 3D. Nous allons utiliser le vertex shader pour dessiner la sphère et par la suite nous allons utiliser le fragment shader pour rajouter de la lumière sur celle-ci.

```glsl
void mainImage( out vec4 fragColor, in vec2 fragCoord )
{
    // Normaliser les coordonnées et centrer
    vec2 uv = fragCoord / iResolution.xy;
    uv = uv - 0.5;
    uv.x *= iResolution.x / iResolution.y; // Garder le bon ratio

    // Rayon de notre sphère
    float radius = 0.3;

    // Distance 2D du centre
    float dist2D = length(uv);

    // Si on est en dehors de la sphère
    if (dist2D > radius) {
        fragColor = vec4(0.1, 0.1, 0.15, 1.0); // Fond bleu foncé
        return;
    }

    // Calculer la coordonnée Z pour créer la 3D
    float z = sqrt(radius * radius - dist2D * dist2D);

    // Créer la normale 3D (direction perpendiculaire à la surface)
    vec3 normal = normalize(vec3(uv.x, uv.y, z));

    // Position de la lumière (animée avec le temps)
    vec3 lightPos = vec3(cos(iTime) * 2.0, sin(iTime) * 2.0, 1.5);

    // Direction de la lumière vers chaque point de la sphère
    vec3 lightDir = normalize(lightPos - vec3(uv.x, uv.y, z));

    // Calculer l'intensité de la lumière (éclairage diffus)
    // Plus la surface fait face à la lumière, plus elle est éclairée
    float diffuse = max(dot(normal, lightDir), 0.0);

    // Couleur de base de la sphère (rouge orange)
    vec3 baseColor = vec3(0.9, 0.4, 0.2);

    // Ajouter une lumière ambiante (pour qu'elle ne soit jamais complètement noire)
    float ambient = 0.2;

    // Couleur finale = couleur de base × (lumière ambiante + lumière directe)
    vec3 finalColor = baseColor * (ambient + diffuse * 0.8);

    fragColor = vec4(finalColor, 1.0);
}
```

**Explication**:

- On commence tout d'abord par déterminer la valeur de Z :
    - x² + y² + z² = r²
    - z = √(r² - x² - y²)
    - x² + y² = dist2D²
    - z = √(r² - dist2D²)
- La **normale** est un vecteur perpendiculaire à la surface de la sphère
- On calcule comment la lumière frappe chaque point de la surface en calculant l'intensité de la lumière
- L'éclairage **diffus** rend les parties face à la lumière plus brillantes
- La lumière **ambiante** empêche les zones sombres d'être complètement noires

**Concepts 3D**:

- **Normales** - direction de la surface
- **Éclairage diffus** - calcul de réflexion de lumière
- **Lumière ambiante** - éclairage de base

---

Par Youssef Birji.
