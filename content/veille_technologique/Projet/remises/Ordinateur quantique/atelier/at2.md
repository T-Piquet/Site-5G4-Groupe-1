+++ 
title = "Atelier 02 - Superposition et mesure (Qubit unique)"
weight = 20
+++

Objectif : préparer un qubit en superposition, mesurer et collecter des statistiques.

## Étapes
1. Écrire une opération Q# qui applique H sur un qubit et le mesure.
2. Exécuter plusieurs fois pour estimer les probabilités (répéter 1000 fois).
3. Afficher la fréquence d'obtention de 0 et 1.

### Exemple minimal (à coller dans Program.qs)
Voir le fichier de solution dans le dossier bonus.

## Résultats attendus
- Probabilité proche de 50% pour 0 et 1.

## Code de base (squelette pour l'étudiant·e)

Collez ce squelette dans `Operations.qs` d'un projet Q# puis complétez les TODO.

```qsharp
namespace Atelier2 {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	// TODO: implémenter FlipCoin (même consignes que Atelier1)
	operation FlipCoin() : Result {
		fail "À compléter par l'étudiant";
	}

	// TODO: implémenter RunStatistics
	//  - répéter FlipCoin nbShots fois
	//  - compter Zeros et Ones
	operation RunStatistics(nbShots : Int) : (Int, Int) {
		// À compléter par l'étudiant·e
		fail "À compléter par l'étudiant";
	}

	@EntryPoint()
	operation Main() : Unit {
		// TODO: appeler RunStatistics(1000) et afficher les résultats
		fail "À compléter par l'étudiant";
	}
}
```

Remarque : commencez par un petit `nbShots` (10) pour tester, puis augmentez.