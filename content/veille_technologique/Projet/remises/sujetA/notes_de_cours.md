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

### 0.1 Rappel rapide sur AES (chiffrement symétrique)

Avant de parler de distribution de clés, rappelons l’outil qui consomme ces clés partagées : le chiffrement symétrique.

- **But** : chiffrer/déchiffrer rapidement de grands volumes de données avec une clé unique partagée.
- **Algorithme** : AES (Advanced Encryption Standard) travaille sur des blocs de 128 bits en enchaînant des tours de substitutions et permutations
- **Tailles de clé** : 128, 192 ou 256 bits (AES‑128, AES‑192, AES‑256). Plus la clé est longue, plus elle résiste à la force brute.

**Exemple Chiffrement**  
Clé : `00112233445566778899aabbccddeeff` (128 bits)  
IV : `0f1e2d3c4b5a6978b6a5c4d2` (96 bits)  
Message : `Bonjour AES !`

```python
from cryptography.hazmat.primitives.ciphers.aead import AESGCM

key = bytes.fromhex("00112233445566778899aabbccddeeff")  # clé AES-128 (128 bits)
iv = bytes.fromhex("0f1e2d3c4b5a6978b6a5c4d2")  # valeur initiale aléatoire qui sert à “démarrer” le chiffrement
msg = b"Bonjour AES !"  # message en clair à chiffrer

aes = AESGCM(key)
cipher = aes.encrypt(iv, msg, None)  # chiffre + ajoute une étiquette d'intégrité
plain = aes.decrypt(iv, cipher, None)

print("Chiffré (hex) :", cipher.hex())
print("Déchiffré     :", plain.decode())
```

## 1. Pourquoi un échange de clés ?

### 1.1 Le problème de la distribution de clés

Le chiffrement symétrique (AES, ChaCha20) est rapide et sûr, mais il faut que les deux parties partagent la même clé secrète avant toute communication. Sur un réseau non sécurisé, comment établir cette clé sans qu’un attaquant puisse l’intercepter ? Historiquement, on utilisait des canaux physiques ou des tiers de confiance : peu pratique et impossible à l’échelle d’Internet.

### 1.2 Idée générale de Diffie–Hellman

Diffie–Hellman (1976) permet à deux parties qui ne se connaissent pas de construire ensemble un secret partagé **sans jamais transmettre la clé**. La sécurité repose sur la difficulté du **logarithme discret** dans un groupe choisi. Un observateur voit tous les échanges publics, mais ne peut pas en déduire la clé finale si les paramètres sont robustes.

### 1.3 DH ne chiffre pas

DH ne chiffre pas directement les données. Il produit une clé symétrique partagée (appelée souvent`K`). Cette clé est ensuite utilisée avec un algorithme de chiffrement symétrique et un autre mode d’authentification (ex. AES‑GCM) pour protéger confidentialité et intégrité.
