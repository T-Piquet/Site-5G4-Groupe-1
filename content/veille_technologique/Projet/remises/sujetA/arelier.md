+++
title = "Exercices"
weight = 3
+++

## Question 1
**Trouver le maximum et le minimum d'un tableau**

Écrivez une fonction en Go qui retourne **le plus grand** et **le plus petit élément** d’un tableau de taille fixe de 5 entiers.

**Par exemple :**
```
Données : {4, 45, 73, 59, 33}
Sortie : max = 73, min = 4
```

## Question 2
**Inverser un tableau**

Écrivez une fonction pour inverser les données d'un tableau fixe de taille 4

**Par exemple :**
```
Données : {1, 2, 3, 4}
Sortie : {4, 3, 2, 1}
```

## Question 3
**Vérifier si un tableau est trié**

Écrivez une function pour vérifier si le tableau est trié ou pas

**Exemples :**
```
Données : {1, 2, 2, 3, 5}
Sortie : true

Entrée : {2, 2, 5, 1, 3}
Sortie : false
```

## Question 4
**Trouver l'élément le deuxième plus grand**

Écrivez une fonction Go qui retourne le deuxième plus grand nombre du tableau.
- Le tableau n'a pas de taille fixe et est rempli par l'utilisateur
- Taille minimum du tableau : 2

**Par exemple :**
```
Entrée : {10, 5, 20, 8}
Sortie : 10
```

## Question 5
**Compter les voyelles dans un mot**

Écrivez une fonction qui retourne le nombre de voyelles dans un mot.

**Par exemple :**
```
Entrée utilisateur : mot = "Hello"
Sortie : 2
```

## Question 6
**Compléter le code**

Utilisez des structs et une interface pour compléter le code
- Créer une interface Vehicule qui déclare la méthode ToString().
- Créer les 3 structs : Voiture, Camion et Moto. 
- Créer les fonctions ToString() pour chaque objet. Celle-ci retourne la marque du vehicule.

**La Fonction Main**
```Go
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
**Jeu : Deviner le Nombre**

Créez un jeu où un nombre aléatoire entre 1 et 100 est généré. Le but pour l'utilisateur est de deviner ce nommbre.
Après chaque réponse, le programme indique si le nombre à deviner est plus grand ou plus petit.
Le nombre d'essaie doit être compter par le programme.

**Par exemple :**
```
Entrez votre réponse : 11
Plus grand
Entrez votre réponse : 20
Plus petit
Entrez votre réponse : 15
Plus petit
Entrez votre réponse : 13
Vous avez trouvé le nombre 13 en 4 essais 
```

[Solution des ateliers](https://github.com/MansouriE/GO_SOLUTIONS)