+++
title = "Notes de cours"
weight = 2
+++

## Installations nécessaire

Aller sur ce site et installer la version x64 de Rust : [ici](https://rust-lang.org/fr/learn/get-started/)

Pendant l'installation faite y, puis enter, puis enter

Ensuite faire le commande suivant pour vérifier que l'installation à bien fonctionnée :

![alt text](../rust_version.png)

## Information sur l'installation :

![alt text](../info_installation.png)

- **Cargo** est le gestionnaire de paquets officiel de Rust. Il permet non seulement d’installer et de mettre à jour des dépendances externes, mais aussi de compiler le projet, de lancer des tests automatisés et de générer des exécutables. En pratique, c’est l’outil central qui simplifie la gestion de projets Rust, car il automatise des tâches qui seraient longues à réaliser manuellement.

- **Clippy** est un outil d'analyse statique spécialisé pour Rust. Il analyse le code source afin de détecter des erreurs courantes, des mauvaises pratiques ou des constructions qui ne suivent pas les conventions de style propres à Rust. En plus de signaler les problèmes, il propose des améliorations pour rendre le code plus lisible, plus efficace et conforme aux standards de la communauté Rust. C’est un outil précieux pour progresser et écrire du code robuste.

- **Rust-docs** correspond à une copie locale de la documentation officielle de Rust. Elle est installée avec la chaîne d'outils Rust(c'est à dire l'ensemble des programmes nécessaires pour compiler, gérer et documenter le code) et permet de consulter toutes les références, guides et explications sans connexion internet. Cela facilite l’apprentissage et le dépannage, car tu peux accéder rapidement aux descriptions des fonctions, des modules et des concepts du langage.

- **Rust-std** est la bibliothèque standard de Rust. Elle contient les fonctionnalités de base nécessaires à la plupart des programmes : gestion des chaînes de caractères, collections (vecteurs, hashmaps), entrées/sorties, gestion des threads, etc. Sans cette librairie, il serait impossible d’écrire du code Rust pratique, car elle fournit les fondations essentielles du langage.

- **Rustc** est le compilateur officiel de Rust. C’est lui qui traduit ton code source écrit en Rust vers du code machine exécutable par ton ordinateur. Il s’assure également du respect des règles de sécurité mémoire et du contrôle rigoureux des types qui font la réputation de Rust. En général, tu n’appelles pas directement rustc, car Cargo s’en charge pour toi, mais il reste le coeur du processus de compilation.

- **Rustfmt** est un outil de formatage automatique du code. Il applique des règles de style standardisées afin que le code soit propre, lisible et cohérent, peu importe qui l’écrit. Cela évite les débats sur la mise en forme et permet de se concentrer sur la logique du programme. En équipe, Rustfmt garantit une uniformité qui facilite la maintenance et la collaboration.

## Extensions VS Code pour Rust

- **Rust-analyzer** : Cette extension est essentielle pour travailler efficacement avec Rust dans Visual Studio Code. Elle fournit une aide intelligente à l’écriture du code grâce à l’autocomplétion, la coloration syntaxique avancée, la navigation entre les définitions et les suggestions contextuelles. Rust-analyzer permet aussi de lancer le compilateur directement depuis l’interface de VS Code, mais il est recommandé de ne pas utiliser cette fonction pour exécuter vos projets. La méthode correcte et idiomatique consiste à utiliser la commande cargo run dans le terminal intégré. Cela garantit que le projet est compilé et exécuté dans son environnement complet, en respectant la configuration du Cargo.toml et les dépendances définies.

![alt text](../extension_rust-analyzer.png)

- **CodeLLDB** : Cette extension ajoute un débogueur puissant pour Rust (et C/C++). Elle permet de placer des points d’arrêt, d’inspecter les variables, de suivre l’exécution pas à pas et de comprendre le comportement interne du programme. Grâce à CodeLLDB, vous pouvez analyser les erreurs logiques ou les comportements inattendus de votre code Rust directement dans VS Code, ce qui facilite énormément le processus de correction et d’optimisation.

![alt text](../extension_codelldb.png)

## Changement de settings

Il est possible que Visual Studio Code ne reconnaisse pas automatiquement les commandes rustc et cargo après l’installation de Rust. Dans ce cas, il faut configurer manuellement le PATH afin que l’éditeur puisse accéder aux outils de compilation et de gestion de projets.

![alt text](../settings.png)

Sélectionnez les paramètres utilisateur. Ensuite ajoutez ce code à la fin :

```json
"terminal.integrated.env.windows": {
    "PATH": "C:\\Users\\Antoi\\.cargo\\bin;${env:PATH}"
  }
```

Cette configuration indique au terminal intégré de VS Code où trouver les exécutables de Rust. Le dossier .cargo/bin contient les outils essentiels comme cargo et rustc, et ${env:PATH} permet de conserver les autres chemins déjà définis dans votre système.

Pour garantir que vous utilisez une version stable et compatible de Rust, il est recommandé d’installer et de définir la version stable par défaut avec rustup :

```cmd
rustup install stable-x86_64-pc-windows-gnu
rustup default stable-x86_64-pc-windows-gnu
```

Ces commandes assurent que votre environnement Rust est cohérent et que VS Code utilise toujours la bonne version du compilateur.

## Création et lancement d'un projet rust

Une fois le PATH configuré, vous pouvez créer un nouveau projet Rust directement depuis le terminal intégré de VS Code. La commande est :

```cmd
cargo new projet_rust
```

Ensuite pour lancer le projet, il faut faire cette commande :

```cmd
cargo run
```

Ensuite pour lancer le débogueur, il faut faire quelque étapes supplémentaire :

- Faite Ctrl + Shift + D dans vs code. Cela ouvre directement la section Exécuter et déboguer dans VS Code
- Cliquez sur Exécuter et déboguer. Cela permet de créer une configuration de débogage adaptée à votre projet Rust. Le fichier launch.json est créé automatiquement :
  ![alt text](../deboguer.png)
- Lorsque VS Code vous propose différents environnements, sélectionnez CodeLLDB. C’est l’extension qui permet de déboguer du code Rust (et aussi C/C++). Elle vous donnera accès aux points d’arrêt, à l’inspection des variables et au suivi pas à pas de l’exécution. Nous l'avons installer un peu plus tôt :
  ![alt text](../choix_debogue.png)
- Dans la configuration générée, il est nécessaire d’ajouter le chemin correct vers vos exécutables Rust. Cela garantit que le débogueur sait où trouver le binaire compilé par Cargo. Sans cette étape, le débogage risque de ne pas fonctionner correctement :
  ![alt text](../chemin.png)

## Introduction du langage

Rust est conçu pour offrir performances de bas niveau comparables à C/C++ tout en garantissant, à la compilation, l’absence de data races et de nombreux bugs mémoire (use-after-free, double-free, invalid aliasing). Il réalise cette promesse via un système d’ownership, d’emprunts, et un borrow checker strict, sans garbage collector. L’ergonomie moderne (pattern matching, traits, generics, tooling intégré) rend viable des projets industriels et pédagogiques.

## Premier programme

Le premier programme typique, Hello word! :

```rust
fn main() {
    println!("Hello world!");
}
```

## Explication du code

```rust
println!("Hello world!");
```

On écrit println!("Hello world!") (avec point d’exclamation). Ici, println! est une macro, pas une fonction. Les macros en Rust permettent de générer du code à la compilation (elles sont plus puissantes que de simples fonctions).

## Q'est ce que des Macros?

Rust utilise des macros (reconnaissables au point d’exclamation !) pour agir directement sur la syntaxe avant la vérification des types et du système d’emprunt. Contrairement aux fonctions, les macros peuvent :

- Accepter un nombre variable d’arguments.
- Inspecter leur structure syntaxique.
- Générer du code au moment de la compilation.

**Voici un exemple avec println!** :

```rust
let a = "bonjour";
let b = 2.1;
let c = 2;
let d = true;
println!("a = {} / b = {} / c = {} / d = {}", a,b,c,d)
```

**Affichage** :

```cmd
a = bonjour / b = 2.1 / c = 2 / d = true
```

Dans ce code nous avons un string, un float, un int et un boolan. Les variables sont définies automatiquement, et à l'affichage, pas besoin de faire la gestion des types, elle se fait aussi automatiquement grace au macro. Vous pouvez aussi notez que chaque variable est associer à son {}. L'association se fait en ordre avec les variables, donc le premier {} affiche la première variable qui est a, insi de suite...

## Écriture

**Voici un exemple d'écriture** :

```rust
use std::io;
fn main() {
    let mut nom = String::new();

    print!("Entrez votre nom : ");

    io::stdin().read_line(&mut nom).expect("Erreur lors de la lecture");

    print!("Bonjour {}!", nom);
}
```

**Explication du code**

```rust
use std::io;
```

**std** est la bibliohtèque standard de Rust (abréviation de standard).
**io** est le module qui gère les entrées/sorties (input/output), comme :

- Lire au clavier (stdin)
- Écrire à l’écran (stdout)
- Écrire dans un fichier ou lire un fichier

```rust
let mut nom = String::new();
```

Par défaut, toutes les variables en Rust sont immuables (non modifiables), donc nous devons la déclarer mut pour être capable de la modifier en y ajoutant ce que l'utilisateur a écrit.Le mot‑clé **mut** rend une variable mutable, c’est‑à‑dire qu’on peut changer son contenu après l’initialisation.

```rust
print!("Entrez votre nom : ");
```

Ceci est un affichage avec print que vous êtes familiés.

```rust
io::stdin().read_line(&mut nom).expect("Erreur lors de la lecture");
```

**io::std()** : Accède à l’entrée standard (standard input), c’est‑à‑dire le clavier. Cela retourne un objet qui permet de lire ce que l’utilisateur tape.

**read_line(&mut nom)** :

- Demande à Rust de lire une ligne complète depuis le clavier.
- Le texte saisi est ajouté dans la variable nom.
- On passe &mut nom car :
  - & → on donne une référence à la fonction (on ne copie pas la variable).
  - mut → on autorise la fonction à modifier le contenu de nom.
  - Sans mut, Rust refuserait car read_line doit écrire dans la variable.

```rust
print!("Bonjour {}!", nom);
```

Ensuite l'affichage.

Par contre ce code a un petit soucie d'affichage. Voyon voir :

```cmd
antoine
Entrez votre nom : Bonjour antoine
!
```

Rust n’affiche pas forcément immédiatement le texte à l’écran. Pourquoi ? Parce que la sortie standard (stdout) est bufferisée :

- Le texte est d’abord stocké dans une mémoire tampon (buffer).
- Il n’est envoyé à l’écran qu’à certains moments (par exemple quand il y a un \n ou quand le buffer est plein).

Résultat : si tu demandes une entrée juste après, il peut arriver que l’utilisateur ne voie pas l’invite avant de taper son texte.

On peut le voir avec ce code :

```rust
use std::io;
fn main() {
    let mut nom = String::new();

    println!("Entrez votre nom : ");

    io::stdin().read_line(&mut nom).expect("Erreur lors de la lecture");

    print!("Bonjour {}!", nom);
}
```

```cmd
Entrez votre nom :
antoine
Bonjour antoine
!
```

Ici, le println! fait un retour de ligne après affichage. Par contre, l'écriture se fait en dessous, ce n'est pas ce qu'on veut non plus.

Il faut ajouter ce code pour bien faire l'affichage :

```rust
use std::io::Write;
std::io::stdout().flush().unwrap();
```

**use std::io::Write** :

- En Rust, use sert à importer des modules ou des traits.
- Ici, on importe le trait Write du module std::io.
- Pourquoi ? Parce que la méthode .flush() est définie par ce trait.
- Sans cette ligne, le compilateur ne saurait pas que stdout() peut utiliser .flush().

**std::io::stdout().flush().unwrap()** :

- std::io::stdout() donne accès à la sortie standard (stdout), c’est‑à‑dire l’écran.
- .flush() force l’écriture immédiate du contenu du buffer vers l’écran.
- Rust bufferise l’affichage pour des raisons de performance.
- Par défaut, le texte n’est envoyé qu’au moment d’un saut de ligne (\n) ou quand le buffer est plein.
- Avec .flush(), on dit : « Vide le buffer tout de suite, montre le texte maintenant. »

**.unwrap() gère le Result retourné par .flush()**

- Si tout va bien on continue.
- Si une erreur survient le programme s’arrête avec un message d’erreur.
- C’est une façon simple de dire « je ne veux pas gérer l’erreur autrement ».

Il faut comprendre que quand on tape le nom comme antoine et que l'on fait "enter", rust rentre ceci dans la variable nom : **"antoine\n"**

Pour remédier à ce problème, il faut ajouter ce code :

```rust
let nom = nom.trim();
```

Voici le résultat final :

```rust
use std::io;
fn main() {
    let mut nom = String::new();

    print!("Entrez votre nom : ");

    use std::io::Write;
    std::io::stdout().flush().unwrap();

    io::stdin().read_line(&mut nom).expect("Erreur lors de la lecture");

    let nom = nom.trim();

    print!("Bonjour {}!", nom);
}
```

```cmd
Entrez votre nom : antoine
Bonjour antoine!
```

## Fondement: ownership, borrows, lifetime

- **Ownership** : Chaque valeur a un propriétaire unique. Le move transfère la propriété; la copie est explicite (via Copy ou clone()).
- **Borrowing** : &T (immutable borrow) peut avoir plusieurs emprunts simultanés, &mut T (mutable borrow) doit être unique. Cette règle prévient les conflits d'accès condurrent.
- **Lifetime** : Le compilateur infère souvent les durées de vie; l’annotation explicite ('a) garantit que les références ne survivent pas à leurs données.

Exemple de code d'emprun:

```rust
fn main() {
    let a = "hello";
    let b = &a;          // emprunt immuable
    let mut c = String::from("world"); // emprunt mutable unique
    let d = &mut c;
    d.push_str("!");
    // b.push_str(","); peut pas faire ceci puisque c'est une reference non mutable
    println!("bonjour {} {}", b, d);
}
```

```cmd
bonjour hello world!
```

```rust
let mut c = String::from("world");
let d = &mut c;
d.push_str("!");
```

Comme expliquez plus tôt, les variables ne peuvent pas être modifier par défaut, pour être capable de les modifiées, il faut les déclarer avec **mut**. Ensuite, comme avec la déclaration de D, il faut utiliser **&mut** pour prendre la référence de la variable, puis la modifier. Pour ajouter ! on utilise **push_str**. Aussi, on utilise **&** pour pointer vers la référence de la variable comme en C++.

## Source

- https://www.youtube.com/watch?v=ZhedgZtd8gw
- https://rust-lang.org/fr/learn/get-started/
- https://certiquizz.com/fr/cours/programmation/rust/rust-de-zero-a-operationnel/installation-et-configuration-de-l-environnement-de-developpement#:~:text=C%27est%20un%20installateur%20de%20toolchains%20Rust%20qui%20vous,versions%20de%20Rust%20%28stable%2C%20beta%2C%20nightly%29%20si%20n%C3%A9cessaire.
- https://learn.microsoft.com/fr-fr/windows/dev-environment/rust/overview
- https://learn.microsoft.com/en-us/windows/dev-environment/rust/setup
- https://stackoverflow.com/questions/68424927/cargo-missing-from-path-in-vscode-powershell
- https://code.visualstudio.com/docs/terminal/profiles
- https://github.com/microsoft/vscode/issues/212062
- https://github.com/rust-lang/rustup/issues/846
- https://stackoverflow.com/questions/47379214/step-by-step-instruction-to-install-rust-and-cargo-for-mingw-with-msys2
