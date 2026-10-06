#!/usr/bin/env bash
# =========================================================
# ROLGEST — gerar o que se importa
#
#   NN-<ecrã>.png    cada ecrã a 1440×900, para ver e para colar
#   NN-<ecrã>.pdf    o mesmo em vetor, para o Canva e o Figma
#   00-fluxo.png     o mapa de navegação, com as setas
#
# Uma só fonte: o `web/index.html`. Mudar um token, um texto ou uma peça e
# voltar a correr. O `#so=ecra` tira a moldura do editor da fotografia, e
# o `&ecra=` escolhe o ecrã. Os ecrãs saem pela ordem do index.html.
# =========================================================
set -euo pipefail
cd "$(dirname "$0")"
CH=$(ls ~/.cache/ms-playwright/chromium_headless_shell-*/*/chrome-headless-shell | head -1)
INDEX="$(cd ../web && pwd)/index.html"

correr() { "$CH" --no-sandbox --disable-gpu --hide-scrollbars --virtual-time-budget=5000 "$@" >/dev/null 2>&1; }

# os nomes de ficheiro antigos do ecrã de entrada
rm -f 01-ecra-entrada.png 01-ecra-entrada.pdf

n=0
for e in $(grep -o 'data-ecra="[^"]*"' "$INDEX" | cut -d'"' -f2); do
  n=$((n + 1)); f=$(printf '%02d-%s' "$n" "$e")
  correr --window-size=1440,900 --screenshot="$PWD/$f.png" "file://$INDEX#so=ecra&ecra=$e"
  correr --no-pdf-header-footer --print-to-pdf="$PWD/$f.pdf" "file://$INDEX#so=ecra&ecra=$e"
  echo "$f"
done

correr --window-size=2600,3500 --screenshot="$PWD/00-fluxo.png" "file://$INDEX#so=fluxo"
echo 00-fluxo
