+++
title = "Notes de cours"
weight = 2
+++

# Notes de cours — Ordinateur quantique

Ce document donne une synthèse pédagogique des concepts fondamentaux en calcul quantique, basée sur la liste fournie et complétée par des précisions utiles pour un cours ou une remise.

## 1. Le qubit

Le qubit est l'équivalent quantique du bit classique. Alors qu'un bit classique vaut soit 0 soit 1, un qubit peut être dans une superposition des deux états :

|ψ⟩ = α|0⟩ + β|1⟩

où α et β sont des amplitudes complexes satisfaisant la normalisation |α|² + |β|² = 1. Les probabilités d'obtenir 0 ou 1 lors d'une mesure sont |α|² et |β|² (règle de Born). L'état d'un qubit peut être représenté sur la sphère de Bloch, utile pour visualiser rotations et phases.

## 2. Superposition

La superposition signifie qu'un qubit peut « explorer » plusieurs états simultanément jusqu'à la mesure. Contrairement à l'idée fausse d'une « multicalcul », la superposition permet de traiter des amplitudes simultanément et, combinée à l'interférence, d'amplifier les bonnes solutions.

Exemple simple : appliquer une porte Hadamard H à |0⟩ donne (|0⟩ + |1⟩)/√2 — une superposition égale de 0 et 1.

## 3. Intrication (entanglement)

Deux (ou plus) qubits peuvent former un état intriqué où l'état global n'est pas séparé en états individuels. Les états de Bell (paires EPR) illustrent l'intrication maximale. Mesurer un qubit intriqué corrèle instantanément les résultats mesurés, indépendamment de la distance.

L'intrication est une ressource fondamentale pour la communication quantique, la télémétrie, et certains algorithmes quantiques.

## 4. Interférence

L'interférence quantique contrôle les phases des amplitudes pour augmenter la probabilité des réponses correctes et annuler les mauvaises. Les algorithmes quantiques exploitent des séquences de portes qui créent interférences constructives sur les états solution et destructives ailleurs (ex. Grover).

## 5. Mesure

La mesure transforme un état quantique en résultat classique : la superposition s'effondre sur un des états base et l'information quantique liée à la phase est en général perdue. C'est pourquoi on évite les mesures intermédiaires trop tôt — elles détruisent l'avantage quantique.

## 6. Portes quantiques

Les portes sont des opérations unitaires réversibles agissant sur qubits.
- Hadamard (H) : crée superposition.
- Pauli X, Y, Z : équivalents quantiques de rotations (X ~ NOT).
- CNOT (controlled-NOT) : crée intrication / opère conditionnellement.
- T (π/8) et S : ajoutent des phases cruciaux pour universalité.
- SWAP : échange deux qubits.

Les programmes quantiques se conçoivent comme des circuits (séquences de portes) appliqués sur un registre.

## 7. Registre quantique

Un registre de n qubits représente une combinaison linéaire de 2^n états de base. Avec n qubits, l'espace d'état a dimension 2^n — c'est la source de la complexité exponentielle en représentation.

Exemple : 50 qubits → ~1,1259×10^15 amplitudes.

## 8. Décohérence

La décohérence est la perte d'informations quantiques due aux interactions avec l'environnement (bruit thermique, vibrations, champ électromagnétique). Elle est caractérisée par des temps T1 (relaxation) et T2 (décohérence de phase). C'est l'obstacle majeur à des calculs longs et fiables.

## 9. Correction d'erreurs quantiques

Le théorème de non‑clonage interdit de copier un état inconnu, ce qui complique la correction d'erreurs. Les approches incluent :
- Codes stabilisateurs (ex. code de surface)
- Qubits logiques construits à partir de plusieurs qubits physiques

La correction d'erreurs nécessite une redondance importante : des dizaines à des milliers de qubits physiques par qubit logique selon l'architecture et la qualité des qubits.

## 10. Types de qubits (technologies)

- Supraconducteurs (IBM, Google) : rapides, demandent des cryostats (mK).
- Ions piégés (IonQ, Honeywell) : très précis, temps d'opération plus lents.
- Photoniques (Xanadu) : utilisant la lumière, potentiellement à température ambiante.
- Spins dans silicium (Intel) : bonne intégration CMOS potentielle.
- Topologiques (recherche, Microsoft) : approche théorique prometteuse pour robustesse.

Chaque technologie a des compromis en vitesse, fidélité, scalabilité et conditionnement (température, contrôle optique/électrique).

## 11. Algorithmes quantiques importants

- Shor : factorisation en temps polynomial (menace pour RSA/ECC).
- Grover : recherche non structurée avec accélération quadratique (√N).
- QFT (Quantum Fourier Transform) : composant clé de Shor et d'autres algorithmes.
- Variational algorithms (VQE, QAOA) : méthodes hybrides variationales adaptées aux machines NISQ pour optimisation et chimie quantique.

## 12. NISQ (Noisy Intermediate-Scale Quantum)

Période actuelle : machines NISQ (≈ quelques dizaines à quelques centaines de qubits) — bruyantes, sans correction d'erreurs complète. Utiles pour la recherche, le prototypage d'algorithmes variationales, et études d'applications spécifiques, mais pas encore pour casser RSA ou exécuter certains algorithmes à grande échelle.

## 13. Post‑quantum cryptography

Comme Shor menace RSA/ECC, la cryptographie post‑quantique vise à résister aux attaques quantiques. NIST a sélectionné des familles et candidats (ex. Kyber pour chiffrement, Dilithium pour signatures) basés sur des problèmes comme les réseaux euclidiens (lattices), multivariés, ou basés sur hachage.

## 14. Avantage quantique (Quantum supremacy / advantage)

Résultat de Google (2019) revendiquant un calcul de sampling difficile pour un super‑ordinateur classique. Ce type de résultat montre un point de comparaison, mais l'« avantage utile » (pour une application pratique) reste à démontrer sur des problèmes du monde réel.

## Annexe : Programmation et Q# (introduction)

Q# est un langage de haut niveau développé par Microsoft pour écrire algorithmes quantiques. Points clés :
- `operation` définit une opération quantique.
- Allocation : `using (qs = Qubit[n]) { ... }`.
- Portes : `H`, `CNOT`, `X`, `Z`, `T`, etc.
- Mesure : `M(q)` retourne `Zero` ou `One`.

Exemple minimal (paire de Bell) :

```qsharp
namespace Examples {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	operation BellPair() : (Result, Result) {
		using (qs = Qubit[2]) {
			H(qs[0]);
			CNOT(qs[0], qs[1]);
			let r0 = M(qs[0]);
			let r1 = M(qs[1]);
			ResetAll(qs);
			return (r0, r1);
		}
	}
}
```

Commandes rapides (Windows PowerShell) :

```powershell
dotnet tool install -g Microsoft.Quantum.IQSharp
dotnet new -i Microsoft.Quantum.ProjectTemplates
dotnet new console -lang Q# -o MonProjetQuantique
cd MonProjetQuantique
dotnet run
```

## Références et lectures recommandées

- Wikipedia — Quantum computing: https://en.wikipedia.org/wiki/Quantum_computing
- Microsoft Learn — Azure Quantum overview: https://learn.microsoft.com/en-us/azure/quantum/overview-understanding-quantum-computing
- IBM — Quantum computing overview: https://www.ibm.com/think/topics/quantum-computing
- AWS — What is quantum computing?: https://aws.amazon.com/what-is/quantum-computing/
- BlueQuBit — Quantum computing basics: https://www.bluequbit.io/quantum-computing-basics
- SpinQuanta — Guide aux concepts quantiques: https://www.spinquanta.com

---

Ces notes sont prêtes à être étendues : je peux ajouter des exemples pas à pas (téléportation, Grover, VQE), des exercices, ou un tutoriel complet d'installation et d'utilisation de Q# sur Windows. Dis‑moi quelle suite tu préfères.