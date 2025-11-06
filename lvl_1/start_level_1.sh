#!/usr/bin/bash

gen_rd_file() {
	local name_num="$1"
	local out_dir="${2:-.}"
	local min_size=8
	local max_size=512

	local file_size=$(( RANDOM % (max_size - min_size + 1) + min_size ))
	#echo "$file_size"

	head -c "$file_size" /dev/urandom > "${out_dir}/file_${name_num}"
}

gen_rd_dir() {
    local depth="$1"
	local per_node="${2:-5}"
	local parent_dir="${3:-.}"
	local max_files="${4:-3}"

	# Si profondeur atteinte, on s'arrête
	if (( depth <= 0 )); then
	    return 0
	fi

    # Créer tous les sous-dossiers de ce niveau
	local children=()
    for (( i=1; i<=per_node; i++ )); do
        local dir="${parent_dir}/dir_${i}"
        mkdir -p "${dir}" || return 1

        local n_files=$(( RANDOM % (max_files + 1) ))
        for (( j=1; j<=n_files; j++ )); do
            gen_rd_file "$j" "${dir}" || return 1
        done

        children+=("${dir}")
    done

    # Descendre récursivement dans chacun
    for dir in "${children[@]}"; do
        gen_rd_dir "$(( depth - 1 ))" "$per_node" "$dir" "$max_files"
    done
}

pick_rd_dir() {
    # Choisis un dossier dans "/cabinet" au hasard.
    local root="${1:-./cabinet}"
    mapfile -t dirs < <(find "$root" -mindepth 1 -type d -print)
    if (( ${#dirs[@]} == 0 )); then
        echo "Aucun sous-dossier trouvé sous $root" >&2
        return 1
    fi
    printf '%s\n' "${dirs[RANDOM % ${#dirs[@]}]}"
}


rename_files_random() {
    local root="${1:-./cabinet}"
    # Parcourt tous les fichiers sous root et les renomme en file_<1..512>
    find "$root" -type f -print0 | while IFS= read -r -d '' f; do
        local d n new tries=0
        d="$(dirname "$f")"
        while :; do
            n=$(( RANDOM % 512 + 1 ))
            new="${d}/file_${n}"
            # Si le nouveau nom est identique au nom actuel, ne rien faire
            if [[ "$new" == "$f" ]]; then
                break
            fi
            # Si le nom n'existe pas, on renomme
            if [[ ! -e "$new" ]]; then
                mv -- "$f" "$new" || break
                break
            fi
            # Sinon on retente, et au bout d'un certain nombre d'essais on ajoute un suffixe
            tries=$((tries + 1))
            if (( tries > 100 )); then
                new="${d}/file_${n}_$RANDOM"
                mv -- "$f" "$new" || break
                break
            fi
        done
    done
}

# Reset le niveau si le dossier est déjà existant
if [[ -d "./cabinet" ]]; then
    ./reset_level_1.sh
fi

# Génération de l'arborescence
echo "Creating folders..."
if gen_rd_dir 2 3 "./cabinet" 5; then
    echo "Done."
else
    echo "An error has occured."
fi

# Choix d'un dossier aléatoire et copie du programme1 dedans
random_dir="$(pick_rd_dir "./cabinet")" || exit 1
# echo "Dossier aléatoire choisi: $random_dir"
cp ../assets/l1/p1 "${random_dir}"

# Renommage aléatoire des fichiers
rename_files_random "./cabinet" || { echo "Rename failed."; exit 1; }
echo ""

# Affichage de l'instruction
cat instructions.txt
