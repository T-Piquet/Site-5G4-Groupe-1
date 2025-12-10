
+++
title = "Atelier"
weight = 3
+++

# Atelier – Visualiser l’algorithme A* dans Unity

> 💾 Exemple de dépôt Git (à adapter avec votre propre lien) :  
> [Code source de l’atelier sur GitHub](https://github.com/votre-compte/atelier-a-star-unity)

---

## 1. Objectif de l’atelier

Dans cet atelier, vous allez créer une **démonstration interactive** de l’algorithme A* dans Unity.  
À la fin, vous aurez une scène où l’on peut :

- Générer une **grille de cases** ;
- Cliquer pour **ajouter/enlever des murs** ;
- Lancer l’algorithme A* pour voir :
  - les cases **ouvertes** (*open set*),
  - les cases **fermées** (*closed set*),
  - le **chemin final** ;
- Afficher sur chaque case les **coûts g, h, f**.

L’atelier est conçu pour être réalisable par un·e débutant·e en **2 à 3 heures**.

---

## 2. A* en quelques mots (théorie)

### 2.1 Idée générale

A* sert à trouver un **chemin le plus court** entre un point de départ (*Start*) et un point d’arrivée (*End*) sur une grille (ou un graphe).

Il combine :

- la logique de **Dijkstra** (on tient compte du coût déjà parcouru) ;
- et une **heuristique** (une estimation de la distance restante).

En résumé :

> **f = g + h**

- **g** : coût réel depuis le départ jusqu’à la case.
- **h** : estimation du coût restant jusqu’à l’arrivée (ici : distance de Manhattan).
- **f** : estimation du coût total du chemin passant par cette case.

A* choisit toujours la case avec le plus petit **f** à explorer en premier.

---

### 2.2 Open set et Closed set

- **Open set** : liste des cases à explorer (candidats).  
  → en vert dans la visualisation.
- **Closed set** : cases déjà explorées, qu’on ne revisite plus.  
  → en bleu / fermé.

Visuellement, on voit A* « avancer » dans la grille en ouvrant des cases et en en fermant d’autres.

---

### 2.3 Heuristique de Manhattan

Dans cette démo, on autorise uniquement des déplacements **haut / bas / gauche / droite** et non diagonale.

L’heuristique utilisée est la **distance de Manhattan** :

> `h = (|x1 - x2| + |y1 - y2|) * 10`

On multiplie par 10 seulement pour éviter les nombres à virgule.

Cette heuristique est :

- simple ;
- rapide à calculer ;
- **admissible** (elle ne surestime pas la vraie distance dans ce cas), donc A* reste optimal.

---

### 2.4 Comparaison rapide

- **BFS** : explore tout en largeur, pas de notion de coût → lent mais simple.
- **Dijkstra** : tient compte du coût exact, mais explore beaucoup → robuste, mais plus lent.
- **A\*** : combine coût exact + heuristique → souvent le meilleur compromis pour les jeux vidéo.

---

## 3. Pré-requis

- Unity installé (version **2021+** recommandée).
- Connaissances de base :
  - Créer un projet Unity.
  - Ajouter des GameObjects.
  - Ajouter un script C# à un GameObject.
- Aucune connaissance préalable en A* n’est requise : l’atelier sert justement à le **visualiser**.

---

## 4. Création du projet Unity

1. Créez un **nouveau projet Unity 3D** (template *3D Core* par exemple).
2. Renommez la scène principale, par exemple `AStarScene` ou le nom du projet.
3. Placez la **Camera** en vue de dessus :
   - Rotation : `X = 90`, `Y = 0`, `Z = 0`
   - Position : ajustez pour voir le centre de la grille (ex. `X = 0`, `Y = 10`, `Z = 0`).

---

## 5. Étape 1 – Créer le prefab `Cell`

### 5.1 Création de la case de base

1. Menu : `GameObject > 3D Object > Cube`.
2. Renommez le cube en **`Cell`**.
3. Modifiez sa **Scale** pour qu’il ressemble à une tuile :
   - `X = 0.9`
   - `Y = 0.1`
   - `Z = 0.9`
4. Vérifiez qu’il possède bien un **BoxCollider** (pour pouvoir cliquer dessus).

### 5.2 Script `Cell.cs`

Créez un script **`Cell.cs`**, attachez-le au prefab `Cell`, puis collez :

```csharp
using UnityEngine;

public class Cell : MonoBehaviour
{
    [Header("Grid coords")]
    public int x, y;
    public bool isWall = false;

    // --- A* Costs ---
    public int gCost = int.MaxValue;
    public int hCost = 0;
    public int fCost => gCost + hCost;

    private Renderer rend;

    // Texts (g, h, f)
    private TextMesh fCostText;
    private TextMesh gCostText;
    private TextMesh hCostText;

    [Header("Colors")]
    public Color baseColor   = new Color32(235, 235, 240, 255);
    public Color wallColor   = new Color32(35, 35, 40, 255);
    public Color startColor  = new Color32(0, 190, 255, 255);
    public Color endColor    = new Color32(255, 200, 0, 255);
    public Color openColor   = new Color32(130, 210, 140, 255);
    public Color closedColor = new Color32(120, 160, 230, 255);
    public Color pathColor   = new Color32(255, 245, 120, 255);
    public Color hoverColor  = new Color32(210, 225, 255, 255);

    private Color currentLogicalColor;

    void Awake()
    {
        rend = GetComponent<Renderer>();

        CreateTextObjects();
        ClearCosts();

        SetBase();
    }

    void LateUpdate()
    {
        // Les textes regardent toujours la caméra
        if (Camera.main != null)
        {
            Vector3 camDir = Camera.main.transform.forward;
            transform.rotation = Quaternion.LookRotation(camDir, Vector3.up);
        }
    }

    // --- Création des TextMeshs ---
    void CreateTextObjects()
    {
        fCostText = CreateText("fCostText",
            new Vector3(0f, 0.01f, -0.02f),
            0.14f, 95, TextAnchor.MiddleCenter);

        gCostText = CreateText("gCostText",
            new Vector3(-0.32f, -0.26f, -0.02f),
            0.11f, 85, TextAnchor.LowerLeft);

        hCostText = CreateText("hCostText",
            new Vector3(0.32f, -0.26f, -0.02f),
            0.11f, 85, TextAnchor.LowerRight);
    }

    TextMesh CreateText(string name, Vector3 localPos, float scale, int fontSize, TextAnchor anchor)
    {
        GameObject go = new GameObject(name);
        go.transform.SetParent(transform);
        go.transform.localPosition = localPos;
        go.transform.localRotation = Quaternion.identity;
        go.transform.localScale = Vector3.one * scale;

        TextMesh tm = go.AddComponent<TextMesh>();
        tm.text = "";
        tm.fontSize = fontSize;
        tm.characterSize = 0.20f;
        tm.anchor = anchor;
        tm.alignment = TextAlignment.Center;
        tm.color = Color.black;
        return tm;
    }

    // --- Mise à jour des textes ---
    public void UpdateCostTexts()
    {
        if (gCost == int.MaxValue)
        {
            fCostText.text = "";
            gCostText.text = "";
            hCostText.text = "";
            return;
        }

        fCostText.text = fCost.ToString();
        gCostText.text = gCost.ToString();
        hCostText.text = hCost.ToString();
    }

    public void ClearCosts()
    {
        gCost = int.MaxValue;
        hCost = 0;
        if (fCostText != null) fCostText.text = "";
        if (gCostText != null) gCostText.text = "";
        if (hCostText != null) hCostText.text = "";
    }

    // --- Couleurs logiques ---
    public void SetBase()
    {
        isWall = false;
        SetLogicalColor(baseColor);
    }

    public void SetWall()
    {
        isWall = true;
        SetLogicalColor(wallColor);
    }

    public void SetAsStart() => SetLogicalColor(startColor);
    public void SetAsEnd()   => SetLogicalColor(endColor);
    public void SetAsOpen()  { if (!isWall) SetLogicalColor(openColor); }
    public void SetAsClosed(){ if (!isWall) SetLogicalColor(closedColor); }
    public void SetAsPath()  { if (!isWall) SetLogicalColor(pathColor); }

    void SetLogicalColor(Color c)
    {
        currentLogicalColor = c;
        ApplyColor(c);
    }

    void ApplyColor(Color c)
    {
        if (rend != null)
            rend.material.color = c;
    }

    // --- Hover visuel ---
    void OnMouseEnter()
    {
        if (!isWall)
            ApplyColor(hoverColor);
    }

    void OnMouseExit()
    {
        ApplyColor(currentLogicalColor);
    }

    // --- Mur ON/OFF ---
    public void ToggleWall()
    {
        if (isWall)
        {
            SetBase();
        }
        else
        {
            SetWall();
        }
    }
}
````

> À la fin, faites glisser le `Cube` dans un dossier `Prefabs/` pour créer le **prefab `Cell`**.

---

## 6. Étape 2 – Générer la grille (`GridGenerator`)

Créez un GameObject vide **`GridManager`** et ajoutez-lui le script `GridGenerator.cs` :

```csharp
using UnityEngine;

public class GridGenerator : MonoBehaviour
{
    public GameObject cellPrefab;
    public int width = 10;
    public int height = 10;
    public float spacing = 1.1f;

    public Cell[,] grid;

    public Cell startCell;
    public Cell endCell;

    void Start()
    {
        grid = new Cell[width, height];

        float offsetX = -(width - 1) * spacing / 2f;
        float offsetY = -(height - 1) * spacing / 2f;

        for (int x = 0; x < width; x++)
        {
            for (int y = 0; y < height; y++)
            {
                Vector3 pos = new Vector3(
                    x * spacing + offsetX,
                    y * spacing + offsetY,
                    0
                );

                GameObject cellObj = Instantiate(cellPrefab, pos, Quaternion.identity);

                Cell c = cellObj.GetComponent<Cell>();
                if (c == null)
                {
                    Debug.LogError("Le prefab Cell n’a PAS de script Cell !");
                    continue;
                }

                c.x = x;
                c.y = y;

                grid[x, y] = c;
            }
        }

        // Start & End par défaut
        startCell = grid[0, 0];
        endCell   = grid[width - 1, height - 1];

        startCell.SetAsStart();
        endCell.SetAsEnd();
    }
}
```

Dans l’Inspector :

* Sur `GridManager` → **`Cell Prefab`** : glissez le prefab `Cell`.

> Exemple dans l’Inspector pour ajouter le composant `GridGenerator` :

![Ajouter le composant GridGenerator sur le GameObject Grid](creer-gridgenerator.png)

**Test** : lancez la scène → la grille doit apparaître, avec une case de départ et une case d’arrivée colorées.

---

## 7. Étape 3 – Cliquer pour placer des murs (`CellClickManager`)

Créez un GameObject vide **`InputManager`** et ajoutez-lui :

```csharp
using UnityEngine;

public class CellClickManager : MonoBehaviour
{
    void Update()
    {
        if (Input.GetMouseButtonDown(0))
        {
            Ray ray = Camera.main.ScreenPointToRay(Input.mousePosition);
            RaycastHit hit;

            if (Physics.Raycast(ray, out hit))
            {
                Cell cell = hit.collider.GetComponent<Cell>();
                if (cell != null)
                {
                    cell.ToggleWall();
                }
            }
        }
    }
}
```

**Test** : en mode Play, cliquez sur les cases → elles deviennent des murs (gris foncé) puis redeviennent normales au clic suivant.

---

## 8. Étape 4 – Implémenter A* (`Pathfinder`)

Ajoutez un script **`Pathfinder.cs`** (sur `GridManager` ou sur un nouvel objet `Pathfinder`) :

```csharp
using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class Pathfinder : MonoBehaviour
{
    public GridGenerator gridGenerator;
    public float stepDelay = 0.05f;

    private const int MOVE_STRAIGHT_COST = 10;

    void Update()
    {
        // Lancer A* avec la barre d'espace
        if (Input.GetKeyDown(KeyCode.Space))
        {
            RunAStarFromButton();
        }
    }

    // Appelé par un bouton ou la barre d'espace
    public void RunAStarFromButton()
    {
        StopAllCoroutines();
        StartCoroutine(RunAStarCoroutine());
    }

    // Bouton Reset optionnel
    public void ResetGrid()
    {
        Cell[,] grid = gridGenerator.grid;

        foreach (Cell c in grid)
        {
            if (c.isWall)
                c.SetWall();
            else
                c.SetBase();

            c.ClearCosts();
        }

        gridGenerator.startCell.SetAsStart();
        gridGenerator.endCell.SetAsEnd();

        Debug.Log("Grille réinitialisée !");
    }

    IEnumerator RunAStarCoroutine()
    {
        Cell start = gridGenerator.startCell;
        Cell end   = gridGenerator.endCell;
        Cell[,] grid = gridGenerator.grid;

        // Reset visuel
        foreach (Cell c in grid)
        {
            c.ClearCosts();

            if (c == start) c.SetAsStart();
            else if (c == end) c.SetAsEnd();
            else if (c.isWall) c.SetWall();
            else c.SetBase();
        }

        List<Cell> openSet = new List<Cell>();
        HashSet<Cell> closedSet = new HashSet<Cell>();
        Dictionary<Cell, Cell> cameFrom = new Dictionary<Cell, Cell>();

        foreach (Cell c in grid)
        {
            c.gCost = int.MaxValue;
            c.hCost = 0;
            c.UpdateCostTexts();
        }

        start.gCost = 0;
        start.hCost = Heuristic(start, end);
        start.UpdateCostTexts();

        openSet.Add(start);

        while (openSet.Count > 0)
        {
            // Choisir la case avec le plus petit fCost
            Cell current = openSet[0];
            foreach (Cell c in openSet)
            {
                if (c.fCost < current.fCost ||
                    (c.fCost == current.fCost && c.hCost < current.hCost))
                {
                    current = c;
                }
            }

            // Arrivé à la cible
            if (current == end)
            {
                yield return StartCoroutine(ReconstructPathCoroutine(cameFrom, current, start, end));
                yield break;
            }

            openSet.Remove(current);
            closedSet.Add(current);

            if (current != start && current != end && !current.isWall)
                current.SetAsClosed();

            foreach (Cell neighbor in GetNeighbors(current, grid))
            {
                if (neighbor.isWall || closedSet.Contains(neighbor))
                    continue;

                int moveCost   = GetDistance(current, neighbor);
                int tentativeG = current.gCost + moveCost;

                if (tentativeG < neighbor.gCost)
                {
                    cameFrom[neighbor] = current;
                    neighbor.gCost = tentativeG;
                    neighbor.hCost = Heuristic(neighbor, end);
                    neighbor.UpdateCostTexts();

                    if (!openSet.Contains(neighbor))
                    {
                        openSet.Add(neighbor);
                        if (neighbor != start && neighbor != end)
                            neighbor.SetAsOpen();
                    }
                }
            }

            yield return new WaitForSeconds(stepDelay);
        }

        Debug.Log("Aucun chemin trouvé !");
    }

    int Heuristic(Cell a, Cell b)
    {
        return GetDistance(a, b); // distance de Manhattan * 10
    }

    int GetDistance(Cell a, Cell b)
    {
        int xDistance = Mathf.Abs(a.x - b.x);
        int yDistance = Mathf.Abs(a.y - b.y);
        return (xDistance + yDistance) * MOVE_STRAIGHT_COST;
    }

    IEnumerator ReconstructPathCoroutine(Dictionary<Cell, Cell> cameFrom, Cell current, Cell start, Cell end)
    {
        List<Cell> path = new List<Cell>();
        path.Add(current);

        while (cameFrom.ContainsKey(current))
        {
            current = cameFrom[current];
            path.Add(current);
        }

        path.Reverse();

        foreach (Cell c in path)
        {
            if (c != start && c != end)
                c.SetAsPath();

            yield return new WaitForSeconds(stepDelay);
        }
    }

    List<Cell> GetNeighbors(Cell c, Cell[,] grid)
    {
        List<Cell> list = new List<Cell>();
        int w = gridGenerator.width;
        int h = gridGenerator.height;

        TryAdd(list, c.x + 1, c.y, grid, w, h);
        TryAdd(list, c.x - 1, c.y, grid, w, h);
        TryAdd(list, c.x, c.y + 1, grid, w, h);
        TryAdd(list, c.x, c.y - 1, grid, w, h);

        return list;
    }

    void TryAdd(List<Cell> list, int x, int y, Cell[,] grid, int w, int h)
    {
        if (x >= 0 && y >= 0 && x < w && y < h)
            list.Add(grid[x, y]);
    }
}
```

---

## 9. Ajouter un bouton **Start** (UI)

Pour lancer A* via l’interface :

1. Créez un bouton : `GameObject > UI > Button`.
2. Renommez-le, par exemple, **`StartButton`**.
3. Dans l’Inspector du bouton, dans la section **On Click ()** :

   * Cliquez sur **`+`**.
   * Glissez le GameObject qui possède le script `Pathfinder` dans le champ.
   * Dans le menu déroulant, choisissez :

     > `Pathfinder → RunAStarFromButton()`

> Exemple de configuration de l’événement **On Click** :

![Configurer On Click du bouton pour appeler Pathfinder.RunAStarFromButton](Bouton-Start.png)

Vous pouvez créer un deuxième bouton et lui lier la méthode `ResetGrid()` pour réinitialiser la grille.

---

## 10. Exercices pour les étudiants

1. **Modifier la taille de la grille**
   Changez `width` et `height` (par ex. 15×15) et observez l’impact sur le nombre de cases ouvertes/fermées.

2. **Changer dynamiquement Start / End**
   Bonus : via une touche (par ex. `S` pour Start, `E` pour End) + clic de souris, choisir une nouvelle case de départ ou d’arrivée.

3. **Tester une autre heuristique**
   Remplacez la fonction `Heuristic` par une distance euclidienne, testez avec et sans facteur `* 10`, puis comparez le nombre de cases explorées.

4. **Créer des labyrinthes impossibles**
   Construisez un mur qui coupe totalement la grille en deux et vérifiez le message **"Aucun chemin trouvé !"**.

5. **Améliorer l’interface**
   Ajoutez :

   * un bouton `Reset`,
   * un slider pour `stepDelay`,
   * un texte d’explication (légende des couleurs : start, end, open, closed, path, murs…).

---

## 11. Corrigé

Le corrigé complet correspond aux scripts fournis ci-dessus :

* `Cell.cs`
* `GridGenerator.cs`
* `CellClickManager.cs`
* `Pathfinder.cs`

### 🔗 Dépôt Git du corrigé 

> Voici le dépôt Git contenant le projet Unity complet ainsi que les scripts utilisés dans cet atelier :  
> **https://github.com/areejBudayr/Apathfinderunity.git**
