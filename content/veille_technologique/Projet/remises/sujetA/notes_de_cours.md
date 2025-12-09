+++
title = "Notes de cours : Voice-to-Text"
weight = 2
+++

## Introduction
Voice to text

C'est quoi?

Voice to text (ou reconnaissance automatique de la parole) est le processus qui analyse et convertis les mots qui sont prononcés oralement en texte lisible par une machine.

Comment ça fonctionne?

Voice to text fonctionne en trois étapes:
    1. Enregistrement de la parole:
        La langue parlé est capturé par le système par une source audio. Par example, un microphone.
    2. Traitement de la parole:
        L'enregistement vocal est nettoyé des bruits indésirables dans l'audio. Un algorithme analyse les caractéristiques phonétiques et phonémiques de la parole pour identifier des mots individuels en comparant ces caractéristiques avec celles des autres modèles préalablement entraînés.
    3. Génération de de texte:
        Le système convertit les sons reconnus en texte.

![ImageFonction](../../images/fonction.jpg)

La reconnaissance vocale est souvent traitée dans le middleware.

Humain -> Hardware(Input) -> Middleware -> Hardware(Output) -> Humain

![ImageMiddleware](../../images/middleware.png)

Example: On parle(humain) dans un microphone(input) et ça transforme en texte(middleware) sur notre écran(output) qu'on voit(humain).

## Taux d'Erreur de Mots (TEM)

La reconnaissance automatique de la parole n'est pas parfait. Le Taux d'Erreur de Mots (TEM) indique la précision du système automatique de la parole. Il compare les erreurs comme les mots omis, ajoutés et mal reconnus avec le nombre de mots prononcés. Plus que cette valeur est basse, plus la précison du système de reconnaissance automatique de la parole est élevée. Par example, si on on a un taux d'erreur de 14%, la précision de la transcription est de 86%.

## Source
- https://www.ionos.fr/digitalguide/sites-internet/developpement-web/automatic-speech-recognition/
- https://www.ibm.com/fr-fr/think/topics/speech-to-text
- https://fr.wikipedia.org/wiki/Reconnaissance_automatique_de_la_parole