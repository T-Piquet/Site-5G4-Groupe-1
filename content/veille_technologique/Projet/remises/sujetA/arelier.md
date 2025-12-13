+++
title = "Atelier"
weight = 3
+++

# Atelier — Découvrir DOTS

Cet atelier a pour but :

- de créer un projet Unity moderne  
- d’installer DOTS (ECS + Jobs + Burst)  
- de faire un exemple minimal  
- de comprendre les différences fondamentales entre **POO classique** et **DOTS**  
- d’illustrer les avantages (performances, organisation mémoire)

---

# 1. Création du projet Unity

## 1.1 Installer la bonne version d’Unity

DOTS est officiellement stable à partir de :

- **Unity 2022.3 LTS** (ECS 1.0)  
- ou **Unity 2023 LTS**  

Assurez-vous d’utiliser au minimum Unity **2022.3 LTS**.

---

## 1.2 Créer un nouveau projet

1. Ouvrez Unity Hub  
2. Cliquez sur **New Project**  
3. Choisissez le template **Core 3D (URP ou non-URP)**
4. Nommez le projet : `DOTS_Atelier_Base`
5. Cliquez **Create**

---

# 2. Installer DOTS dans le projet

## 2.1 Activer les packages nécessaires

Ouvrez le **Package Manager** :  
→ *Window → Package Manager*

Activez **"Show preview packages"** si nécessaire.

Installez les packages suivants :

- **Entities**
- **Entities Graphics**
- **Collections**
- **Burst**
- **Mathematics**

Une fois installé :

- Burst doit être **Enable Burst Compilation**
- et **Enable Safety Checks** (pour débuter)

---

# 3. Exemple simple en POO (Unity classique)

On commence par ce que vous connaissez :

```csharp
using UnityEngine;

public class MovePOO : MonoBehaviour
{
    public float speed = 1f;

    void Update()
    {
        transform.position += Vector3.forward * speed * Time.deltaTime;
    }
}
```

**Caractéristiques :**

- attaché à un GameObject
- exécute Update() pour chaque objet
- simple à comprendre
- mais peu performant si on a 10 000 objets

Nous allons maintenant faire exactement la même chose, mais en DOTS.

---

## 4. Version DOTS — Exemple minimal

**Objectif :** Déplacer des entités en avant, comme dans `MovePOO`, mais en utilisant **ECS + Jobs + Burst**.

Cela permet de comprendre la structure réelle de DOTS.

### 4.1 Créer un composant DOTS (data only)

Dans `Scripts/` créez un fichier `MoveSpeed.cs` :

```csharp
using Unity.Entities;

public struct MoveSpeed : IComponentData
{
    public float Value;
}
```

Caractéristiques :

- `struct`
- aucune référence objet
- représente une donnée pure

### 4.2 Convertir un GameObject en entité

Unity propose un système automatique : **Baker**.

Créez un script `MoveAuthoring.cs` :

```csharp
using Unity.Entities;
using UnityEngine;

public class MoveAuthoring : MonoBehaviour
{
    public float speed = 1f;

    class Baker : Baker<MoveAuthoring>
    {
        public override void Bake(MoveAuthoring authoring)
        {
            var entity = GetEntity(TransformUsageFlags.Dynamic);
            AddComponent(entity, new MoveSpeed { Value = authoring.speed });
        }
    }
}
```

L’idée :

- vous placez un GameObject dans la scène
- il est converti automatiquement en entité à l’exécution
- il reçoit le composant `MoveSpeed`

### 4.3 Créer un système DOTS (logic only)

Créez le fichier `MoveSystem.cs` :

```csharp
using Unity.Burst;
using Unity.Entities;
using Unity.Mathematics;
using Unity.Transforms;

[BurstCompile]
public partial struct MoveSystem : ISystem
{
    public void OnUpdate(ref SystemState state)
    {
        float dt = SystemAPI.Time.DeltaTime;

        foreach (var (speed, transform) in 
            SystemAPI.Query<RefRO<MoveSpeed>, RefRW<LocalTransform>>())
        {
            transform.ValueRW.Position += math.forward() * speed.ValueRO.Value * dt;
        }
    }
}
```

Ce système :

- trouve toutes les entités ayant `LocalTransform` et `MoveSpeed`
- calcule le déplacement
- applique le mouvement en job Burst (optimisé)

## 5. Résultat : vous avez une version fonctionnelle de DOTS

Vous pouvez maintenant :

- Créer un cube
- Lui ajouter le script `MoveAuthoring`
- Lancer le jeu

Résultat attendu :

- le cube est converti en entité
- DOTS prend le contrôle
- le cube bouge comme avec le script POO

## 8. Mini-exercice

1. Dupliquez 1000 cubes dans la scène.
2. Comparez les deux versions :

   - `MovePOO` (MonoBehaviour)
   - `MoveSystem` (DOTS)

3. Regarder votre écran, si ca ne lag pas, dupliquer en plus

Résultat attendu :

- DOTS : tourne fluide
- POO : commence à ralentir dès ~200–500 objets selon la machine

## 9. Comprendre la philosophie DOTS

POO = organiser par objets.

→ simple, intuitif, mais pas optimal pour les CPU modernes.

DOTS = organiser par données.

→ plus de performance, architecture plus claire, mais demande un changement de mentalité.

En industrie, DOTS est utilisé pour :

- jeux massifs
- simulation
- IA de foule
- systèmes de particules personnalisés
- jeux mobiles exigeants
- outils internes hautes performances

## 10. Fin

Cette atelier n'a pas de corriger, mais est la pour vous montrer la différence que ceci peut faire dans l'optimisation du code de haut niveaux.