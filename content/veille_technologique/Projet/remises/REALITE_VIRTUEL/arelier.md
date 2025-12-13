+++
title = "Atelier : Moteur VR stéréoscopique en C++"
weight = 3
+++

Dans cet atelier, vous allez construire un **mini moteur de rendu VR stéréoscopique** en C++ avec OpenGL.

Concrètement, vous allez mettre en place :

- l’ouverture d’une fenêtre OpenGL ;
- l’affichage d’une **scène 3D simple** (sol et cubes) ;
- un **cube en rotation** pour visualiser le mouvement ;
- un rendu **stéréoscopique**, avec une vue pour l’**œil gauche** et une vue pour l’**œil droit**, affichées côte à côte.

L’objectif n’est pas de créer un moteur de jeu complet, mais de comprendre **les briques techniques fondamentales de la réalité virtuelle** :  
caméra virtuelle, matrices de vue et de projection, séparation des yeux et rendu stéréo.

> [!info] **Compétences visées**
>
> - Lire et comprendre la structure d’un projet C++/OpenGL existant.  
> - Comprendre le rôle des **shaders** (`vertex.glsl`, `fragment.glsl`).  
> - Comprendre comment générer deux vues différentes (gauche / droite) à partir d’une même scène 3D.  
> - Comprendre la différence entre **rendu mono** et **rendu stéréo**.  
> - Compiler et exécuter un projet (`vr` / `vr.exe`) dans un environnement reproductible (Docker).

---

## Qu’est-ce que la stéréoscopie en réalité virtuelle, et pourquoi est-elle essentielle ?

La **stéréoscopie** est le mécanisme fondamental qui permet à la réalité virtuelle de produire une **illusion de profondeur réaliste**.

Dans la vie réelle, nos deux yeux sont séparés d’environ **6 à 6,5 cm**  
(IPD — *Inter-Pupillary Distance*). Cette séparation fait que :

- chaque œil observe le monde depuis un **point de vue légèrement différent**.

Le cerveau combine ensuite ces deux images pour reconstruire :

- la **profondeur** ;
- la **distance des objets** ;
- le **volume** des formes ;
- notre **position dans l’espace**.

Sans stéréoscopie, la VR ne serait qu’un **écran plat placé devant les yeux** :  
il n’y aurait presque plus de relief, peu d’immersion, et l’expérience deviendrait rapidement inconfortable.

---

## Pourquoi faut-il rendre deux images différentes ?

En réalité virtuelle, il ne suffit pas d’afficher **la même image** deux fois.

Il faut créer deux **caméras virtuelles distinctes** :

- une pour **l’œil gauche** ;
- une pour **l’œil droit**.

Chaque caméra possède :

- une **position légèrement décalée** (selon l’IPD) ;
- une **matrice de vue différente** ;
- parfois une **projection légèrement différente** pour tenir compte des lentilles du casque.

Ce procédé s’appelle le **rendu stéréoscopique** (*stereo rendering*).

Dans cet atelier, vous implémentez une version simplifiée de ce principe :

- deux matrices de vue ;
- deux viewports ;
- un même monde 3D rendu deux fois.

Un mode **mono** est également disponible pour comparer visuellement :
- ce que l’on voit **avec** stéréoscopie ;
- et ce que l’on voit **sans** stéréoscopie.

Cette comparaison permet de comprendre concrètement **le rôle de la stéréoscopie dans la perception de la profondeur**.

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

Dépôt : https://github.com/SamuelGranger1/Laboratoire-Stereoscopie-1.git

```bash
git clone https://github.com/SamuelGranger1/Laboratoire-Stereoscopie-1.git
cd Laboratoire-Stereoscopie-1
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

// Couleur passée par le CPU
uniform vec4 colorOverride;

void main() {
    FragColor = colorOverride;
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



## 5. `main.cpp` — le “cerveau” de votre moteur VR

Le fichier `main.cpp` est le **point d’entrée principal** de votre application.

C’est lui qui orchestre **toute la logique du mini moteur VR**, du démarrage du programme jusqu’à l’affichage final à l’écran.

Concrètement, `main.cpp` est responsable de :

- l’initialisation de la fenêtre et du contexte OpenGL ;
- le chargement et la compilation des **shaders GPU** ;
- la création de la géométrie 3D (cubes et sol) ;
- la gestion de la **caméra VR** (la “tête”) ;
- le calcul des deux vues distinctes (œil gauche / œil droit) ;
- le rendu stéréoscopique image par image ;
- la libération propre des ressources à la fin du programme.

Même si ce projet n’est pas un moteur de jeu complet, `main.cpp` en contient déjà **les fondations essentielles**, telles qu’on les retrouve dans de vrais moteurs VR.

> [!tip] **Plan général du `main.cpp`**
>
> - Includes et bibliothèques  
> - Fonctions utilitaires (chargement et compilation des shaders)  
> - Caméra VR (`CameraState`) et gestion des entrées clavier  
> - Initialisation d’OpenGL (GLFW + GLEW)  
> - Chargement du programme shader  
> - Création de la géométrie 3D (VAO / VBO)  
> - Boucle principale : rendu stéréo (œil gauche / œil droit)  
> - Nettoyage des ressources  

---

### 5.1 Includes et bibliothèques

La première partie du fichier consiste à inclure toutes les **dépendances nécessaires** au fonctionnement du moteur.


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

- Ouvre un fichier sur le disque (vertex.glsl, fragment.glsl, etc.)

- Lit tout le contenu dans une chaîne de caractères

- Retourne le texte → parfait pour l’envoyer à OpenGL

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

- glCreateShader(type) : crée un shader (vertex ou fragment).

- glShaderSource : envoie le code GLSL au GPU.

- glCompileShader : compile le shader.

- En cas d’erreur, on récupère et on affiche le log de compilation.

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

- Charge vertex.glsl et fragment.glsl avec loadFile.

- Compile chaque shader avec compileShader.

- Les attache à un programme (glAttachShader) et fait le link (glLinkProgram).

- Libère les shaders individuels (on garde le programme final).

- Ce programme sera utilisé plus tard avec glUseProgram(program);

## 5.3 Caméra VR : structure CameraState et gestion clavier
### 5.3.1 Structure de la “tête” VR

```cpp
// --- Etat de la "tête" VR (caméra) ---
struct CameraState {
    glm::vec3 position = glm::vec3(0.0f, 1.6f, 5.0f); // hauteur humaine + recul
    float yaw   = 0.0f;  // rotation gauche/droite
    float pitch = 0.0f;  // regarder haut/bas
};
```

- position : position de la tête dans le monde 3D.

- yaw : orientation horizontale (gauche/droite).

- pitch : orientation verticale (haut/bas).

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

    glm::vec3 right = glm::normalize(glm::cross(forward, glm::vec3(0.0f, 1.0f, 0.0f)));
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
    if (cam.pitch > maxPitch) cam.pitch = maxPitch;
    if (cam.pitch < -maxPitch) cam.pitch = -maxPitch;
}
```

Touches utilisées :

W/S : avancer / reculer

A/D : strafe gauche / droite

Q/E : descendre / monter

Flèches ← → ↑ ↓ : tourner la tête

dt = temps écoulé depuis la dernière frame → mouvements fluides indépendants du FPS.

## 5.4 draw scene

```cpp
// --- Fonction utilitaire : dessiner la scène (sol + plusieurs cubes) ---
void drawScene(GLuint vao,
               GLint locModel,
               GLint locColor,
               float timeSeconds)
{
    glBindVertexArray(vao);

    // 1) Cube central qui tourne (bleu)
    glm::mat4 modelCenter = glm::mat4(1.0f);
    modelCenter = glm::translate(modelCenter, glm::vec3(0.0f, 1.2f, 0.0f));
    modelCenter = glm::rotate(modelCenter, timeSeconds * 0.8f, glm::vec3(0.0f, 1.0f, 0.0f));
    glUniformMatrix4fv(locModel, 1, GL_FALSE, &modelCenter[0][0]);
    glUniform4f(locColor, 0.15f, 0.55f, 1.0f, 1.0f); // bleu
    glDrawArrays(GL_TRIANGLES, 0, 36);

    // 2) Cube proche à gauche (orange/rouge)
    glm::mat4 modelNear = glm::mat4(1.0f);
    modelNear = glm::translate(modelNear, glm::vec3(-1.5f, 0.8f, -1.0f));
    glUniformMatrix4fv(locModel, 1, GL_FALSE, &modelNear[0][0]);
    glUniform4f(locColor, 1.0f, 0.45f, 0.1f, 1.0f); // orange
    glDrawArrays(GL_TRIANGLES, 0, 36);

    // 3) Cube loin à droite (vert)
    glm::mat4 modelFar = glm::mat4(1.0f);
    modelFar = glm::translate(modelFar, glm::vec3(2.5f, 0.8f, -8.0f));
    glUniformMatrix4fv(locModel, 1, GL_FALSE, &modelFar[0][0]);
    glUniform4f(locColor, 0.2f, 0.9f, 0.3f, 1.0f); // vert
    glDrawArrays(GL_TRIANGLES, 0, 36);

    // 4) Sol gris très large
    glm::mat4 modelFloor = glm::mat4(1.0f);
    modelFloor = glm::translate(modelFloor, glm::vec3(0.0f, -0.2f, -5.0f));
    modelFloor = glm::scale(modelFloor, glm::vec3(30.0f, 0.05f, 30.0f));
    glUniformMatrix4fv(locModel, 1, GL_FALSE, &modelFloor[0][0]);
    glUniform4f(locColor, 0.85f, 0.85f, 0.85f, 1.0f); // gris clair
    glDrawArrays(GL_TRIANGLES, 0, 36);
}
```

La fonction drawScene dessine plusieurs objets pour rendre la profondeur facile à percevoir :

- un cube central en rotation (repère dynamique) ;

- un cube plus proche (effet stéréo plus fort) ;

- un cube plus loin (effet stéréo plus faible) ;

- un sol large (repère visuel pour la distance).

- Chaque objet a une couleur différente pour aider à lire la scène.

## 5.5 Initialisation d’OpenGL (GLFW + GLEW)

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

    GLFWwindow* window = glfwCreateWindow(WIDTH, HEIGHT, "Mini VR Engine - Stereo Demo", nullptr, nullptr);
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
        std::cerr << "Erreur: glewInit a échoué : " << glewGetErrorString(err) << "\n";
        glfwTerminate();
        return -1;
    }

    glEnable(GL_DEPTH_TEST);
```

Résumé :

- glfwInit() : démarre GLFW.

- glfwCreateWindow() : crée une fenêtre 1600×900.

- glfwMakeContextCurrent() : associe le contexte OpenGL à la fenêtre.

- glewInit() : charge les fonctions OpenGL modernes (3.3+).

- glEnable(GL_DEPTH_TEST) : active le z-buffer pour un rendu 3D correct.

## 5.6 Chargement du programme shader

On utilise ici la fonction createProgram() vue plus haut.

```cpp
    // --- Programme shader ---
    GLuint program = createProgram("shaders/vertex.glsl", "shaders/fragment.glsl");
    if (program == 0) {
        glfwTerminate();
        return -1;
    }
```

Ce que ça fait :

- Charge vertex.glsl et fragment.glsl.

- Compile + link le programme GPU.

- En cas d’erreur, on quitte l’application proprement.

## 5.7 Création du cube 3D et des uniforms

```cpp
    // --- Données cube (cube unité) ---
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
    glBufferData(GL_ARRAY_BUFFER, sizeof(cubeVertices), cubeVertices, GL_STATIC_DRAW);
    glEnableVertexAttribArray(0); // layout (location = 0)
    glVertexAttribPointer(0, 3, GL_FLOAT, GL_FALSE, 3 * sizeof(float), (void*)0);
    glBindVertexArray(0);

    // --- Uniforms ---
    GLint locModel = glGetUniformLocation(program, "model");
    GLint locView  = glGetUniformLocation(program, "view");
    GLint locProj  = glGetUniformLocation(program, "proj");
    GLint locColor = glGetUniformLocation(program, "colorOverride");

    // IPD EXAGÉRÉE pour que la différence soit évidente sur écran
    float ipd = 0.30f; // 30 cm pour la démo (dans la vraie vie ~0.064f)

    CameraState cam;
    bool stereoEnabled = true;
    double lastTime = glfwGetTime();
```

Points importants :

- Les sommets décrivent un cube 2×2×2 centré sur l’origine.

- vao / vbo stockent la géométrie côté GPU.

- location = 0 correspond à l’attribut position dans vertex.glsl.

- On récupère les uniform pour les matrices model, view, proj.

## 5.8 Boucle principale : rendu VR stéréo

```cpp
    // --- Boucle principale ---
    while (!glfwWindowShouldClose(window)) {
        double currentTime = glfwGetTime();
        float dt = static_cast<float>(currentTime - lastTime);
        lastTime = currentTime;

        glfwPollEvents();

        // Toggle mono/stéréo avec la touche M
        static bool mWasPressed = false;
        if (glfwGetKey(window, GLFW_KEY_M) == GLFW_PRESS) {
            if (!mWasPressed) {
                stereoEnabled = !stereoEnabled;
                std::cout << (stereoEnabled ? "Mode = STEREO" : "Mode = MONO") << "\n";
            }
            mWasPressed = true;
        } else {
            mWasPressed = false;
        }

        updateCamera(window, cam, dt);

        // Recalcul de la direction de la caméra
        glm::vec3 forward;
        forward.x = cosf(cam.pitch) * sinf(cam.yaw);
        forward.y = sinf(cam.pitch);
        forward.z = cosf(cam.pitch) * cosf(cam.yaw) * -1.0f;

        glm::vec3 worldUp(0.0f, 1.0f, 0.0f);
        glm::vec3 right = glm::normalize(glm::cross(forward, worldUp));
        glm::vec3 up    = glm::normalize(glm::cross(right, forward));

        // Projections pour chaque oeil (moitié d'écran)
        float halfWidth = WIDTH * 0.5f;
        glm::mat4 projLeft  = glm::perspective(glm::radians(90.0f), halfWidth / (float)HEIGHT, 0.1f, 100.0f);
        glm::mat4 projRight = projLeft;

        glm::vec3 eyeCenter = cam.position;
        glm::vec3 eyeLeft;
        glm::vec3 eyeRight;
        glm::mat4 viewLeft;
        glm::mat4 viewRight;

        if (stereoEnabled) {
            // --- MODE STEREO : deux caméras légèrement décalées ---
            eyeLeft  = eyeCenter - right * (ipd * 0.5f);
            eyeRight = eyeCenter + right * (ipd * 0.5f);

            viewLeft  = glm::lookAt(eyeLeft,  eyeLeft  + forward, up);
            viewRight = glm::lookAt(eyeRight, eyeRight + forward, up);
        } else {
            // --- MODE MONO : même point de vue dans les deux moitiés ---
            glm::mat4 viewMono = glm::lookAt(eyeCenter, eyeCenter + forward, up);
            viewLeft  = viewMono;
            viewRight = viewMono;
        }

        glUseProgram(program);
        glEnable(GL_SCISSOR_TEST);

        // --- Oeil gauche : vue à gauche de l'écran ---
        glViewport(0, 0, (int)halfWidth, HEIGHT);
        glScissor(0, 0, (int)halfWidth, HEIGHT);
        glClearColor(0.03f, 0.03f, 0.12f, 1.0f);  // bleu nuit
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUniformMatrix4fv(locView,  1, GL_FALSE, &viewLeft[0][0]);
        glUniformMatrix4fv(locProj,  1, GL_FALSE, &projLeft[0][0]);
        drawScene(vao, locModel, locColor, static_cast<float>(currentTime));

        // --- Oeil droit : vue à droite de l'écran ---
        glViewport((int)halfWidth, 0, (int)halfWidth, HEIGHT);
        glScissor((int)halfWidth, 0, (int)halfWidth, HEIGHT);
        glClearColor(0.02f, 0.09f, 0.04f, 1.0f); // vert très foncé
        glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);

        glUniformMatrix4fv(locView,  1, GL_FALSE, &viewRight[0][0]);
        glUniformMatrix4fv(locProj,  1, GL_FALSE, &projRight[0][0]);
        drawScene(vao, locModel, locColor, static_cast<float>(currentTime));

        glDisable(GL_SCISSOR_TEST);
        glfwSwapBuffers(window);
    }
```

Idée VR :

- Les deux yeux voient le même cube, mais avec :

- matrices viewLeft / viewRight différentes

- même model et même proj (ou presque)

- glViewport découpe la fenêtre en deux moitiés (gauche/droite).

- C’est la différence entre les deux vues qui crée la profondeur stéréoscopique.

## 5.9 Nettoyage des ressources

```cpp
    glDeleteBuffers(1, &vbo);
    glDeleteVertexArrays(1, &vao);
    glDeleteProgram(program);

    glfwTerminate();
    return 0;
}
```

À la fin :

- On libère la mémoire GPU (VBO, VAO, programme shader).

- On ferme GLFW proprement.

# Compiler et exécuter

## A. Windows — Solution 1 (recommandée) : Visual Studio (MSVC)
### A.1 Ouvrir un terminal “Developer” (MSVC)

Ouvrir “x64 Native Tools Command Prompt for VS” (Visual Studio)
ou dans VS Code : terminal PowerShell si Visual Studio est installé et détecté.

### A.2 Build

Dans le dossier du projet :

```bash
cd C:\chemin\vers\Laboratoire-Stereoscopie-1
cmake -S . -B build
cmake --build build --config Release
```

### A.3 Run
```bash
.\build\Release\vr.exe
```
(Si vous avez build en Debug, c’est .\build\Debug\vr.exe.)

## B. Windows — Solution 2 : MSYS2 MinGW64 (comme un terminal “Linux”)
### B.1 Installer MSYS2 + outils

Installer MSYS2 : https://www.msys2.org/

Ouvrir “MSYS2 MinGW x64” (important)

Dans MSYS2 MinGW64, installer les outils + libs :
```bash
pacman -Syu
pacman -S mingw-w64-x86_64-toolchain
pacman -S mingw-w64-x86_64-cmake
pacman -S mingw-w64-x86_64-glfw mingw-w64-x86_64-glew mingw-w64-x86_64-glm
```
### B.2 Build

Dans MSYS2 MinGW64, aller dans le projet (exemple si le projet est sur C:) :

```bash
cd /c/chemin/vers/Laboratoire-Stereoscopie-1
rm -rf build
mkdir build
cd build
cmake -G "MinGW Makefiles" ..
cmake --build .
```

### B.3 Run

```bash
./vr.exe
```

## C. Linux (Ubuntu/Debian) — Build + Run
### C.1 Installer dépendances

```bash
sudo apt update
sudo apt install -y cmake g++ make git \
  libglfw3-dev libglew-dev libglm-dev \
  libgl1-mesa-dev libglu1-mesa-dev
```

### C.2 Build
```bash
cd /chemin/vers/Laboratoire-Stereoscopie-1
rm -rf build
cmake -S . -B build
cmake --build build
```

### C.3 Run

```bash
./build/vr
```

## Notes importantes

- Si cmake --build ... dit “not a CMake build directory (missing CMakeCache.txt)”, ça veut dire que la commande cmake ... de configuration n’a pas été faite au bon endroit (ou a échoué). Refaire la séquence complète : configure → build → run.

- Sous Windows, un .exe ne peut pas être lancé dans un conteneur Linux (et inversement). Compilez et exécutez dans le même environnement.
