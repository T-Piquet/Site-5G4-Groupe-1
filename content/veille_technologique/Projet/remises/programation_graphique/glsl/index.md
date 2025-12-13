+++
title = "OpenGL et GLSL"
weight = 6
[params]
  author = 'Youssef Birji'
+++

## Qu'est-ce qu'OpenGL ?

**OpenGL** (Open Graphics Library) est une API graphique 2D et 3D publiée en 1992. Elle permet aux développeurs de communiquer avec le GPU pour afficher des graphiques à l'écran.

Pour être plus précis, **OpenGL** est un standard géré par le Khronos Group, sans propriétaire unique. Son implémentation en tant qu'API dépend des fabricants de cartes graphiques et plus précisément des développeurs des drivers de ces cartes graphiques. En raison de ce fait, il arrive (rarement) que les cartes graphiques de certains fabricants agissent de manière différente que d'autres fabricants car leur implémentation a tendance à être légèrement différente.


### Qu'est-ce que GLSL ?

**GLSL** (OpenGL Shading Language) est le langage de programmation utilisé pour écrire des shaders dans OpenGL. Il permet de programmer directement sur le GPU pour contrôler le rendering graphique.

### GLFW

**GLFW** (Graphics Library Framework) est une bibliothèque qui permet la création de fenêtres et la gestion des contextes OpenGL.

### Pourquoi GLFW ?

OpenGL ne sert qu'à faire du rendu graphique et ne fournit pas de fonctionnalités pour :
- Créer des fenêtres
- Gérer les événements clavier/souris
- Initialiser un contexte OpenGL

Malgré le fait qu'il est possible de faire ces actions sans bibliothèque, **GLFW** comble ces lacunes et nous offre une interface plus simple à utiliser.

### GLAD

Pour utiliser OpenGL moderne (3.3+), nous avons aussi besoin de **GLAD**. C'est une bibliothèque qui charge les fonctions OpenGL depuis votre carte graphique.
 
Les fonctions OpenGL comme `glCreateShader()`, `glGenVertexArrays()`, etc. ne sont pas directement disponibles. GLAD les charge dynamiquement depuis les drivers de votre carte graphique.

## Synthaxe GLSL

### Exemple de configuration minimale avec GLFW et GLAD

```cpp
#include <glad/glad.h>
#include <GLFW/glfw3.h>
#include <iostream>

int main() {
    // Initialisation de GLFW
    if (!glfwInit()) {
        std::cerr << "Échec de l'initialisation de GLFW" << std::endl;
        return -1;
    }

    // Configuration du contexte OpenGL
    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);
    glfwWindowHint(GLFW_OPENGL_PROFILE, GLFW_OPENGL_CORE_PROFILE);

    // Création de la fenêtre
    GLFWwindow* window = glfwCreateWindow(800, 600, "Ma fenêtre OpenGL", nullptr, nullptr);
    if (!window) {
        std::cerr << "Échec de la création de la fenêtre" << std::endl;
        glfwTerminate();
        return -1;
    }

    // Activation du contexte OpenGL
    glfwMakeContextCurrent(window);
    
    // Initialiser GLAD pour charger les fonctions OpenGL
    if (!gladLoadGLLoader((GLADloadproc)glfwGetProcAddress)) {
        std::cerr << "Échec de l'initialisation de GLAD" << std::endl;
        return -1;
    }

    // Boucle de render
    while (!glfwWindowShouldClose(window)) {
        // Rendered ici
        glClear(GL_COLOR_BUFFER_BIT);

        // Échange des buffers et gestion des événements
        glfwSwapBuffers(window);
        glfwPollEvents();
    }

    // Nettoyage
    glfwTerminate();
    return 0;
}
```

### Compiler et utiliser des shaders

Avant de pouvoir utiliser nos shaders GLSL, nous devons:
1. **Compiler** chaque shader individuellement (vertex et fragment)
2. **Lier** les shaders ensemble pour créer un programme complet
3. **Utiliser** le programme dans notre boucle de render

#### Fonction pour compiler un shader

Cette fonction nous permet de gagner du temps en compilant notre code GLSL (sous forme de texte) et retourne un ID.

```cpp
GLuint compileShader(GLenum type, const char* source) {
    // Créer le shader
    GLuint shader = glCreateShader(type);
    
    // Attacher le code source
    glShaderSource(shader, 1, &source, nullptr);
    
    // Compiler
    glCompileShader(shader);
    
    // Vérifier les erreurs de compilation
    GLint success;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &success);
    if (!success) {
        char infoLog[512];
        glGetShaderInfoLog(shader, 512, nullptr, infoLog);
        std::cerr << "Erreur de compilation du shader:\n" << infoLog << std::endl;
    }
    
    return shader; // Retourne un identifiant de shader compilé
}
```

#### Créer un programme de shader

Une fois nos deux types de shaders compilés, nous devons les lier pour créer un programme complet qui contient aussi bien les fragment shaders que les vertex shaders.

```cpp
GLuint createShaderProgram(GLuint vertexShader, GLuint fragmentShader) {
    // Créer le programme
    GLuint program = glCreateProgram();
    
    // Attacher les shaders
    glAttachShader(program, vertexShader);
    glAttachShader(program, fragmentShader);
    
    // Lier le programme
    glLinkProgram(program);
    
    // Vérifier les erreurs de liaison
    GLint success;
    glGetProgramiv(program, GL_LINK_STATUS, &success);
    if (!success) {
        char infoLog[512];
        glGetProgramInfoLog(program, 512, nullptr, infoLog);
        std::cerr << "Erreur de liaison du programme:\n" << infoLog << std::endl;
    }
    
    // Les shaders peuvent être supprimés après la liaison
    glDeleteShader(vertexShader);
    glDeleteShader(fragmentShader);
    
    return program;
}
```

> [!Warning] **Important**
> Après la liaison, vous pouvez maintenant supprimer les shaders individuels avec `glDeleteShader()` car leur code est maintenant intégré dans le programme.


#### Exemple complet d'utilisation

Pour faire usage de ces fonctions dans notre code, on utilise `R"(...)"` qui permet d'écrire du code GLSL sur plusieurs lignes.
```cpp
// 1. Écrire le code GLSL des shaders
const char* vertexShaderSource = R"(
    #version 330 core
    layout (location = 0) in vec3 aPos;
    layout (location = 1) in vec3 aColor;
    
    out vec3 ourColor;
    
    void main() {
        gl_Position = vec4(aPos, 1.0);
        ourColor = aColor;
    }
)";

const char* fragmentShaderSource = R"(
    #version 330 core
    in vec3 ourColor;
    out vec4 FragColor;
    
    void main() {
        FragColor = vec4(ourColor, 1.0);
    }
)";

// 2. Compiler les shaders
GLuint vertexShader = compileShader(GL_VERTEX_SHADER, vertexShaderSource);
GLuint fragmentShader = compileShader(GL_FRAGMENT_SHADER, fragmentShaderSource);

// 3. Créer le programme
GLuint shaderProgram = createShaderProgram(vertexShader, fragmentShader);

// 4. Utiliser le programme dans la boucle de render
glUseProgram(shaderProgram);
```

**Explications de quelques lignes:**

- **`#version 330 core`** : Indique la version d'OpenGL utilisée (3.3)
- **`layout (location = 0)`** : Spécifie où le shader reçoit les données (correspond au `glVertexAttribPointer`)
- **`in` / `out`** : Variables d'entrée et de sortie du shader
- **`R"(...)"`**: Syntaxe C++ pour écrire du texte en plusieurs lignes

N'oubliez pas de compiler vos shaders **une seule fois** au début du programme, après avoir créé le contexte OpenGL.

#### Envoyer des données aux shaders

Suite à cela, nous devons envoyer des données à notre programme pour qu'il puisse travailler dessus. Il existe cependant 2 types de données.

**1. Les données des vertex** : Ce sont les informations de base de nos formes (positions, couleurs, etc.). Elles sont stockées dans des tableaux et envoyées au GPU une seule fois au début.

```cpp
// Un triangle : 3 vertex avec positions x, y, z
float vertices[] = {
    -0.5f, -0.5f, 0.0f,  // vertex 1 (bas gauche)
     0.5f, -0.5f, 0.0f,  // vertex 2 (bas droite)
     0.0f,  0.5f, 0.0f   // vertex 3 (haut centre)
};
```

Ces données restent sur le GPU et sont utilisées à chaque fois qu'on fait un rendu.

**2. Les uniforms** : Ce sont des variables globales que nous pouvons modifier à chaque image (temps, couleurs, etc.). Contrairement aux données de vertex, les uniforms peuvent changer à chaque frame.

```cpp
// Récupérer l'emplacement de la variable dans le shader
int timeLocation = glGetUniformLocation(program, "time");

// Envoyer la valeur au shader
float currentTime = glfwGetTime();
glUniform1f(timeLocation, currentTime);
```

**Comment utiliser un uniform dans un shader :**
```glsl
uniform float time;  // Reçoit la valeur depuis le C++

void main() {
    float pulse = sin(time);  // Utilise le temps pour animer
    FragColor = vec4(pulse, 0.0, 0.0, 1.0);
}
```

**Fonctions `glUniform` courantes :**
- `glUniform1f(location, value)` : Envoie un seul `float`
- `glUniform3f(location, x, y, z)` : Envoie 3 `float` (par exemple, une couleur RGB)
- `glUniform2f(location, x, y)` : Envoie 2 `float` (par exemple, une résolution)

#### Le cycle de render complet

Maintenant que nous savons comment compiler les shaders et comment leur envoyer des données, il ne reste plus qu'a voir le cycle complet pour afficher quelque chose à l'écran.

**Étape 1 : Préparation (une seule fois au début du programme)**

Cette étape configure comment les données sont organisées sur le GPU :

```cpp
// 1. Préparer (une seule fois au début)
GLuint VAO, VBO;
glGenVertexArrays(1, &VAO);
glGenBuffers(1, &VBO);
glBindVertexArray(VAO);
glBindBuffer(GL_ARRAY_BUFFER, VBO);
glBufferData(GL_ARRAY_BUFFER, sizeof(vertices), vertices, GL_STATIC_DRAW);
glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
glEnableVertexAttribArray(0);
```

**Que fait ce code ?**
- **VAO (Vertex Array Object)** : Conteneur qui mémorise la configuration de vos données
- **VBO (Vertex Buffer Object)** : Buffer qui stocke les données des vertex sur le GPU
- **glVertexAttribPointer** : Indique au GPU comment lire les données (3 valeurs float par vertex pour la position)
- **glEnableVertexAttribArray(0)** : Active l'attribut à la location 0 (correspond au `layout (location = 0)` dans le shader)

**Étape 2 : Boucle de render (répété à chaque image)**

Cette partie s'exécute en continu, typiquement 60 fois par seconde :

```cpp
// 2. Dans la boucle (à chaque image)
while (!glfwWindowShouldClose(window)) {
    glClear(GL_COLOR_BUFFER_BIT);              // Effacer l'écran
    glUseProgram(shaderProgram);                // Utiliser vos shaders
    glBindVertexArray(VAO);                     // Utiliser vos données
    glDrawArrays(GL_TRIANGLES, 0, 3);          // Dessiner !
    
    glfwSwapBuffers(window);
    glfwPollEvents();
}
```

**Explication de la boucle :**
1. **`glClear()`** : Efface l'écran (comme effacer un tableau noir avant de redessiner)
2. **`glUseProgram()`** : Active vos shaders pour qu'ils soient utilisés pour le dessin
3. **`glBindVertexArray()`** : Sélectionne les données à utiliser (votre triangle)
4. **`glDrawArrays(GL_TRIANGLES, 0, 3)`** : Dessine
   - `GL_TRIANGLES` : Dessiner des triangles
   - `0` : Commencer au premier vertex
   - `3` : Utiliser 3 vertex (un triangle)
5. **`glfwSwapBuffers()`** : Affiche le résultat à l'écran
6. **`glfwPollEvents()`** : Vérifie si l'utilisateur a appuyé sur des touches ou fermé la fenêtre

## Fonctions utiles pour l'atelier

**Changer la couleur dans le temps** :
```glsl
uniform float time;
float variation = sin(time) * 0.5 + 0.5;  // Oscille entre 0 et 1
vec3 color = vec3(variation, 0.0, 1.0 - variation);
```

**Mélanger deux couleurs** :
```glsl
uniform vec3 color1;
uniform vec3 color2;
float facteur = 0.5;  // 0 = 100% color1, 1 = 100% color2
vec3 resultat = mix(color1, color2, facteur);
```

**Faire tourner un point** :
```glsl
uniform float time;
float angle = time;
float newX = position.x * cos(angle) - position.y * sin(angle);
float newY = position.x * sin(angle) + position.y * cos(angle);
```

## Compilation du programme

**Dev Container fourni :** Ce projet inclut un dev container Debian avec GLAD, MinGW (Win64) et g++ déjà configurés. Les bibliothèques GLFW pour Windows sont incluses pour la cross-compilation.

**Lien GitHub du dev container :** https://github.com/2176587/OpenGL-devcontainer/tree/master

#### Installation de GLFW (dev container)

Dans le dev container, installez GLFW pour Linux :
```bash
sudo apt-get update
sudo apt-get install libglfw3-dev
```

#### Compilation

**Pour Linux (dans le dev container) :**
```bash
g++ -o mon_programme mon_programme.cpp src/glad.c -I./include -lglfw -lGL -ldl
```

**Pour Windows (cross-compilation depuis le dev container) :**
```bash
x86_64-w64-mingw32-g++ mon_programme.cpp src/glad.c -o mon_programme.exe \
    -I./include -I./include/windows \
    -L./lib/windows \
    -lglfw3 -lopengl32 -lgdi32 -static
```

#### Installation manuelle (hors dev container)

**macOS :**
```bash
brew install glfw
```

Par la suite, Téléchargez GLAD depuis https://glad.dav1d.de/ (OpenGL 3.3, Core) et placez `glad.c` dans `src/` et les headers dans `include/`.

---

Par Youssef Birji.
