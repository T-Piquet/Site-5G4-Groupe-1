+++ 
title = "Atelier 01 - Prise en main Q# et .NET"
weight = 10
+++


Objectif : installer l'environnement Q#, créer et exécuter un premier programme.

## Étapes
1. Créer un projet Q# pour l'atelier FlipCoin :

```bash
cd /workspace
dotnet new console -lang Q# -o Atelier1
cd Atelier1
```

2. Ouvrir `Operations.qs` (ou `Program.qs` selon le template) et coller le squelette fourni plus bas. Compléter les TODO pour implémenter l'opération `FlipCoin` et `Main`.
3. Exécuter le programme :

```bash
dotnet run
```

4. Relancer plusieurs fois `dotnet run` (ou exécuter dans une boucle) pour observer le comportement aléatoire "Pile / Face".

## Résultat attendu (pour l'atelier FlipCoin)
- Le programme affiche soit "Pile (Zero)" soit "Face (One)" à chaque exécution.
- En lançant l'expérience plusieurs fois (ou en répétant `FlipCoin` dans `Main`), la fréquence d'apparition de "Pile" et "Face" doit être proche de 50/50 sur un grand nombre de lancers.
- Les qubits doivent être correctement réinitialisés avant d'être libérés (aucune erreur de reset au runtime).

## Code de base 

Collez ce squelette dans `Operations.qs` d'un projet Q# créé avec `dotnet new console -lang Q#` puis complétez les TODO.

```qsharp
namespace Atelier1 {
	open Microsoft.Quantum.Intrinsic;
	open Microsoft.Quantum.Canon;

	// TODO: implémenter FlipCoin
	//  - allouer un qubit
	//  - appliquer H pour la superposition
	//  - mesurer et stocker le résultat
	//  - réinitialiser le qubit avant de le libérer
	//  - retourner le Result (Zero ou One)
	operation FlipCoin() : Result {
		// À compléter par l'étudiant·e
		fail "À compléter par l'étudiant";
	}

	@EntryPoint()
	operation Main() : Unit {
		// TODO: appeler FlipCoin() et afficher "Pile" ou "Face" en fonction du résultat
		fail "À compléter par l'étudiant";
	}
}
```

Conseil : créez le projet, collez ce code puis complétez les TODO avant d'exécuter `dotnet run`.