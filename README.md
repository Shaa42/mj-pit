# Projet PIT - Mini-Jeu

Ce dépôt contient une série de mini-jeux/salles de défis en ligne de commande. Chaque niveau se trouve dans un dossier `lvl_X` avec ses scripts dédiés (génération, vérification, réinitialisation).

## Prérequis

- Bash (>= 4 recommandé)
- Outils GNU usuels: coreutils (cp, mv, find, grep, awk, sed, tr, od, base64, sha256sum, etc.)
- Git

## Cloner le dépôt

Remplace l’URL par l’adresse de ton dépôt.

```bash
git clone https://github.com/Shaa42/mj-pit.git
cd mj-pit
```

## Installation

Il n’y a pas d’installation spécifique. Assure-toi simplement que les scripts sont exécutables si tu souhaites les lancer directement.

```bash
# Facultatif
chmod +x reset_levels.sh
chmod +x lvl_*/start_level_*.sh
chmod +x lvl_*/reset_level_*.sh
chmod +x lvl_2/morse_decode.sh
```

## Structure du projet

```bash
mj-pit
├── assets                  : ressources partagées (fichiers, clés, programmes)
├── lvl_1                   : scripts du niveau 1
│   ├── reponse.txt
│   ├── reset_level_1.sh
│   ├── start_level_1.sh
│   └── verify_level_1.sh
├── lvl_2                   : scripts du niveau 2
│   ├── morse_decode.sh
│   ├── reponse.txt
│   ├── reset_level_2.sh
│   ├── start_level_2.sh
│   └── verify_level_2.sh
├── lvl_3
├── README.md
└── reset_levels.sh         : lance la réinitialisation de tous les niveaux (depuis leur dossier)
```

## Démarrer un niveau

Depuis la racine du dépôt (`mj-pit/`), `cd` dans le dossier d'un niveau et exécute le script de démarrage d’un niveau:

```bash
# Exemple: niveau 1
cd lvl_1 && ./start_level_1.sh

# Exemple: niveau 2
cd lvl_2 && ./start_level_2.sh
```

## Valider un niveau

Pour valider ta réponse à un niveau, utilise le script de vérification dans le dossier du niveau avec ton fichier `reponse.txt`:

```bash
./verify_level_X.sh reponse.txt
```

## Réinitialiser les niveaux

Pour réinitialiser tous les niveaux (chaque script s’exécute depuis son propre dossier):

```bash
./reset_levels.sh
```

Tu peux aussi réinitialiser un niveau en particulier:

```bash
(cd lvl_1 && ./reset_level_1.sh)
```

## Lore

Tu es un.e pentester engagé.e pour tester la sécurité d'une entreprise high-tech. En explorant leurs systèmes, tu découvres une série de défis conçus pour évaluer tes compétences.

## Règles

L'objectif est de récupérer toutes les clés en complétant chaque niveau.
Pour obtenir une clef, tu devras mettre ta réponse dans le fichier `reponse.txt` de chaque niveau.
Ensuite tu pourras faire vérifier ta réponse avec le script `verify_level_X.sh reponse.txt`.

( Interdiction de regarder le dossier `/assets` please :D )
