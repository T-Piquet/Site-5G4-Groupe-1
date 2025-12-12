---
title: "Laboratoire : Construction d'une Galerie dans Unreal Engine 5"
weight: 30
---

**Objectif Final :** Construire un espace intérieur fermé, l'éclairer avec une lumière ponctuelle, appliquer un matériau bleu clair aux murs, et y disposer une œuvre d'art (sphère) sur un piédestal (cylindre), en utilisant uniquement les formes de base d'UE5.

### Partie 0 : Préparation et Installation

#### 0.0 Installation d’Unreal Engine
1.  Installer Epic Games Launcher : `https://store.epicgames.com/en-US/download`
2.  Créer un compte.
3.  Installer Unreal Engine 5.7.1.
![4, 4, 1](/images/1.png)

#### 0.1. Création du Projet
1.  Lancez la version d'UE5.
2.  Sélectionnez l'onglet **Jeux (Games)**.
3.  Choisissez le modèle **Blank (Vide)**.
4.  Nommez le projet : `Labo`.
5.  Cliquez sur **Créer**.

---

### Partie 1 : Construction de la pièce avec les formes de base

Nous allons utiliser les outils intégrés de l'éditeur pour créer les murs.

#### Exercice 1.1 : Préparation du Sol et des Murs

1.  **Supprimer les lumières déjà présentes** : Dans l'**Outliner** (Explorateur de monde), supprimez les acteurs suivants (si présents) :
    * `DirectionalLight`
    * `Sky Light`
    * `Sky Atmosphere`
    * `Volumetric Cloud`

2.  **Placer le sol** :
    * Dans la barre d'outils, cliquez sur **Quickly Add to Project**.
    * Sélectionnez **Shapes (Formes) > Plane (Plan)**.
    ![4, 4, 1](/images/2.png)
    * Dans le panneau **Details**, assurez-vous que sa **Location (translation)** est réglée sur **X=0, Y=0, Z=0.1**.
    * Réglez l'**Échelle (Scale)** sur **X=4, Y=4 et Z=1**.
    ![4, 4, 1](/images/3.png)

3.  **Placer le premier mur (Cube)** :
    * Cliquez sur Quickly Add to Project &gt; Shapes (Formes) &gt; Cube.
    * Réglez sa **Location (position)** sur **X = 200, Y = 0, Z = 100**.
    * Réglez son **Échelle** : **X = 4.0, Y = 0.1, Z = 2.0**.
    * Réglez la **Rotation** sur **X=0, Y= 0, Z=90**.

#### Exercice 1.2 : Assembler la pièce (Duplication et Rotation)

1.  **Mur 2 (Axe Y Positif) :**
    * Sélectionnez le **Mur 1**.
    * **Dupliquez-le** (Clic Droit -> modifier -> Dupliquer).
    * Réglez sa **Location** sur **X = 0, Y = 200, Z = 100**.
    * Réglez la **Rotation** sur **X=0, Y=0, Z=180**.

2.  **Mur 3 (Axe X Négatif) :**
    * Sélectionnez le **Mur 1**.
    * **Dupliquez-le** (Clic Droit -> modifier -> Dupliquer).
    * Réglez sa **Location** sur **X = -200, Y= 0, Z=100**.
    * Maintenez la **Rotation** sur **X=0, Y=0, Z=90**.

3.  **Mur 4 (Axe Y Négatif) :**
    * Sélectionnez le **Mur 1**.
    * **Dupliquez-le** (Clic Droit -> modifier -> Dupliquer).
    * Réglez la **Location** sur **X=0, Y=-200 et Z= 100**.
    * Maintenez la **Rotation** sur **X=0, Y=0, Z=180**.

> **Vérification :** Vous devez avoir une pièce carrée fermée (un cube ouvert vers le haut) au centre de votre monde.

---

### Partie 2 : Éclairage et Matériaux de Base

#### Exercice 2.1 : Éclairage de la Galerie
1.  Cliquez sur **Quickly Add to Project > Lights (Lumières) > Point Light (Point lumineux)**.
2.  Réglez sa **Location (Position)** : **X=0, Y=0, Z=400**.
3.  Dans la section **Light** du panneau Details, réglez **Intensity (Intensité)** à **15000.0**.
4. Laissez Light Color par défaut
![4, 4, 1](/images/light.png)


#### Exercice 2.2 : Application de Couleurs Simples (Matériaux)

1.  **Créer le Matériau Bleu Clair pour les Murs :**
    * Ouvrez le **Content Drawer**.
    * Cliquez sur **Add > Material (Matériau)**. Nommez-le `M_Mur_Bleu`.
    * **Double-cliquez** sur `M_Mur_Bleu`.
    * Faites un clic droit et tapez **Constant3Vector**.
    * Réglez la couleur sur **Bleu Clair** (valeur : R=0.5, G=0.7, B=1.0).
    * Reliez la sortie de ce nœud **Constant3Vector** à l'entrée **Couleur de base** (Base Color) du nœud principal.
    * Cliquez sur **Apply (Appliquer)**, puis **Save (Sauvegarder)**, puis fermez l'éditeur.
    ![4, 4, 1](/images/5.png)

2.  **Appliquer les Matériaux** :
    * Retournez dans le Viewport.
    * **Sélectionnez chaque mur un par un** et glissez ce nouveau matériau sur chaque mur. Ils devraient tous devenir bleu maintenant.

3.  **Sol de Contraste :**
    * Répétez l'étape 1 pour créer un matériau `M_Sol_Gris` (choisissez une couleur grise foncée).
    * Faites glisser `M_Sol_Gris` sur le sol (le Plane).

---

### Partie 3 : Mise en scène de la galerie

#### Exercice 3.1 : Création d'un Piédestal
1.  Cliquez sur **Quickly Add to Project > Shapes (Formes) > Cylinder (Cylindre)**.
2.  Réglez sa **Location (Translation)** pour qu'il soit au centre de la pièce (X=0, Y=0, Z=50).
3.  Réglez son **Échelle** : X et Y (Diamètre) = 0.5, Z (Hauteur) = 1.0.
4. **Matériau Noir Brillant** : Créez un matériau noir (Base Color = Noir) et réglez la **Rugosité** (Roughness) à 0.0 pour un effet miroir. Appliquez-le au cylindre.
![4, 4, 1](/images/6.png)

#### Exercice 3.2 : L'Œuvre d'Art (Sphère)
1.  Cliquez sur **Quickly Add to Project > Shapes (Formes) > Sphere (Sphère)**.
2.  Utilisez l'outil de **Translation** pour positionner la sphère précisément au-dessus du piédestal (X=0, Y=0).
3.  Sa **Translation Z** devrait être de 140.
4.  Réglez les 3 valeurs de **Échelle** à 0.8.
5. **Matériau Rouge Vif** : Créez un matériau. Réglez la **Base Color** sur Rouge (R=1.0, G=0.0, B=0.0). Ajoutez un nœud **Constant** (valeur 50) et connectez-le à l'entrée **Couleur Émissive** (Emissive Color) pour que l'objet brille comme une source de lumière. Appliquez-le à la sphère.

#### Exercice 3.3 : Test Final
1.  Cliquez sur le bouton **Play (Jouer)** (icône de flèche verte) dans la barre d'outils.
2.  Déplacez-vous dans votre galerie.
3.  Appuyez sur **Échap** pour revenir à l'éditeur.
4.  Cliquez sur **Sauvegarder Tout (Save All)**.
![4, 4, 1](/images/7.png)
---
#### Correction de l'atelier
**Lien Drive :**
https://drive.google.com/file/d/1LNAGcyuj6mv6yPs0nljJTo8d6iRO-4yp/view