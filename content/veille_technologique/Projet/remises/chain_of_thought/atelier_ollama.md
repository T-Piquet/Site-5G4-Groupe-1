+++
title = "Laboratoire pratique"
weight = 3
+++

# Laboratoire : Chain of Thought avec Ollama

## Objectifs pédagogiques

Ce laboratoire permet d'expérimenter concrètement les techniques de Chain of Thought (CoT) à l'aide d'un modèle de langage local. À la fin de ce laboratoire, vous serez capable de :

1. Configurer et utiliser Ollama pour exécuter des LLMs localement
2. Comparer les performances d'un modèle avec et sans Chain of Thought
3. Implémenter différentes variantes de CoT (Zero-Shot, Few-Shot)
4. Mesurer l'impact du CoT sur la précision et le temps de réponse
5. Créer des prompts CoT adaptés à différents types de problèmes

**Durée estimée** : 2-3 heures  
**Niveau** : Intermédiaire  
**Prérequis** : Notions de base en IA et prompt engineering

---

---

## Partie 1 : Installation et configuration

### 1.1 Installation d'Ollama

**Windows** :
```powershell
# Télécharger depuis https://ollama.com/download
# Ou avec winget
winget install Ollama.Ollama
```

**macOS** :
```bash
brew install ollama
```

**Linux** :
```bash
curl -fsSL https://ollama.com/install.sh | sh
```

**Vérification de l'installation** :
```powershell
ollama --version
```

Résultat attendu : `ollama version 0.x.x`

### 1.2 Téléchargement des modèles

**Modèle recommandé** : Llama 3.2 (3B paramètres, ~2GB)

```powershell
ollama pull llama3.2
```

**Modèles alternatifs** :

| Modèle | Taille | Paramètres | Caractéristiques |
|--------|--------|------------|-------------------|
| `llama3.2` | 2GB | 3B | Rapide, idéal pour démonstration |
| `phi3` | 2.3GB | 3.8B | Équilibré, bon raisonnement |
| `mistral` | 4.1GB | 7B | Performance supérieure |
| `llama3.1` | 4.7GB | 8B | Excellent pour CoT complexe |

### 1.3 Test de fonctionnement

**Mode interactif** :
```powershell
ollama run llama3.2
```

Testez avec :
```
>>> Quelle est la capitale de la France ?
>>> /bye
```

**Ligne de commande** :
```powershell
ollama run llama3.2 "Explique brièvement ce qu'est un LLM."
```

**Commandes utiles** :
```powershell
# Lister les modèles
ollama list

# Informations sur un modèle
ollama show llama3.2

# Supprimer un modèle
ollama rm nom_du_modele
```

### 1.4 Configuration Python (optionnel)

Pour automatiser les tests :

```powershell
# Créer un environnement virtuel
python -m venv venv
.\venv\Scripts\Activate

# Installer les dépendances
pip install requests
```

---

## Partie 2 : Expérimentations comparatives

### Méthodologie

Pour chaque exercice, nous comparerons systématiquement :
1. La réponse **sans Chain of Thought**
2. La réponse **avec Chain of Thought**
3. La précision, le temps de réponse et la qualité du raisonnement

---

### Exercice 1 : Problème arithmétique simple

### Sans Chain of Thought

**Commande** :
```powershell
ollama run llama3.2 "Un magasin a 23 pommes. Il reçoit 45 pommes le matin, puis vend 18 pommes l'après-midi. Combien reste-t-il de pommes ?"
```

**Résultat attendu** :
> "Il reste 50 pommes."

**Problème** : Pas de justification, impossible de vérifier.

---

### Avec Chain of Thought

**Commande** :
```powershell
ollama run llama3.2 "Un magasin a 23 pommes. Il reçoit 45 pommes le matin, puis vend 18 pommes l'après-midi. Combien reste-t-il de pommes ? Résous ce problème étape par étape."
```

**Résultat attendu** :
```
Étape 1 : Début = 23 pommes
Étape 2 : Après réception = 23 + 45 = 68 pommes
Étape 3 : Après vente = 68 - 18 = 50 pommes
Réponse finale : 50 pommes
```

**✅ Avantage** : Raisonnement transparent et vérifiable.

---

## 🧪 Démonstration 2 : Problème avec pourcentages

### Sans CoT

**Commande** :
```powershell
ollama run llama3.2 "Un produit coûte 120€. On applique une réduction de 20%, puis une taxe de 10% sur le prix réduit. Quel est le prix final ?"
```

**Observation** : Réponse souvent incorrecte ou confuse.

---

### Avec CoT

**Commande** :
```powershell
ollama run llama3.2 "Un produit coûte 120€. On applique une réduction de 20%, puis une taxe de 10% sur le prix réduit. Quel est le prix final ? Explique étape par étape."
```

**Résultat attendu** :
```
Étape 1 : Réduction = 120€ × 20% = 24€
Étape 2 : Prix après réduction = 120€ - 24€ = 96€
Étape 3 : Taxe = 96€ × 10% = 9.6€
Étape 4 : Prix final = 96€ + 9.6€ = 105.6€

Réponse : 105,6€
```

---

## 🧪 Démonstration 3 : Raisonnement logique

### Problème complexe

**Sans CoT** :
```powershell
ollama run llama3.2 "Si 5 machines fabriquent 5 widgets en 5 minutes, combien de temps faut-il à 100 machines pour fabriquer 100 widgets ?"
```

**Piège** : Réponse intuitive incorrecte (100 minutes).

---

**Avec CoT** :
```powershell
ollama run llama3.2 "Si 5 machines fabriquent 5 widgets en 5 minutes, combien de temps faut-il à 100 machines pour fabriquer 100 widgets ? Raisonne étape par étape."
```

**Résultat attendu** :
```
Étape 1 : 5 machines → 5 widgets en 5 minutes
Étape 2 : Donc 1 machine → 1 widget en 5 minutes
Étape 3 : 100 machines travaillent en parallèle
Étape 4 : Chaque machine fait 1 widget en 5 minutes
Étape 5 : 100 machines → 100 widgets en 5 minutes

Réponse : 5 minutes
```

**✅ Le CoT évite le piège !**

---

## 🧪 Démonstration 4 : Problème de mots

**Commande avec CoT** :
```powershell
ollama run llama3.2 "Marie a le double de l'âge de Jean. Dans 5 ans, la somme de leurs âges sera 35 ans. Quel âge ont-ils maintenant ? Résous étape par étape."
```

**Solution attendue** :
```
Soit x = âge de Jean
Alors 2x = âge de Marie

Dans 5 ans :
Jean aura x + 5 ans
Marie aura 2x + 5 ans

Équation : (x + 5) + (2x + 5) = 35
           3x + 10 = 35
           3x = 25
           x = 8.33... 

Vérification : Jean = 8.33 ans, Marie = 16.67 ans
Dans 5 ans : 13.33 + 21.67 = 35 ✓

Réponse : Jean a environ 8 ans, Marie environ 17 ans
```

---

## Partie 3 : Variantes du Chain of Thought

### Vue d'ensemble

| Technique | Description | Complexité |
|-----------|-------------|-------------|
| **Zero-Shot CoT** | Instruction simple ("Let's think step by step") | Faible |
| **Few-Shot CoT** | Exemples de raisonnements fournis avant la question | Moyenne |
| **Self-Consistency** | Génération multiple + vote majoritaire | Élevée |

---

### Exercice 5 : Few-Shot Chain of Thought

**Problème** : "Un restaurant a 12 tables de 4 personnes et 8 tables de 6 personnes. Combien de clients maximum ?"

**Étape 1** : Créez un exemple similaire

```powershell
ollama run llama3.2 "Exemple :
Q: Un café a 5 tables de 3 personnes et 4 tables de 2 personnes. Combien de clients maximum ?
Raisonnement:
- 5 tables × 3 personnes = 15 personnes
- 4 tables × 2 personnes = 8 personnes
- Total = 15 + 8 = 23 personnes
R: 23 clients maximum

Maintenant résous :
Q: Un restaurant a 12 tables de 4 personnes et 8 tables de 6 personnes. Combien de clients maximum ?"
```

**Observation** : Le modèle suit le format de l'exemple !

---

### Exercice : Self-Consistency manuelle

**Objectif** : Générer 3 raisonnements et comparer

**Problème** : "Si un livre a 450 pages et je lis 23 pages par jour, en combien de jours je finis le livre ?"

**Commande** (répétez 3 fois) :
```powershell
ollama run llama3.2 "Si un livre a 450 pages et je lis 23 pages par jour, en combien de jours je finis le livre ? Résous étape par étape."
```

**Notez les réponses** :
- Génération 1 : ______ jours
- Génération 2 : ______ jours
- Génération 3 : ______ jours

**Vote majoritaire** : ______ jours

**Discussion** : Les réponses sont-elles identiques ? Pourquoi des différences ?

---

### Exercice : Comparer français vs anglais

**Hypothèse** : Le CoT fonctionne mieux en anglais (modèles entraînés surtout en anglais)

**Test en français** :
```powershell
ollama run llama3.2 "Un train part de Montréal à 8h et roule à 100 km/h. Un autre part de Québec (250 km) à 9h à 120 km/h vers Montréal. À quelle heure se croisent-ils ? Résous étape par étape."
```

**Test en anglais** :
```powershell
ollama run llama3.2 "A train leaves Montreal at 8am traveling at 100 km/h. Another leaves Quebec City (250 km away) at 9am at 120 km/h toward Montreal. When do they meet? Let's solve this step by step."
```

**Comparez** :
- Précision : _____ (français) vs _____ (anglais)
- Clarté du raisonnement : _____ vs _____
- Temps de génération : _____ vs _____

---

## Partie 4 : Automatisation et mesure de performance

### Script d'automatisation Python

Ce script permet de comparer systématiquement les performances avec et sans CoT :

```python
import subprocess
import time
import re

def query_ollama(prompt, model="llama3.2"):
    """Exécute une requête Ollama et retourne la réponse"""
    result = subprocess.run(
        ["ollama", "run", model, prompt],
        capture_output=True,
        text=True,
        timeout=30
    )
    return result.stdout.strip()

def compare_cot(question, expected_answer, model="llama3.2"):
    """Compare les performances avec et sans CoT"""
    
    # Test sans CoT
    print(f"\nQuestion : {question}")
    print(f"Réponse attendue : {expected_answer}\n")
    
    print("--- SANS CHAIN OF THOUGHT ---")
    start = time.time()
    response_no_cot = query_ollama(question, model)
    time_no_cot = time.time() - start
    print(f"Réponse : {response_no_cot}")
    print(f"Temps : {time_no_cot:.2f}s")
    
    # Test avec CoT
    print("\n--- AVEC CHAIN OF THOUGHT ---")
    start = time.time()
    response_cot = query_ollama(f"{question} Let's solve this step by step.", model)
    time_cot = time.time() - start
    print(f"Réponse : {response_cot}")
    print(f"Temps : {time_cot:.2f}s")
    
    # Comparaison
    print(f"\nRatio temps : {time_cot/time_no_cot:.2f}x")
    print(f"Tokens estimés : ~{len(response_no_cot.split())} vs ~{len(response_cot.split())}")
    
    return {
        'no_cot': {'response': response_no_cot, 'time': time_no_cot},
        'cot': {'response': response_cot, 'time': time_cot}
    }

# Exemple d'utilisation
if __name__ == "__main__":
    problems = [
        {
            "question": "A store has 23 apples. It receives 45 in the morning and sells 18 in the afternoon. How many apples remain?",
            "answer": "50"
        },
        {
            "question": "A product costs 120 euros. A 20% discount is applied, then a 10% tax on the reduced price. What is the final price?",
            "answer": "105.6"
        },
        {
            "question": "If 5 machines make 5 widgets in 5 minutes, how long does it take 100 machines to make 100 widgets?",
            "answer": "5"
        }
    ]
    
    for i, problem in enumerate(problems, 1):
        print(f"\n{'='*60}")
        print(f"PROBLÈME {i}")
        print(f"{'='*60}")
        compare_cot(problem['question'], problem['answer'])
```

### Exécution

```powershell
python test_cot.py
```

### Résultats attendus

| Métrique | Sans CoT | Avec CoT | Variation |
|----------|----------|----------|--------|
| **Précision** | 40-60% | 70-85% | +25-40% |
| **Temps** | 2-4s | 4-8s | 2x |
| **Tokens** | ~50 | ~150 | 3x |
| **Vérifiabilité** | Non | Oui | - |

---

## Corrigé des exercices

### Exercice 1 : Problème arithmétique

**Réponse attendue** : 50 pommes

**Raisonnement correct** :
```
Étape 1 : Inventaire initial = 23 pommes
Étape 2 : Après réception = 23 + 45 = 68 pommes
Étape 3 : Après vente = 68 - 18 = 50 pommes
Réponse : 50 pommes
```

### Exercice 2 : Calcul avec pourcentages

**Réponse attendue** : 105,6€

**Raisonnement correct** :
```
Étape 1 : Réduction = 120€ × 20% = 24€
Étape 2 : Prix réduit = 120€ - 24€ = 96€
Étape 3 : Taxe = 96€ × 10% = 9,6€
Étape 4 : Prix final = 96€ + 9,6€ = 105,6€
```

### Exercice 3 : Piège logique

**Réponse attendue** : 5 minutes

**Raisonnement correct** :
```
Étape 1 : 5 machines → 5 widgets en 5 minutes
Étape 2 : Donc 1 machine → 1 widget en 5 minutes
Étape 3 : 100 machines travaillent en parallèle
Étape 4 : Chaque machine produit 1 widget en 5 minutes
Étape 5 : Résultat : 100 machines → 100 widgets en 5 minutes
```

**Piège évité** : La réponse intuitive (mais incorrecte) est 100 minutes.

### Exercice 4 : Problème algébrique

**Réponse attendue** : Jean ≈ 8,3 ans, Marie ≈ 16,7 ans

**Raisonnement correct** :
```
Soit x = âge de Jean
Alors 2x = âge de Marie

Dans 5 ans :
(x + 5) + (2x + 5) = 35
3x + 10 = 35
3x = 25
x = 8,33 ans

Vérification :
Jean = 8,33 ans, Marie = 16,67 ans
Dans 5 ans : 13,33 + 21,67 = 35 ✓
```

### Exercice 5 : Few-Shot CoT

**Réponse attendue** : 96 clients maximum

**Raisonnement correct** :
```
Étape 1 : Tables de 4 personnes = 12 × 4 = 48 personnes
Étape 2 : Tables de 6 personnes = 8 × 6 = 48 personnes  
Étape 3 : Total = 48 + 48 = 96 clients maximum
```

### Exercice 6 : Self-Consistency

**Réponse attendue** : 20 jours (ou 19,57 jours si précis)

**Raisonnement correct** :
```
Étape 1 : Pages totales = 450
Étape 2 : Pages par jour = 23
Étape 3 : Jours nécessaires = 450 ÷ 23 = 19,57 jours
Étape 4 : Arrondi : 20 jours complets
```

---

## Synthèse et observations

### Comparaison des techniques

| Critère | Sans CoT | Zero-Shot CoT | Few-Shot CoT |
|---------|----------|---------------|-------------|
| **Précision** | 40-60% | 70-80% | 80-85% |
| **Temps** | Rapide | Moyen | Lent |
| **Coût (tokens)** | Faible | Moyen | Élevé |
| **Contrôle** | Aucun | Faible | Élevé |
| **Complexité** | Minimale | Faible | Moyenne |

### Cas d'usage recommandés

**Utiliser le Chain of Thought pour** :
- Problèmes mathématiques et scientifiques
- Raisonnement logique complexe
- Analyse de données
- Décisions critiques (finance, santé, légal)
- Apprentissage et tutorat

**Éviter le Chain of Thought pour** :
- Questions factuelles simples
- Génération créative
- Applications temps réel strictes
- Ressources limitées (mémoire, calcul)

---

## Références

### Documentation technique
- **Ollama** : https://github.com/ollama/ollama
- **Modèles disponibles** : https://ollama.com/library

### Articles scientifiques
- Wei, J., et al. (2022). "Chain-of-Thought Prompting Elicits Reasoning in Large Language Models". *arXiv:2201.11903*
- Kojima, T., et al. (2022). "Large Language Models are Zero-Shot Reasoners". *arXiv:2205.11916*
- Wang, X., et al. (2022). "Self-Consistency Improves Chain of Thought Reasoning in Language Models". *arXiv:2203.11171*

---

## Dépannage

### Problème : Ollama ne répond pas

**Solution** :
```powershell
# Redémarrer le service
Stop-Process -Name "ollama" -Force
ollama serve
```

### Problème : Modèle trop lent

**Solutions** :
1. Utiliser un modèle plus léger : `llama3.2` au lieu de `llama3.1`
2. Réduire la longueur du contexte
3. Vérifier les ressources système (RAM, CPU)

### Problème : Réponses incohérentes

**Solutions** :
1. Baisser la température : `--temperature 0.3`
2. Reformuler la question
3. Essayer un modèle différent

### Problème : Erreur de mémoire

**Solution** :
- Utiliser un modèle plus petit
- Fermer les applications inutilisées
- Augmenter la mémoire virtuelle

### test_cot_ollama.py

```python
import subprocess
import time

def query_ollama(prompt, model="llama3.2"):
    """Envoie une requête à Ollama et retourne la réponse"""
    result = subprocess.run(
        ["ollama", "run", model, prompt],
        capture_output=True,
        text=True,
        timeout=30
    )
    return result.stdout.strip()

def compare_cot():
    """Compare les réponses avec et sans CoT"""
    
    problems = [
        {
            "question": "Un magasin a 23 pommes. Il reçoit 45 pommes le matin, puis vend 18 pommes l'après-midi. Combien reste-t-il de pommes ?",
            "answer": "50"
        },
        {
            "question": "Un produit coûte 120€. On applique une réduction de 20%, puis une taxe de 10% sur le prix réduit. Quel est le prix final ?",
            "answer": "105.6"
        },
        {
            "question": "Si 5 machines fabriquent 5 widgets en 5 minutes, combien de temps faut-il à 100 machines pour fabriquer 100 widgets ?",
            "answer": "5"
        }
    ]
    
    for i, problem in enumerate(problems, 1):
        print(f"\n{'='*60}")
        print(f"PROBLÈME {i}")
        print(f"{'='*60}")
        print(f"\nQuestion : {problem['question']}")
        print(f"Réponse attendue : {problem['answer']}")
        
        # Sans CoT
        print(f"\n--- SANS CHAIN OF THOUGHT ---")
        start = time.time()
        response_no_cot = query_ollama(problem['question'])
        time_no_cot = time.time() - start
        print(f"Réponse : {response_no_cot}")
        print(f"Temps : {time_no_cot:.2f}s")
        
        # Avec CoT
        print(f"\n--- AVEC CHAIN OF THOUGHT ---")
        start = time.time()
        response_cot = query_ollama(f"{problem['question']} Résous étape par étape.")
        time_cot = time.time() - start
        print(f"Réponse : {response_cot}")
        print(f"Temps : {time_cot:.2f}s")
        
        print(f"\nRatio temps : {time_cot/time_no_cot:.2f}x plus lent avec CoT")

if __name__ == "__main__":
    print("🧪 TEST : Chain of Thought avec Ollama")
    print("Modèle : llama3.2")
    compare_cot()
```

**Lancer le script** :
```powershell
python test_cot_ollama.py
```

---

## 📊 Observations attendues

### Résultats typiques

| Métrique | Sans CoT | Avec CoT | Amélioration |
|----------|----------|----------|--------------|
| **Précision** | 40-60% | 70-85% | **+25-30%** |
| **Temps** | 2-4s | 4-8s | **2x plus lent** |
| **Tokens** | ~50 | ~150 | **3x plus** |
| **Vérifiabilité** | ❌ Non | ✅ Oui | - |

### Points clés observés

1. **Transparence** : Le CoT montre le raisonnement
2. **Erreurs détectables** : On voit où le modèle se trompe
3. **Coût** : 2-3x plus de temps de calcul
4. **Performance** : Meilleure sur problèmes complexes

---

## 🎯 Variantes à tester

### 1. Zero-Shot CoT (simple)

```powershell
ollama run llama3.2 "[question] Let's think step by step."
```

### 2. Few-Shot CoT (avec exemple)

```powershell
ollama run llama3.2 "Exemple :
Q: Jean a 3 boîtes de 12 crayons. Combien en tout ?
Raisonnement:
- Jean a 3 boîtes
- Chaque boîte = 12 crayons
- Total = 3 × 12 = 36 crayons
R: 36 crayons

Maintenant résous :
Q: Marie a 4 paquets de 15 bonbons. Combien en tout ?"
```

### 3. CoT en français vs anglais

**Tester** : Le CoT fonctionne-t-il mieux en anglais ?

```powershell
# En français
ollama run llama3.2 "[question] Résous étape par étape."

# En anglais
ollama run llama3.2 "[question in English] Let's solve this step by step."
```

---

## 💡 Instructions CoT efficaces

**Variantes testées** :

1. "Résous étape par étape"
2. "Explique ton raisonnement"
3. "Montre tes calculs intermédiaires"
4. "Décompose le problème"
5. "Let's think step by step" (anglais)
6. "Let's approach this methodically" (anglais)

**La plus efficace** : "Let's think step by step" (en anglais)

---

## 🔧 Dépannage

### Problème : Ollama ne répond pas

**Solution** :
```powershell
# Redémarrer le service
Stop-Process -Name "ollama" -Force
ollama serve
```

### Problème : Modèle trop lent

**Solutions** :
1. Utiliser un modèle plus petit : `ollama pull llama3.2`
2. Réduire le contexte
3. Limiter la longueur de réponse

### Problème : Réponses incohérentes

**Solutions** :
1. Baisser la température : `ollama run llama3.2 --temperature 0.3`
2. Reformuler la question
3. Essayer un autre modèle : `mistral` ou `phi3`

---

## 🎓 Questions pour la discussion

1. **Pourquoi le CoT améliore-t-il les performances ?**
   - Décomposition du problème
   - Mémoire de travail étendue
   - Auto-correction possible

2. **Quand NE PAS utiliser le CoT ?**
   - Questions factuelles simples
   - Applications temps réel
   - Ressources limitées

3. **Le CoT fonctionne-t-il sur tous les modèles ?**
   - Non, meilleur sur grands modèles (>3B paramètres)
   - Performance variable selon l'architecture

4. **Peut-on combiner CoT avec d'autres techniques ?**
   - Oui : RAG, Self-Consistency, Tree of Thoughts

---

## 📚 Ressources complémentaires

**Pour aller plus loin** :
- Documentation Ollama : https://github.com/ollama/ollama
- Modèles disponibles : https://ollama.com/library
- Paper original CoT : https://arxiv.org/abs/2201.11903

**Modèles recommandés pour CoT** :
- `llama3.1` (8B) - Excellent raisonnement
- `mistral` (7B) - Bon équilibre
- `phi3` (3.8B) - Rapide et efficace


