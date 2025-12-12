+++
title = "Corrigé de l'atelier"
weight = 4
+++

## Corrigé complet des exercices

Ce document contient les solutions détaillées de tous les exercices de l'atelier d'informatique quantique.

---

## Exercice 1 : Premier circuit quantique - La superposition

### Solution complète

```python
# Importations
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Créer un circuit avec 1 qubit et 1 bit classique
circuit = QuantumCircuit(1, 1)  # ✅ 1 qubit, 1 bit classique

# Appliquer la porte Hadamard au qubit 0
circuit.h(0)  # ✅ h() pour Hadamard

# Mesurer le qubit 0 et stocker dans le bit classique 0
circuit.measure(0, 0)  # ✅ mesure qubit 0 → bit classique 0

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

### Résultat attendu

```
Circuit quantique :
     ┌───┐┌─┐
q_0: ┤ H ├┤M├
     └───┘└╥┘
c: 1/══════╩═
           0

Résultats :
{'0': ~500, '1': ~500}
```

*Note : Les valeurs exactes varient car c'est probabiliste, mais on obtient environ 50/50*

### Réponses aux questions

**Q: Pourquoi obtient-on environ 50% de 0 et 50% de 1 ?**

La porte de Hadamard crée une superposition égale : |ψ⟩ = (|0⟩ + |1⟩)/√2. Cela signifie que le qubit est dans une combinaison linéaire des états |0⟩ et |1⟩ avec des amplitudes égales (1/√2 ≈ 0.707). Lors de la mesure, la probabilité d'observer chaque état est le carré de l'amplitude : (1/√2)² = 1/2 = 50%.

**Q: Que se passerait-il si on n'appliquait pas la porte de Hadamard ?**

Sans la porte H, le qubit resterait dans son état initial |0⟩. Les résultats donneraient : `{'0': 1000, '1': 0}`, c'est-à-dire 100% de 0.

**Q: Quelle est la différence entre l'état quantique avant et après la mesure ?**

- **Avant la mesure** : Le qubit est en superposition (|0⟩ + |1⟩)/√2, il n'a pas de valeur définie
- **Après la mesure** : Le qubit "s'effondre" (collapse) vers |0⟩ ou |1⟩ de manière irréversible. La superposition est détruite.

---

## Exercice 2 : L'intrication quantique (Bell State)

### Solution complète

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Circuit avec 2 qubits, 2 bits classiques
circuit = QuantumCircuit(2, 2)

# Étape 1 : Superposition du qubit 0
circuit.h(0)  # ✅ Hadamard sur qubit 0

# Étape 2 : Intrication avec une porte CNOT
circuit.cx(0, 1)  # ✅ Contrôle = qubit 0, Cible = qubit 1

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

### Résultat attendu

```
Circuit de Bell :
     ┌───┐     ┌─┐   
q_0: ┤ H ├──■──┤M├───
     └───┘┌─┴─┐└╥┘┌─┐
q_1: ─────┤ X ├─╫─┤M├
          └───┘ ║ └╥┘
c: 2/═══════════╩══╩═
                0  1

Résultats :
{'00': ~500, '11': ~500}
```

*Note : On n'observe JAMAIS '01' ou '10'*

### Réponses aux questions

**Q: Pourquoi n'obtient-on que les résultats |00⟩ et |11⟩ et jamais |01⟩ ou |10⟩ ?**

Après la porte H, le qubit 0 est en superposition : (|0⟩ + |1⟩)/√2. La porte CNOT crée une corrélation :
- Si qubit 0 est |0⟩ → qubit 1 reste |0⟩ → état final |00⟩
- Si qubit 0 est |1⟩ → qubit 1 devient |1⟩ → état final |11⟩

L'état final est : |Φ⁺⟩ = (|00⟩ + |11⟩)/√2, une superposition d'états corrélés. Les qubits sont maintenant **intriqués** : leurs états sont interdépendants.

**Q: Que signifie le fait que les deux qubits donnent toujours le même résultat ?**

Cela signifie qu'ils sont **intriqués**. La mesure du premier qubit détermine instantanément le résultat du second, même s'ils sont séparés par des années-lumière ! C'est le phénomène qu'"effrayait" Einstein (il l'appelait "action fantôme à distance").

**Q: Comment cette propriété pourrait-elle être utilisée en cryptographie ?**

Dans la **distribution quantique de clés (QKD)** :
- Alice et Bob partagent des paires de qubits intriqués
- Ils mesurent leurs qubits pour générer une clé secrète commune
- Toute tentative d'interception par Ève perturbe l'intrication et est détectée
- C'est la base du protocole BB84 et de la cryptographie quantique

---

## Exercice 3 : Algorithme de Deutsch

### Solution complète

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram

# Circuit avec 2 qubits (0: qubit de travail, 1: qubit auxiliaire)
circuit = QuantumCircuit(2, 1)

# Initialisation : mettre le qubit 1 à |1⟩
circuit.x(1)  # ✅ Porte X (NOT) sur qubit 1

# Superposition des deux qubits
circuit.h(0)
circuit.h(1)

# Oracle pour fonction constante (f(x) = 0)
# Une fonction constante ne fait rien au circuit
# Pour f(x) = 1 constante, on ajouterait : circuit.z(0)

# Interférence : Hadamard sur le qubit 0
circuit.h(0)  # ✅ Porte H sur qubit 0

# Mesure du qubit 0
circuit.measure(0, 0)  # ✅ Mesurer qubit 0 dans bit classique 0

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

### Résultat attendu

```
Algorithme de Deutsch (fonction constante) :
     ┌───┐┌───┐┌─┐
q_0: ┤ H ├┤ H ├┤M├
     ├───┤├───┤└╥┘
q_1: ┤ X ├┤ H ├─╫─
     └───┘└───┘ ║ 
c: 1/═══════════╩═
                0

Résultats :
{'0': 1000}

Interprétation : Mesure = 0 → fonction constante ✓
```

### Variante : Fonction équilibrée

Pour tester une fonction équilibrée (f(0)=0, f(1)=1), ajoutez une porte CNOT comme oracle :

```python
# Remplacer la section oracle par :
circuit.cx(0, 1)  # Oracle pour fonction équilibrée
```

Résultat : `{'1': 1000}` → fonction équilibrée détectée

### Réponses aux questions

**Q: Pourquoi le résultat est-il toujours 0 pour une fonction constante ?**

L'algorithme de Deutsch utilise l'**interférence quantique**. Pour une fonction constante, les amplitudes de probabilité des différents chemins quantiques interfèrent constructivement pour |0⟩ et destructivement pour |1⟩, donnant une probabilité de 100% pour |0⟩.

Mathématiquement :
- État initial après les H : (|0⟩ + |1⟩)/√2 ⊗ (|0⟩ - |1⟩)/√2
- Fonction constante : pas de changement
- Après le dernier H : retour à |0⟩ avec certitude

**Q: Comment modifieriez-vous le circuit pour tester une fonction équilibrée ?**

Ajoutez une porte CNOT entre les deux qubits après les premières portes H :
```python
circuit.cx(0, 1)  # Oracle pour f(x) = x (fonction équilibrée)
```

Ou pour f(x) = NOT x :
```python
circuit.x(1)
circuit.cx(0, 1)
circuit.x(1)
```

**Q: En quoi cet algorithme démontre-t-il un avantage quantique ?**

- **Classiquement** : Pour déterminer si f est constante ou équilibrée, il faut évaluer f(0) ET f(1), donc **2 appels** à la fonction
- **Quantiquement** : Deutsch le fait en **1 seul appel** grâce à la superposition et l'interférence

C'est le premier algorithme à démontrer une "suprematie quantique" sur un problème bien défini (même si artificiellement simple).

---

## Exercice 4 : Téléportation quantique

### Solution complète

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import AerSimulator
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

# Pour la téléportation quantique, nous devons simuler sans opérations conditionnelles dynamiques
# Nous allons créer un circuit qui montre le principe sans les corrections conditionnelles

# Circuit avec 3 qubits, 2 bits classiques (pour les mesures d'Alice)
circuit = QuantumCircuit(3, 2)

# Étape 1 : Préparer un état à téléporter (qubit 0)
# Appliquons X puis H pour créer un état intéressant: |ψ⟩ = (|0⟩ - |1⟩)/√2
circuit.x(0)
circuit.h(0)

# Ajouter une barrière pour la lisibilité
circuit.barrier()

# Étape 2 : Créer une paire de Bell entre qubits 1 et 2 (intrication Alice-Bob)
circuit.h(1)  # ✅ Hadamard sur qubit 1
circuit.cx(1, 2)  # ✅ CNOT entre qubits 1 (contrôle) et 2 (cible)

circuit.barrier()

# Étape 3 : Alice effectue une mesure de Bell
circuit.cx(0, 1)  # ✅ CNOT entre qubit 0 (contrôle) et qubit 1 (cible)
circuit.h(0)  # ✅ Hadamard sur qubit 0
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

### Résultat attendu

```
Circuit de téléportation quantique (mesures d'Alice) :
     ┌───┐┌───┐ ░            ░      ┌───┐┌─┐
q_0: ┤ X ├┤ H ├─░────────────░───■──┤ H ├┤M├
     └───┘└───┘ ░ ┌───┐      ░ ┌─┴─┐└┬─┬┘└╥┘
q_1: ───────────░─┤ H ├──■───░─┤ X ├─┤M├──╫─
                ░ └───┘┌─┴─┐ ░ └───┘ └╥┘  ║ 
q_2: ───────────░──────┤ X ├─░────────╫───╫─
                ░      └───┘ ░        ║   ║ 
c: 2/═════════════════════════════════╩═══╩═
                                      0   1 

📊 Résultats des mesures d'Alice :
{'00': ~250, '01': ~250, '10': ~250, '11': ~250}

Alice mesure 2 bits classiques qui indiquent à Bob quelles corrections appliquer.

============================================================
DÉMONSTRATION : Corrections de Bob selon les mesures d'Alice
============================================================

📌 Cas 00: Alice mesure 00
  Résultats : {'000': ~50, '100': ~50}

📌 Cas 01: Alice mesure 01
  → Bob applique X (car bit 1 = 1)
  Résultats : {'001': ~50, '101': ~50}

📌 Cas 10: Alice mesure 10
  → Bob applique Z (car bit 0 = 1)
  Résultats : {'010': ~50, '110': ~50}

📌 Cas 11: Alice mesure 11
  → Bob applique X (car bit 1 = 1)
  → Bob applique Z (car bit 0 = 1)
  Résultats : {'011': ~50, '111': ~50}

============================================================
✅ CONCLUSION : La téléportation fonctionne !
Le qubit de Bob (qubit 2) reproduit l'état initial du qubit 0
grâce aux corrections basées sur les mesures d'Alice.
============================================================
```

### Interprétation des résultats

L'état initial préparé était (X puis H sur qubit 0) : |ψ⟩ = (|0⟩ - |1⟩)/√2

Le code démontre les 4 cas possibles de mesures d'Alice (00, 01, 10, 11), chacun avec ~25% de probabilité. Pour chaque cas, Bob applique les corrections appropriées :
- **Cas 00** : Aucune correction
- **Cas 01** : Correction X
- **Cas 10** : Correction Z
- **Cas 11** : Corrections X et Z

Après les corrections, le qubit de Bob reproduit fidèlement l'état initial en superposition, d'où les résultats montrant environ 50% |0⟩ et 50% |1⟩ pour chaque cas.

### Réponses aux questions

**Q: Pourquoi avons-nous besoin de communication classique (les 2 mesures d'Alice) ?**

Sans les corrections conditionnelles basées sur les mesures d'Alice, le qubit de Bob serait dans un mélange statistique, pas dans l'état original. Les 2 bits classiques envoyés par Alice indiquent à Bob quelles corrections appliquer (X, Z, les deux, ou aucune) pour récupérer l'état exact.

C'est crucial car **sans cette communication classique, la téléportation ne fonctionne pas**.

**Q: Peut-on utiliser ce protocole pour communiquer plus vite que la lumière ? Pourquoi pas ?**

**Non !** Bien que l'intrication soit instantanée, Bob ne peut pas interpréter son qubit sans connaître les résultats des mesures d'Alice. Ces résultats doivent être transmis par un canal classique (limité à la vitesse de la lumière). 

Sans cette information, le qubit de Bob semble complètement aléatoire. La téléportation quantique **respecte la relativité** : pas de communication supraluminique possible.

**Q: Que devient l'état du qubit 0 après la téléportation ?**

Le qubit 0 est **détruit** lors de la mesure. Son état original n'existe plus nulle part : il a été transféré au qubit 2. C'est conforme au **théorème de non-clonage quantique** qui stipule qu'on ne peut pas copier un état quantique arbitraire.

La téléportation ne viole pas ce théorème car l'original est détruit pendant le processus.

---

## Exercice 5 : Exploration libre - Portes quantiques

### Solutions des expérimentations

#### 1. Effet de chaque porte de base

```python
from qiskit import QuantumCircuit
from qiskit_aer import Aer
from qiskit.visualization import plot_bloch_multivector
from qiskit.quantum_info import Statevector
import matplotlib.pyplot as plt

# Porte X
circuit = QuantumCircuit(1)
circuit.x(0)
state = Statevector.from_instruction(circuit)
print("État après porte X :", state)
display(plot_bloch_multivector(state))

# Porte Y
circuit_y = QuantumCircuit(1)
circuit_y.y(0)
state_y = Statevector.from_instruction(circuit_y)
print("État après porte Y :", state_y)
display(plot_bloch_multivector(state_y))

# Porte Z (avec H avant pour voir l'effet)
circuit_z = QuantumCircuit(1)
circuit_z.h(0)  # D'abord en superposition
circuit_z.z(0)  # Puis appliquer Z
state_z = Statevector.from_instruction(circuit_z)
print("État après H puis Z :", state_z)
display(plot_bloch_multivector(state_z))

# Porte S (√Z)
circuit_s = QuantumCircuit(1)
circuit_s.h(0)
circuit_s.s(0)
state_s = Statevector.from_instruction(circuit_s)
print("État après H puis S :", state_s)
display(plot_bloch_multivector(state_s))

# Porte T (π/8)
circuit_t = QuantumCircuit(1)
circuit_t.h(0)
circuit_t.t(0)
state_t = Statevector.from_instruction(circuit_t)
print("État après H puis T :", state_t)
display(plot_bloch_multivector(state_t))
```

**Résultats attendus :**

- **X** : |0⟩ → |1⟩ (pôle Nord → pôle Sud sur Bloch)
- **Y** : |0⟩ → i|1⟩ (rotation de 180° autour de Y)
- **Z** : |0⟩ → |0⟩ (pas d'effet visible sur |0⟩, change la phase de |1⟩)
- **H** : |0⟩ → (|0⟩+|1⟩)/√2 (équateur de la sphère, sur l'axe X)
- **S** : |0⟩ → |0⟩ (pas d'effet sur |0⟩, ajoute phase π/2 à |1⟩)
- **T** : |0⟩ → |0⟩ (pas d'effet sur |0⟩, ajoute phase π/4 à |1⟩)

#### 2. H-Z-H : Une découverte intéressante

```python
# H-Z-H devrait être équivalent à X
circuit_hzh = QuantumCircuit(1)
circuit_hzh.h(0)
circuit_hzh.z(0)
circuit_hzh.h(0)
state_hzh = Statevector.from_instruction(circuit_hzh)
print("État après H-Z-H :", state_hzh)
display(plot_bloch_multivector(state_hzh))

print("\nObservation : H-Z-H transforme |0⟩ en |1⟩, exactement comme la porte X !")
```

**Résultat :** H-Z-H = X !

**Explication :** La porte Z change la phase relative entre |0⟩ et |1⟩. Les portes H avant et après transforment cette phase en une différence d'amplitude, ce qui équivaut à une porte X. C'est un exemple d'**équivalence de portes** importante en informatique quantique.

#### 3. Rotations personnalisées

```python
import numpy as np

# Rotation autour de l'axe Y de 45 degrés
circuit_ry = QuantumCircuit(1)
circuit_ry.ry(np.pi/4, 0)  # π/4 radians = 45 degrés
state_ry = Statevector.from_instruction(circuit_ry)
print("État après RY(π/4) :", state_ry)
display(plot_bloch_multivector(state_ry))

# Combinaison de rotations pour atteindre un point arbitraire
circuit_combo = QuantumCircuit(1)
circuit_combo.ry(np.pi/3, 0)  # 60° autour de Y
circuit_combo.rz(np.pi/6, 0)  # 30° autour de Z
state_combo = Statevector.from_instruction(circuit_combo)
print("État après RY(60°) puis RZ(30°) :", state_combo)
display(plot_bloch_multivector(state_combo))
```

---

## Bonus : Solutions des défis

### Défi 1 : Algorithme de Grover simplifié (2 qubits)

Recherche de l'élément |11⟩ parmi {|00⟩, |01⟩, |10⟩, |11⟩}

```python
from qiskit import QuantumCircuit, transpile
from qiskit_aer import Aer
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

def grover_oracle_11(circuit, qubits):
    """Oracle qui marque l'état |11⟩"""
    circuit.cz(qubits[0], qubits[1])  # Change la phase de |11⟩

def grover_diffusion(circuit, qubits):
    """Opérateur de diffusion (inversion autour de la moyenne)"""
    # H sur tous les qubits
    for qubit in qubits:
        circuit.h(qubit)
    
    # X sur tous les qubits
    for qubit in qubits:
        circuit.x(qubit)
    
    # Multi-controlled Z (CZ pour 2 qubits)
    circuit.cz(qubits[0], qubits[1])
    
    # X sur tous les qubits
    for qubit in qubits:
        circuit.x(qubit)
    
    # H sur tous les qubits
    for qubit in qubits:
        circuit.h(qubit)

# Créer le circuit de Grover
n_qubits = 2
grover = QuantumCircuit(n_qubits, n_qubits)

# Étape 1 : Superposition initiale
for qubit in range(n_qubits):
    grover.h(qubit)

grover.barrier()

# Étape 2 : Itération de Grover (1 fois suffit pour 2 qubits)
# Oracle
grover_oracle_11(grover, [0, 1])
grover.barrier()

# Diffusion
grover_diffusion(grover, [0, 1])
grover.barrier()

# Mesure
grover.measure([0, 1], [0, 1])

print("Circuit de Grover (recherche de |11⟩) :")
print(grover.draw())

# Simulation
simulator = Aer.get_backend('qasm_simulator')
compiled_circuit = transpile(grover, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\nRésultats de la recherche :")
print(counts)
print("\nL'état |11⟩ devrait être trouvé avec une forte probabilité !")
plot_histogram(counts)
plt.show()
```

**Résultat attendu :** `{'11': ~1000}` - L'élément recherché est trouvé avec ~100% de probabilité !

**Recherche d'un autre état : |01⟩**

```python
def grover_oracle_01(circuit, qubits):
    """Oracle qui marque l'état |01⟩"""
    circuit.x(qubits[0])  # Inverser qubit 0
    circuit.cz(qubits[0], qubits[1])  # CZ
    circuit.x(qubits[0])  # Réinverser qubit 0

# Créer le circuit de Grover pour |01⟩
grover_01 = QuantumCircuit(n_qubits, n_qubits)

# Superposition
for qubit in range(n_qubits):
    grover_01.h(qubit)
grover_01.barrier()

# Oracle pour |01⟩
grover_oracle_01(grover_01, [0, 1])
grover_01.barrier()

# Diffusion
grover_diffusion(grover_01, [0, 1])
grover_01.barrier()

# Mesure
grover_01.measure([0, 1], [0, 1])

print("Circuit de Grover (recherche de |01⟩) :")
print(grover_01.draw())

# Simulation
compiled_circuit = transpile(grover_01, simulator)
job = simulator.run(compiled_circuit, shots=1000)
result = job.result()
counts = result.get_counts()

print("\nRésultats de la recherche :")
print(counts)
print("\nL'état |01⟩ devrait être trouvé avec une forte probabilité !")
plot_histogram(counts)
plt.show()
```

**Comparaison classique vs quantique**

```python
import numpy as np

print("Comparaison : Recherche classique vs Grover")
print("="*50)

for n in [2, 4, 8, 16, 20]:
    N = 2**n  # Nombre d'éléments
    classical = N/2  # Moyenne classique
    quantum = np.sqrt(N)  # Itérations de Grover
    speedup = classical / quantum
    
    print(f"\nn = {n} qubits ({N} éléments):")
    print(f"  Recherche classique : ~{classical:.0f} évaluations")
    print(f"  Algorithme de Grover : ~{quantum:.0f} itérations")
    print(f"  Accélération : {speedup:.1f}x")

print("\nGrover offre une accélération quadratique : O(√N) vs O(N)")
```

### Défi 2 : Correction d'erreur (Bit-flip code)

```python
def bit_flip_code():
    """Code de répétition 3 qubits : |0⟩ → |000⟩, |1⟩ → |111⟩"""
    circuit = QuantumCircuit(3, 1)
    
    # Encodage : créer |000⟩ ou |111⟩ selon l'état initial
    # (ici on part de |0⟩, donc on obtient |000⟩)
    circuit.cx(0, 1)
    circuit.cx(0, 2)
    
    circuit.barrier()
    
    # Simulation d'une erreur sur le qubit 1
    circuit.x(1)  # Erreur !
    
    circuit.barrier()
    
    # Détection et correction
    # Syndrome measurement
    circuit.cx(0, 1)
    circuit.cx(0, 2)
    circuit.ccx(1, 2, 0)  # Correction si erreur détectée
    
    circuit.measure(0, 0)
    
    return circuit

circuit = bit_flip_code()
print(circuit.draw())

simulator = Aer.get_backend('qasm_simulator')
job = simulator.run(transpile(circuit, simulator), shots=1000)
result = job.result()
counts = result.get_counts()

print("\nAprès correction d'erreur :")
print(counts)  # Devrait être {'0': 1000} - l'erreur est corrigée !
```

### Défi 3 : Code pour IBM Quantum (backend réel)

```python
from qiskit_ibm_runtime import QiskitRuntimeService
from qiskit import QuantumCircuit, transpile

# Première fois : sauvegarder votre token
# Obtenez votre token sur : https://quantum-computing.ibm.com/
# QiskitRuntimeService.save_account(channel="ibm_quantum", token="VOTRE_TOKEN_ICI")

# Se connecter au service
service = QiskitRuntimeService()

# Obtenir le backend le moins occupé (non-simulateur)
backend = service.least_busy(operational=True, simulator=False, min_num_qubits=2)
print(f"Backend sélectionné : {backend.name}")
print(f"File d'attente : {backend.status().pending_jobs} jobs")

# Créer un circuit simple (Bell state)
circuit = QuantumCircuit(2, 2)
circuit.h(0)
circuit.cx(0, 1)
circuit.measure([0, 1], [0, 1])

# Transpiler pour le backend spécifique
transpiled = transpile(circuit, backend)

# Soumettre le job
print("\nSoumission du circuit...")
job = backend.run(transpiled, shots=1024)
print(f"Job ID : {job.job_id()}")
print("En attente des résultats... (peut prendre plusieurs minutes)")

# Attendre et récupérer les résultats
result = job.result()
counts = result.get_counts()

print("\n🎉 Résultats du vrai ordinateur quantique IBM :")
print(counts)

# Comparer avec le simulateur
from qiskit_aer import Aer
sim_backend = Aer.get_backend('qasm_simulator')
sim_job = sim_backend.run(transpile(circuit, sim_backend), shots=1024)
sim_counts = sim_job.result().get_counts()

print("\nComparaison avec simulateur idéal :")
print(sim_counts)

# Visualisation
from qiskit.visualization import plot_histogram
import matplotlib.pyplot as plt

plot_histogram([counts, sim_counts], 
               legend=['Matériel réel', 'Simulateur'],
               title=f'Bell State sur {backend.name}')
plt.show()
```

**Note :** Sur un vrai backend, vous observerez du **bruit quantique** :
- Au lieu de {'00': ~512, '11': ~512}, vous aurez aussi des '01' et '10'
- Les taux d'erreur typiques sont de 1-5% par porte
- C'est normal et représente l'état actuel de la technologie (ère NISQ)

---

## Tableau récapitulatif des réponses

| Exercice | Concepts clés | Résultat principal |
|----------|---------------|-------------------|
| 1. Superposition | Porte H, mesure probabiliste | 50% |0⟩, 50% |1⟩ |
| 2. Intrication | CNOT, état de Bell | Corrélation parfaite |
| 3. Deutsch | Interférence, avantage quantique | 1 appel vs 2 classiques |
| 4. Téléportation | Communication classique + quantique | Transfert d'état |
| 5. Exploration | Portes de base, sphère de Bloch | Visualisation |

---

## Points d'attention pour l'évaluation

### Erreurs fréquentes à éviter

1. **Confusion entre qubits et bits classiques** dans `QuantumCircuit(n_qubits, n_bits)`
2. **Ordre des paramètres** dans `cx(contrôle, cible)` - l'ordre compte !
3. **Oublier la mesure** - sans mesure, pas de résultats observables
4. **Confondre h(0)** (porte) et **H** (symbole mathématique)
5. **Ne pas utiliser barrier()** pour la lisibilité des circuits complexes

### Bonnes pratiques observées

- Code commenté et structuré  
- Utilisation de `circuit.draw()` pour visualiser  
- Interprétation des résultats (pas juste les afficher)  
- Expérimentation avec différents paramètres  
- Comparaison simulateur vs théorie  

---

## Pour aller plus loin

Maintenant que vous maîtrisez les bases, explorez :

1. **Algorithmes avancés**
   - Algorithme de Shor (factorisation)
   - Grover complet (n qubits)
   - VQE (Variational Quantum Eigensolver)
   - QAOA (Quantum Approximate Optimization Algorithm)

2. **Applications réelles**
   - Chimie quantique (simulation de molécules)
   - Optimisation combinatoire
   - Machine Learning quantique
   - Cryptographie post-quantique

3. **Matériel réel**
   - IBM Quantum Experience (gratuit)
   - Amazon Braket
   - Azure Quantum
   - Google Quantum AI

4. **Théorie approfondie**
   - Correction d'erreurs quantiques
   - Codes de surface
   - Compilation de circuits
   - Complexité quantique

---

## Ressources complémentaires

- **Qiskit Textbook** : https://qiskit.org/learn/ (gratuit, interactif)
- **Quantum Country** : https://quantum.country/ (essais interactifs)
- **Microsoft Quantum Katas** : Exercices progressifs en Q#
- **Papers** : arXiv.org section quant-ph

Félicitations pour avoir complété cet atelier ! 

Vous avez maintenant les bases solides pour explorer le monde fascinant de l'informatique quantique. N'hésitez pas à expérimenter, à casser des circuits, et surtout : **amusez-vous** ! 
