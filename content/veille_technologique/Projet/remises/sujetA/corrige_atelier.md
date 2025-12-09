+++
title = "Corrigé atelier Diffie-Hellman"
weight = 4
+++

Ce fichier propose un exemple complet de script `calculatrice_dh.py` qui répond aux étapes de l’atelier :

- test de primalité (`est_premier`) ;
- calcul de puissances modulo `p` (`puissance_mod`) ;
- calcul des clés publiques et de la clé partagée (`cle_publique`, `cle_partagee`) ;
- fonction interactive `calculatrice_dh()` ;
- mode attaquant optionnel (`brute_force_secret`, `mode_attaquant`).

Tu peux copier ce code dans un fichier `calculatrice_dh.py` et l’exécuter avec :

```bash
python calculatrice_dh.py
```

---

## Script complet `calculatrice_dh.py`

```python
def est_premier(n: int) -> bool:
    """Retourne True si n est un nombre premier, False sinon."""
    if n < 2:
        return False
    d = 2
    while d * d <= n:
        if n % d == 0:
            return False
        d += 1
    return True


def puissance_mod(a: int, e: int, p: int) -> int:
    """Calcule a**e mod p (a puissance e modulo p)."""
    # On utilise la fonction built-in pow avec 3 arguments
    return pow(a, e, p)


def cle_publique(p: int, g: int, secret: int) -> int:
    """Calcule la clé publique : g^secret mod p."""
    return puissance_mod(g, secret, p)


def cle_partagee(p: int, cle_autre: int, secret: int) -> int:
    """Calcule la clé partagée : cle_autre^secret mod p."""
    return puissance_mod(cle_autre, secret, p)


def brute_force_secret(p: int, g: int, A: int) -> int | None:
    """Tente de retrouver un secret a tel que g^a mod p = A."""
    # On essaie toutes les valeurs possibles pour le secret a
    # x vaudra 1, 2, 3, ..., p-1
    for x in range(1, p):
        # On calcule g^x mod p et on compare au A observé
        if puissance_mod(g, x, p) == A:
            # Si ça correspond, on a trouvé un candidat pour le secret a
            return x
    # Si aucune valeur ne convient, on renvoie None
    return None


def mode_attaquant(p: int, g: int, A: int, B: int) -> None:
    """Mode attaquant : essaie de retrouver a et b à partir de A et B."""
    print("\n=== Mode attaquant (brute-force) ===")

    secret_a = brute_force_secret(p, g, A)
    secret_b = brute_force_secret(p, g, B)

    if secret_a is None and secret_b is None:
        print("Impossible de retrouver les secrets : p est trop grand ou aucune valeur ne convient.")
        return

    if secret_a is not None:
        print(f"Secret d'Alice retrouvé par brute-force : a = {secret_a}")
    else:
        print("Secret d'Alice (a) non retrouvé.")

    if secret_b is not None:
        print(f"Secret de Bob retrouvé par brute-force : b = {secret_b}")
    else:
        print("Secret de Bob (b) non retrouvé.")



def calculatrice_dh() -> None:
    print("=== Calculatrice Diffie-Hellman ===")

    # 1) Saisir p et vérifier qu'il est premier
    while True:
        try:
            p = int(input("Choisir un nombre premier p : "))
        except ValueError:
            print("Merci d'entrer un entier.")
            continue

        if est_premier(p):
            break
        print("Ce n'est pas un nombre premier, réessaie.")

    # 2) Saisir g et vérifier 1 < g < p
    while True:
        try:
            g = int(input(f"Choisir une base g (entre 2 et {p-1}) : "))
        except ValueError:
            print("Merci d'entrer un entier.")
            continue

        if 1 < g < p:
            break
        print("g doit vérifier 1 < g < p.")

    # 3) Saisir les secrets a et b
    while True:
        try:
            a = int(input("Secret d'Alice a (entre 1 et p-1) : "))
            b = int(input("Secret de Bob   b (entre 1 et p-1) : "))
        except ValueError:
            print("Merci d'entrer des entiers.")
            continue

        if 1 <= a < p and 1 <= b < p:
            break
        print("a et b doivent vérifier 1 <= a,b < p.")

    # 4) Calculer les clés publiques
    A = cle_publique(p, g, a)
    B = cle_publique(p, g, b)

    # 5) Calculer la clé partagée des deux côtés
    K_A = cle_partagee(p, B, a)
    K_B = cle_partagee(p, A, b)

    print("\n--- Résultats ---")
    print(f"p = {p}, g = {g}")
    print(f"A (clé publique d'Alice) = {A}")
    print(f"B (clé publique de Bob)   = {B}")
    print(f"Clé calculée par Alice K_A = {K_A}")
    print(f"Clé calculée par Bob   K_B = {K_B}")

    if K_A == K_B:
        print("\nOK : les deux clés sont identiques !")
    else:
        print("\nAttention : les clés ne sont pas identiques.")

    # 6) Option : lancer le mode attaquant
    choix = input(
        "\nLancer le mode attaquant pour essayer de retrouver a à partir de A ? (o/n) : "
    ).strip().lower()
    if choix == "o":
        mode_attaquant(p, g, A, B)


if __name__ == "__main__":
    calculatrice_dh()
```


