+++
title = "Veille technologique"
weight = 1
+++

## Introduction

Cette veille technologique porte sur le protocole Diffie-Hellman, une méthode essentielle en cryptographie moderne permettant à deux machines d'établir une clé secrète sur un réseau non sécurisé.

## 1. Premier prompt envoyé au LLM

**Prompt initial**

> « Explique-moi simplement le protocole Diffie-Hellman et pourquoi il est important aujourd'hui. »

**Réponse du LLM (ChatGPT - GPT-5.1, 2025)**

> Le protocole Diffie-Hellman est une méthode qui permet à deux personnes ou deux ordinateurs de créer un secret commun, même s'ils communiquent sur un réseau non sécurisé.  
> Chaque partie choisit un nombre secret, effectue un calcul à partir d'un nombre public, puis envoie le résultat à l'autre. Grâce à certaines propriétés mathématiques, les deux côtés peuvent ensuite calculer **la même clé secrète**, sans jamais l'envoyer directement.  
> Cette méthode repose sur le « logarithme discret », un problème mathématique extrêmement difficile à résoudre, ce qui rend le protocole sûr.  
> Diffie-Hellman est essentiel aujourd'hui : il est utilisé dans HTTPS, TLS, VPN, SSH, Signal, WhatsApp et Wi-Fi pour établir des clés secrètes qui protègent la confidentialité des communications.

**Réponse de Gemini (2025)**

> Le protocole Diffie-Hellman (DH) est une méthode cryptographique fondamentale qui consiste à permettre à deux parties (Alice et Bob) qui n'ont jamais communiqué de manière sécurisée de s'entendre sur un secret partagé (une clé secrète) via un canal de communication entièrement public et non sécurisé.  
> **Résumé simple** — Type de protocole : échange de clés cryptographiques. Objectif : créer une clé de chiffrement symétrique commune (le secret partagé K). Sécurité : l'échange est conçu pour qu'un observateur externe (Eve) qui intercepte toutes les communications ne puisse pas déduire la clé finale.  
> **Rôle du protocole** — DH sert uniquement à l'établissement de la clé. Une fois la clé secrète partagée (K) établie entre Alice et Bob, ils peuvent l'utiliser pour chiffrer et déchiffrer leurs messages suivants à l'aide d'un algorithme symétrique (comme AES), garantissant ainsi la confidentialité de leur communication. En substance, il résout le problème historique de la distribution de clés en permettant aux parties de construire la clé ensemble plutôt que de la transmettre.
