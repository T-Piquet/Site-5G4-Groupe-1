+++
title = "Le language GO"
weight = 2
+++

Ici, on va voir l’utilisation du langage Go pour nous aider à développer des applications efficaces et concurrentes, ce qui n’est qu’un sous-ensemble de tout ce que permet de faire Go dans le monde du développement logiciel.

## c’est quoi Go et pourquoi il existe ?

Go est un langage de programmation compilé, performant et orienté concurrence, qui s’inspire de la simplicité de Pascal et de l’efficacité de C. Il a été créé chez Google par Robert Griesemer, Rob Pike et Ken Thompson, trois ingénieurs reconnus pour leurs travaux sur les systèmes d’exploitation, les compilateurs et le développement de systèmes distribués. Leur objectif était de concevoir un langage moderne, facile à apprendre et capable de gérer efficacement les charges de travail massivement parallèles.
![alt text](/images/Google.webp)

Go a été créé pour rendre la programmation plus rapide, plus simple et plus efficace, surtout dans les projets de grande envergure. Sa syntaxe minimaliste et ses outils intégrés permettent d’écrire facilement aussi bien des petits programmes ou des scripts que des applications complexes, des services web et des systèmes haute performance.

![alt text](/images/GoLogo.png)

## Un langage simple mais puissant

![alt text](/images/simple.png)

L’une des grandes forces de Go est sa simplicité. Contrairement à d’autres langages qui possèdent des dizaines de concepts avancés, Go privilégie une approche minimaliste. Il ne propose pas d’héritage complexe, pas de génériques pendant longtemps (introduits seulement en 2022), et limite volontairement les fonctionnalités pouvant rendre un code difficile à comprendre. Cette philosophie se traduit par un code clair, lisible et facile à maintenir, ce qui fait de Go un excellent choix pour les équipes qui recherchent une grande productivité. Malgré cette simplicité, Go reste extrêmement puissant grâce à la qualité de ses bibliothèques standard et à son écosystème en constante croissance.

#### Exemple de Hello world en GO VS assembleur x86

**GO :**
```
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```

**Assembleur x86 :**
```
section .data
    msg db "Hello, World!", 0x0A  ; le texte à afficher, suivi d’un saut de ligne
    len equ $ - msg               ; longueur du texte

section .text
    global _start                 ; point d’entrée du programme

_start:
    ; appel système write(1, msg, len)
    mov eax, 4                    ; 4 = numéro de l’appel système write
    mov ebx, 1                    ; 1 = sortie standard (stdout)
    mov ecx, msg                  ; adresse du message
    mov edx, len                  ; longueur du message
    int 0x80                      ; interruption pour appeler le noyau Linux

    ; appel système exit(0)
    mov eax, 1                    ; 1 = numéro de l’appel système exit
    mov ebx, 0                    ; code de retour 0
    int 0x80

```

## La concurrence : le cœur de Go

La gestion de la concurrence est probablement l’aspect le plus innovant et distinctif de Go. Alors que les threads traditionnels peuvent être lourds et difficiles à synchroniser, les goroutines de Go sont très légères et permettent de lancer des milliers de tâches concurrentes en quelques lignes de code. Leur fonctionnement repose sur un modèle appelé CSP (Communicating Sequential Processes), qui encourage la communication sécurisée entre goroutines via des canaux. Grâce à cela, il devient beaucoup plus facile de programmer des serveurs web, des systèmes d’analyse en temps réel ou des microservices capables de traiter simultanément de nombreuses requêtes sans sacrifier les performances.

## Compagnie utilisant GO
![alt text](/images/GoCampagnie.png)

## Un langage taillé pour le cloud, DevOps et les microservices

![alt text](/images/DevOps.webp)

Au fil du temps, Go a été largement adopté par les entreprises travaillant dans le cloud et les infrastructures modernes. Des outils majeurs comme Docker, Kubernetes, Terraform, Prometheus et Etcd sont tous écrits en Go, ce qui montre à quel point ce langage est adapté aux environnements critiques nécessitant robustesse et efficacité. Sa capacité à produire des exécutables statiques, son faible coût en ressources et sa vitesse d’exécution en font un candidat idéal pour créer des microservices, des outils de déploiement ou des systèmes distribués. Pour un étudiant ou un développeur qui souhaite travailler dans les domaines du backend ou du DevOps, Go représente un atout extrêmement précieux.

## Un écosystème professionnel et un outillage intégré

Contrairement à de nombreux langages qui nécessitent l’installation de frameworks ou d’outils externes, Go propose dès son installation tout le nécessaire pour développer proprement. Les commandes comme go fmt, go build, go run ou go test font partie de la boîte à outils du langage et encouragent de bonnes pratiques. Le formateur automatique gofmt, par exemple, garantit un style uniforme dans tous les projets, ce qui améliore la lisibilité et évite les débats inutiles sur la mise en forme du code. Cet outillage intégré simplifie énormément la vie des développeurs et contribue à la réputation de Go comme un langage “prêt à utiliser”.

## Installation sur Linux

Il existe plusieurs façons d’installer Go sur une distribution Linux. On peut utiliser les dépôts officiels (apt install golang), mais la méthode recommandée par l’équipe Go est d’installer la version officielle disponible sur le site de Go. Dans cette section, nous allons voir la méthode la plus simple à mettre en place, compatible avec Ubuntu/Debian et la majorité des distributions Linux.

``` bash
$ sudo apt update
$ sudo apt install golang -y
$ go version
```
Go est maintenant prêt à être utilisé.

## Premiers tests : Hello World

Une fois Go installé, testons rapidement son fonctionnement avec un programme simple :

Un programme Go se compose généralement :

- d’un package main,

- d’importations de packages standard ou externes,

- d’une fonction main(), point d’entrée du programme.

Créez un fichier hello.go :

``` 
package main

import "fmt"

func main() {
    fmt.Println("Hello, World!")
}
```
Exécutez-le :

``` 
$ go run hello.go
```

Ou compilez-le :

``` 
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

l existe plusieurs façons de déclarer des variables en Go.

##### Déclaration classique


``` 
var x int = 10
```

##### Inférence de type

Go peut déduire automatiquement le type d’une variable :

``` 
x := 10
```

Le symbole := permet de déclarer et d'initialiser en même temps.
C’est la méthode préférée dans les petits programmes car elle est concise.

##### Déclaration multiple

``` 
var a, b, c int = 1, 2, 3
```
ou avec inférence :
``` 
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
``` 
var age int = 20
var pi float64 = 3.14
var nom string = "Nikola"
var actif bool = true
```

### Les chaînes de caractères (string)
Les chaînes en Go sont immuables : une fois créées, elles ne peuvent être modifiées. On peut cependant les manipuler en créant de nouvelles chaînes.

``` 
message := "Bonjour"
fmt.Println(message)

```
Pour obtenir la longueur :
``` 
fmt.Println(len(message))

```

#### Les tableaux (Array)

Un tableau possède une taille fixe :

``` 
var notes [3]int = [3]int{12, 15, 18}
```

##### Les slices : le type le plus utilisé en Go

Les slices sont des tableaux dynamiques, beaucoup plus flexibles.
C’est l’un des types les plus importants en Go.

``` 
nombres := []int{1, 2, 3, 4}
fmt.Println(nombres)
```
Ajouter un élément :
``` 
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

``` 
func nomDeFonction(param1 type1, param2 type2) typeRetour {
    // corps de la fonction
}
```
Exemple :

``` 
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
``` 
resultat := Bonjour("Nikola")
fmt.Println(resultat) // Affiche : Bonjour Nikola
```

### Retourner plusieurs valeurs

Une particularité très utilisée en Go est la possibilité de retourner plusieurs valeurs.
C’est notamment utilisé pour retourner un résultat et une erreur éventuelle.
``` 
func Diviser(a, b float64) (float64, error) {
    if b == 0 {
        return 0, fmt.Errorf("division par zéro")
    }
    return a / b, nil
}
```
Utilisation :
``` 
resultat, err := Diviser(10, 2)
if err != nil {
    fmt.Println("Erreur :", err)
} else {
    fmt.Println("Résultat :", resultat)
}
```
Si la fonction ne retourne rien, on utilise simplement :
``` 
func AfficherMessage(msg string) {
    fmt.Println(msg)
}

```
### Paramètres nommés et valeurs de retour nommées

Go permet aussi de donner des noms aux valeurs de retour :

``` 
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

``` 
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
``` 
func main() {
    saluer := func(nom string) {
        fmt.Println("Bonjour", nom)
    }

    saluer("Alex")
}

```
Une closure est une fonction anonyme qui capture des variables extérieures :
``` 
func Compteur() func() int {
    x := 0
    return func() int {
        x++
        return x
    }
}

func main() {
    c := Compteur()
    fmt.Println(c()) // 1
    fmt.Println(c()) // 2
    fmt.Println(c()) // 3
}
```
Ici, la fonction interne garde en mémoire la variable x même après la fin de Compteur().

### Exemple complet
``` 
package main

import (
    "fmt"
)

// Fonction qui calcule la somme de deux entiers
func Somme(a, b int) int {
    return a + b
}

// Fonction qui retourne le minimum et le maximum d'un slice
func MinMax(valeurs []int) (min int, max int) {
    if len(valeurs) == 0 {
        return 0, 0
    }
    min, max = valeurs[0], valeurs[0]
    for _, v := range valeurs {
        if v < min {
            min = v
        }
        if v > max {
            max = v
        }
    }
    return
}

func main() {
    fmt.Println("Somme :", Somme(3, 4))

    nombres := []int{5, 2, 9, 1, 7}
    min, max := MinMax(nombres)
    fmt.Println("Min :", min, "Max :", max)
}
```

## Les interfaces en Go

Les interfaces sont un concept central du langage Go.
Elles permettent de définir un comportement plutôt qu’une structure.
Une interface contient uniquement des méthodes, sans implémentation.

##### Exemple simple
``` 
type Parlant interface {
    Parler() string
}

type Personne struct {
    Nom string
}

func (p Personne) Parler() string {
    return "Bonjour, je m'appelle " + p.Nom
}

```
Ici, Personne **implémente automatiquement** l’interface Parlant parce qu’elle possède une méthode Parler().

**Pas besoin d’un mot-clé** implements
→ Contrairement à Java, TypeScript, C#, Rust, etc.

###### **Pourquoi c’est important ?**

- Permet un encapsulation très légère

- Favorise le polymorphisme sans héritage

- Évite les hiérarchies de classes compliquées

- Très utile pour les tests (mocking facile)

##### **Comment Go se différencie des autres langages ?**

| Langage       | Fonctionnement                       | Différence par rapport à Go                                           |
| ------------- | ------------------------------------ | --------------------------------------------------------------------- |
| **Java / C#** | Interfaces explicites (`implements`) | Go n’a **pas d’héritage**, implementation **implicite**               |
| **Python**    | Duck typing runtime                  | Go a un **duck typing à compilation** : rapide et sûr                 |
| **Rust**      | Traits                               | Très similaire, mais Rust est plus complexe (génériques obligatoires) |
| **C++**       | Classes virtuelles                   | Plus lourd, lié aux `class`, pas simple comme Go                      |

Go = interfaces minimalistes, implicites, et faciles à utiliser.

## La concurrence : goroutines & channels

C’est la plus grande force du langage Go.
Son modèle de concurrence est inspiré du CSP (Communicating Sequential Processes).

#### **Les goroutines**

Une goroutine est une **fonction concurrente ultra légère.**
``` 
go fmt.Println("Bonjour !")

```
Caractéristiques :

- démarre en quelques nanosecondes

- consomme très peu de mémoire (~2 Ko)

- le runtime Go gère automatiquement les threads

Vous pouvez lancer **des milliers** de goroutines sans problème.

#### Les channels : communiquer en sécurité

Les channels permettent de communiquer entre goroutines :
``` 
c := make(chan int)

go func() {
    c <- 10
}()

val := <-c
fmt.Println(val)

```
Avantages :

- synchronisation simple

- évite les verrous (mutex)

- pensée “communication-first” plutôt que “mémoire partagée”

**Go = parallélisme simple, performant, et accessible.**