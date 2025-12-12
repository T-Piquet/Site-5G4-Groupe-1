+++
title = "Notes de cours"
weight = 2
+++

## 0. Objectif du cours

Ces notes ont pour objectif d’expliquer le protocole d’échange de clés Diffie–Hellman (DH). À la fin, vous serez capables de :

- comprendre le problème que DH résout (distribution de clés) ;
- maîtriser les principes mathématiques minimaux (arithmétique modulaire, logarithme discret) ;
- connaître le protocole pas à pas, ses variantes et ses faiblesses ;
- Identifier les usages réels de Diffie–Hellman (TLS 1.3, VPN, SSH, Wi‑Fi, messageries chiffrées) ;
- Connaître les principales faiblesses du protocole

### 0.1 Rappel : pourquoi a-t-on besoin d’une clé symétrique

Avant d’expliquer comment créer une clé partagée, il faut rappeler pourquoi cette clé est indispensable.

Le chiffrement symétrique (AES, ChaCha20, etc.) :

- permet de chiffrer rapidement de grands volumes de données ;
- utilise une seule clé secrète partagée entre les deux parties ;
- est utilisé partout : SSL/TLS, VPN, disques chiffrés, messageries, stockage sécurisé.

Mais il pose un problème majeur : les deux parties doivent déjà posséder cette clé avant de communiquer.

Sur Internet, où les communications passent par des serveurs, routeurs, points d’accès Wi-Fi souvent non fiables, comment transmettre cette clé sans qu’un attaquant puisse l’intercepter ?

C’est précisément ce défi qu’adresse Diffie–Hellman.

### 0.2 Création du protocole : créateur, année et contexte

**Créateurs officiels :**

- Whitfield Diffie (chercheur en cryptographie)
- Martin Hellman (professeur à Stanford)
- Travaux influencés par Ralph Merkle, pionnier des méthodes de distribution de clés.

**Année d’invention :**

- 1976, publication du papier fondateur :
  _“New Directions in Cryptography”_

**Contexte du problème à résoudre :**

Avant les années 1970, toute communication chiffrée utilisait des clés partagées à l’avance.  
La distribution de clés reposait sur :

- des messagers de confiance ;
- des échanges physiques ;
- des valises diplomatiques.

Avec l’arrivée des réseaux informatiques, cette méthode devient impossible à grande échelle.  
La question était alors :

> Comment deux personnes peuvent-elles créer une clé secrète sans se connaître et sans se rencontrer ?

**Idée révolutionnaire :**

- utiliser une opération mathématique très facile dans un sens (exponentiation modulaire),
  mais extrêmement difficile à inverser (logarithme discret) ;
- permettre à deux participants de calculer séparément le même secret
  **sans jamais l’envoyer sur le réseau**.

## 1. Rappels mathématiques indispensables

L’objectif ici n’est pas de faire un cours complet de théorie des nombres, mais de donner juste assez d’outils pour comprendre pourquoi Diffie–Hellman fonctionne, et sur quoi repose sa sécurité.

### 1.1 Arithmétique modulaire

En arithmétique modulaire, on travaille avec des **restes**.

On prend un nombre `p`, et on dit qu’on travaille **modulo `p`**.  
Cela veut dire que :

- dès qu’un résultat dépasse `p`, on le ramène dans l’intervalle `0 … p-1`.

Exemples très simples :

- `17 mod 5 = 2` → parce que 17 laisse un reste 2 quand on le divise par 5.
- `24 mod 7 = 3`
- `(7 + 11) mod 10 = 18 mod 10 = 8`

On peut aussi l’écrire avec la notation :

- `a ≡ b (mod p)` si `a` et `b` ont le même reste dans la division par `p`  
  (par exemple `17 ≡ 2 (mod 5)`).

Ce système a une utilité énorme :

on peut manipuler des nombres gigantesques, mais les résultats restent toujours entre `0` et `p-1`.


**Deux propriétés importantes :**

- les sommes et produits « se comportent bien » modulo `p` ;
- si `p` est **premier**, alors tout nombre `x` entre `1` et `p-1` a un **inverse** modulo `p`  
  (il existe un `y` tel que `x·y ≡ 1 (mod p)`).

On note souvent l’ensemble des restes possibles modulo `p` :

- `{0, 1, 2, …, p-1}`.

### 1.2 Les puissances mod p : l’idée clé

Dans Diffie–Hellman, on manipule constamment des expressions de la forme :

- `g^a mod p`
- `g^b mod p`

où :

- `p` est un grand nombre premier,
- `g` est une base publique (un générateur) comprise entre `2` et `p-1`,
- `a` et `b` sont des secrets entiers (les exposants).

Calculer `g^a mod p` (en multipliant `g` par lui-même `a` fois) serait beaucoup trop lent pour de grands exposants.  
On utilise donc des algorithmes rapides, par exemple :

- **l’exponentiation rapide** (exponentiation binaire) ;
- ou tout simplement la fonction `pow(g, a, p)` en Python, qui implémente déjà ces optimisations.

Un point important :

Même si `a` est immense (par exemple 2048 bits), on sait calculer rapidement `g^a mod p`.

Mais surtout :

Connaître `g^a mod p` **ne permet pas** d’en déduire facilement `a`.

Et c’est là que le protocole devient très puissant.

### 1.3 Pourquoi `g^a mod p` est difficile à inverser ?

#### Le logarithme discret

Le problème mathématique central de Diffie–Hellman est le :

**logarithme discret**

Idée :

- On connaît `g`, `p` et `A = g^a mod p`.
- On voudrait retrouver `a`.

Ce problème est extrêmement difficile pour des grands `p`.

C’est l’équivalent du logarithme classique, mais dans le monde modulo `p`.  
Et dans ce monde-là, les outils habituels (logarithmes, dérivées, équations) ne fonctionnent plus.

#### Petit exemple concret (avec petits nombres)

Supposons :

- `p = 23`
- `g = 5`
- `A = 8`

On cherche `a` tel que :

- `5^a mod 23 = 8`

Pour trouver `a`, la seule méthode simple est de tester toutes les puissances :

- `5^1 mod 23 = 5`
- `5^2 mod 23 = 2`
- `5^3 mod 23 = 10`
- …
- `5^6 mod 23 = 8` → trouvé, `a = 6`

Avec de **petits nombres**, c’est faisable à la main ou avec un petit programme.

Mais avec de vrais paramètres cryptographiques (par exemple `p` de 2048 bits) :

- il y a des centaines de chiffres ;
- l’espace des possibles pour `a` est gigantesque ;
- tester toutes les valeurs prendrait un temps **astronomique**.

Même avec tous les ordinateurs de la planète, on estime qu’il faudrait des **millions d’années** pour parcourir tout l’espace des secrets.

C’est précisément cette difficulté (le logarithme discret) qui rend Diffie–Hellman **pratiquement incassable** si les paramètres sont bien choisis.

---

## 2. Le protocole Diffie–Hellman de base

Nous pouvons maintenant décrire le protocole dans sa version la plus simple, avec deux participants : Alice et Bob.

### 2.1 Choix des paramètres publics

Alice et Bob commencent par se mettre d’accord sur deux paramètres **publics** :

- un nombre premier `p` (grand en pratique, par exemple 2048 bits) ;
- une base `g` telle que `1 < g < p`, choisie convenablement dans le groupe.

Ces paramètres peuvent être envoyés en clair, ou même fixés dans une norme. Ils ne sont pas secrets.

### 2.2 Le déroulement pas à pas

1. **Choix des secrets :**

   - Alice choisit un secret `a` (nombre entier aléatoire entre `1` et `p-1`) ;
   - Bob choisit un secret `b` (nombre entier aléatoire entre `1` et `p-1`).

2. **Calcul des clés publiques :**

   - Alice calcule `A = g^a mod p` et l’envoie à Bob ;
   - Bob calcule `B = g^b mod p` et l’envoie à Alice.

   `A` et `B` sont des **valeurs publiques** : elles peuvent transiter sur le réseau, être observées par un attaquant, ce n’est pas grave.

3. **Calcul de la clé partagée :**

   - Alice reçoit `B` et calcule `K_A = B^a mod p` ;
   - Bob reçoit `A` et calcule `K_B = A^b mod p`.

   On montre alors que :

   - `K_A = B^a mod p = (g^b)^a mod p = g^{ab} mod p` ;
   - `K_B = A^b mod p = (g^a)^b mod p = g^{ab} mod p` ;

   donc `K_A = K_B = K`.

Les deux parties ont maintenant une **même valeur secrète** `K = g^{ab} mod p`, sans l’avoir jamais envoyée telle quelle sur le réseau.

### 2.3 Ce que voit un attaquant

Un attaquant placé sur le réseau peut voir :

- les paramètres publics `p` et `g` ;
- les valeurs `A = g^a mod p` et `B = g^b mod p` échangées entre Alice et Bob.

Mais il ne voit pas :

- les exposants secrets `a` et `b` ;
- ni directement la valeur `K = g^{ab} mod p`.

Pour retrouver `a` à partir de `A`, l’attaquant devrait résoudre :

> trouver `a` tel que `A = g^a mod p` == Difficile voir impossible

---

## 3. Sécurité et logarithme discret

### 3.1 Le problème du logarithme discret

Le problème du logarithme discret peut se formuler ainsi :

> Étant donné `p`, `g` et `A = g^a mod p`, retrouver `a`.

- Calculer `A = g^a mod p` est facile (exponentiation rapide).
- L’opération inverse, retrouver `a` à partir de `A`, est **très difficile** quand `p` est grand.

Il existe des algorithmes connus pour attaquer ce problème :

- **brute‑force** : tester toutes les valeurs possibles de `a` jusqu’à trouver celle qui vérifie `g^a mod p = A` ;
- **baby-step giant-step** : améliore le brute‑force en utilisant de la mémoire pour stocker une partie des puissances de `g`, puis en avançant par « grands pas » ; on gagne un facteur de vitesse, mais le coût reste énorme pour de grands `p` ;
- **index calculus** : exploite des relations entre plusieurs logarithmes discrets, et les transforme en un grand système d’équations à résoudre (avec de l’algèbre linéaire) ; c’est plus efficace que brute‑force sur des grands `p`, mais ça reste très coûteux ;

Ces algorithmes montrent que le problème n’est pas « impossible » mathématiquement, mais qu’il est **trop coûteux** dès que les paramètres sont bien choisis.

En pratique, pour des tailles de paramètres recommandées (par exemple `p` de 2048 bits ou plus) :

- le temps de calcul nécessaire pour casser une seule clé est gigantesque ;
- le matériel (processeurs, mémoire, énergie) nécessaire dépasserait largement ce qui est réaliste.

C’est pour cette raison qu’on considère Diffie–Hellman sûr aujourd’hui, à condition d’utiliser des paramètres modernes (grande taille de `p`, bons groupes, clés éphémères, etc.).

### 3.2 Taille des paramètres

Pour que Diffie–Hellman soit sécurisé, il faut choisir :

- un `p` suffisamment grand (2048 bits minimum dans la plupart des standards modernes) ;
- une base `g` correcte (générateur d’un sous-groupe de grande taille).

Des tailles courantes :

- 1024 bits : considérée comme insuffisante à long terme;
- 2048 bits : encore jugée acceptable aujourd’hui ;
- 3072 bits et plus : pour une marge de sécurité plus confortable.

### 3.3 Diffie–Hellman statique vs éphémère

On distingue aussi :

- **DH statique** : les secrets `a` et `b` sont gardés longtemps, réutilisés sur plusieurs sessions.
- **DH éphémère (DHE)** : à chaque session, on choisit de nouveaux secrets `a` et `b` aléatoires.

Les protocoles modernes (comme TLS 1.3) recommandent fortement :

- l’utilisation de **clés éphémères** ;
- car cela apporte la propriété de **Perfect Forward Secrecy (PFS)** :
  - même si la clé privée d’un serveur est compromise dans le futur, les anciennes sessions restent protégées (puisque leurs secrets `a`/`b` étaient temporaires et ont été oubliés).

---

## 4. Variantes modernes et usages

### 4.1 Diffie–Hellman dans TLS / HTTPS

Lorsque vous accédez à un site en `https://`, le navigateur et le serveur web :

- négocient une suite cryptographique ;
- utilisent souvent une variante de Diffie–Hellman pour établir une clé de session.

Schéma :

1. Le client et le serveur s’accordent sur des paramètres publics (parfois fixés par la suite de chiffrement).
2. Ils effectuent un échange Diffie–Hellman.
3. La clé obtenue sert ensuite avec AES (ou un autre algorithme symétrique) pour chiffrer le reste de la session.

Le rôle de DH est donc de résoudre **le problème de la distribution de clé** dans un environnement non sûr (Internet).

### 4.2 VPN, SSH, messageries chiffrées

On retrouve Diffie–Hellmandans de nombreux contextes :

- **VPN** (IPsec, WireGuard, etc.) pour établir des tunnels chiffrés ;
- **SSH** pour établir une session encryptée entre un client et un serveur distant ;
- **messageries chiffrées** (Signal, WhatsApp, etc.) pour mettre en place des clés de session entre deux appareils.

Dans ces systèmes, DH est souvent combiné avec :

- des mécanismes d’authentification (certificats, signatures, QR codes, empreintes de clé) ;
- des protocoles plus élaborés pour obtenir des propriétés avancées comme le renouvellement fréquent des clés.

## 5. Faiblesses, attaques et bonnes pratiques

### 5.1 Attaque de l’homme du milieu (Man-in-the-Middle)

Diffie–Hellman, **tout seul**, ne garantit pas l’authenticité des participants.

Scénario :

1. Alice croit parler à Bob, Bob croit parler à Alice.
2. Un attaquant Mallory se place au milieu :
   - il ouvre une session DH avec Alice ;
   - et une autre session DH avec Bob.
3. Alice partage en réalité un secret avec Mallory (`K_AM`), Bob partage un secret avec Mallory (`K_MB`).
4. Mallory peut :
   - déchiffrer les messages d’Alice, les modifier, les rechiffrer pour Bob ;
   - et inversement.

Problème : Alice et Bob ne se rendent compte de rien – la connexion **semble** chiffrée, mais elle est en fait interceptée.

Conclusion :

- Diffie–Hellman doit **toujours** être combiné avec un mécanisme d’authentification :
  - certificats et signatures (comme dans TLS) ;
  - clés publiques connues à l’avance ;
  - vérification manuelle de l’empreinte des clés (dans certaines messageries).

### 5.2 Paramètres faibles et groupes réutilisés

La sécurité de DH dépend aussi du choix des paramètres :

- un `p` trop petit rend le brute‑force ou les attaques sur le logarithme discret réalisables ;
- un mauvais choix de `g` ou de groupe peut introduire des sous‑groupes de petite taille et des attaques spécialisées.

Dans la pratique :

- on utilise des paramètres recommandés par des normes (RFC, suites cryptographiques) ;
- on évite d’inventer soi‑même des paramètres sans expertise.

### 5.3 Importance de l’authentification et du renouvellement

Pour résumer les bonnes pratiques :

- **Authentifier** l’échange Diffie–Hellman :
  - via certificats X.509 ;
  - signatures numériques (RSA, ECDSA, EdDSA, …) ;
  - ou d’autres mécanismes (PSK, etc.).
- **Utiliser des clés éphémères** 
- **Choisir des paramètres robustes** :
  - taille de `p` suffisante ;
  - bases `g` standardisées.
- **Mettre à jour les suites cryptographiques**

---

## 6. Résumé

Diffie–Hellman répond à un problème de la cryptographie :

> Comment établir une clé symétrique partagée sur un réseau non fiable, sans l’envoyer telle quelle ?

Pour y parvenir, il s’appuie sur :

- l’arithmétique modulaire ;
- les propriétés des groupes multiplicatifs modulo `p` ;
- la difficulté du problème du logarithme discret.

Bien utilisé, et combiné avec des mécanismes d’authentification et des paramètres robustes, Diffie–Hellman reste un des piliers des protocoles sécurisés modernes (TLS, VPN, SSH, messageries chiffrées, etc.).

---

## Sources

« Qu’est-ce qu’un échange de clés Diffie-Hellman », NinjaOne IT Hub —  
https://www.ninjaone.com/fr/it-hub/endpoint-security/qu-est-ce-qu-un-echange-de-cles-diffie-hellman/
« Algorithme Diffie–Hellman : définition », Futura-Sciences —  
https://www.futura-sciences.com/tech/definitions/algorithme-diffie-hellman-18606/
Article Wikipédia « Problème de Diffie-Hellman » —  
https://fr.wikipedia.org/wiki/Probl%C3%A8me_de_Diffie-Hellman
Vidéo explicative YouTube — Diffie–Hellman Key Exchange (version 1) —  
https://www.youtube.com/watch?v=fNwVKNx7u6w&t=25s
Vidéo explicative YouTube — Diffie–Hellman Key Exchange (version 2) —  
https://www.youtube.com/watch?v=n4YnXv6dZak
