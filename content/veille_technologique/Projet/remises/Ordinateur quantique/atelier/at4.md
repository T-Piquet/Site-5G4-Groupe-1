+++ 
title = "Atelier 04 - Mini‑Grover (2 qubits)"
weight = 40
+++

Objectif : implémenter une version réduite de l'algorithme de Grover pour 2 qubits.

## Étapes
1. Préparer l'état uniformément superposé sur 2 qubits.
2. Implémenter l'oracle pour une valeur cible.
3. Appliquer l'amplification d'amplitude (diffusion).
4. Mesurer et vérifier que la valeur cible est favorisée.

## Tests recommandés
- Tester pour chaque cible possible (00, 01, 10, 11).
- Mesurer après 1 itération d'amplification.

## Résultat attendu
- Probabilité accrue d'obtenir la valeur cible.

## Code de base (squelette pour l'étudiant·e)

Collez ce squelette dans `Operations.qs` d'un projet Q# puis complétez les TODO.

```qsharp
namespace Atelier4 {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	// TODO: implémenter TargetIndex() pour choisir la valeur recherchée (0..3)
	function TargetIndex() : Int {
		fail "À compléter par l'étudiant";
	}

	// TODO: convertir un tableau de Result en Int (q0=LSB, q1=MSB)
	function ResultsToInt(results : Result[]) : Int {
		fail "À compléter par l'étudiant";
	}

	// TODO: préparer la superposition uniforme
	operation PrepareSuperposition(register : Qubit[]) : Unit is Adj + Ctl {
		fail "À compléter par l'étudiant";
	}

	// TODO: oracle qui marque l'état cible
	operation Oracle(register : Qubit[]) : Unit is Adj + Ctl {
		fail "À compléter par l'étudiant";
	}

	// TODO: opérateur de diffusion (inversion par rapport à la moyenne)
	operation Diffusion(register : Qubit[]) : Unit is Adj + Ctl {
		fail "À compléter par l'étudiant";
	}

	@EntryPoint()
	operation Main() : Unit {
		// TODO: allouer 2 qubits, préparer, appliquer GroverIteration, mesurer, réinitialiser et afficher
		fail "À compléter par l'étudiant";
	}
}
```

Astuce : commencez par implémenter `ResultsToInt` puis `PrepareSuperposition`, puis l'`Oracle`.