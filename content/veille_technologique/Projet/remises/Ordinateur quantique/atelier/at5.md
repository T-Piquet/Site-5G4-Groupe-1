+++ 
title = "Atelier 05 - Mesures avancées et statistiques"
weight = 50
+++

Objectif : collecter et analyser les mesures (confiance statistique, erreurs).

## Étapes
1. Implémenter un outil de collecte (ex: exécuter N fois et agréger).
2. Calculer moyenne, écart‑type et intervalles de confiance simples.
3. Présenter les résultats sous forme de tableau ou histogramme (export CSV).

## Sortie attendue
- CSV de résultats dans `results/`.
- Interprétation des écarts observés.

## Code de base (squelette pour l'étudiant·e)

Collez ce squelette dans `Operations.qs` d'un projet Q# puis complétez les TODO.

```qsharp
namespace Atelier5 {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	// TODO: implémenter FlipCoin comme précédemment
	operation FlipCoin() : Result {
		fail "À compléter par l'étudiant";
	}

	@EntryPoint()
	operation Main() : Unit {
		// TODO: exécuter FlipCoin nbShots fois, compter et afficher les résultats
		// TODO (optionnel): exporter les résultats côté host pour produire un CSV
		fail "À compléter par l'étudiant";
	}
}
```

Atelier : calculez la proportion, l'écart-type approximatif, exportez les données pour tracer.