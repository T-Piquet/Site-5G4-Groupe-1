+++
title = "Solutions"
weight = 3
+++

## Question 1
```Go
package main
import "fmt"

// trouverMaxMin retourne le maximum et le minimum d'un tableau d'entiers de taille 5
func trouverMaxMin(tableau [5]int) (int, int) {
    max := tableau[0]
    min := tableau[0]

    for i := 1; i < len(tableau); i++ {
        if tableau[i] > max {
            max = tableau[i]
        }
        if tableau[i] < min {
            min = tableau[i]
        }
    }

    return max, min
}

func main() {
    nombres := [5]int{4, 45, 73, 59, 33}

    max, min := trouverMaxMin(nombres)

	fmt.Printf("Le nombre maximum est : %v\n", max)
	fmt.Printf("Le nombre minimum est : %v\n", min)
}
```

## Question 2
```Go
package main
import "fmt"

// inverserTab retourne un tableau inversé de taille fixe [4]int
func inverserTab(tableau [4]int) [4]int {
    var tableauInverse [4]int
    for i := 0; i < len(tableau); i++ {
        tableauInverse[i] = tableau[len(tableau)-1-i]
    }
    return tableauInverse
}

func main() {
    nombres := [4]int{1, 2, 3, 4}

    tableauInverse := inverserTab(nombres)

    fmt.Printf("Le tableau inversé est : %v\n", tableauInverse)
}
```

## Question 3
```Go
package main
import "fmt"

func estTrier(tab []int) bool {
	for i := 0; i < len(tab) - 1; i++ {
		if tab[i] > tab[i+1] {
			return false
		}
	}

	return true
}

func main() {
	nombres := []int{1, 2, 2, 3, 5}
	nombres2 := []int{2, 2, 5, 1, 3, 4, 2}

	fmt.Printf("Le tableau est trié ? %v\n", estTrier(nombres))
	fmt.Printf("Le tableau est trié ? %v\n", estTrier(nombres2))
}
```

## Question 4
```Go
package main
import "fmt"

func trouverDeuxiemeMax(tab []int) int {
    if len(tab) < 2 {
        fmt.Println("Le tableau doit contenir au moins deux éléments.")
        return -1
    }

    max, deuxiemeMax := tab[0], tab[0]

    for i := 0; i < len(tab); i++ {
        if tab[i] > max {
            deuxiemeMax = max
            max = tab[i]
        } else if tab[i] > deuxiemeMax && tab[i] != max {
            deuxiemeMax = tab[i]
        }
    }

    return deuxiemeMax
}

func main() {
    var nombre int
    fmt.Print("Combien de nombres allez-vous entrer ? ")
    fmt.Scan(&nombre)

    if nombre < 2 {
        fmt.Println("Il faut au moins 2 nombres.")
        return
    }

    var nombres []int 
    fmt.Println("Entrez les nombres :")
    for i := 0; i < nombre; i++ {
        var num int
        fmt.Scan(&num)
        nombres = append(nombres, num) 
    }

    deuxiemeMax := trouverDeuxiemeMax(nombres)
    if deuxiemeMax != -1 {
        fmt.Printf("Le deuxième plus grand nombre est : %v\n", deuxiemeMax)
    }
}
```

## Question 5
```Go
package main
import "fmt"
import "strings"

func compterVoyelles(mot string) int {
    mot = strings.ToLower(mot)
    voyelles := "aeiouy"
    count := 0

    for i := 0; i < len(mot); i++ {
        for j := 0; j < len(voyelles); j++ {
            if mot[i] == voyelles[j] {
                count++
                break
            }
        }
    }

    return count
}

func main() {
    var mot string
    fmt.Print("Entrez un mot : ")
    fmt.Scanln(&mot)

    fmt.Printf("Nombre de voyelles : %d\n", compterVoyelles(mot))
}
```

## Question 6
```Go
package main

type Vehicule interface {
    ToString() string
}

type Voiture struct {
    Marque string
}

type Camion struct {
    Marque string
}

type Moto struct {
    Marque string
}

func (v Voiture) ToString() string {
    return "Voiture : " + v.Marque
}

func (c Camion) ToString() string {
    return "Camion : " + c.Marque
}

func (m Moto) ToString() string {
    return "Moto : " + m.Marque
}

func main() {
    var v1 Vehicule = Voiture{Marque: "Ferrari"}
    var v2 Vehicule = Camion{Marque: "Mercedes"}
    var v3 Vehicule = Moto{Marque: "Yamaha"}

    println(v1.ToString())
    println(v2.ToString())
    println(v3.ToString())
}

```

## Question 7
```Go
package main
import "fmt"
import "math/rand"

func main() {
    nombre := rand.Intn(100) + 1
    var devine int
    essais := 0

    fmt.Println("Devinez le nombre entre 1 et 100")

    for {
        fmt.Print("Entrez votre réponse : ")
        fmt.Scan(&devine)
        essais++

        if devine < nombre {
            fmt.Println("Plus grand")
        } else if devine > nombre {
            fmt.Println("Plus petit")
        } else {
            fmt.Printf("Vous avez trouvé le nombre %d en %d essais \n", nombre, essais)
            break
        }
    }
}
```