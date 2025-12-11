+++
title = "Le language GO"
weight = 2
+++

Ici, on va voir l’utilisation du langage Go pour nous aider à développer des applications efficaces et concurrentes, ce qui n’est qu’un sous-ensemble de tout ce que permet de faire Go dans le monde du développement logiciel.

## c’est quoi Go et pourquoi il existe ?

Go est un langage de programmation compilé, performant et orienté concurrence, qui s’inspire de la simplicité de Pascal et de l’efficacité de C. Il a été créé chez Google par Robert Griesemer, Rob Pike et Ken Thompson, trois ingénieurs reconnus pour leurs travaux sur les systèmes d’exploitation, les compilateurs et le développement de systèmes distribués. Leur objectif était de concevoir un **langage moderne**, **facile à apprendre et capable de gérer efficacement les charges de travail massivement parallèles.**
![alt text](/images/Google.webp)

Go a été **créé pour** rendre la **programmation plus rapide, plus simple et plus efficace**, surtout **dans les projets de grande envergure**. Sa syntaxe minimaliste et ses outils intégrés permettent d’écrire facilement aussi bien des petits programmes ou des scripts que des applications complexes, des services web et des systèmes haute performance.

![alt text](/images/GoLogo.png)

## Un langage simple mais puissant

![alt text](/images/simple.png)

**L’une des grandes forces de Go est sa simplicité**. Contrairement à d’autres langages qui possèdent des dizaines de concepts avancés, Go privilégie une **approche minimaliste.** Il ne propose pas d’héritage complexe, pas de génériques pendant longtemps (introduits seulement en 2022), et limite volontairement les fonctionnalités pouvant rendre un code difficile à comprendre. Cette philosophie se traduit par un **code clair, lisible et facile à maintenir**, ce qui fait de Go un excellent choix pour les équipes qui recherchent une grande productivité. Malgré cette simplicité, Go reste extrêmement puissant grâce à la qualité de ses bibliothèques standard et à son écosystème en constante croissance.

#### Exemple de Hello world en GO VS Java

**GO :**
```go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

**Java**
```java
public class Main {
    public static void main(String[] args) {
        System.out.println("Hello, World!");
    }
}


```

## La concurrence : le cœur de Go

La gestion de la concurrence est probablement l’aspect le plus innovant et distinctif de Go. Alors que les threads traditionnels peuvent être lourds et difficiles à synchroniser, **les goroutines de Go sont très légères et permettent de lancer des milliers de tâches concurrentes en quelques lignes de code.** Leur fonctionnement repose sur un modèle appelé **CSP** (Communicating Sequential Processes), qui encourage la communication sécurisée entre goroutines via des canaux. Grâce à cela, il devient beaucoup plus facile de programmer des serveurs web, des systèmes d’analyse en temps réel ou des microservices capables de traiter simultanément de nombreuses requêtes sans sacrifier les performances.
![alt text](/images/CSP.jpg)

## Compagnie utilisant GO
![alt text](/images/GoCampagnie.png)

## Un langage taillé pour le cloud, DevOps et les microservices

![alt text](/images/DevOps.webp)

Au fil du temps, Go a été largement adopté par les entreprises travaillant dans le cloud et les infrastructures modernes. Des outils majeurs comme Docker, Kubernetes, Terraform, Prometheus et Etcd sont tous écrits en Go, ce qui montre à quel point ce langage est adapté aux environnements critiques nécessitant robustesse et efficacité. **Sa capacité à produire des exécutables statiques, son faible coût en ressources et sa vitesse d’exécution en font un candidat idéal pour créer des microservices, des outils de déploiement ou des systèmes distribués.** Pour un étudiant ou un développeur qui souhaite travailler dans les domaines du backend ou du DevOps, Go représente un atout extrêmement précieux.

## Un écosystème professionnel et un outillage intégré

Contrairement à de nombreux langages qui nécessitent l’installation de frameworks ou d’outils externes, **Go propose dès son installation tout le nécessaire pour développer proprement**. Les commandes comme go fmt, go build, go run ou go test font partie de la boîte à outils du langage et encouragent de bonnes pratiques. Le formateur automatique gofmt, par exemple, garantit un style uniforme dans tous les projets, ce qui améliore la lisibilité et évite les débats inutiles sur la mise en forme du code. Cet outillage intégré simplifie énormément la vie des développeurs et contribue à la réputation de Go comme un langage “prêt à utiliser”.

## Installation sur Linux

Il existe plusieurs façons d’installer Go sur une distribution Linux. On peut utiliser les dépôts officiels (apt install golang), mais la méthode recommandée par l’équipe Go est d’installer la version officielle disponible sur le site de Go. Dans cette section, nous allons voir la méthode la plus simple à mettre en place, compatible avec Ubuntu/Debian et la majorité des distributions Linux.

``` bash
$ sudo apt update
$ sudo apt install golang -y
$ go version
```

Exécuter le fichier
``` bash
go run fichier.go
```
Go est maintenant prêt à être utilisé.

## Premiers tests : Hello World

Une fois Go installé, testons rapidement son fonctionnement avec un programme simple :

Un programme Go se compose généralement :

- d’un package main,

- d’importations de packages standard ou externes,

- d’une fonction main(), point d’entrée du programme.

Créez un fichier hello.go :

``` go
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```
Exécutez-le :

``` bash
$ go run hello.go
```

Ou compilez-le :

``` bash
$ go build hello.go
$ ./hello
```
Si tout fonctionne, Go est correctement installé.

## Les types et les variables en Go

Comme dans la plupart des langages, Go possède des types primitifs (nombres, chaînes, booléens) ainsi que des types plus avancés (tableaux, slices, maps, structures). L’un des objectifs de Go est de rendre ces types simples à utiliser, tout en conservant une grande efficacité lors de l’exécution.

Go est un langage statiquement typé, ce qui veut dire que le type des variables est connu à la compilation. Malgré cela, Go reste très facile à écrire grâce à ses mécanismes d’inférence de type.

> [!info]
> Le mécanisme d’inférence de type:
> 1. L’inférence de type est un mécanisme qui permet à Go de deviner automatiquement le type d’une variable en fonction de la valeur qu’on lui donne.
> 2. Cela permet d’écrire du code plus court, sans perdre les avantages d’un langage statiquement typé.

### Déclaration de variables

Il existe plusieurs façons de déclarer des variables en Go.

##### Déclaration classique


``` go
var x int = 10
```

##### Inférence de type

Go peut déduire automatiquement le type d’une variable :

``` go
x := 10
```

Le symbole := permet de déclarer et d'initialiser en même temps.
C’est la méthode préférée dans les petits programmes car elle est concise.

##### Déclaration multiple

``` go
var a, b, c int = 1, 2, 3
```
ou avec inférence :
``` go
a, b, c := 1, 2, 3
```

### Types de base
Voici les principaux types natifs fournis par Go :

| Type                                      | Description                     |
|-------------------------------------------|---------------------------------|
| `int`, `int8`, `int16`, `int32`, `int64`  | Entiers signés                  |
| `uint`, `uint8`, `uint16`, `uint32`, `uint64` | Entiers non signés          |
| `float32`, `float64`                      | Nombres à virgule               |
| `complex64`, `complex128`                 | Nombres complexes               |
| `bool`                                    | Vrai ou faux                    |
| `string`                                  | Chaîne de caractères UTF-8      |
| `byte`                                    | Alias de `uint8`                |
| `rune`                                    | Caractère Unicode (alias `int32`) |


Exemple :
``` go
var age int = 20
var pi float64 = 3.14
var nom string = "Nikola"
var actif bool = true
```

### Les chaînes de caractères (string)
Les chaînes en Go sont immuables : une fois créées, elles ne peuvent être modifiées. On peut cependant les manipuler en créant de nouvelles chaînes.

``` go
message := "Bonjour"
fmt.Println(message)
```
Pour obtenir la longueur :
``` go
fmt.Println(len(message))

```

#### Les tableaux (Array)

Un tableau possède une taille fixe :

``` go
var notes [3]int = [3]int{12, 15, 18}
```

##### Les slices : le type le plus utilisé en Go

Les slices sont des tableaux dynamiques, beaucoup plus flexibles.
C’est l’un des types les plus importants en Go.

``` go
nombres := []int{1, 2, 3, 4}
fmt.Println(nombres)
```
Ajouter un élément :
``` go
nombres = append(nombres, 5)

```

## Les fonctions en Go

Les fonctions sont au cœur de la programmation en Go.
Comme dans la plupart des langages, elles permettent de regrouper du code réutilisable, mais Go ajoute quelques particularités intéressantes :

- retour de plusieurs valeurs

- paramètres et retours nommés

- fonctions anonymes et closures

- méthodes associées à des types (structs)

### Définition d’une fonction simple

La syntaxe de base d’une fonction en Go est la suivante :

``` go
func nomDeFonction(param1 type1, param2 type2) typeRetour {
    // corps de la fonction
}
```
Exemple :

``` go
func Bonjour(nom string) string {
    message := "Bonjour " + nom
    return message
}

```
Ici :

- func : mot-clé pour définir une fonction

- Bonjour : nom de la fonction

- nom string : paramètre de type string

- string après les parenthèses : type de la valeur de retour

#### Appeler une fonction
``` go
resultat := Bonjour("Nikola")
fmt.Println(resultat) // Affiche : Bonjour Nikola
```

### Retourner plusieurs valeurs

Une particularité très utilisée en Go est la possibilité de retourner plusieurs valeurs.
C’est notamment utilisé pour retourner un résultat et une erreur éventuelle.
``` go
func Diviser(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("division par zéro")
    }
    return a / b, nil
}
```
Utilisation :
``` go
resultat, err := Diviser(10, 2)
if err != nil {
    fmt.Println("Erreur :", err)
} else {
    fmt.Println("Résultat :", resultat)
}
```
Voici le rendu final :
``` bash
Résultat : 5
Erreur : division par zéro
```

### Paramètres nommés et valeurs de retour nommées

Go permet aussi de donner des noms aux valeurs de retour :

``` go
func SommeEtMoyenne(a, b, c int) (somme int, moyenne float64) {
    somme = a + b + c
    moyenne = float64(somme) / 3
    return // retourne somme et moyenne automatiquement
}
```
Ce style n’est pas obligatoire, mais il peut rendre le code plus lisible dans certaines fonctions.

### Passage des paramètres

En Go, les paramètres sont passés par valeur.
Cela signifie que la fonction reçoit une copie des arguments.
Pour modifier une variable en dehors de la fonction, on utilise un pointeur :

Go possède des pointeurs, car ils permettent :

- de modifier une variable depuis une fonction,

- d’optimiser la mémoire,

- d’éviter de copier de grandes structures,

- et de créer des méthodes efficaces sur les structs.

Mais Go ne permet pas l’arithmétique des pointeurs, ce qui évite les erreurs dangereuses (comme en C).

``` go
func Incrementer(x *int) {
    *x = *x + 1
}

func main() {
    valeur := 10
    Incrementer(&valeur)
    fmt.Println(valeur) // Affiche 11
}
```

### Fonctions anonymes et closures

On peut aussi définir des fonctions sans nom, qu’on appelle “fonctions anonymes” :
``` go
func main() {
    saluer := func(nom string) {
        fmt.Println("Bonjour", nom)
    }

    saluer("Alex")
}

```



##### **Comment Go se différencie des autres langages ?**
| Langage       | Fonctionnement                                                                                 | Différence par rapport à Go                                                                                                                           |
| ------------- | ---------------------------------------------------------------------------------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------- |
| **Java / C#** | Les classes doivent déclarer explicitement qu’elles implémentent une interface (`implements`). | Go n’a pas d’héritage et **pas de mot-clé**. L’implémentation est **implicite** : si la méthode existe, l’interface est considérée comme implémentée. |
| **Python**    | Utilise le *Duck Typing* au moment de l’exécution.                                             | Go utilise un *Duck Typing à la compilation*, donc **plus rapide** et **plus sûr** (erreurs détectées avant l’exécution).                             |
| **Rust**      | Utilise des *traits*, puissants mais complexes, souvent combinés avec les génériques.          | Go a un système d’interfaces **plus simple**, sans ownership, sans contraintes avancées.                                                              |
| **C++**       | Utilise des classes virtuelles dans une hiérarchie d’héritage parfois lourde.                  | Go n’a pas de classes ni d’héritage. Les interfaces sont **légères et indépendantes** des structs.                                                    

Go = interfaces minimalistes, implicites, faciles à utiliser, et vérifiées à la compilation.

## La concurrence : goroutines & channels

C’est la plus grande force du langage Go.
Son modèle de concurrence est inspiré du CSP (Communicating Sequential Processes).

#### **Les goroutines**

Une goroutine est une **fonction concurrente ultra légère.**
``` go
go fmt.Println("Bonjour !")

```
**Le mot-clé go → lance la fonction en parallèle du reste du programme.**

Caractéristiques :

- démarre en quelques nanosecondes

- consomme très peu de mémoire (~2 Ko)

- le runtime Go gère automatiquement les threads

Vous pouvez lancer **des milliers** de goroutines sans problème.


### Les interfaces en Go

Une interface en Go sert à définir un comportement.
Si une struct possède la méthode demandée, elle **implémente automatiquement** l’interface, sans mot-clé particulier.

---

#### Exemple très simple

**1. Définir une interface :**

```go
type Parlant interface {
    Parler() string
}
```

Cette interface dit :

> « Tout type qui possède une méthode `Parler()` est considéré comme un Parlant. »

---

**2. Une struct qui correspond à l’interface :**

```go
type Personne struct {
    Nom string
}

func (p Personne) Parler() string {
    return "Bonjour, je m'appelle " + p.Nom
}
```

---

**3. Utilisation de l’interface :**

```go
func main() {
    var p Parlant = Personne{"Alex"}
    fmt.Println(p.Parler())
}
```

**Affichage :**

```bash
Bonjour, je m'appelle Alex
```

---

#### Résumé

* Une interface décrit une ou plusieurs méthodes.
* Une struct l’implémente automatiquement si elle possède ces méthodes.
* Pas besoin d’écrire `implements` : Go le fait de manière implicite.

---

### Conclusion générale sur le langage Go

Go est un langage simple, rapide et efficace, conçu pour aider les développeurs à créer facilement des applications modernes. Il repose sur des principes clairs : une syntaxe minimaliste, des outils intégrés et une gestion de la concurrence extrêmement puissante grâce aux goroutines. Go évite la complexité inutile tout en offrant d’excellentes performances, ce qui en fait un langage agréable à apprendre et à utiliser. Aujourd’hui, Go est largement adopté dans les domaines du cloud, du DevOps et des services web, car il permet de développer des programmes fiables et faciles à maintenir. En résumé, Go est un langage pratique, moderne et parfaitement adapté aux besoins actuels du développement logiciel.

## Source
- https://go.dev/
- https://en.wikipedia.org/wiki/Go_(programming_language)
- https://gobyexample.com/