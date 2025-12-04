+++
title = "Réponses — Solutions complètes des ateliers Q#"
weight = 100
+++

# Réponses et solutions complètes

Ce fichier contient des implémentations complètes et exécutables (`Operations.qs`) pour chaque atelier. Ces solutions servent de référence après que vous ayez essayé les squelettes.

---

## Atelier 1 — FlipCoin (solution)

```qsharp
namespace Atelier1 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation FlipCoin() : Result {
        use q = Qubit();
        H(q);
        let result = M(q);
        if (result == One) {
            X(q);
        }
        return result;
    }

    @EntryPoint()
    operation Main() : Unit {
        let r = FlipCoin();
        if (r == Zero) {
            Message("Pile (Zero)");
        } else {
            Message("Face (One)");
        }
    }
}
```

---

## Atelier 2 — Statistiques (solution)

```qsharp
namespace Atelier2 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation FlipCoin() : Result {
        use q = Qubit();
        H(q);
        let result = M(q);
        if (result == One) { X(q); }
        return result;
    }

    operation RunStatistics(nbShots : Int) : (Int, Int) {
        mutable countZero = 0;
        mutable countOne = 0;
        for (i in 1..nbShots) {
            let r = FlipCoin();
            if (r == Zero) {
                set countZero += 1;
            } else {
                set countOne += 1;
            }
        }
        return (countZero, countOne);
    }

    @EntryPoint()
    operation Main() : Unit {
        let nbShots = 1000;
        let (zeros, ones) = RunStatistics(nbShots);
        Message($"Sur {nbShots} lancers :");
        Message($"  Zero (Pile) : {zeros}");
        Message($"  One  (Face) : {ones}");
    }
}
```

---

## Atelier 3 — Paire de Bell (solution)

```qsharp
namespace Atelier3 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation BellPairOnce() : (Result, Result) {
        use (q0, q1) = (Qubit(), Qubit());
        H(q0);
        CNOT(q0, q1);
        let r0 = M(q0);
        let r1 = M(q1);
        if (r0 == One) { X(q0); }
        if (r1 == One) { X(q1); }
        return (r0, r1);
    }

    operation RunBellStatistics(nbShots : Int) : (Int, Int, Int, Int) {
        mutable c00 = 0;
        mutable c01 = 0;
        mutable c10 = 0;
        mutable c11 = 0;
        for (i in 1..nbShots) {
            let (r0, r1) = BellPairOnce();
            if (r0 == Zero and r1 == Zero) { set c00 += 1; }
            elif (r0 == Zero and r1 == One) { set c01 += 1; }
            elif (r0 == One and r1 == Zero) { set c10 += 1; }
            else { set c11 += 1; }
        }
        return (c00, c01, c10, c11);
    }

    @EntryPoint()
    operation Main() : Unit {
        let nbShots = 1000;
        let (c00, c01, c10, c11) = RunBellStatistics(nbShots);
        Message($"Sur {nbShots} mesures de la paire de Bell :");
        Message($"  00 : {c00}");
        Message($"  01 : {c01}");
        Message($"  10 : {c10}");
        Message($"  11 : {c11}");
    }
}
```

---

## Atelier 4 — Mini‑Grover (solution)

```qsharp
namespace Atelier4 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    function TargetIndex() : Int {
        return 2; // par défaut, chercher l'élément 2 (10 en binaire)
    }

    function ResultsToInt(results : Result[]) : Int {
        let q0 = results[0];
        let q1 = results[1];
        let bit0 = (q0 == One) ? 1 | 0;
        let bit1 = (q1 == One) ? 1 | 0;
        return bit0 + 2 * bit1;
    }

    operation PrepareSuperposition(register : Qubit[]) : Unit is Adj + Ctl {
        for (q in register) { H(q); }
    }

    operation Oracle(register : Qubit[]) : Unit is Adj + Ctl {
        let q0 = register[0];
        let q1 = register[1];
        X(q0);
        Controlled Z([q1], q0);
        X(q0);
    }

    operation Diffusion(register : Qubit[]) : Unit is Adj + Ctl {
        let q0 = register[0];
        let q1 = register[1];
        H(q0); H(q1);
        X(q0); X(q1);
        Controlled Z([q1], q0);
        X(q0); X(q1);
        H(q0); H(q1);
    }

    operation GroverIteration(register : Qubit[]) : Unit {
        Oracle(register);
        Diffusion(register);
    }

    @EntryPoint()
    operation Main() : Unit {
        use register = Qubit[2];
        PrepareSuperposition(register);
        GroverIteration(register);
        mutable results = new Result[2];
        set results w/= 0 <- M(register[0]);
        set results w/= 1 <- M(register[1]);
        for (i in 0..1) { if (results[i] == One) { X(register[i]); } }
        let value = ResultsToInt(results);
        Message($"Valeur mesurée : {value}");
        Message($"Valeur cible   : {TargetIndex()}");
    }
}
```

---

## Atelier 5 — Collecte & statistiques (solution)

```qsharp
namespace Atelier5 {
    open Microsoft.Quantum.Intrinsic;
    open Microsoft.Quantum.Canon;

    operation FlipCoin() : Result {
        use q = Qubit();
        H(q);
        let r = M(q);
        if (r == One) { X(q); }
        return r;
    }

    @EntryPoint()
    operation Main() : Unit {
        let nbShots = 5000;
        mutable zeros = 0;
        for (i in 1..nbShots) {
            let r = FlipCoin();
            if (r == Zero) { set zeros += 1; }
        }
        let ones = nbShots - zeros;
        Message($"Sur {nbShots} mesures : Zero={zeros}, One={ones}");
    }
}
```

---

## Bonus — Exemple Bell (référence)

(voir Atelier3 pour l'implémentation de Bell)

---

Fin des solutions. Bonne exploration !
