+++ 
title = "Atelier 03 - Intrication : États de Bell"
weight = 30
+++

Objectif : créer une paire de Bell, mesurer et vérifier les corrélations.

## Étapes
1. Préparer deux qubits, appliquer H sur le premier puis CNOT(0,1).
2. Mesurer les deux qubits sur de nombreuses itérations.
3. Calculer la corrélation (mêmes résultats attendus).

### Points à vérifier
- Gestion du reset des qubits.
- Comptage des paires (00, 01, 10, 11).

## Résultats attendus
- Les observations sont majoritairement 00 ou 11.

## Code de base (squelette pour l'étudiant·e)

Collez ce squelette dans `Operations.qs` d'un projet Q# puis complétez les TODO.

```qsharp
namespace Atelier3 {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	// TODO: implémenter BellPairOnce
	//  - allouer 2 qubits
	//  - préparer |Φ+> avec H et CNOT
	//  - mesurer et réinitialiser les qubits
	//  - retourner les deux Result
	operation BellPairOnce() : (Result, Result) {
		fail "À compléter par l'étudiant";
	}

	// TODO: implémenter RunBellStatistics(nbShots) qui répète BellPairOnce et compte 00/01/10/11

	@EntryPoint()
	operation Main() : Unit {
		// TODO: appeler RunBellStatistics et afficher le tableau de comptage
		fail "À compléter par l'étudiant";
	}
}
```

Exercice : une fois fonctionnel, modifiez la base de mesure (ex: base X) et observez les effets.