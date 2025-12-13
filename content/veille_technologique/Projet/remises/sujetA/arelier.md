+++
title = "Atelier : construire une calculatrice Diffie-Hellman"
weight = 3
+++

L’objectif de cet atelier est de **programmer pas à pas une petite calculatrice Diffie-Hellman en Python**.


## 1. Préparation rapide

Tu peux travailler directement sur ta machine avec Python, ou utiliser Docker.

### 1.1. Option Docker

Dans un dossier de travail (par exemple `atelier-dh`), crée un fichier `Dockerfile` :

```dockerfile
FROM python:3.11-slim
WORKDIR /app
RUN useradd -m student
USER student
COPY . /app
CMD ["bash"]
```

Puis, dans ce dossier :

- construire l’image :  
  `docker build -t atelier-dh .`
- lancer un terminal dans le conteneur (PowerShell) :  
  `docker run -it --rm -v ${PWD}:/app atelier-dh`

Dans le conteneur, tu seras dans `/app`.  
Tu créeras le fichier `calculatrice_dh.py` dans ce dossier, et tu le lanceras avec :

```bash
python calculatrice_dh.py
```

---

## 2. Vue d’ensemble de l’atelier

Tout l’atelier se fait dans **un seul fichier** : `calculatrice_dh.py`.

Tu vas successivement :

1. Créer une fonction `est_premier(n)` pour tester si un nombre est premier.
2. Créer une fonction `puissance_mod(a, e, p)` pour calculer `a^e mod p`.
3. Créer des fonctions `cle_publique(p, g, secret)` et `cle_partagee(p, cle_autre, secret)`.
4. Créer une fonction `calculatrice_dh()` qui :
   - demande `p`, `g`, `a`, `b` à l’utilisateur ;
   - vérifie que `p` est premier et que `1 < g < p` ;
   - calcule `A`, `B` et `K` ;
   - affiche le tout de manière lisible.
5. Ajouter un petit “mode attaquant” qui essaie de retrouver `a` par brute-force.

Chaque étape est un **petit exercice** où tu ajoutes une fonction dans `calculatrice_dh.py`.

---

## Etape 1 : `fonction est_premier`

Dans Diffie-Hellman, on choisit un nombre p et on fait tous les calculs "modulo p" (par exemple g^a mod p).
Pour que les proprietes mathematiques soient correctes et eviter des faiblesses, p est presque toujours un **nombre premier**.

Dans notre calculatrice, on voudra :

- demander un p a l'utilisateur ;
- refuser les valeurs de p qui ne sont pas premieres (et lui redemander un autre p).

Pour cela, on a besoin d'une fonction reutilisable est_premier(n) qui dit simplement :
"ce nombre n est-il premier, oui ou non ?".

Dans calculatrice_dh.py, crée la fonction suivante et complète la fonction :

```python
def est_premier(n: int) -> bool:
    """Retourne True si n est un nombre premier, False sinon."""
    # A TOI DE JOUER :
    # retourne True si n est premier, False sinon
    ...
```

Ensuite, ajoute quelques tests simples en bas du fichier, par exemple :

```python
print("2 est premier ?", est_premier(2))
print("15 est premier ?", est_premier(15))
print("23 est premier ?", est_premier(23))
```

> **Résultats attendus :**
> `2 est premier ? True` - 
> `15 est premier ? False` - 
> `23 est premier ? True`

Lance ```python calculatrice_dh.py``` pour verifier que tout marche et que tu comprends les resultats.

Quand les résultats sont bons et conformes, tu pourras retirer ces prints afin de ne pas les avoir dans le terminal tout au long de l'atelier.


## Etape 2 : fonction `puissance_mod`

Le principe même du protocole vient du fait qu’on travaille constamment avec des puissances modulo p, par exemple g^a mod p ou g^b mod p. Comme ce calcul revient à de nombreuses étapes du protocole, il est préférable d’écrire une fonction réutilisable, puissance_mod(a, e, p), plutôt que de recopier la même opération plusieurs fois dans le programme.

**But :** ecrire une fonction qui calcule `a^e mod p` proprement.

Dans `calculatrice_dh.py`, ajoute le squelette suivant et complete-le toi-meme :

```python
def puissance_mod(a: int, e: int, p: int) -> int:
    """Calcule a**e mod p (a puissance e modulo p)."""
    # A TOI DE JOUER :
    # indice : tu peux utiliser la fonction integrée pow(a, e, p)
    ...

```

Teste-la avec quelques valeurs :

```python
print("2^10 mod 13 =", puissance_mod(2, 10, 13))  # doit donner 10
print("5^6 mod 23  =", puissance_mod(5, 6, 23))   # doit donner 8
```

Quand les résultats sont bons et conformes, tu pourras retirer ces prints afin de ne pas les avoir dans le terminal tout au long de l'atelier.

---

## Etape 3 : fonctions Diffie-Hellman (`cle_publique`, `cle_partagee`)

Dans Diffie-Hellman :

- chaque personne (Alice, Bob) a un **secret** (`a` ou `b`) ;
- elle calcule une **clé publique** à partir de ce secret :
  - `cle_publique = g^secret mod p` ;
- en échangeant leurs clés publiques, ils peuvent calculer la **même clé partagée** `K` :
  - côté Alice : `K_A = B^a mod p` ;
  - côté Bob   : `K_B = A^b mod p`.

La **clé publique** est la valeur que l'on peut envoyer sur le réseau (A ou B). 
La **clé partagée** est la valeur secrète finale (K) que les deux côtés obtiennent, sans jamais l''envoyer.

**But :** écrire des fonctions qui calculent ces valeurs importantes du protocole DH.

Ajoute dans `calculatrice_dh.py` :

```python
def cle_publique(p: int, g: int, secret: int) -> int:
    """Calcule la clé publique : g^secret mod p."""
    # A TOI DE JOUER
    ...


def cle_partagee(p: int, cle_autre: int, secret: int) -> int:
    """Calcule la clé partagée : cle_autre^secret mod p."""
    # A TOI DE JOUER
    ...
```

Teste ces fonctions avec un petit exemple classique :

- `p = 23`, `g = 5`, `a = 6`, `b = 15`.

Par exemple :

```python
p, g = 23, 5
a, b = 6, 15
A = cle_publique(p, g, a)
B = cle_publique(p, g, b)
K_A = cle_partagee(p, B, a)
K_B = cle_partagee(p, A, b)
print("A =", A, "B =", B)
print("K_A =", K_A, "K_B =", K_B)
```

Résultats attendus :

- `A = 8`, `B = 19` ;
- `K_A = 2` et `K_B = 2`.

## Étape 4 : faire une vraie calculatrice interactive

**But :** regrouper toutes les fonctions dans une fonction `calculatrice_dh()` qui guide l’utilisateur.

Remplace tes tests isolés par une fonction :

```python
def calculatrice_dh():
    print("=== Calculatrice Diffie-Hellman ===")

    # 1) Saisir p et vérifier qu'il est premier
       # A TOI DE JOUER :
       

    # 2) Saisir g et vérifier 1 < g < p 
        # A TOI DE JOUER :

    # 3) Demander à l'utilisateur de saisir les secrets a et b
    # A TOI DE JOUER :

    # 4) Calculer les clés publiques de A et B
    # A TOI DE JOUER :

    # 5) Calculer la clé partagée des deux côtés K_A et K_B 
    # A TOI DE JOUER :

    # Affciher les résultats dans le terminal 
    # A TOI DE JOUER :
  
```
Exemple d'affichage :

=== Calculatrice Diffie-Hellman ===

Choisissez un nombre premier p : 23

Choisissez un g tel que 1 < g < 23 : 5

Secret a (Alice) : 6
Secret b (Bob) : 15

--- Résultats ---
p = 23, g = 5
A (clé publique d'Alice) = 8
B (clé publique de Bob)   = 19
Clé calculée par Alice K_A = 2
Clé calculée par Bob   K_B = 2

OK : les deux clés sont identiques !

En bas du fichier, ajoute :

```python
if __name__ == "__main__":
    calculatrice_dh()
```

Tu as maintenant une **vraie calculatrice** : tu choisis `p`, `g`, `a`, `b`, et tu vois les clés.

---

## Étape 5  : mode attaquant

**But :** montrer qu'avec des petits nombres, on peut retrouver le secret `a` par brute-force.

Quand le nombre premier `p` est **petit**, un attaquant peut retrouver le secret `a`
en testant **toutes les valeurs possibles** de `a` jusqu"à trouver celle qui vérifie
`g^a mod p = A`. Le nombre d'essais est au plus `p-1` :
- si `p = 97`, il suffit de tester au plus 96 valeurs, ce qui est très rapide pour un ordinateur ;
- mais en cryptographie réelle, `p` est un nombre gigantesque (par exemple de 2048 bits,
  de l'ordre de `10^600`), et il faudrait alors faire environ `p` essais : c'est un nombre
tellement immense que même tous les ordinateurs de la planête ne finiraient pas le parcours
avant des milliards d'années.

C'est justement cette idée qui rend Diffie-Hellman  : pour des petits `p` de démonstration,
une attaque par brute-force est possible ; mais pour des grands `p` utilisés en pratique,
le parcours complet des secrets possibles devient **pratiquement impossible**.

On va donc programmer une fonction qui simule ce comportement d'attaquant : elle essaye
successivement toutes les valeurs possibles pour le secret `a` et regarde si cela
reproduit la clé publique observée.

Ajoute une fonction :

```python
def brute_force_secret(p: int, g: int, A: int) -> int | None:
    """Tente de retrouver un secret a tel que g^a mod p = A."""
    # Créer une boucle qui teste/parcours toutes les valeurs possibles pour a,
    # généralement de 1 jusqu'à p-1.
    # Pour chaque valeur x, calculer g^x mod p puis comparer le résultat avec A
    # Retourner x (si trouvé) ou none pour l'absence de solution

```

Le rôle de cette fonction est donc de simuler un attaquant qui :
- connaît `p`, `g` et la clé publique `A` (observée sur le réseau) ;
- teste toutes les valeurs possibles de `a` en calculant `g^a mod p` ;
- renvoie la première valeur de `a` qui redonne exactement `A` ;
- renvoie `None` si aucune valeur de `1` … `p-1` ne convient.

Avec un petit `p`, la fonction va rapidement trouver le secret ; avec un `p` réaliste de
cryptographie, la boucle `for x in range(1, p)` serait beaucoup trop longue pour filtrer.
Tu peux ensuite proposer un petit sous-menu dans `calculatrice_dh()` ou une autre fonction qui :

- prend `p`, `g`, `A` (par exemple la clé publique d’Alice) ;
- appelle `brute_force_secret` ;
- affiche le secret retrouvé si `p` est petit.

---

Pour aller un peu plus loin, tu peux intégrer ce mode attaquant directement
dans la calculatrice en deux étapes :

1. **Ajouter une fonction `mode_attaquant` dans `calculatrice_dh.py`**

   Dans `calculatrice_dh.py`, juste après la fonction `brute_force_secret`, ajoute :

   ```python
   def mode_attaquant(p: int, g: int, A: int) -> None:
       print("\n=== Mode attaquant (brute-force) ===")
       secret_trouve = brute_force_secret(p, g, A)
       if secret_trouve is None:
           print("Impossible de retrouver le secret : p est trop grand ou aucune valeur ne convient.")
       else:
           print(f"Secret retrouvé par brute-force : a = {secret_trouve}")
    ```
    Ajouter un choix de menu dans calculatrice_dh()

    Toujours dans calculatrice_dh.py, repère la fonction calculatrice_dh() et, à la fin,
    juste après :

    ```python
    if K_A == K_B:
      print("\nOK : les deux clés sont identiques !")
    else:
      print("\nAttention : les clés ne sont pas identiques.")
    ```

    ajoute :
  
    ```python
    choix = input("\nLancer le mode attaquant pour essayer de retrouver a à partir de A ? (o/n) : ").strip().lower()
    if choix == "o":
    mode_attaquant(p, g, A)
    ```

    Ainsi, à chaque exécution de calculatrice_dh(), après le calcul normal des clés,
    la calculatrice propose à l’utilisateur de lancer ou non le mode attaquant.

