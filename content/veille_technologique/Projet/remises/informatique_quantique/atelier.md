+++
title = "Atelier"
weight = 3
+++

## Objectif

**Premiers pas avec l'informatique quantique**

Découvrir et expérimenter avec la programmation quantique en utilisant Qiskit, le framework open-source d'IBM. Vous allez créer vos premiers circuits quantiques, observer les phénomènes de superposition et d'intrication, et exécuter des algorithmes quantiques simples.

## Prérequis

- Connaissances de base en Python
- Notions de probabilités (utiles mais non essentielles)
- Docker installé sur votre machine
- VSCode (recommandé) avec l'extension Jupyter

## Durée estimée

**2h30 à 3h00** pour un débutant complet en informatique quantique

## Scénario

Vous êtes un développeur qui découvre l'informatique quantique. Vous allez explorer les concepts fondamentaux en créant et testant différents circuits quantiques, du plus simple (un qubit en superposition) jusqu'à des algorithmes quantiques classiques comme l'algorithme de Deutsch et la téléportation quantique.

---

## Étape 1 : Préparation de l'environnement

### 1.1 Structure du projet

Créez un répertoire pour cet atelier :

```bash
mkdir atelier-quantique
cd atelier-quantique
```

Votre projet contiendra :
- `requirements.txt` : Dépendances Python
- `atelier_quantique.ipynb` : Notebook Jupyter pour les exercices
- `.venv/` : Environnement virtuel Python (créé automatiquement)

### 1.2 Créer le fichier `requirements.txt`

```txt
qiskit==2.2.3
qiskit-aer==0.17.2
matplotlib==3.10.7
numpy==2.3.5
jupyter==1.1.1
ipykernel==7.1.0
```

**Explication des dépendances :**

- **qiskit** : Framework principal pour créer des circuits quantiques
- **qiskit-aer** : Simulateur quantique local (permet de tester sans matériel réel)
- **matplotlib** : Visualisation des circuits et résultats
- **numpy** : Calculs numériques (vecteurs d'état, matrices)
- **jupyter** : Interface notebook interactive
- **ipykernel** : Noyau Python pour Jupyter

### 1.3 Configurer l'environnement Python

**Étape 1 : Créer un environnement virtuel**

```bash
python3 -m venv .venv
```

**Étape 2 : Activer l'environnement virtuel**

Sur Linux/macOS :
```bash
source .venv/bin/activate
```

Sur Windows (PowerShell) :
```bash
.venv\Scripts\Activate.ps1
```

Sur Windows (CMD) :
```bash
.venv\Scripts\activate.bat
```

**Étape 3 : Installer les dépendances**

```bash
pip install --upgrade pip
pip install -r requirements.txt
```

**Étape 4 : Vérifier l'installation**

```bash
python -c "import qiskit; print(f'Qiskit version: {qiskit.__version__}')"
```

Vous devriez voir : `Qiskit version: 2.2.3` (ou similaire)

### 1.4 Lancer Jupyter Notebook

**Démarrer Jupyter :**

```bash
jupyter notebook
```

Votre navigateur devrait s'ouvrir automatiquement à l'adresse : **http://localhost:8888**

**Dans VS Code (recommandé) :**

1. Ouvrez VS Code dans le dossier du projet
2. Installez l'extension "Jupyter" si ce n'est pas déjà fait
3. Créez un nouveau fichier `atelier_quantique.ipynb`
4. Sélectionnez le noyau Python de votre environnement virtuel (`.venv`)

**Note :** Si votre kernel ne démarre pas, sélectionnez directement l'interpréteur Python de votre `.venv` dans le sélecteur de kernel

---

## Étape 2 : Exercices avec Qiskit

Créez un nouveau notebook Jupyter nommé `atelier_quantique.ipynb` et suivez les exercices ci-dessous.

### Exercice 1 : Premier circuit quantique - La superposition

**Objectif :** Créer un qubit en superposition et observer les résultats probabilistes.

**Consignes :**

1. Importez les bibliothèques nécessaires
2. Créez un circuit quantique avec 1 qubit et 1 bit classique
3. Appliquez une porte de Hadamard (H) pour créer la superposition
4. Mesurez le qubit
5. Dessinez le circuit
6. Simulez le circuit avec 1000 exécutions (shots)
7. Affichez les résultats sous forme d'histogramme

**Code à compléter :**

```python
# Importations
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Créer un circuit avec 1 qubit et 1 bit classique
circuit = QuantumCircuit(?, ?)  # TODO: Complétez les paramètres (nombre de qubits, nombre de bits classiques)

# Appliquer la porte Hadamard au qubit 0
circuit.?  # TODO: Appliquez la porte H au qubit 0

# Mesurer le qubit 0 et stocker dans le bit classique 0
circuit.measure(?, ?)  # TODO: Mesurez le qubit 0 dans le bit classique 0

# Dessiner le circuit
print("Circuit quantique :")
print(circuit.draw())

# Simuler le circuit
simulator = Aer.get_backend('qasm_simulator')
compiled_circuit = transpile(circuit, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

# Afficher les résultats
print("\nRésultats :")
print(counts)
plot_histogram(counts)
plt.show()
```

**Questions de réflexion :**

- Pourquoi obtient-on environ 50% de 0 et 50% de 1 ?
- Que se passerait-il si on n'appliquait pas la porte de Hadamard ?
- Quelle est la différence entre l'état quantique avant et après la mesure ?

---

### Exercice 2 : L'intrication quantique (Bell State)

**Objectif :** Créer une paire de qubits intriqués et observer leur corrélation.

**Contexte théorique :**

L'intrication est un phénomène où deux qubits sont liés de telle sorte que la mesure de l'un affecte instantanément l'autre, quelle que soit la distance. L'état de Bell |Φ⁺⟩ = (|00⟩ + |11⟩)/√2 est un exemple classique.

**Consignes :**

1. Créez un circuit avec 2 qubits et 2 bits classiques
2. Appliquez une porte H au qubit 0 (superposition)
3. Appliquez une porte CNOT avec le qubit 0 comme contrôle et le qubit 1 comme cible (intrication)
4. Mesurez les deux qubits
5. Simulez et observez les résultats

**Code à compléter :**

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Circuit avec 2 qubits, 2 bits classiques
circuit = QuantumCircuit(2, 2)

# Étape 1 : Superposition du qubit 0
circuit.?  # TODO: Appliquez une porte Hadamard au qubit 0

# Étape 2 : Intrication avec une porte CNOT
circuit.cx(?, ?)  # TODO: CNOT avec qubit 0 = contrôle, qubit 1 = cible

# Mesure des deux qubits
circuit.measure([0, 1], [0, 1])

# Affichage du circuit
print("Circuit de Bell :")
print(circuit.draw())

# Simulation
simulator = Aer.get_backend('qasm_simulator')
compiled_circuit = transpile(circuit, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\nRésultats :")
print(counts)
plot_histogram(counts)
plt.show()
```

**Questions de réflexion :**

- Pourquoi n'obtient-on que les résultats |00⟩ et |11⟩ et jamais |01⟩ ou |10⟩ ?
- Que signifie le fait que les deux qubits donnent toujours le même résultat ?
- Comment cette propriété pourrait-elle être utilisée en cryptographie ?

---

### Exercice 3 : Algorithme de Deutsch

**Objectif :** Implémenter l'algorithme de Deutsch, qui démontre la "suprematie quantique" sur un problème simple.

**Contexte théorique :**

L'algorithme de Deutsch résout un problème spécifique : déterminer si une fonction f(x) est constante (toujours 0 ou toujours 1) ou équilibrée (renvoie 0 pour la moitié des entrées et 1 pour l'autre moitié).

- **Classiquement** : Il faut 2 évaluations de la fonction
- **Quantiquement** : 1 seule évaluation suffit !

**Consignes :**

Pour cet exercice, vous allez implémenter l'algorithme de Deutsch avec une fonction constante (renvoie toujours 0).

1. Créez un circuit avec 2 qubits et 1 bit classique
2. Initialisez le qubit 1 à |1⟩ avec une porte X
3. Appliquez des portes Hadamard aux deux qubits
4. Implémentez l'oracle (fonction constante : ne fait rien)
5. Appliquez une porte Hadamard au qubit 0
6. Mesurez le qubit 0

**Code à compléter :**

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram

# Circuit avec 2 qubits (0: qubit de travail, 1: qubit auxiliaire)
circuit = QuantumCircuit(2, 1)

# Initialisation : mettre le qubit 1 à |1⟩
circuit.?(?)  # TODO: Appliquez une porte X au qubit 1

# Superposition des deux qubits
circuit.h(0)
circuit.h(1)

# Oracle pour fonction constante (f(x) = 0)
# Une fonction constante ne fait rien au circuit
# (pour f(x) = 1, on ajouterait une porte Z au qubit 0)

# Interférence : Hadamard sur le qubit 0
circuit.?(?)  # TODO: Appliquez une porte H au qubit 0

# Mesure du qubit 0
circuit.measure(?, ?)  # TODO: Mesurez le qubit 0 dans le bit classique 0

print("Algorithme de Deutsch (fonction constante) :")
print(circuit.draw())

# Simulation
simulator = Aer.get_backend('qasm_simulator')
compiled_circuit = transpile(circuit, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\nRésultats :")
print(counts)
print("\nInterprétation : Si mesure = 0 → fonction constante")
print("                 Si mesure = 1 → fonction équilibrée")
```

**Questions de réflexion :**

- Pourquoi le résultat est-il toujours 0 pour une fonction constante ?
- Comment modifieriez-vous le circuit pour tester une fonction équilibrée ?
- En quoi cet algorithme démontre-t-il un avantage quantique ?

---

### Exercice 4 : Téléportation quantique

**Objectif :** Implémenter le protocole de téléportation quantique pour "transférer" l'état d'un qubit à un autre.

**Contexte théorique :**

La téléportation quantique permet de transférer l'état quantique d'un qubit à un autre en utilisant :
- Une paire de qubits intriqués (partagée entre Alice et Bob)
- De la communication classique (2 bits)

**Important :** On ne transfère pas de matière, seulement de l'information quantique !

**Consignes :**

Le protocole utilise 3 qubits :
- Qubit 0 : État à téléporter (chez Alice)
- Qubit 1 : Moitié de la paire intriquée (chez Alice)
- Qubit 2 : L'autre moitié (chez Bob)

1. Préparez un état à téléporter (appliquons une porte X puis H au qubit 0)
2. Créez une paire de Bell entre les qubits 1 et 2
3. Alice effectue une mesure de Bell sur les qubits 0 et 1
4. Bob applique des corrections en fonction des mesures d'Alice

**Code à compléter :**

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import AerSimulator
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Pour la téléportation quantique, nous simulons le principe sans opérations conditionnelles dynamiques
# Circuit avec 3 qubits, 2 bits classiques (pour les mesures d'Alice)
circuit = QuantumCircuit(3, 2)

# Étape 1 : Préparer un état à téléporter (qubit 0)
# Appliquons X puis H pour créer un état intéressant: |ψ⟩ = (|0⟩ - |1⟩)/√2
circuit.?(?)  # TODO: Appliquez une porte X au qubit 0
circuit.?(?)  # TODO: Appliquez une porte H au qubit 0

# Ajouter une barrière pour la lisibilité
circuit.barrier()

# Étape 2 : Créer une paire de Bell entre qubits 1 et 2 (intrication Alice-Bob)
circuit.?(?)  # TODO: Appliquez une porte H au qubit 1
circuit.cx(?, ?)  # TODO: CNOT entre qubits 1 (contrôle) et 2 (cible)

circuit.barrier()

# Étape 3 : Alice effectue une mesure de Bell
circuit.cx(?, ?)  # TODO: CNOT entre qubit 0 (contrôle) et qubit 1 (cible)
circuit.?(?)  # TODO: Appliquez une porte H au qubit 0
circuit.measure([0, 1], [0, 1])

print("Circuit de téléportation quantique (mesures d'Alice) :")
print(circuit.draw())

# Simulation pour voir les mesures d'Alice
simulator = AerSimulator()
compiled_circuit = transpile(circuit, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\n📊 Résultats des mesures d'Alice :")
print(counts)
print("\nAlice mesure 2 bits classiques qui indiquent à Bob quelles corrections appliquer.")

# Maintenant, créons des circuits séparés pour chaque cas de correction de Bob
print("\n" + "="*60)
print("DÉMONSTRATION : Corrections de Bob selon les mesures d'Alice")
print("="*60)

for alice_bits in ['00', '01', '10', '11']:
    print(f"\n📌 Cas {alice_bits}: Alice mesure {alice_bits}")
    
    # Créer un circuit pour ce cas spécifique
    qc = QuantumCircuit(3, 3)
    
    # État initial à téléporter
    qc.x(0)
    qc.h(0)
    qc.barrier()
    
    # Paire de Bell
    qc.h(1)
    qc.cx(1, 2)
    qc.barrier()
    
    # Mesure de Bell d'Alice
    qc.cx(0, 1)
    qc.h(0)
    qc.barrier()
    
    # Corrections de Bob selon le cas
    # Si bit 1 (qubit 1) = 1 → Bob applique X
    if alice_bits[1] == '1':
        qc.x(2)
        print(f"  → Bob applique X (car bit 1 = 1)")
    
    # Si bit 0 (qubit 0) = 1 → Bob applique Z
    if alice_bits[0] == '1':
        qc.z(2)
        print(f"  → Bob applique Z (car bit 0 = 1)")
    
    # Mesure finale
    qc.measure([0, 1, 2], [0, 1, 2])
    
    # Simuler ce cas
    compiled = transpile(qc, simulator)
    job = simulator.run(compiled, shots=100)
    result = job.result()
    case_counts = result.get_counts()
    
    print(f"  Résultats : {case_counts}")

print("\n" + "="*60)
print("✅ CONCLUSION : La téléportation fonctionne !")
print("Le qubit de Bob (qubit 2) reproduit l'état initial du qubit 0")
print("grâce aux corrections basées sur les mesures d'Alice.")
print("="*60)
```

**Note technique :** Le simulateur `qasm_simulator` ne supporte pas les opérations conditionnelles dynamiques modernes de Qiskit. Cette implémentation démontre donc le principe en simulant explicitement les 4 cas possibles de mesures d'Alice.

**Questions de réflexion :**

- Pourquoi avons-nous besoin de communication classique (les 2 mesures d'Alice) ?
- Peut-on utiliser ce protocole pour communiquer plus vite que la lumière ? Pourquoi pas ?
- Que devient l'état du qubit 0 après la téléportation ?

---

### Exercice 5 : Exploration libre - Portes quantiques

**Objectif :** Expérimenter avec différentes portes quantiques et observer leurs effets.

**Consignes :**

Créez des circuits pour tester les portes suivantes et observez leurs effets :

1. **Porte X (NOT quantique)** : Inverse |0⟩ ↔ |1⟩
2. **Porte Y** : Rotation autour de l'axe Y de la sphère de Bloch
3. **Porte Z** : Change la phase de |1⟩
4. **Porte S** : Porte de phase (√Z)
5. **Porte T** : Porte π/8

**Code de démarrage :**

```python
from qiskit import QuantumCircuit
from qiskit_aer import Aer
from qiskit.visualization import plot_bloch_multivector
from qiskit.quantum_info import Statevector

# Exemple : Effet de la porte X
circuit = QuantumCircuit(1)
circuit.x(0)  # Appliquer X

# Obtenir le vecteur d'état (avant mesure)
state = Statevector.from_instruction(circuit)
print("État après porte X :", state)

# Visualiser sur la sphère de Bloch
display(plot_bloch_multivector(state))
```

**Note importante :** Dans un notebook Jupyter, utilisez `display()` pour afficher les visualisations Bloch au lieu de `plt.show()`.

**Expérimentations suggérées :**

- Combinez plusieurs portes et observez le résultat
- Appliquez H puis Z puis H : que remarquez-vous ? (Cela devrait être équivalent à X !)
- Créez une rotation personnalisée avec les portes RX, RY, RZ

**Exemple de rotation personnalisée :**

```python
import numpy as np

# Rotation autour de l'axe Y de 45 degrés
circuit_ry = QuantumCircuit(1)
circuit_ry.ry(np.pi/4, 0)  # π/4 radians = 45 degrés
state_ry = Statevector.from_instruction(circuit_ry)
print("État après RY(π/4) :", state_ry)
display(plot_bloch_multivector(state_ry))
```

---

## Étape 3 : Aller plus loin (Bonus)

### Défi 1 : Algorithme de Grover (recherche)

Implémentez une version simplifiée de l'algorithme de Grover pour rechercher un élément dans une liste non triée. Pour 2 qubits, cela permet de chercher parmi 4 éléments.

**Indice :** L'algorithme nécessite :
- Une superposition initiale (portes H sur tous les qubits)
- Un oracle qui marque l'élément recherché (utilisez CZ pour marquer |11⟩)
- Un opérateur de diffusion (inversion autour de la moyenne)

**Code de départ :**

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

def grover_oracle_11(circuit, qubits):
    """Oracle qui marque l'état |11⟩"""
    # TODO: Implémentez l'oracle
    pass

def grover_diffusion(circuit, qubits):
    """Opérateur de diffusion (inversion autour de la moyenne)"""
    # TODO: Implémentez la diffusion
    # Indice : H → X → CZ → X → H
    pass

# Créer le circuit de Grover
n_qubits = 2
grover = QuantumCircuit(n_qubits, n_qubits)

# Étape 1 : Superposition initiale
# TODO: Appliquez H à tous les qubits

# Étape 2 : Itération de Grover
grover_oracle_11(grover, [0, 1])
grover_diffusion(grover, [0, 1])

# Mesure
grover.measure([0, 1], [0, 1])

# Simulation
simulator = Aer.get_backend('qasm_simulator')
compiled_circuit = transpile(grover, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\nRésultats de la recherche :")
print(counts)
plot_histogram(counts)
plt.show()
```

### Défi 2 : Correction d'erreur quantique

Implémentez le code de correction d'erreur de bit-flip à 3 qubits qui protège contre une erreur X sur un seul qubit.

### Défi 3 : Utiliser un vrai ordinateur quantique IBM

Créez un compte gratuit sur [IBM Quantum](https://quantum-computing.ibm.com/) et exécutez votre circuit de Bell sur un vrai ordinateur quantique !

```python
# Code pour se connecter à IBM Quantum
from qiskit_ibm_runtime import QiskitRuntimeService

# Sauvegarder votre token (première fois uniquement)
# QiskitRuntimeService.save_account(channel="ibm_quantum", token="VOTRE_TOKEN")

# Se connecter
service = QiskitRuntimeService()

# Obtenir un backend réel
backend = service.least_busy(operational=True, simulator=False)
print(f"Utilisation du backend : {backend.name}")

# Exécuter votre circuit sur le vrai matériel !
job = backend.run(circuit, shots=1000)
result = job.result()
counts = result.get_counts()
print(counts)
```

---

## Nettoyage

Lorsque vous avez terminé l'atelier :

**Désactiver l'environnement virtuel :**

```bash
deactivate
```

**Supprimer l'environnement (optionnel) :**

```bash
rm -rf .venv
```

---

## Ressources supplémentaires

- **Documentation Qiskit** : https://qiskit.org/documentation/
- **Qiskit Textbook** : https://qiskit.org/learn/ (tutoriels interactifs)
- **IBM Quantum Composer** : Interface visuelle pour créer des circuits
- **Communauté Qiskit** : https://qiskit.slack.com/

---

## Aide-mémoire des portes quantiques

| Porte | Symbole | Effet | Usage |
|-------|---------|-------|-------|
| Hadamard | H | Crée une superposition | Initialisation |
| Pauli-X | X | NOT quantique (|0⟩↔|1⟩) | Inversion de bit |
| Pauli-Y | Y | Rotation Y + changement de phase | Rarement seule |
| Pauli-Z | Z | Change la phase de |1⟩ | Manipulation de phase |
| CNOT | CX | NOT conditionnel | Intrication |
| Toffoli | CCX | CCNOT (2 contrôles) | Calcul réversible |
| S | S | Porte de phase (√Z) | Correction d'erreur |
| T | T | Porte π/8 | Algorithmes |
| SWAP | SWAP | Échange deux qubits | Routage |

---

## Critères d'évaluation (pour référence)

Si cet atelier était évalué, voici les critères :

| Critère | Points |
|---------|--------|
| Exercice 1 : Superposition | 15% |
| Exercice 2 : Intrication (Bell) | 20% |
| Exercice 3 : Algorithme de Deutsch | 25% |
| Exercice 4 : Téléportation | 30% |
| Qualité du code et documentation | 10% |
| **Total** | **100%** |

**Bonus :** +5% par défi bonus complété (max 15%)

---

## Prochain niveau

Une fois cet atelier complété, vous serez prêt à :
- Explorer des algorithmes plus complexes (Shor, Grover complet, VQE)
- Travailler avec des backends réels sur IBM Quantum
- Implémenter des applications quantiques (optimisation, chimie, ML)
- Contribuer à des projets open-source en informatique quantique

Bon coding quantique ! 
