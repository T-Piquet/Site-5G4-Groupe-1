+++
title = "Atelier : Moteur VR stéréoscopique en C++"
weight = 3
+++

Dans cet atelier, vous allez construire un **mini moteur VR stéréoscopique** en C++/OpenGL :

- ouverture d’une fenêtre OpenGL ;
- affichage d’un **cube 3D en rotation** ;
- rendu **stéréo**, avec une vue pour l’**œil gauche** et une vue pour l’**œil droit** côte à côte.

L’objectif est de comprendre **les briques techniques de base de la VR** : matrices de vue/projection, séparation des yeux, caméra virtuelle.

> [!info] **Compétences visées**
>
> - Lire et organiser un projet C++/OpenGL existant.  
> - Comprendre le rôle des **shaders** (`vertex.glsl`, `fragment.glsl`).  
> - Comprendre comment générer deux vues différentes (gauche/droite) pour un même monde 3D.  
> - Compiler et exécuter un projet (`vr` / `vr.exe`) dans un environnement reproductible (Docker).

---

## Qu’est-ce que la stéréoscopie en réalité virtuelle, et pourquoi est-elle essentielle ?

La **stéréoscopie** est le mécanisme fondamental qui permet à la réalité virtuelle de produire une **illusion de profondeur réaliste**.

Dans la vraie vie, nos deux yeux sont séparés d’environ **6.3 cm** (IPD — *Inter-Pupillary Distance*), ce qui fait que :

- chaque œil reçoit une **image légèrement différente** du monde réel.

Le cerveau fusionne ensuite ces deux images pour reconstruire :

- la **profondeur**,  
- la **distance des objets**,  
- le **volume** des formes,  
- la **position de notre corps** dans l’espace.

**Sans stéréoscopie, la VR serait juste un écran plat collé au visage**, sans relief, sans immersion et totalement inconfortable.

### Pourquoi doit-on rendre deux images différentes ?

En VR, on ne peut pas simplement afficher **la même scène** dans les deux yeux.

Il faut créer deux caméras virtuelles :

- une pour **l’œil gauche**
- une pour **l’œil droit**

Chacune possède :

- une **position différente** (décalage de l’IPD),
- une **orientation légèrement différente**,
- parfois une **projection asymétrique** pour compenser les lentilles du casque.

Ce procédé s’appelle **le rendu stéréo** (*stereo rendering*), et c’est exactement ce que vous allez implémenter dans cet atelier.

---

## 1. Prérequis

Avant de commencer, assurez-vous d’avoir accès aux outils suivants :

- **Git**
- **Docker**
- **Visual Studio Code** (recommandé)

> [!warning] **Important**
>
> Toute la compilation doit se faire **dans le conteneur Docker fourni**, afin que tout le monde travaille dans le même environnement.

---

## 2. Récupérer le projet de départ

### 2.1 Cloner le dépôt

```bash
git clone <URL-DU-DEPOT> labo-vr-cpp
cd labo-vr-cpp
```

---

## 3. Structure du projet

Lorsque vous ouvrez le dossier, vous devriez voir :

```
labo-vr-cpp/
  CMakeLists.txt
  Dockerfile
  main.cpp
  shaders/
    vertex.glsl
    fragment.glsl
```

---

## 4. Les shaders : programmes GPU

Les shaders sont des mini-programmes exécutés **sur la carte graphique**.

Il y en a 2 dans ce labo :

- `vertex.glsl` → transforme les sommets  
- `fragment.glsl` → colore les pixels  

Ils sont indispensables pour **toute application 3D**, et encore plus en VR où chaque œil possède sa propre matrice de vue.

---

## 4.1 `fragment.glsl` — Shader de fragments (pixels)

Ce shader s’exécute **pour chaque pixel**.  
Il détermine la **couleur finale** affichée à l'écran.

### Code du labo

```glsl
#version 330 core

out vec4 FragColor;

void main() {
    // Couleur bleu clair
    FragColor = vec4(0.3, 0.7, 1.0, 1.0);
}
```

### Rôle du fragment shader

- C’est **la dernière étape** du pipeline graphique.  
- Chaque pixel reçoit une couleur calculée ici.  
- Il peut gérer :
  - l’éclairage
  - les textures
  - les effets spéciaux  
  - l’anti-aliasing, fog, etc.

Dans le labo :  
**On affiche simplement une couleur bleu clair pour tester le rendu stéréo.**

---

## 4.2 `vertex.glsl` — Shader de sommets (positions 3D)

Ce shader est exécuté **une fois par sommet** du cube.  
Il transforme les coordonnées 3D pour les projeter sur l’écran.

### Code du labo

```glsl
#version 330 core

layout(location = 0) in vec3 position;

uniform mat4 model;
uniform mat4 view;
uniform mat4 proj;

void main() {
    gl_Position = proj * view * model * vec4(position, 1.0);
}
```

### Rôle du vertex shader

Il applique trois transformations essentielles :

1. **model**  
   Position, rotation, échelle du cube.

2. **view**  
   Position/orientation de la caméra (votre “tête VR”).

3. **proj**  
   Projection perspective (champ de vision, profondeur).

### Pourquoi c’est important en VR ?

Chaque œil a :

- une **position légèrement différente** (IPD = Inter-Pupillary Distance)  
- donc une **matrice `view` différente**

```text
œil gauche  → viewLeft
œil droit   → viewRight
```

Ce décalage est ce qui crée **la perception de profondeur**.



## 5. `main.cpp` est le “cerveau” de votre moteur VR.`

Le fichier `main.cpp` est le **point d’entrée** de votre application.  
C’est lui qui :

- initialise la fenêtre et OpenGL ;
- charge et compile les shaders ;
- crée la géométrie du cube ;
- gère la “tête VR” (caméra) ;
- dessine les deux vues (œil gauche / œil droit) à chaque frame.

> [!tip] Plan du `main.cpp`
> - Includes et bibliothèques  
> - Fonctions utilitaires pour les shaders  
> - Caméra VR (`CameraState`) et gestion clavier  
> - Initialisation d’OpenGL (GLFW + GLEW)  
> - Chargement du programme shader  
> - Création du cube 3D (VAO/VBO)  
> - Boucle principale : rendu stéréo (œil gauche / œil droit)  
> - Nettoyage des ressources  

---

### 5.1 Includes et bibliothèques

On commence par inclure toutes les dépendances nécessaires : OpenGL, GLFW, GLM et la STL.

```cpp
#include <GL/glew.h>
#include <GLFW/glfw3.h>

#include <glm/glm.hpp>
#include <glm/gtc/matrix_transform.hpp>

#include <fstream>
#include <sstream>
#include <iostream>
#include <string>
```


### Rôle des includes :

- GL/glew.h, GLFW/glfw3.h

- Fonctions OpenGL modernes

- Création de fenêtre / gestion clavier / boucle d’événements

- glm/...

- Math 3D : vecteurs, matrices, perspective, lookAt, etc.

- fstream, sstream, iostream, string

- Lecture de fichiers (pour les shaders)

- Affichage d’erreurs dans la console

## 5.2 Fonctions utilitaires : chargement + compilation des shaders
### 5.2.1 Lecture d’un fichier texte (loadFile)

```cpp
// --- Utilitaire pour charger un fichier texte (glsl) ---
std::string loadFile(const std::string& path) {
    std::ifstream file(path);
    if (!file) {
        std::cerr << "Erreur: impossible d'ouvrir le fichier " << path << "\n";
        return "";
    }
    std::stringstream buffer;
    buffer << file.rdbuf();
    return buffer.str();
}
```

À quoi ça sert ?

Ouvre un fichier sur le disque (vertex.glsl, fragment.glsl, etc.)

Lit tout le contenu dans une chaîne de caractères

Retourne le texte → parfait pour l’envoyer à OpenGL

### 5.2.2 Compilation d’un shader (compileShader)

```cpp
// --- Compilation d'un shader ---
GLuint compileShader(GLenum type, const std::string& source) {
    GLuint shader = glCreateShader(type);
    const char* src = source.c_str();
    glShaderSource(shader, 1, &src, nullptr);
    glCompileShader(shader);

    GLint ok = 0;
    glGetShaderiv(shader, GL_COMPILE_STATUS, &ok);
    if (!ok) {
        GLint logLen = 0;
        glGetShaderiv(shader, GL_INFO_LOG_LENGTH, &logLen);
        std::string log(logLen, '\0');
        glGetShaderInfoLog(shader, logLen, nullptr, log.data());
        std::cerr << "Erreur de compilation shader :\n" << log << "\n";
    }
    return shader;
}
```


Ce qui se passe :

glCreateShader(type) : crée un shader (vertex ou fragment).

glShaderSource : envoie le code GLSL au GPU.

glCompileShader : compile le shader.

En cas d’erreur, on récupère et on affiche le log de compilation.

### 5.2.3 Création du programme GPU (createProgram)

```cpp
// --- Création du programme shader complet ---
GLuint createProgram(const std::string& vertPath, const std::string& fragPath) {
    std::string vertSrc = loadFile(vertPath);
    std::string fragSrc = loadFile(fragPath);
    if (vertSrc.empty() || fragSrc.empty()) {
        std::cerr << "Erreur: shaders vides\n";
        return 0;
    }

    GLuint vs = compileShader(GL_VERTEX_SHADER, vertSrc);
    GLuint fs = compileShader(GL_FRAGMENT_SHADER, fragSrc);

    GLuint prog = glCreateProgram();
    glAttachShader(prog, vs);
    glAttachShader(prog, fs);
    glLinkProgram(prog);

    GLint ok = 0;
    glGetProgramiv(prog, GL_LINK_STATUS, &ok);
    if (!ok) {
        GLint logLen = 0;
        glGetProgramiv(prog, GL_INFO_LOG_LENGTH, &logLen);
        std::string log(logLen, '\0');
        glGetProgramInfoLog(prog, logLen, nullptr, log.data());
        std::cerr << "Erreur de linkage du programme :\n" << log << "\n";
    }

    glDeleteShader(vs);
    glDeleteShader(fs);

    return prog;
}
```

Résumé :

Charge vertex.glsl et fragment.glsl avec loadFile.

Compile chaque shader avec compileShader.

Les attache à un programme (glAttachShader) et fait le link (glLinkProgram).

Libère les shaders individuels (on garde le programme final).

Ce program sera utilisé plus tard avec glUseProgram(program);.

## 5.3 Caméra VR : structure CameraState et gestion clavier
### 5.3.1 Structure de la “tête” VR

```cpp
// --- Etat de la "tête" VR (caméra) ---
struct CameraState {
    glm::vec3 position = glm::vec3(0.0f, 1.6f, 5.0f); // hauteur humaine + recul
    float yaw   = 0.0f; // rotation gauche/droite
    float pitch = 0.0f; // regarder haut/bas
};
```

position : position de la tête dans le monde 3D.

yaw : orientation horizontale (gauche/droite).

pitch : orientation verticale (haut/bas).

## 5.3.2 Mise à jour de la caméra (updateCamera)

```cpp
void updateCamera(GLFWwindow* window, CameraState& cam, float dt) {
    const float moveSpeed = 3.0f;   // m/s
    const float rotSpeed  = 1.5f;   // rad/s

    // Calcul du vecteur "forward" et "right" selon yaw/pitch
    glm::vec3 forward;
    forward.x = cosf(cam.pitch) * sinf(cam.yaw);
    forward.y = sinf(cam.pitch);
    forward.z = cosf(cam.pitch) * cosf(cam.yaw) * -1.0f; // -Z vers l'avant

    glm::vec3 right = glm::normalize(
        glm::cross(forward, glm::vec3(0.0f, 1.0f, 0.0f))
    );
    glm::vec3 up    = glm::vec3(0.0f, 1.0f, 0.0f);

    // Déplacements (WASDQE)
    if (glfwGetKey(window, GLFW_KEY_W) == GLFW_PRESS)
        cam.position += forward * moveSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_S) == GLFW_PRESS)
        cam.position -= forward * moveSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_A) == GLFW_PRESS)
        cam.position -= right * moveSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_D) == GLFW_PRESS)
        cam.position += right * moveSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_E) == GLFW_PRESS)
        cam.position += up * moveSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_Q) == GLFW_PRESS)
        cam.position -= up * moveSpeed * dt;

    // Rotations (flèches)
    if (glfwGetKey(window, GLFW_KEY_LEFT) == GLFW_PRESS)
        cam.yaw += rotSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_RIGHT) == GLFW_PRESS)
        cam.yaw -= rotSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_UP) == GLFW_PRESS)
        cam.pitch += rotSpeed * dt;
    if (glfwGetKey(window, GLFW_KEY_DOWN) == GLFW_PRESS)
        cam.pitch -= rotSpeed * dt;

    // Clamp du pitch pour éviter de se retourner totalement
    const float maxPitch = glm::radians(89.0f);
    if (cam.pitch > maxPitch)  cam.pitch = maxPitch;
    if (cam.pitch < -maxPitch) cam.pitch = -maxPitch;
}
```

Touches utilisées :

W/S : avancer / reculer

A/D : strafe gauche / droite

Q/E : descendre / monter

Flèches ← → ↑ ↓ : tourner la tête

dt = temps écoulé depuis la dernière frame → mouvements fluides indépendants du FPS.

## 5.4 Initialisation d’OpenGL (GLFW + GLEW)

Cette partie se trouve dans le début de main().

```cpp
int main() {
    // --- Initialisation GLFW ---
    if (!glfwInit()) {
        std::cerr << "Erreur: Impossible d'initialiser GLFW\n";
        return -1;
    }

    glfwWindowHint(GLFW_CONTEXT_VERSION_MAJOR, 3);
    glfwWindowHint(GLFW_CONTEXT_VERSION_MINOR, 3);

    const int WIDTH  = 1600;
    const int HEIGHT = 900;

    GLFWwindow* window = glfwCreateWindow(
        WIDTH, HEIGHT,
        "Mini VR Engine - Vue Stereo",
        nullptr, nullptr
    );
    if (!window) {
        std::cerr << "Erreur: Impossible de créer la fenêtre GLFW\n";
        glfwTerminate();
        return -1;
    }

    glfwMakeContextCurrent(window);

    // --- GLEW ---
    glewExperimental = GL_TRUE;
    GLenum err = glewInit();
    if (err != GLEW_OK) {
        std::cerr << "Erreur: glewInit a échoué : "
                  << glewGetErrorString(err) << "\n";
        glfwTerminate();
        return -1;
    }

    glEnable(GL_DEPTH_TEST);
```

Résumé :

glfwInit() : démarre GLFW.

glfwCreateWindow() : crée une fenêtre 1600×900.

glfwMakeContextCurrent() : associe le contexte OpenGL à la fenêtre.

glewInit() : charge les fonctions OpenGL modernes (3.3+).

glEnable(GL_DEPTH_TEST) : active le z-buffer pour un rendu 3D correct.

## 5.5 Chargement du programme shader

On utilise ici la fonction createProgram() vue plus haut.

```cpp
    // --- Programme shader ---
    GLuint program = createProgram("shaders/vertex.glsl",
                                   "shaders/fragment.glsl");
    if (program == 0) {
        glfwTerminate();
        return -1;
    }
```

Ce que ça fait :

Charge vertex.glsl et fragment.glsl.

Compile + link le programme GPU.

En cas d’erreur, on quitte l’application proprement.

## 5.6 Création du cube 3D et des uniforms

```cpp
    // --- Données cube ---
    float cubeVertices[] = {
        // Face avant
        -1.f, -1.f,  1.f,   1.f, -1.f,  1.f,   1.f,  1.f,  1.f,
        -1.f, -1.f,  1.f,   1.f,  1.f,  1.f,  -1.f,  1.f,  1.f,
        // Face arrière
        -1.f, -1.f, -1.f,   1.f,  1.f, -1.f,   1.f, -1.f, -1.f,
        -1.f, -1.f, -1.f,  -1.f,  1.f, -1.f,   1.f,  1.f, -1.f,
        // Face gauche
        -1.f, -1.f, -1.f,  -1.f, -1.f,  1.f,  -1.f,  1.f,  1.f,
        -1.f, -1.f, -1.f,  -1.f,  1.f,  1.f,  -1.f,  1.f, -1.f,
        // Face droite
         1.f, -1.f, -1.f,   1.f,  1.f,  1.f,   1.f, -1.f,  1.f,
         1.f, -1.f, -1.f,   1.f,  1.f, -1.f,   1.f,  1.f,  1.f,
        // Face haut
        -1.f,  1.f, -1.f,  -1.f,  1.f,  1.f,   1.f,  1.f,  1.f,
        -1.f,  1.f, -1.f,   1.f,  1.f,  1.f,   1.f,  1.f, -1.f,
        // Face bas
        -1.f, -1.f, -1.f,   1.f, -1.f,  1.f,  -1.f, -1.f,  1.f,
        -1.f, -1.f, -1.f,   1.f, -1.f, -1.f,   1.f, -1.f,  1.f
    };

    GLuint vao = 0, vbo = 0;
    glGenVertexArrays(1, &vao);
    glGenBuffers(1, &vbo);

    glBindVertexArray(vao);
    glBindBuffer(GL_ARRAY_BUFFER, vbo);
    glBufferData(GL_ARRAY_BUFFER,
                 sizeof(cubeVertices),
                 cubeVertices,
                 GL_STATIC_DRAW);

    glEnableVertexAttribArray(0); // layout (location = 0)
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE,
                          3 * sizeof(float),
                          (void*)0);
    glBindVertexArray(0);

    // --- Uniforms ---
    GLint locModel = glGetUniformLocation(program, "model");
    GLint locView  = glGetUniformLocation(program, "view");
    GLint locProj  = glGetUniformLocation(program, "proj");

    // Matrice de projection (pour chaque oeil, on ajustera l'aspect)
    float ipd = 0.064f; // distance interpupillaire en mètres

    CameraState cam;
    double lastTime = glfwGetTime();
```

Points importants :

Les sommets décrivent un cube 2×2×2 centré sur l’origine.

vao / vbo stockent la géométrie côté GPU.

location = 0 correspond à l’attribut position dans vertex.glsl.

On récupère les uniform pour les matrices model, view, proj.

## 5.7 Boucle principale : rendu VR stéréo

```cpp
    // --- Boucle principale ---
    while (!glfwWindowShouldClose(window)) {
        double currentTime = glfwGetTime();
        float dt = static_cast<float>(currentTime - lastTime);
        lastTime = currentTime;

        glfwPollEvents();
        updateCamera(window, cam, dt);

        // Vision "forward" et vecteur right recalculés
        glm::vec3 forward;
        forward.x = cosf(cam.pitch) * sinf(cam.yaw);
        forward.y = sinf(cam.pitch);
        forward.z = cosf(cam.pitch) * cosf(cam.yaw) * -1.0f;

        glm::vec3 worldUp(0.0f, 1.0f, 0.0f);
        glm::vec3 right = glm::normalize(glm::cross(forward, worldUp));
        glm::vec3 up    = glm::normalize(glm::cross(right, forward));

        // Projections pour chaque oeil (moitié d'écran)
        float halfWidth = WIDTH * 0.5f;
        glm::mat4 projLeft  = glm::perspective(
            glm::radians(90.0f),
            halfWidth / (float)HEIGHT,
            0.1f, 100.0f
        );
        glm::mat4 projRight = projLeft;

        // Décalage des yeux (gauche/droite)
        glm::vec3 eyeCenter = cam.position;
        glm::vec3 eyeLeft   = eyeCenter - right * (ipd * 0.5f);
        glm::vec3 eyeRight  = eyeCenter + right * (ipd * 0.5f);

        glm::mat4 viewLeft  = glm::lookAt(eyeLeft,  eyeLeft  + forward, up);
        glm::mat4 viewRight = glm::lookAt(eyeRight, eyeRight + forward, up);

        // Modèle (cube qui tourne devant nous)
        static float angle = 0.0f;
        angle += dt * 0.8f;
        glm::mat4 model = glm::mat4(1.0f);
        model = glm::translate(model, glm::vec3(0.0f, 1.2f, 0.0f));
        model = glm::rotate(model, angle, glm::vec3(0.0f, 1.0f, 0.0f));

        glEnable(GL_SCISSOR_TEST); // pour bien nettoyer chaque oeil

        glUseProgram(program);
        glBindVertexArray(vao);

        // --- Oeil gauche : vue à gauche de l'écran ---
        glViewport(0, 0, (int)halfWidth, HEIGHT);
        glScissor(0, 0, (int)halfWidth, HEIGHT);
        glClearColor(0.05f, 0.05f, 0.15f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUniformMatrix4fv(locModel, 1, GL_FALSE, &model[0][0]);
        glUniformMatrix4fv(locView,  1, GL_FALSE, &viewLeft[0][0]);
        glUniformMatrix4fv(locProj,  1, GL_FALSE, &projLeft[0][0]);
        glDrawArrays(GL_TRIANGLES, 0, 36);

        // --- Oeil droit : vue à droite de l'écran ---
        glViewport((int)halfWidth, 0, (int)halfWidth, HEIGHT);
        glScissor((int)halfWidth, 0, (int)halfWidth, HEIGHT);
        glClearColor(0.05f, 0.1f, 0.05f, 1.0f);
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUniformMatrix4fv(locView,  1, GL_FALSE, &viewRight[0][0]);
        glUniformMatrix4fv(locProj,  1, GL_FALSE, &projRight[0][0]);
        glDrawArrays(GL_TRIANGLES, 0, 36);

        glBindVertexArray(0);
        glDisable(GL_SCISSOR_TEST);

        glfwSwapBuffers(window);
    }
```

Idée VR :

Les deux yeux voient le même cube, mais avec :

matrices viewLeft / viewRight différentes

même model et même proj (ou presque)

glViewport découpe la fenêtre en deux moitiés (gauche/droite).

C’est la différence entre les deux vues qui crée la profondeur stéréoscopique.

## 5.8 Nettoyage des ressources

```cpp
    glDeleteBuffers(1, &vbo);
    glDeleteVertexArrays(1, &vao);
    glDeleteProgram(program);

    glfwTerminate();
    return 0;
}
```

À la fin :

On libère la mémoire GPU (VBO, VAO, programme shader).

On ferme GLFW proprement.

