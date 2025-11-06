#!/usr/bin/bash

verifiy_file() {
    # Récupère les fichiers
    local in_file="$1"
    local key_file="../assets/l2/k2"

    # Récupère les clefs sha256
    local shasum_in="$( cat "$in_file" | tr -d \t\r\n | sha256sum | awk '{print $1}' )"
    # echo "$shasum_in" # Debug
    local shasum_key="$( tr -d \t\r\n < "$key_file" )"

    # Si égale alors retourne vrai
    if [[ "$shasum_in" == "$shasum_key" ]]; then
        return 0
    # Sinon retourne faux
    else
        return 1
    fi
}

input_file="$1"
if [ -z "$input_file" ]; then
    echo "Erreur: pas de fichier fournis en entrée." >&2
fi

if verifiy_file "$input_file"; then
    echo "Niveau 2 terminé avec succès !"
    exit 0
else
    echo "Échec de la vérification du niveau 1." >&2
    exit 1
fi
