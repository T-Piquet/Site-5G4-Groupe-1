+++
title = "Notes de cours"
weight = 2
[params]
  author = 'Farid Sani'
+++

> [!info]
> Notes de cours portant sur le moteur de jeu Unity.  

## Unity : Fondements, fonctionnement et utilisation

Par Farid Sani.

---

### 1. Introduction générale

Unity est l’un des moteurs de jeu les plus populaires au monde. Il est utilisé par des studios professionnels, des développeurs indépendants, des étudiants et même des entreprises qui ne font pas du jeu vidéo au sens traditionnel (formation, visualisation 3D, architecture, simulation médicale, etc.). Sa force principale est de proposer un environnement de développement complet, visuel et relativement simple à prendre en main, tout en offrant des fonctionnalités avancées pour des projets plus ambitieux.

Après la lecture, vous devriez être capable de :
- comprendre la structure d’un projet Unity ;
- reconnaître les concepts de base (GameObject, Component, Prefab, Scene) ;
- naviguer dans l’interface de l’éditeur ;
- lire et écrire des scripts C# simples pour contrôler des objets ;
- comprendre comment sont gérées la physique, l’interface utilisateur et les ressources.

---

### 2. Installation et environnement de travail

#### 2.1 Unity Hub

L’installation d’Unity passe par un logiciel appelé **Unity Hub**. Ce programme sert de point central pour :

- installer différentes versions du moteur (par exemple Unity 2022 LTS, Unity 6, etc.) ;
- créer de nouveaux projets ;
- ouvrir, renommer ou supprimer des projets existants ;
- ajouter des modules de build (Android, iOS, WebGL, etc.).

#### 2.2 Création d’un projet

Depuis Unity Hub :

1. Cliquer sur **New Project**.  
2. Choisir un *template* :
   - **2D** pour les jeux en sprites ;
   - **3D** pour des environnements volumétriques simples ;
   - **URP 3D** si l’on veut un rendu plus moderne et optimisé ;
   - d’autres modèles existent pour la VR, le mobile, etc.
3. Donner un nom au projet et choisir un dossier.
4. Lancer la création.

Unity ouvre ensuite l’éditeur avec une scène vide et une structure de projet de base. C’est là que commence vraiment le travail.

---

### 3. Interface de l’éditeur Unity

L’éditeur Unity peut intimider au début, mais il est organisé en fenêtres dont chacune a un rôle précis.

#### 3.1 Hierarchy

La fenêtre **Hierarchy** affiche la liste de tous les objets présents dans la scène active. Chaque ligne correspond à un **GameObject**. Les GameObjects peuvent être groupés par parent/enfant, ce qui permet d’organiser la scène (par exemple un GameObject « Ennemis » qui contient toutes les instances d’ennemis).

#### 3.2 Scene View

La **Scene View** est la vue de travail. On y voit la scène de manière éditoriale : on peut déplacer les objets, zoomer, changer de point de vue, ajouter des lumières, positionner des caméras, etc. C’est un peu l’atelier dans lequel on construit le niveau.

#### 3.3 Game View

La **Game View** montre ce que le joueur verra quand on lance le jeu. Le cadre de la caméra y est respecté (résolution, ratio d’écran, etc.). Lorsque l’on appuie sur le bouton **Play**, c’est dans cette vue que le jeu s’exécute.

#### 3.4 Inspector

L’**Inspector** est une fenêtre essentielle. Quand on sélectionne un GameObject dans la Hierarchy ou dans la Scene, l’Inspector affiche tous les **components** attachés à cet objet : Transform, Sprite Renderer, Collider, Rigidbody, scripts, etc. C’est dans l’Inspector que l’on modifie la plupart des paramètres : valeurs numériques, références à d’autres objets, booléens, événements.

#### 3.5 Project Window

La **Project Window** correspond au gestionnaire de fichiers du projet. Elle reflète la structure du dossier `Assets` : scripts C#, sprites, prefabs, scènes, sons, matériaux, animations, etc. On peut créer des sous-dossiers pour organiser proprement le contenu : `Scripts`, `Prefabs`, `Scenes`, `Audio`, `UI`, etc.

#### 3.6 Console

La **Console** affiche les messages générés par Unity et par vos scripts :

- erreurs (en rouge) ;
- avertissements (en jaune) ;
- messages de debug (en blanc, via `Debug.Log()`).

Apprendre à lire et interpréter ces messages fait partie intégrante du travail avec Unity : une grande partie du débogage se fait depuis cette fenêtre.

---

### 4. Concepts fondamentaux : GameObjects, Components, Prefabs, Scenes

Unity adopte un modèle orienté **composition** plutôt qu’héritage. Au lieu de créer une énorme classe qui sait tout faire, on compose des objets à partir de petits blocs indépendants.

#### 4.1 GameObjects

Un **GameObject** est une entité qui existe dans une scène. Sans component, un GameObject est en quelque sorte « vide », à part son **Transform** (position, rotation, échelle). Il peut représenter des éléments visibles (un joueur, un mur, un ennemi), des éléments invisibles (un gestionnaire de score), ou encore des éléments abstraits (un point de spawn, un trigger).

#### 4.2 Components

Les **Components** sont les briques qui donnent vie aux GameObjects. Voici quelques composants courants :

- **Sprite Renderer** : pour afficher une image 2D ;
- **Mesh Renderer + Mesh Filter** : pour rendre un modèle 3D ;
- **Collider / Collider2D** : pour les collisions ;
- **Rigidbody / Rigidbody2D** : pour que l’objet obéisse aux lois de la physique ;
- **Audio Source** : pour jouer un son ;
- **Scripts C#** : pour coder des comportements personnalisés.

En attachant différents composants à un GameObject, on lui donne progressivement toutes ses fonctionnalités.

#### 4.3 Prefabs

Un **Prefab** est un GameObject « enregistré » comme modèle. On peut le considérer comme un moule permettant de fabriquer des copies identiques : par exemple un ennemi de base, un projectile, un bonus, une brique de décor.

L’intérêt majeur des prefabs est la maintenance : si vous modifiez le prefab (par exemple la vitesse de base d’un ennemi), toutes les instances présentes dans les scènes seront mises à jour automatiquement.

#### 4.4 Scenes

Une **Scene** représente une portion de jeu ou d’application : menu principal, niveau 1, écran de victoire, etc. Unity permet de charger des scènes de plusieurs manières :

- remplacement complet (on quitte la scène actuelle pour entrer dans une nouvelle) ;
- chargement additif (plusieurs scènes actives en même temps, pratique pour séparer le décor, les personnages, l’UI, etc.).

Organiser correctement son jeu en scènes facilite le développement, les tests et la navigation.

---

### 5. Programmation C# dans Unity

Pour donner des comportements interactifs, on écrit des scripts en **C#**. Chaque script est une classe qui hérite généralement de `MonoBehaviour` et qui est attachée à un GameObject comme component.

#### 5.1 Cycle de vie d’un script

Unity appelle certaines méthodes automatiquement :

- `Awake()` : appelée une seule fois, avant même `Start()`, quand l’objet est chargé.
- `Start()` : appelée au tout début de la vie de l’objet, juste avant la première frame.
- `Update()` : appelée à chaque frame. On y met souvent les contrôles du joueur ou les comportements dépendants du temps.
- `FixedUpdate()` : appelée à intervalles réguliers, synchronisés avec le moteur physique. On y met plutôt les calculs qui affectent des `Rigidbody`.
- `OnDestroy()` : appelée lorsque l’objet est détruit.

Exemple simple de script de déplacement horizontal :

```csharp
using UnityEngine;

public class PlayerMovement : MonoBehaviour
{
    public float speed = 5f;

    void Update()
    {
        float move = Input.GetAxis("Horizontal");
        transform.Translate(Vector3.right * move * speed * Time.deltaTime);
    }
}

```
Ce script doit être attaché à un GameObject (par exemple, le joueur) pour fonctionner.

#### 5.2 Références et communication entre objets

Les scripts doivent souvent communiquer entre eux. Quelques méthodes typiques :

- Exposer une variable publique ou `[SerializeField]` dans l’Inspector, puis y glisser un autre GameObject ou un component.
- Utiliser `GetComponent<T>()` pour récupérer un component sur le même objet.
- Utiliser `FindObjectOfType<T>()` ou des événements pour communiquer avec des gestionnaires globaux (par exemple un `GameManager`).

Exemple : récupérer un composant Rigidbody2D au démarrage :

```csharp
private Rigidbody2D rb;

void Start()
{
    rb = GetComponent<Rigidbody2D>();
}

```

### 6. Le moteur physique

Unity fournit un moteur physique complet, avec un support 2D et 3D. La physique permet d’obtenir des mouvements réalistes, des collisions, des rebonds, des forces, de la gravité et une dynamique globale beaucoup plus naturelle que si tout était codé manuellement.

#### 6.1 Rigidbody et Rigidbody2D

Un **Rigidbody** (3D) ou **Rigidbody2D** (2D) indique qu’un objet doit être contrôlé par la physique du moteur. Cela signifie que :

- l’objet sera affecté par la gravité,
- il pourra recevoir des forces ou des impulsions,
- il réagira aux collisions avec d’autres objets,
- il aura une vitesse et une inertie.

Sans Rigidbody, un objet est statique : il ne bouge pas tout seul et doit être déplacé manuellement avec `transform.Translate` ou une interpolation directe.

Paramètres importants :

- **Mass** : masse de l’objet  
- **Drag** / **Angular Drag** : frein sur la vitesse et la rotation  
- **Gravity Scale** (en 2D) : intensité de la gravité affectant l’objet  
- **Constraints** : permet de bloquer certaines rotations ou translations  

#### 6.2 Colliders et Triggers

Un **Collider** définit la forme géométrique utilisée pour les collisions.  
En 3D :
- BoxCollider  
- SphereCollider  
- CapsuleCollider  
- MeshCollider  

En 2D :
- BoxCollider2D  
- CircleCollider2D  
- CapsuleCollider2D  
- PolygonCollider2D  

Un collider peut être configuré en **Trigger**.  
Un Trigger n’arrête pas les objets mais permet de détecter qu’ils entrent dans une zone.

Exemple typique : augmenter le score quand le joueur passe un point.

#### 6.3 Détection de collisions et de triggers

Unity appelle automatiquement certaines méthodes quand des collisions se produisent :

```csharp
void OnCollisionEnter2D(Collision2D collision)
{
    Debug.Log("Collision avec : " + collision.gameObject.name);
}

void OnTriggerEnter2D(Collider2D other)
{
    Debug.Log("Trigger détecté avec : " + other.name);
}

```

Ces fonctions servent à :

déclencher un Game Over, appliquer des dégâts, ramasser un objet, activer un mécanisme (porte, lumière, etc.).

### 7. Interface utilisateur (UI)

Unity possède un système d’interface basé sur un **Canvas**, qui permet de créer tout ce qui concerne l’affichage à l’écran : menus, textes, boutons, panneaux, barres de vie, score, écrans de Game Over, etc. L’UI est un élément indispensable dans tout projet de jeu ou d’application interactive, car elle constitue le pont entre l’utilisateur et ce qu’il voit à l’écran.

#### 7.1 Canvas et ancrages

Le **Canvas** est le conteneur principal de toute interface graphique dans Unity. Il existe trois modes d’affichage :

- **Screen Space - Overlay**  
  Le Canvas se dessine par-dessus le jeu. C’est le mode le plus utilisé pour les HUD (score, vies, timer).

- **Screen Space - Camera**  
  Le Canvas dépend de la caméra sélectionnée. Ce mode est pratique lorsqu’on veut que l’UI soit affectée par les réglages de la caméra.

- **World Space**  
  L’UI est réellement placée dans la scène 3D, comme si elle était un objet physique.  
  Exemple : un panneau dans un monde VR ou un écran interactif dans un jeu 3D.

Les éléments qui composent l'UI (TextMeshPro, Image, Button, etc.) possèdent un système d’**anchors** (ancres).  
Les ancres déterminent comment un élément se repositionne lorsque la résolution change.

Exemples :

- ancrer un score en haut à gauche : il reste toujours dans ce coin, même si la fenêtre est redimensionnée ;
- ancrer un bouton au centre : il reste centré peu importe la résolution.

Bien gérer les ancres est essentiel pour éviter que l’UI se déforme ou se décale.

---

#### 7.2 TextMeshPro

Unity inclut **TextMeshPro**, un système avancé pour gérer les textes dans l’interface.  
Il remplace avantageusement l’ancien `UI.Text` grâce à :

- une meilleure netteté (même avec des polices personnalisées),
- des options typographiques avancées (ombres, contours, gradients),
- des performances satisfaisantes même dans des projets lourds,
- une meilleure gestion du rendu sur tous les types de résolutions et écrans.

TextMeshPro est utilisé pour :

- afficher le score,
- afficher un message « Game Over »,
- créer des menus,
- écrire des instructions à l’écran.

Tous les jeux modernes sous Unity utilisent TextMeshPro pour leur texte.

---

#### 7.3 Boutons et événements

Les **Buttons** (boutons UI) sont des éléments interactifs qui déclenchent une action lorsqu’on clique dessus.  
Chaque bouton possède un **événement `OnClick`** que l’on peut lier à une fonction publique dans un script.

Exemples d'utilisation :

- recommencer une partie,
- quitter le jeu,
- montrer / cacher un panneau,
- charger une autre scène,
- ouvrir un menu de paramètres.

Voici un exemple simple de fonction que peut appeler un bouton :

```csharp
using UnityEngine;
using UnityEngine.SceneManagement;

public class UIManager : MonoBehaviour
{
    public void RestartGame()
    {
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }
}

```

Pour connecter cette fonction au bouton :

- Sélectionner le bouton dans la Hierarchy.

Dans la section OnClick() de l’Inspector :

- cliquer sur +,

- glisser/déposer l’objet qui porte le script UIManager,

- choisir la fonction UIManager.RestartGame().

- Une fois cela fait, cliquer sur le bouton dans le jeu exécutera la fonction.

---

### 8. Exemples d’utilisation d’Unity

Unity est un moteur extrêmement polyvalent utilisé dans des milliers de projets à travers le monde. Il ne sert pas uniquement à créer des jeux vidéo : on le retrouve dans la formation professionnelle, la simulation, la visualisation architecturale, la réalité virtuelle et même l’industrie automobile.  

---

#### 8.1 Exemple : Jeu 2D (runner)

Un des projets les plus courants pour débuter avec Unity est un jeu 2D de type **runner**.  
Le joueur contrôle un personnage (ou une moto, selon votre projet) qui se déplace dans un environnement où :

- des obstacles apparaissent automatiquement,
- le joueur doit les éviter,
- un score augmente à chaque obstacle franchi,
- une collision déclenche un Game Over,
- une interface simple permet de recommencer.

Ce type de jeu introduit plusieurs concepts clés d’Unity :

- les **Prefabs** pour créer les obstacles réutilisables,  
- les **spawners** pour instancier des objets au fil du temps,  
- les **Colliders** pour détecter les collisions,  
- le **Canvas** pour afficher le score,  
- les **scripts C#** pour gérer le mouvement, le score, le game over, etc.

C’est un excellent exercice pour apprendre la base du moteur.

---

#### 8.2 Exemple : Jeu 3D simple

Unity excelle aussi dans la création de petits jeux 3D.  
Par exemple, un jeu où le joueur explore une zone, ramasse des objets et évite des dangers.  
Ce type de projet introduit :

- les modèles 3D (Mesh Renderer, matériaux),
- les lumières (Directional, Point, Spot),
- la caméra libre avec **Cinemachine** (caméra intelligente),
- l’animation de personnages (Animator Controller),
- la physique 3D (Rigidbody, Collider),
- les triggers pour ramasser un objet ou déclencher une action.

Même un prototype très simple peut être réalisé en quelques heures avec Unity, ce qui en fait un outil idéal pour le prototypage rapide.

---


##### Architecture et visualisation 3D

Unity est utilisé pour :

- créer des visites virtuelles d’immeubles,
- présenter des projets immobiliers,
- simuler des éclairages et des matériaux,
- afficher des objets 3D interactifs pour des clients.

Cela permet de remplacer des rendus statiques par des expériences immersives.

---

### 9. Avantages d’Unity

Unity est l’un des moteurs les plus utilisés dans le monde pour de bonnes raisons. Sa polyvalence, son accessibilité, ses outils intégrés et son écosystème riche en font un choix idéal pour les étudiants, les indépendants et même pour certains studios professionnels. Cette section présente les principaux avantages qui expliquent son immense popularité.

---

#### 9.1 Export multiplateforme

L’un des plus grands atouts d’Unity est sa capacité à exporter un même projet vers une grande variété de plateformes :

- Windows  
- macOS  
- Linux  
- Android  
- iOS  
- WebGL (jouable dans un navigateur)  
- Consoles (PlayStation, Xbox, Nintendo Switch — avec licences appropriées)  
- VR (Meta Quest, HTC Vive, Valve Index, etc.)  
- AR (Android ARCore, iOS ARKit)

Grâce à cette polyvalence, un seul projet peut toucher une audience très large.

---

#### 9.2 Accessibilité et simplicité d'apprentissage

Unity est connu pour être plus facile à apprendre que d’autres moteurs professionnels.  
Son interface visuelle et ses outils intuitifs permettent à des débutants de rapidement :

- créer une scène,
- manipuler des objets,
- écrire des scripts simples,
- importer des ressources,
- tester un prototype.

L'approche par **GameObjects** et **Components** est particulièrement pédagogique : elle aide à organiser les concepts et développe l’esprit de composition.

---

#### 9.3 Langage C# : moderne, propre et puissant

Unity utilise **C#**, un langage orienté objet, largement utilisé dans l’industrie hors du domaine des jeux.  
Avantages :

- syntaxe claire et structurée,
- riche écosystème .NET,
- très bons outils d’édition (Visual Studio, Rider),
- employable dans d'autres domaines (logiciel, back-end, mobile).

Pour un étudiant, apprendre C# est une compétence utile bien au-delà d’Unity.

---

#### 9.4 Prototypage rapide

Unity excelle dans le **prototypage rapide**.  
On peut créer une idée de gameplay en quelques minutes :

- importer un sprite → l’afficher → ajouter un script → tester  
- instancier un ennemi → le faire apparaître toutes les secondes  
- créer un bouton → déclencher une action  
- déplacer un personnage en 3 lignes de code  

Cette rapidité est extrêmement appréciée dans le développement.

---

#### 9.5 Écosystème d'outils très riche

Unity fournit une grande quantité d’outils intégrés ou disponibles via le **Package Manager** :

- **Cinemachine** : caméras dynamiques intelligentes  
- **Timeline** : création de cinématiques  
- **Animator / Animation tools** : systèmes d’animation avancés  
- **Particle System (VFX)** : effets visuels  
- **NavMesh** : navigation et IA basique  
- **Input System** : gestion avancée des controles  

Ce vaste ensemble de fonctionnalités permet de créer des projets très variés.

---

### 10. Limites d’Unity

Même si Unity est un moteur très polyvalent et largement utilisé, il n’est pas parfait. Comme tout outil technologique, il présente des limites qu’il faut connaître pour faire des choix éclairés.  
Ces limites ne rendent pas Unity mauvais, mais elles expliquent pourquoi certains projets ou studios préfèrent d’autres moteurs comme Unreal Engine.  

Voici les principales limites d’Unity.

---

#### 10.1 Performances et graphismes AAA

Unity peut produire de très beaux jeux, mais lorsqu’on vise :

- des graphismes photoréalistes,
- des environnements massifs,
- des effets visuels avancés,
- des simulations physiques haut de gamme,

**Unreal Engine** est souvent préféré, car son moteur de rendu (notamment Lumen, Nanite) est plus performant pour ce type de projets.  

Unity peut faire du AAA, mais cela demande beaucoup de travail d’optimisation, de shaders personnalisés et de pipelines graphiques complexes.

---

#### 10.2 Instabilité entre versions

Unity évolue rapidement et publie de nombreuses versions chaque année.  
Problèmes possibles :

- certaines mises à jour cassent la compatibilité avec des packages,
- des projets peuvent se comporter différemment d’une version à l’autre,
- les projets longs (plusieurs mois ou années) peuvent devenir compliqués à maintenir.

C’est pourquoi l’usage des **versions LTS** est recommandé.

---

#### 10.3 Complexité des gros projets

Unity est excellent pour les petits et moyens projets, mais pour de très grands jeux :

- la structure des scènes devient difficile à gérer,
- les temps de compilation peuvent augmenter,
- la gestion des ressources devient complexe,
- il faut maîtriser beaucoup d’outils avancés (Addressables, ECS/DOTS, profiling, optimisation mémoire, threading, etc.).

Unity peut tout faire, mais demande plus d’expérience pour les projets ambitieux.

---

#### 10.4 Optimisation parfois difficile

Certaines limitations techniques peuvent rendre l’optimisation plus exigeante :

- surcharge CPU pour certains systèmes internes,
- gestion des GameObjects gourmande pour de très grands nombres d’objets,
- nécessité d’utiliser des techniques avancées (Pooling, LOD, instancing).

Unity évolue pour résoudre ces problèmes (notamment avec DOTS/ECS), mais ce n’est pas encore entièrement standardisé.

---

### 11. Conclusion

Unity est aujourd’hui l’un des moteurs de jeu les plus polyvalents, accessibles et utilisés au monde. Sa philosophie basée sur les **GameObjects** et **Components**, l’intégration du langage **C#**, son interface intuitive, ainsi que son écosystème riche (Package Manager, Asset Store, outils intégrés) en font un choix idéal pour apprendre la création d’applications interactives.

Grâce à Unity, un développeur peut créer :

- des jeux 2D simples ou complexes,  
- des jeux 3D,  
- des prototypes rapides,  
- des expériences VR/AR,  
- des simulations professionnelles,  
- des visualisations architecturales,  
- et même des outils internes pour diverses industries.

Les sections précédentes ont présenté :

- comment installer Unity et comprendre son interface,  
- les concepts fondamentaux (GameObjects, Components, Prefabs, Scenes),  
- le cycle de vie des scripts en C#,  
- le fonctionnement de la physique 2D/3D,  
- la création d’interfaces utilisateur (UI),  
- la gestion des ressources et des packages,  
- des exemples concrets d’utilisation dans différents domaines,  
- ainsi que les avantages et limites du moteur.

Ce qu’il faut retenir, c’est que **Unity est un excellent moteur pour apprendre**, mais aussi un outil professionnel capable de soutenir des projets sérieux. Son large éventail d’applications permet à chaque développeur d’exprimer sa créativité, qu’il s’agisse de jeux vidéo, de simulations, ou de contenus interactifs.

Unity continue d’évoluer chaque année, et sa communauté grandissante garantit un support constant, des ressources d’apprentissage nombreuses et une innovation continue. Pour toutes ces raisons, il demeure un outil incontournable dans le paysage du développement interactif moderne.

---

## Sources
- Documentation officielle Unity : https://docs.unity3d.com
- Unity Learn : https://learn.unity.com
- Ressources pédagogiques et exemples issus du moteur Unity (éditeur, API, outils internes)

