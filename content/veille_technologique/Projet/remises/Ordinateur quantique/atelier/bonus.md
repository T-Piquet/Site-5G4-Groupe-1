+++ 
title = "Bonus — Solutions et ressources"
weight = 90
+++


Ce fichier centralise :
- Les solutions minimalistes pour chaque atelier.
- Les instructions pour récupérer le devcontainer ZIP.
- Liens utiles et scripts d'exécution.

## Contenu
- Exemple Bell (Q#) — copie dans `Program.qs` :
```qsharp
open Microsoft.Quantum.Intrinsic;
open Microsoft.Quantum.Canon;

operation BellDemo() : Unit {
    using (qs = Qubit[2]) {
        H(qs[0]);
        CNOT(qs[0], qs[1]);
        let r0 = M(qs[0]);
        let r1 = M(qs[1]);
        Message($"{r0}, {r1}");
        ResetAll(qs);
    }
}
```

## Téléchargement devcontainer
Placer `qsharp-devcontainer.zip` dans :
- `static/fichiers/qsharp-devcontainer.zip` — lien de téléchargement depuis le site : [static/fichiers/qsharp-devcontainer.zip](static/fichiers/qsharp-devcontainer.zip)

## Autres références
- Exemple de structure inspirée de : [content/cours/Cplusplus/Exercices/listechainee/index.md](content/cours/Cplusplus/Exercices/listechainee/index.md)
## Solutions et corrigés

Les corrigés complets sont rassemblés dans le fichier de réponses :

- `reponses.md` (fichier situé dans le même dossier) — contient les solutions complètes `Operations.qs` pour Atelier1..Atelier5 et l'atelier Bonus.

Utilisez d'abord les squelettes fournis dans `at1.md`..`at5.md`, puis comparez votre implémentation avec `reponses.md` une fois terminé.
