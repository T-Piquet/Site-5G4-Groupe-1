+++
title = "Notes de cours"
weight = 2
+++

# Chain of Thought : Améliorer le raisonnement des modèles de langage

## Introduction

Les grands modèles de langage (LLMs) comme GPT-4, Claude ou Gemini ont révolutionné le traitement du langage naturel. Cependant, ils rencontrent des difficultés sur des tâches nécessitant un raisonnement complexe en plusieurs étapes. Le **Chain of Thought (CoT)** est une technique de prompt engineering qui améliore significativement ces capacités de raisonnement.

## Qu'est-ce que le Chain of Thought ?

### Définition

Le Chain of Thought est une méthode qui consiste à demander au modèle de décomposer explicitement son raisonnement en étapes intermédiaires avant de donner une réponse finale. Le modèle "montre son travail" comme un étudiant qui détaille sa démarche.

### Exemple simple

**Sans CoT** :
```
Q: "Un magasin a 23 pommes. Il reçoit 45 pommes le matin, 
    puis vend 18 pommes l'après-midi. Combien reste-t-il ?"
R: "Il reste 50 pommes."
```

**Avec CoT** :
```
Q: [Même question] "Résous étape par étape."
R: "Étape 1 : Début = 23 pommes
    Étape 2 : Après réception = 23 + 45 = 68 pommes
    Étape 3 : Après vente = 68 - 18 = 50 pommes
    Réponse finale : 50 pommes"
```

### Avantages

Le CoT permet de :
- Vérifier la logique du modèle
- Identifier les erreurs de raisonnement
- Augmenter la fiabilité
- Améliorer la performance sur problèmes complexes

## Pourquoi le CoT fonctionne-t-il ?

### Fondements théoriques

Les LLMs prédisent le prochain token basé sur le contexte. Pour une réponse directe à un problème complexe, ils doivent "compresser" tout le raisonnement en une seule prédiction.

Le CoT donne un "espace de calcul" supplémentaire :
1. **Décomposition** : Problèmes complexes → sous-problèmes simples
2. **Mémoire de travail** : Étapes intermédiaires servant de mémoire
3. **Activation de connaissances** : Chaque étape active des connaissances pertinentes
4. **Correction d'erreurs** : Le modèle peut se corriger en cours de route

### Résultats empiriques

Améliorations mesurées :
- **GSM8K** (maths) : +42% de précision
- **MATH benchmark** : +30% (niveau lycée)
- **BIG-Bench** : +25% moyenne sur raisonnement

Ces gains sont plus importants sur les grands modèles (>100B paramètres), suggérant que le CoT exploite des capacités latentes.

## Les variantes de CoT

### 1. Few-Shot Chain of Thought

**Principe** : Fournir des exemples de raisonnements étape par étape avant la question.

**Exemple** :
```
Exemple 1:
Q: "Marie a 3 boîtes de 12 crayons. Combien de crayons ?"
Raisonnement: 
- Marie a 3 boîtes
- Chaque boîte = 12 crayons
- Total = 3 × 12 = 36 crayons
R: 36 crayons

[Maintenant votre question]
```

**Avantages** :
- Très efficace
- Contrôle du style de raisonnement
- Intégration de connaissances spécifiques

**Inconvénients** :
- Nécessite des exemples de qualité
- Consomme plus de tokens (coût)
- Peut biaiser le raisonnement

### 2. Zero-Shot Chain of Thought

**Principe** : Ajouter simplement une instruction générique pour déclencher le raisonnement.

**Instructions courantes** :
- "Let's think step by step."
- "Réfléchissons étape par étape."
- "Explique ton raisonnement."

**Exemple** :
```
Q: "Si un train parcourt 120 km en 2h, combien de temps pour 300 km ?"
Prompt: "Let's think step by step."

R: "Étape 1 : Vitesse = 120 km / 2h = 60 km/h
    Étape 2 : Temps = 300 km / 60 km/h = 5h
    Réponse : 5 heures"
```

**Avantages** :
- Extrêmement simple
- Pas besoin d'exemples
- Économique en tokens

**Inconvénients** :
- Moins de contrôle sur le format
- Parfois moins efficace que Few-Shot
- Peut être verbeux

**Découverte** : Kojima et al. (2022) ont montré qu'une simple phrase suffit pour déclencher des capacités de raisonnement impressionnantes.

### 3. Self-Consistency

**Principe** : Générer plusieurs chaînes de pensée (ex: 5-10) et sélectionner la réponse la plus fréquente par vote majoritaire.

**Processus** :
```
1. Générer N chaînes indépendantes (N=5)
2. Extraire la réponse finale de chaque chaîne
3. Vote majoritaire → réponse finale
```

**Exemple avec 3 générations** :

Génération 1 : `15 + 27 = 42; 42 × 2 = 84` → **84**  
Génération 2 : `15 + 27 = 42; 42 × 2 = 84` → **84**  
Génération 3 : `15 + 27 = 43; 43 × 2 = 86` → **86** (erreur)

**Réponse finale** : 84 (2/3 votes)

**Avantages** :
- +10-20% de précision
- Réduit les erreurs aléatoires
- Estimation de confiance

**Inconvénients** :
- Coût ×N
- Lent pour applications temps réel

### 4. Tree of Thoughts (ToT)

**Principe** : Explorer un arbre de raisonnements. Le modèle génère plusieurs branches à chaque étape, évalue leur pertinence, et explore les plus prometteuses.

**Structure** :
```
                Problème
                   |
        ┌──────────┼──────────┐
        |          |          |
    Pensée 1   Pensée 2   Pensée 3
        |          |          |
    ┌───┼───┐  ┌───┼───┐  ┌───┼───┐
   1.1 1.2 1.3 2.1 2.2 2.3 3.1 3.2 3.3
```

**Algorithme** :
1. Générer plusieurs pensées initiales
2. Évaluer chaque pensée (score)
3. Sélectionner les K meilleures
4. Pour chaque sélection, générer des pensées suivantes
5. Répéter jusqu'à solution
6. Utiliser BFS, DFS ou beam search

**Avantages** :
- Excellent pour planification
- Peut revenir en arrière
- +20-40% sur tâches complexes

**Inconvénients** :
- Très coûteux en tokens
- Complexe à implémenter

**Cas d'usage** : Génération de code complexe, énigmes, planification stratégique.

### 5. Graph of Thoughts (GoT)

**Principe** : Extension de ToT avec connexions non linéaires. Les pensées peuvent s'agréger, se transformer ou être raffinées de manière flexible.

**Opérations** :
- **Agrégation** : Combiner plusieurs pensées
- **Raffinement** : Améliorer une pensée existante
- **Génération** : Créer de nouvelles pensées
- **Validation** : Évaluer et scorer

**Avantages** :
- Très flexible
- Fusion multi-sources
- Meilleure modélisation de la pensée humaine

**Inconvénients** :
- Encore plus coûteux
- Complexité d'implémentation élevée

## Limitations et défis

### 1. Coût computationnel

Le CoT augmente :
- **Tokens** : 2-5× plus qu'une réponse directe
- **Latence** : Temps proportionnel aux tokens
- **Coût financier** : Avec APIs payantes

**Exemple GPT-4** :
- Réponse directe : ~50 tokens → $0.0015
- CoT : ~200 tokens → $0.006
- Self-Consistency (5×) : ~1000 tokens → $0.03

### 2. Erreurs de raisonnement

Le CoT peut amplifier :
- **Hallucinations** : Faits incorrects convaincants
- **Erreurs en cascade** : Erreur étape 1 → propage aux suivantes
- **Raisonnement superficiel** : Apparence sans compréhension réelle

### 3. Verbosité excessive

Certains modèles produisent des raisonnements trop longs et répétitifs.

### 4. Dépendance à la taille du modèle

Le CoT est surtout efficace sur grands modèles (>100B paramètres). Sur petits modèles :
- Amélioration moins marquée
- Raisonnement incohérent
- Plus d'erreurs logiques

### 5. Domaines spécialisés

Sur problèmes très spécialisés (médecine, droit, sciences), le CoT peut :
- Donner une fausse impression de compétence
- Produire des raisonnements superficiels
- Manquer de connaissances factuelles critiques

## Bonnes pratiques

### Quand utiliser le CoT ?

**✅ Utiliser pour** :
- Problèmes mathématiques
- Raisonnement logique
- Planification multi-étapes
- Analyse complexe
- Debugging
- Synthèse d'informations

**❌ Ne pas utiliser pour** :
- Questions factuelles simples
- Tâches créatives libres
- Réponses rapides (latence critique)
- Budget tokens limité

### Optimiser les prompts

```python
# ✅ BON : Instructions claires
prompt = """
Résous en suivant ces étapes :
1. Identifie les données
2. Détermine l'opération
3. Effectue le calcul
4. Vérifie ta réponse

Problème : {question}
"""

# ❌ MOINS BON : Vague
prompt = "Réponds à cette question en réfléchissant."
```

### Combiner avec d'autres techniques

- **RAG** : Récupérer infos avant de raisonner
- **Fine-tuning** : Entraîner sur exemples CoT qualité
- **Validation externe** : Vérifier avec calculateur/base de données

## Applications concrètes

### 1. Éducation

Tuteurs intelligents montrant le raisonnement étape par étape, génération d'exercices avec solutions détaillées.

### 2. Développement logiciel

```python
def debug_code(code, erreur):
    prompt = f"""
Analyse ce code avec erreur : {erreur}

Code :
{code}

Analyse :
1. Identifie la ligne problématique
2. Explique l'erreur
3. Propose une correction
4. Explique pourquoi ça marche

Analyse :
"""
```

### 3. Analyse de données

Interprétation de résultats, identification de tendances, détection d'anomalies.

### 4. Service client

Diagnostiquer problèmes techniques, guider dans procédures complexes.

## L'avenir du CoT

### Tendances émergentes

1. **CoT automatique** : Modèles décidant quand l'utiliser
2. **CoT multimodal** : Raisonnement visuel + textuel
3. **CoT collaboratif** : Plusieurs modèles raisonnant ensemble
4. **CoT compressé** : Raisonnements plus courts mais efficaces
5. **CoT spécialisé** : Adapté à chaque domaine

### Modèles récents avec CoT natif

- **OpenAI o1** (2024) : CoT étendu intégré, réflexion de plusieurs minutes
- **Claude 3 Opus** : Excellent raisonnement long contexte
- **Gemini 1.5 Pro** : CoT multimodal

## Conclusion

Le Chain of Thought représente une avancée majeure pour les LLMs sur des tâches de raisonnement complexe. En donnant au modèle un "espace de réflexion", nous débloquons des capacités latentes.

**Points clés** :
1. Le CoT améliore significativement les performances
2. Plusieurs variantes existent (Few-Shot, Zero-Shot, Self-Consistency, ToT, GoT)
3. Implémentation relativement simple
4. Coût et latence sont des considérations importantes
5. Utile en éducation, développement, analyse

**Recommandations** :
- Commencer par Zero-Shot CoT
- Utiliser Self-Consistency pour décisions critiques
- Explorer ToT pour planification complexe
- Toujours vérifier la qualité du raisonnement
- Combiner avec autres techniques pour plus de fiabilité

---

## Sources

1. Wei, J., et al. (2022). "Chain-of-Thought Prompting Elicits Reasoning in Large Language Models". arXiv:2201.11903
2. Kojima, T., et al. (2022). "Large Language Models are Zero-Shot Reasoners". arXiv:2205.11916
3. Wang, X., et al. (2022). "Self-Consistency Improves Chain of Thought Reasoning". arXiv:2203.11171
4. Yao, S., et al. (2023). "Tree of Thoughts". arXiv:2305.10601
5. Besta, M., et al. (2023). "Graph of Thoughts". arXiv:2308.09687
6. Prompt Engineering Guide. https://www.promptingguide.ai/techniques/cot
7. LangChain Documentation. https://python.langchain.com/docs/concepts/chain_of_thought
8. OpenAI. (2024). "Introducing OpenAI o1". https://openai.com/index/introducing-openai-o1/
9. Papers with Code. "Chain-of-Thought Prompting". https://paperswithcode.com/method/chain-of-thought-prompting
10. Zhou, D., et al. (2023). "Least-to-Most Prompting". arXiv:2205.10625
