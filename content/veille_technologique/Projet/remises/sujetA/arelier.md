+++
title = "Atelier"
weight = 3
+++

> [!info]
> Durée estimée : 2 à 3 heures  
> Niveau : Débutant  
> Technologie : Unity (C#)

---


## Objectif du laboratoire

Dans ce laboratoire, vous allez créer un mini-jeu 2D avec Unity.  
Le joueur contrôle une moto qui roule sur une route infinie et doit éviter des barricades.

Fonctionnalités finales :
- Moto contrôlable avec le clavier (A/D)
- Route infinie (défilement en boucle)
- Barricades générées automatiquement
- Score (augmente quand une barricade est dépassée)
- Écran Game Over (interface) avec bouton Restart

---

## Prérequis

- Unity Hub installé
- Unity LTS (recommandé)
- Ordinateur Windows/macOS/Linux
- Visual Studio ou VS Code

---

## Création du projet

1. Ouvrir Unity Hub
2. New Project
3. Template : 2D
4. Nom : `MotoBarricades`
5. Créer le projet

### Réglages d’affichage recommandés
- Vue Game : ajouter/choisir **Portrait 9:16**
- Canvas (plus tard) : `Scale With Screen Size`, résolution portrait

---

## Organisation du projet

Créer ces dossiers :
- `Assets/Sprites`
- `Assets/Scripts`
- `Assets/Prefabs`

---

## Exercice 1 — Importer les sprites et préparer la scène

### Étape 1 : Importer les sprites
1. Mettre `rue.png`, `moto.png`, `barricade.png` dans `Assets/Sprites`
2. Pour chaque sprite, vérifier :
   - Texture Type : `Sprite (2D and UI)`


> [!tip]- Images
{{< tabs >}}
{{% tab title="moto.png" %}}
![alt text](/veille_technologique/projet/remises/sujeta/moto.png)
{{% /tab %}}
{{% tab title="rue.png" %}}
![alt text](/veille_technologique/projet/remises/sujeta/rue.png)
{{% /tab %}}
{{% tab title="barricade.png" %}}
![alt text](/veille_technologique/projet/remises/sujeta/barricade.png)
{{% /tab %}}
{{< /tabs >}}

---

### Étape 2 : Créer la route
1. Glisser `rue.png` dans la scène
2. Renommer : `rue_0`
3. Dupliquer (`Ctrl + D`) et renommer : `rue_1`
4. Positions :
   - `rue_0` : `(0, 0)`
   - `rue_1` : `(0, 10)`

Résultat attendu : deux routes alignées verticalement.

---

### Étape 3 : Créer la moto
1. Glisser `moto.png` dans la scène
2. Renommer : `moto`
3. Ajouter ces composants à la moto :
   - `Rigidbody2D`
     - Body Type : Dynamic
     - Gravity Scale : `0`
   - `Collider2D` (Box ou Polygon)
     - Is Trigger : activé

Résultat attendu : la moto est visible et prête pour collisions.

---

## Exercice 2 — Script `MotoMouvement.cs`

### Objectif
Déplacer la moto à gauche/droite (A/D) et empêcher qu’elle sorte de la route.

### Travail demandé
1. Créer `Assets/Scripts/MotoMouvement.cs`
2. Attacher le script à l’objet `moto`
3. Le script doit :
   - lire `Horizontal` (A/D)
   - déplacer via `Rigidbody2D.MovePosition`
   - limiter X avec `Mathf.Clamp(minX, maxX)`

Résultat attendu : la moto bouge et reste sur la route.

---

## Exercice 3 — Script `RueInfinie.cs`

### Objectif
Faire défiler la route en boucle (illusion d’infini).

### Travail demandé
1. Créer `Assets/Scripts/RueInfinie.cs`
2. Attacher le script à `rue_0` et `rue_1`
3. Le script doit :
   - descendre l’objet en continu
   - si `position.y` passe sous une limite, replacer en haut

Paramètres recommandés :
- `startPositionY = 10`
- `resetPositionY = -10`

Résultat attendu : la route ne s’arrête jamais.

---

## Exercice 4 — Créer la barricade et le prefab

### Étape 1 : Créer l’objet barricade
1. Glisser `barricade.png` dans la scène
2. Renommer : `barricade`
3. Ajouter ces composants à la barricade :
   - `Collider2D` (Box conseillé)
     - Is Trigger : activé
4. Créer le tag `Barricade` et l’assigner à l’objet `barricade`

Important : le collider est obligatoire pour détecter la collision avec la moto.

---

### Étape 2 : Créer le prefab
1. Glisser l’objet `barricade` (Hierarchy) vers `Assets/Prefabs`
2. Vérifier que l’icône du prefab est bleue
3. Supprimer l’objet `barricade` de la scène (Hierarchy)

Résultat attendu : il ne reste plus de barricade placée manuellement dans la scène.

---

## Exercice 5 — Script `Barricade.cs`

### Objectif
Faire descendre une barricade, ajouter un point quand elle est dépassée, puis la détruire.

### Travail demandé
1. Créer `Assets/Scripts/Barricade.cs`
2. Ouvrir le prefab `barricade` (ou sélectionner le prefab dans Project)
3. Attacher `Barricade.cs` au prefab (pas à une instance en scène)
4. Le script doit :
   - descendre vers le bas
   - ajouter 1 point quand `y < scoreY` (ex : -3)
   - ajouter le point une seule fois (bool)
   - détruire quand `y < destroyY` (ex : -6)
   - trouver `LogicScript` via le tag `Logic`

Résultat attendu : chaque barricade donne 1 point quand elle est dépassée.

---

## Exercice 6 — Script `BarricadeSpawner.cs`

### Objectif
Créer automatiquement des barricades à intervalles réguliers et position X aléatoire.

### Travail demandé
1. Créer un objet vide : `BarricadeSpawner`
2. Positionner au-dessus de l’écran (ex : Y = 6)
3. Créer `Assets/Scripts/BarricadeSpawner.cs`
4. Attacher le script à l’objet `BarricadeSpawner`
5. Dans l’Inspector du spawner :
   - Glisser le prefab `barricade` dans le champ `barricadePrefab`
6. Le script doit :
   - appeler `SpawnBarricade()` toutes les secondes
   - choisir X aléatoire entre `minX` et `maxX`
   - instancier le prefab avec `Instantiate(prefab, position, Quaternion.identity)`

Résultat attendu : 1 barricade apparaît toutes les 1 seconde.

---

## Exercice 7 — Interface utilisateur (UI) : Score et Game Over

### Objectif
Afficher le score à l’écran et afficher un panneau Game Over avec un bouton Restart.

### Étape 1 : Créer le Canvas
1. `GameObject > UI > Canvas`
2. Vérifier :
   - Render Mode : `Screen Space - Overlay`
3. Sur le Canvas, ajouter/ajuster `Canvas Scaler` :
   - UI Scale Mode : `Scale With Screen Size`
   - Reference Resolution : `1080 x 1920`
   - Match : `0.5`

---

### Étape 2 : Texte du score
1. Sur le Canvas : `UI > Text` (ou TextMeshPro si disponible)
2. Renommer : `ScoreText`
3. Écrire `0` comme valeur de départ
4. Placer en haut de l’écran (RectTransform)
5. Augmenter la taille de police au besoin

---

### Étape 3 : Panneau Game Over
1. Sur le Canvas : `UI > Panel`
2. Renommer : `GameOverScreen`
3. Mettre ce panel **désactivé** au départ (décocher l’objet dans la Hierarchy)
4. Dans `GameOverScreen`, ajouter :
   - un texte `Game Over`
   - un bouton `Restart`

---

### Étape 4 : Brancher le bouton
1. Sélectionner le bouton Restart
2. Dans l’Inspector : `On Click()` :
   - Ajouter un événement (`+`)
   - Glisser l’objet `Logic` (qui aura `LogicScript`) dans le slot
   - Choisir la fonction `LogicScript.restartGame()`

---

## Exercice 8 — Script `LogicScript.cs`

### Objectif
Gérer le score, afficher Game Over, et redémarrer la scène.

### Travail demandé
1. Créer un objet vide : `Logic`
2. Créer le tag `Logic` et l’assigner à l’objet `Logic`
3. Créer `Assets/Scripts/LogicScript.cs`
4. Attacher `LogicScript` à l’objet `Logic`
5. Dans l’Inspector de `LogicScript` :
   - Assigner `ScoreText` au champ `scoreText`
   - Assigner `GameOverScreen` au champ `gameOverScreen`
6. Le script doit :
   - contenir `ajouteScore()` qui met à jour le texte
   - contenir `gameOver()` qui affiche le panel et met `Time.timeScale = 0`
   - contenir `restartGame()` qui remet `Time.timeScale = 1` et recharge la scène
   - dans `Start()`, s’assurer que le panel GameOver est caché au début

---

## Exercice 9 — Script `PlayerCollision.cs`

### Objectif
Quand la moto touche une barricade, déclencher le Game Over.

### Travail demandé
1. Créer `Assets/Scripts/PlayerCollision.cs`
2. Attacher le script à `moto`
3. Le script doit :
   - récupérer `LogicScript` via le tag `Logic`
   - dans `OnTriggerEnter2D`, vérifier si l’objet touché a le tag `Barricade`
   - appeler `logic.gameOver()`

Préconditions :
- `moto` doit avoir `Rigidbody2D` + `Collider2D (Is Trigger)`
- prefab `barricade` doit avoir `Collider2D (Is Trigger)` + tag `Barricade`

---

## Résultat final attendu

- La moto se déplace à gauche/droite
- La route défile sans fin
- Des barricades apparaissent aléatoirement
- Le score augmente quand une barricade est dépassée
- En collision, le jeu s’arrête et l’écran Game Over apparaît
- Le bouton Restart redémarre la partie

---

## Corrigé 
>[!warning]- Solution
{{< tabs >}}
{{% tab title="MotoMouvement.cs" %}}
```csharp
using UnityEngine;

public class MotoMouvement : MonoBehaviour
{
    public float vitesse = 5f;
    private Rigidbody2D rb;
    private Vector2 mouvement;
    void Start()
    {
        // recupere le RigidBody
      rb = GetComponent<Rigidbody2D>();
    }


    void Update()
    {
        // donne -1 (A), 1 (D) pour gauche/droite
        float horizontal = Input.GetAxisRaw("Horizontal");

        mouvement = new Vector2(horizontal, 0);
    }

    void FixedUpdate()
    {
        rb.MovePosition(rb.position + mouvement * vitesse * Time.fixedDeltaTime);

        // pour le moto ne depasse pas l'ecran
        float minX = -2.4f;   
        float maxX = 2.4f;

        Vector3 pos = transform.position;
        pos.x = Mathf.Clamp(pos.x, minX, maxX);
        transform.position = pos;
    }
}
```
{{% /tab %}}

{{% tab title="RueInfinie.cs" %}}
```csharp
using UnityEngine;

public class RueInfinie : MonoBehaviour
{

    public float vitesse = 2f;
    public float resetPositionY;    // Position Y ou la route se reinitialise
    public float startPositionY;    // Position Y pour revenir a

  
    void Update()
    {
        // Deplacer vers le bas a chaque image
        transform.Translate(Vector3.down * vitesse * Time.deltaTime);

        // Si la rue a depasse le point de reinitialisation, remontez-la
        if (transform.position.y < resetPositionY)
        {
            Vector3 newPos = new Vector3(transform.position.x, startPositionY, transform.position.z);
            transform.position = newPos;
        }
    }
}


```
{{% /tab %}}

{{% tab title="Barricade.cs" %}}
```csharp
using UnityEngine;

public class Barricade : MonoBehaviour

{
    public float vitesse = 2f;      // meme vitesse que la rue
    public float destroyY = -6f;  // detruire l'objet pour conserver du memoire

    public float scoreY = -3f;      // position ou on augmente le score
    private bool hasScored = false; // pour eviter de compter deux fois

    public LogicScript logic;   // reference pour augmenter le score


    void Start()
    {
        // Trouve automatiquement l'objet LogicScript dans la scene
        logic = GameObject.FindGameObjectWithTag("Logic").GetComponent<LogicScript>();
    }


    void Update()
    {
        // Deplacer la barricade vers le bas
        transform.Translate(Vector3.down * vitesse * Time.deltaTime);


        // Ajouter un point quand elle passe sous scoreY (-3)
        if (!hasScored && transform.position.y < scoreY)
        {
            logic.ajouteScore();
            hasScored = true; // empeche de le refaire
        }


        // detruire quand il sort de l'ecran
        if (transform.position.y < destroyY)
        {
            Destroy(gameObject);
        }
    }
}

```
{{% /tab %}}

{{% tab title="BarricadeSpawner.cs" %}}
```csharp
using UnityEngine;

public class BarricadeSpawner : MonoBehaviour
{
    public GameObject barricadePrefab;     // le prefab de la barricade

    public float spawnInterval = 1f;     // temps entre chaque apparition d'une barricade
    public float minX = -2.4f;             // limite gauche de la route
    public float maxX = 2.4f;              // limite droite de la route
    public float spawnY = 6f;              // position Y ou les barricades apparaissent

    void Start()
    {
        // Appelle regulierement la fonction SpawnBarricade
        InvokeRepeating(nameof(SpawnBarricade), 1f, spawnInterval);
    }

    void SpawnBarricade()
    {
        // Choisir une position X aleatoire entre minX et maxX
        float x = Random.Range(minX, maxX);

        // Position finale ou la barricade sera creee
        Vector3 pos = new Vector3(x, spawnY, 0f);

        // Creer la barricade dans la scene
        Instantiate(barricadePrefab, pos, Quaternion.identity);
    }
}

```
{{% /tab %}}


{{% tab title="LogicScripts.cs" %}}
```csharp
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class LogicScript : MonoBehaviour
{
    // score
    public int score;
    // text de score
    public Text scoreText;

    // reference vers l'ecran de Game Over (le Panel)
    public GameObject gameOverScreen;

    // pour tester cette fonction a partir de unity 
    [ContextMenu("Augmenter le score")]
    // public pour l'utiliser dans des autres scripts
    public void ajouteScore()
    {
        score = score + 1;
        scoreText.text = score.ToString();
    }

    // fonction appelee quand le joueur perd
    public void gameOver()
    {
        // afficher l'ecran de Game Over
        gameOverScreen.SetActive(true);

        // mettre le temps du jeu en pause
        Time.timeScale = 0f;
    }

    // appelee par le bouton "Start / Restart"
    public void restartGame()
    {
        // remettre le temps a la normale
        Time.timeScale = 1f;

        // recharger la scene actuelle
        SceneManager.LoadScene(SceneManager.GetActiveScene().name);
    }

}
```
{{% /tab %}}

{{% tab title="PlayerCollision.cs" %}}
```csharp
using UnityEngine;

public class PlayerCollision : MonoBehaviour
{
    private LogicScript logic;

    void Start()
    {
        // trouver le LogicScript grace au tag "Logic"
        logic = GameObject.FindGameObjectWithTag("Logic").GetComponent<LogicScript>();
    }

    void OnTriggerEnter2D(Collider2D other)
    {
        // Si on touche une barricade
        if (other.CompareTag("Barricade"))
        {
            logic.gameOver();
        }
    }
}

```
{{% /tab %}}

{{< /tabs >}}

repo git: https://github.com/FaridSani300/JeuMoto.git