#!/usr/bin/env bash
PORT="${1:-9001}"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "================================================"
echo " Songoo — WASM Runner"
echo "================================================"
echo ""
echo " Server: http://localhost:$PORT/Songoo.html"
echo " CTRL+C to stop."
echo ""

cd "$SCRIPT_DIR" || { echo "Erreur : impossible d'accéder à $SCRIPT_DIR"; exit 1; }

# Vérifier que le fichier HTML existe
if [ ! -f "Songoo.html" ]; then
    echo "Erreur : fichier Songoo.html introuvable dans $SCRIPT_DIR"
    echo "Assurez-vous que la compilation WebAssembly a réussi."
    exit 1
fi

# Lancer le navigateur après un délai
( sleep 1; xdg-open "http://localhost:$PORT/Songoo.html" 2>/dev/null || open "http://localhost:$PORT/Songoo.html" 2>/dev/null ) &

# Démarrer le serveur HTTP
if command -v python3 &>/dev/null; then
    python3 -m http.server "$PORT"
elif command -v python &>/dev/null; then
    python -m http.server "$PORT"
else
    echo "Erreur : Python introuvable."
    exit 1
fi
