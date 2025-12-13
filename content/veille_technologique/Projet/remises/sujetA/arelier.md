+++
title = "Atelier"
weight = 3
+++

Votre atelier, avec un éventuelle lien vers un repos git.

## Objectif

L’idée est de te faire expérimenter différents aspects du langage.

## Bases et syntaxe

**Objectif** : se familiariser avec la syntaxe, les variables, les fonctions, et les structures de contrôle.

Ici nous allons écrire un programme qui vérifie si un nombre est pair ou impaire. Chaque fois que l'utilisateur va écrire un nombre, on va faire la vérification, mais s'il écrit Q ou q et va quitter et s'il écrit une autre chose le programme ne fait rien et redemande un nombre.

**La difficulté** ici est l'affichage, la gestion de la boucle et la transformation de **string à i32**.

**Ceci devrait vous prendre 1h**

Vous devrez utiliser ceci, loop est la boucle et match est pour la conversion :

```rust
flush()
unwrap()
trim()
eq_ignore_ascii_case()
//...
loop{
    match  {
                Ok() => {

                }Err(_) => {

                }
            }
}
```

Voici ce que votre interface doit ressembler :

```cmd
Entrez un nombre (Q pour quitter): 2
2 est pair
Entrez un nombre (Q pour quitter): 3
3 est impaire
Entrez un nombre (Q pour quitter): 4
4 est pair
Entrez un nombre (Q pour quitter): bonjour
bonjour n'est pas une valeur valide
Entrez un nombre (Q pour quitter): salut
salut n'est pas une valeur valide
Entrez un nombre (Q pour quitter): ew42
ew42 n'est pas une valeur valide
Entrez un nombre (Q pour quitter): 234
234 est pair
Entrez un nombre (Q pour quitter): q
Au revoir
```

> [!warning]- Réponse
>
> ```rust
> use std::{i32, io};
> fn main() {
>        loop {
>
>           let mut nb = String::new();
>
>           print!("Entrez un nombre (Q pour quitter): ");
>
>           use std::io::Write;
>           std::io::stdout().flush().unwrap();
>
>           io::stdin().read_line(&mut nb).unwrap();
>
>           let nb = nb.trim(); // on fait trim ici pour enlever le \n pour la verification, vue dans les notes de cours
>
>           if nb.eq_ignore_ascii_case("Q") { // fait la verification de la lettre q sans prendre compte de la majuscule
>
>              println!("Au revoir");
>              break; // met fin a la boucle
>           }
>
>           match nb.parse::<i32>() { // convertit nb en entier i32
>              Ok(nb) => { // s'il n'y a pas d'erreur
>                 if nb % 2 == 0 {
>                    println!("{} est pair", nb);
>               }else {
>                  println!("{} est impair", nb);
>               }
>               }Err(_) => { // s'il y a une erreur, dans notre cas, si ce n'est pas un entier
>                   println!("{} n'est pas une valeur valide", nb);
>               }
>           }
>       }
>   }
> ```

## Utilisation de tableau

**Objectif** : apprendre à utiliser les talbeaux

Ici aussi on va faire une boucle avec **loop**. On va faire trois manipulation avec le tableau, on va ajouter, supprimer et afficher les données du tableaux. On va faire un programme qui va donner 4 choix à l'utilisateur, 1. ajouter, 2. afficher, 3. supprimer et 4. quitter.

**La difficulté** ici est la manipulation d'un tableau, bien gérer les erreurs et faire la gesiton des différents choix **string à i32**.

**Ceci devrait vous prendre environ 1h30**

Voici un exemple d'affichage :

```cmd
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 1
Entrez la tâche : allo
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 1
Entrez la tâche : bonjour
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 2
Affihcer des tâches :
1: allo
2: bonjour
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 3
Entrez l’index de la tâche à supprimer : 1
Tâche supprimée.
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 2
Affihcer des tâches :
1: bonjour
--- Menu ---
1. Ajouter une tâche
2. Afficher les tâches
3. Supprimer une tâche
4. Quitter
Entrez votre choix : 4
```

Pour vous aidez je vais vous fournir un code de départ :

Vous allez avoir besoins d'utiliser ceci :

```rust
// iter parcourt les éléments d'un tableau et fournit des références et enumerate prend ceci et ajoute une valeur avec l'index
iter().enumerate()
match choix {}
for (index, valeur) in /**il faut quelque chose ici */ {}
```

```rust
fn main() {
    let mut taches: Vec<String> = Vec::new();

        let mut choix = String::new();
        use std::io::Write;

        println!("--- Menu ---");
        println!("1. Ajouter une tâche");
        println!("2. Afficher les tâches");
        println!("3. Supprimer une tâche");
        println!("4. Quitter");

        print!("Entrez votre choix : ");
}
```

> [!warning]- Réponse
>
> ```rust
> use std::io;
> fn main() {
>   let mut taches: Vec<String> = Vec::new();
>
>   loop {
>      let mut choix = String::new();
>      use std::io::Write;
>
>       println!("--- Menu ---");
>       println!("1. Ajouter une tâche");
>       println!("2. Afficher les tâches");
>       println!("3. Supprimer une tâche");
>       println!("4. Quitter");
>
>       print!("Entrez votre choix : ");
>
>       std::io::stdout().flush().unwrap();
>
>       io::stdin().read_line(&mut choix).unwrap();
>       let choix = choix.trim();
>
>       // ici match est comme un switch case
>       match choix {
>           "1" => {
>               print!("Entrez la tâche : ");
>
>               let mut new = String::new();
>               std::io::stdout().flush().unwrap();
>
>               io::stdin().read_line(&mut new).unwrap();
>
>               taches.push(new.trim().to_string());
>           }
>           "2" => {
>               println!("Affihcer des tâches : ");
>               // ici iter parcourt les éléments d'un tableau et fournit des références et enumerate prend ceci et ajoute une valeur avec l'index
>               for (i, tache) in taches.iter().enumerate() {
>                   println!("{}: {}", i + 1, tache);
>               }
>           }
>           "3" => {
>               print!("Entrez l’index de la tâche à supprimer : ");
>
>               std::io::stdout().flush().unwrap();
>               let mut index = String::new();
>
>               io::stdin().read_line(&mut index).unwrap();
>
>               // ici on utilise Ok pour verifier si la convertion ver usize est reussi
>               // ici on converti en usize qui est un entier toujours positif pour des longueurs de tableau
>               if let Ok(i) = index.trim().parse::<usize>() {
>                   if i - 1 < taches.len() {
>                       taches.remove(i - 1);
>                       println!("Tâche supprimée.");
>                   } else {
>                       println!("Index invalide.");
>                   }
>               }
>           }
>           "4" => break,
>           _ => println!("Choix invalide."),
>       }
>    }
> }
> ```
