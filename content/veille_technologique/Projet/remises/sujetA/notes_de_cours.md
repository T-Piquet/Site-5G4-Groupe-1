+++
title = "Notes de cours"
weight = 2
+++

# Unity — DOTS (Data-Oriented Technology Stack)

## Introduction
Unity est un moteur de jeu et une plateforme de développement multiplateforme permettant de créer des applications interactives : jeux vidéo, simulations, expériences VR/AR et outils professionnels.  
Ces notes couvrent les bases du moteur, son pipeline, l’architecture d’un projet ainsi que le DOTS.

---

## Installation et préparation de l’environnement

### Unity Hub
Unity se gère via **Unity Hub**, qui sert à :
- installer différentes versions du moteur;
- gérer les projets;
- ajouter des modules de build;
- gérer la licence.

### Versions recommandées
- **LTS** : stable pour les projets longs.
- **Tech Stream** : nouvelles fonctionnalités, moins stable.

### Modules à installer
- Build Android
- Build Windows (IL2CPP)
- WebGL
- Visual Studio + extension Unity

---

## Structure d’un projet Unity

- Assets/
    - Scripts
    - Scènes
    - Modèles
    - Textures
    - Prefabs
- Packages/
    - Dépendances
- ProjectSettings/
    - Configuration du projet
- Library/
    - Cache (non versionné)

### Dossiers recommandés

- Assets/
- Scripts/
- Scenes/
- Prefabs/
- Materials/
- UI/
- Audio/
- Models/
- Plugins/

---

## Unity Editor : interface et outils essentiels

### Fenêtres principales
- **Hierarchy** : GameObjects présents dans la scène.
- **Scene View** : vue éditable de la scène.
- **Game View** : rendu réel du jeu.
- **Inspector** : propriétés du GameObject.
- **Project** : assets du projet.
- **Console** : logs et erreurs.

### Manipulation dans la scène
- `W` : Move  
- `E` : Rotate  
- `R` : Scale  
- Click droit + WASD : navigation

### Modes de jeu
- **Play** : tester
- **Pause**
- **Step**

> Les changements effectués en mode Play ne sont pas sauvegardés.

---

## C# dans Unity

Unity utilise C# pour toute logique personnalisée.

### Exemple de script

```csharp
using UnityEngine;

public class PlayerMove : MonoBehaviour
{
    public float speed = 5f;

    void Update()
    {
        float h = Input.GetAxis("Horizontal");
        float v = Input.GetAxis("Vertical");
        transform.Translate(new Vector3(h, 0, v) * speed * Time.deltaTime);
    }
}
```

### Cycle de vie 
- **Awake()** : initialisation précoce
- **Start()** : initialisation après activation
- **Update()** : logique frame par frame
- **FixedUpdate()** : physique
- **LateUpdate()** : après Update

---

## Scènes, GameObjects et Components

### Scènes

Une scène représente un écran ou un niveau (menu, niveau 1, crédits, etc.).

### GameObjects

Entités dans la scène qui contiennent des composants (Components). Un GameObject sans composants est juste un conteneur.

### Components

Les components ajoutent comportement et apparence aux GameObjects. Exemples courants :

- **Transform** : position, rotation, scale.
- **Renderer** : affichage (MeshRenderer, SpriteRenderer).
- **Rigidbody** : physique 3D (ou `Rigidbody2D` pour la 2D).
- **Collider** : collision (Box, Sphere, Mesh, etc.).
- **Scripts C#** : logique personnalisée.
- **Camera** : vue et rendu.

Unity suit le paradigme Entity-Component.

### Prefabs

Un Prefab est un modèle de GameObject réutilisable.

Avantages :

- **Réutilisation**
- **Overrides** (modifier des instances sans casser le modèle)
- **Mise à jour globale** (changer le Prefab met à jour ses instances)
- **Instantiation dynamique** (créer à l'exécution)

Exemple :

```csharp
public GameObject projectile;

void Shoot()
{
    Instantiate(projectile, transform.position, Quaternion.identity);
}
```

## Assets et pipeline d’importation

Unity importe automatiquement certains formats en assets utilisables :

- Images → textures
- FBX/Blend → modèles 3D
- WAV/OGG → audio
- Scripts (C#)
- Materials
- Animations

Options d’importation importantes :

- Taille
- Compression
- Mipmaps
- Format plateforme
- Type (Sprite, Normal Map)

## UI avec Unity

Trois systèmes principaux :

- Legacy OnGUI (déprécié)
- Unity UI (Canvas) — classique
- UI Toolkit — moderne

### Unity UI (Canvas)

Éléments courants : `Text`, `Button`, `Image`, `Slider`, `Panels`.

Exemple de bouton :

```csharp
public Button b;

void Start()
{
    b.onClick.AddListener(OnClick);
}

void OnClick()
{
    Debug.Log("Bouton cliqué");
}
```

## Système d’entrée (New Input System)

Système moderne pour clavier, souris, manettes et mobile.

Exemple :

```csharp
public InputAction moveAction;

void OnEnable() => moveAction.Enable();
void OnDisable() => moveAction.Disable();

void Update()
{
    Vector2 move = moveAction.ReadValue<Vector2>();
}
```

## Physique

Physique 3D (PhysX) :

- `Rigidbody`
- `Colliders` (Box, Sphere, Mesh)
- `Joints`
- `CharacterController`

Physique 2D (Box2D) :

- `Rigidbody2D`
- `Collider2D`
- `Joint2D`

Exemple de collision :

```csharp
void OnCollisionEnter(Collision col)
{
    Debug.Log(col.gameObject.name);
}
```

## Système d’animation

- `Animator`
- États
- Transitions
- Paramètres (float, bool, trigger)

Exemple :

```csharp
Animator anim;

void Start()
{
    anim = GetComponent<Animator>();
}

void Update()
{
    anim.SetFloat("Speed", Input.GetAxis("Vertical"));
}
```

## Caméras et lumières

Caméras :

- Caméra principale
- Caméra UI
- Caméra minimap

Lumières :

- Directional
- Point
- Spot
- Area (HDRP)

URP (Universal Render Pipeline) et shaders modernes, post-processing intégré.

## Bonnes pratiques et architecture

Organisation recommandée :

```
Assets/
  Scripts/Core/
  Scripts/Gameplay/
  Scripts/UI/
  Prefabs/
  Scenes/
  Materials/
  Models/
  Audio/
```

Patterns utiles :

- `ScriptableObjects` pour configuration
- Event Bus
- Architecture modulaire
- MVC/MVVM pour apps non-jeu
- Dependency Injection (ex. Zenject)

Outils recommandés :

- Cinemachine
- TextMeshPro
- DOTween
- URP
- Addressables

---

## Optimisation avancée — ECS / DOTS

Unity propose depuis quelques années une nouvelle façon de programmer : **DOTS (Data-Oriented Technology Stack)**.  
Cette approche transforme complètement la manière d'organiser données et calculs afin d'obtenir des performances beaucoup plus élevées.
 
L’objectif : comprendre *pourquoi* DOTS existe, *comment* il fonctionne, et *quelles bonnes pratiques suivre* pour l’utiliser efficacement.

---

## 1. Concepts fondamentaux à connaître

### 1.1 Qu’est-ce qu’une architecture orientée données ?

Contrairement au modèle classique **GameObject / MonoBehaviour**, DOTS met l’accent sur :

- **Les données (Components)** : des structs simples qui contiennent uniquement des valeurs.
- **Les entités (Entities)** : de simples identifiants uniques.
- **Les systèmes (Systems)** : le code qui traite les données des entités.

Autrement dit :  
> *On sépare complètement les données, la logique et l'organisation mémoire.*

Cette séparation permet un énorme gain de performance.

---

### 1.2 Archetypes et Chunks

Unity regroupe les entités **par type de composants** dans des blocs mémoire appelés **chunks**.

- Un **archetype** = une combinaison de composants.
- Un **chunk** = un bloc contigu en mémoire contenant uniquement des entités du même archetype.

**Pourquoi c’est rapide ?**  
Parce que la mémoire est organisée pour éviter les sauts, ce qui rend les itérations *cache-friendly*.

---

### 1.3 Jobs System

Unity peut diviser le travail en plusieurs **jobs** exécutés en parallèle sur plusieurs threads.

En 5e session : pensez ça comme des *threads gérés automatiquement* et sécurisés.

---

### 1.4 Burst Compiler

C’est un compilateur spécial qui optimise vos jobs :

- génération SIMD
- vectorisation
- optimisations bas niveau

En pratique :  
> Vous obtenez des performances comparables à du C/C++ sans changer votre façon de coder.

---

## 2. Bonnes pratiques essentielles

### 2.1 Utiliser des composants simples (value types)

Les composants doivent être :

- des **structs**
- sans références managées (pas de `class`, pas de strings modifiables)
- petits, compacts, faciles à aligner en mémoire

Cela permet aux chunks d'être plus compacts et plus rapides.

---

### 2.2 Minimiser les "structural changes"

Les opérations suivantes sont coûteuses :

- créer ou détruire une entité
- ajouter ou retirer un composant
- changer un archetype

Pourquoi ?  
Parce que cela oblige Unity à déplacer l'entité dans un autre chunk.

**Technique recommandée :**

- Les faire **en dehors de la boucle chaude**
- Utiliser un **EntityCommandBuffer (ECB)** pour les différer

---

### 2.3 Toujours préférer l’itération par chunk

Au lieu de faire :

- `GetComponent`
- `SetComponent`
- appels répétitifs à `EntityManager`

… vous laissez Unity vous fournir un chunk complet.

Avec :

- `IJobChunk`
- `Entities.ForEach().ScheduleParallel()`

---

## 3. Mémoire et layout de composants

### 3.1 Grouper les données utilisées ensemble

Par exemple, un objet qui se déplace :

- `Translation`
- `Velocity`

Ces deux composants seront souvent lus ensemble → mettez-les dans le même archetype.

---

### 3.2 Utilisation des NativeArray / NativeList

Pour des données temporaires en jobs :

- utiliser `NativeArray` ou `NativeList`
- avec `Allocator.TempJob`
- toujours les libérer dans `Dispose()`

---

### 3.3 BlobAssetReference

À utiliser pour :

- des données partagées
- immuables (jamais modifiées)

Éviter si vous devez les modifier souvent.

---

### Burst & Jobs

- Annoter les jobs avec `[BurstCompile]` pour gagner en performance.
- Favoriser `ScheduleParallel` pour les travaux qui peuvent s'exécuter en parallèle sans dépendances croisées.
- Éviter les locks; utiliser des algorithmes sans contention (partitionnement par chunk, atomics uniquement si nécessaire).

Exemple (Burst + Job):

```csharp
[BurstCompile]
public struct MoveJob : IJobChunk
{
    public float deltaTime;
    public ComponentTypeHandle<Translation> posHandle;

    public void Execute(ArchetypeChunk chunk, int chunkIndex, int firstEntityIndex)
    {
        var positions = chunk.GetNativeArray(posHandle);
        for (int i = 0; i < positions.Length; i++)
        {
            positions[i].Value += new float3(0, 0, 1) * deltaTime;
        }
    }
}
```

### Éviter les pièges courants

- Ne pas appeler `EntityManager.CreateEntity` ou `DestroyEntity` dans des boucles massives ; regrouper les opérations ou utiliser `EntityCommandBuffer`.
- Limiter les appels à `GetComponent`/`SetComponent` hors des jobs — privilégier les handles et l'accès par chunk.
- Ne pas utiliser `GameObject` / composants managed dans les systèmes critiques en performance.

### EntityQuery / Filters

- Utiliser des `EntityQuery` bien définies (`WithAll`, `WithAny`, `WithNone`) pour réduire le set de travail.
- Utiliser les **change filters** (`HasChanged`) pour ne traiter que les entités modifiées.

### Shared Components & Chunk Components

- Les **SharedComponentData** regroupe les entités en chunks selon la valeur du shared component ; utile pour réduire le travail de rendu mais attention aux ré-organisation fréquentes.
- Les **ChunkComponentData** contiennent des données communes à tout le chunk, économisant de la mémoire et accélérant l'accès.

### Profiling et outils

- Utiliser le Profiler d'Unity pour repérer les goulots d'étranglement CPU/GPU.
- Utiliser le Timeline et le Burst Inspector / Job debugger pour inspecter les jobs.
- Mesurer la fragmentation d'archetype et l'impact des structural changes.

### Exemples d'améliorations pratiques

- Remplacer des boucles Update qui itèrent toutes les entités par des jobs planifiés.
- Utiliser object pooling et réutiliser des entités plutôt que de les détruire/créer.
- Réduire la granularité des composants pour éviter des archetypes trop nombreux.

### Checklist rapide pour optimisation

- [ ] Profiler : identifier la partie la plus coûteuse
- [ ] Réduire structural changes dans la boucle chaude
- [ ] Grouper les composants fréquemment accédés
- [ ] Passez les jobs en `[BurstCompile]` et schedulez-les
- [ ] Utiliser `EntityCommandBuffer` pour modifications différées
- [ ] Préférer `IJobChunk` / `Entities.ForEach().ScheduleParallel()` pour itérations massives

---

## Conclusion

Unity est un moteur complet, flexible et utilisé professionnellement pour créer des projets interactifs multiplateformes. En maîtrisant les scènes, GameObjects, components, C#, UI, physique, animations et pipeline de build, vous pouvez produire des applications efficaces et structurées. Les systèmes avancés comme Addressables, URP, le New Input System, les Shaders et DOTS permettent d’aller encore plus loin dans la performance et la qualité.


