#!/usr/bin/bash

set -euo pipefail

# Évite que les motifs non-matches restent littéraux
shopt -s nullglob

# Récupère et trie naturellement les scripts (lvl_2 avant lvl_10)
mapfile -t scripts < <(printf '%s\n' ./lvl_*/reset_level_*.sh | sort -V)

if (( ${#scripts[@]} == 0 )); then
  echo "Aucun script de reset trouvé."
  exit 0
fi

ran=0
failed=0

for script in "${scripts[@]}"; do
  echo ">>> Running: $script"
  script_dir="$(dirname "$script")"
  script_base="$(basename "$script")"
  if ( cd "$script_dir" && bash "./$script_base" ); then
    ran=$((ran + 1))
  else
    echo "!!! Failed: $script"
    failed=$((failed + 1))
  fi
done

# Restaure le comportement par défaut
shopt -u nullglob

echo "Terminé. Exécutés: $ran, Echecs: $failed"
exit $(( failed > 0 ? 1 : 0 ))
