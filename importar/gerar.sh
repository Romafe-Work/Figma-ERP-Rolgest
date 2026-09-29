#!/usr/bin/env bash
# =========================================================
# ROLGEST — gerar o que se importa
#
#   01-ecra-entrada.png   o ecrã a 1440×900, para ver e para colar
#   01-ecra-entrada.pdf   o mesmo em vetor, para o Canva e o Figma
#
# Uma só fonte: o `web/index.html`. Mudar um token, um texto ou uma peça e
# voltar a correr. O `#so=ecra` tira a moldura do editor da fotografia.
# =========================================================
set -euo pipefail
cd "$(dirname "$0")"
CH=$(ls ~/.cache/ms-playwright/chromium_headless_shell-*/*/chrome-headless-shell | head -1)
INDEX="$(cd ../web && pwd)/index.html"

correr() { "$CH" --no-sandbox --disable-gpu --hide-scrollbars --virtual-time-budget=5000 "$@" >/dev/null 2>&1; }

correr --window-size=1440,900 --screenshot="$PWD/01-ecra-entrada.png" "file://$INDEX#so=ecra"
correr --no-pdf-header-footer --print-to-pdf="$PWD/01-ecra-entrada.pdf" "file://$INDEX#so=ecra"

ls -la 01-ecra-entrada.png 01-ecra-entrada.pdf
