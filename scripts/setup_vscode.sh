#!/bin/bash

# Mapeia os comandos dos editores para suas respectivas pastas no ~/.config
declare -A EDITORES=(
  ["code"]="Code"
  ["codium"]="VSCodium"
)

# Detecta o terminal padrão do sistema para abrir a nova janela
if command -v ptyxis &> /dev/null; then
  TERM_EXEC="ptyxis --"
elif command -v kgx &> /dev/null; then
  TERM_EXEC="kgx -e"
elif command -v gnome-terminal &> /dev/null; then
  TERM_EXEC="gnome-terminal --"
else
  TERM_EXEC="" # Fallback: se não achar nenhum, roda na janela atual
fi

EDITORES_ENCONTRADOS=0

echo "Verificando editores de código instalados..."

if [ ! -f "$_VSCODE/extensions.txt" ]; then
  echo "⚠ Aviso: extensions.txt não encontrado em $_VSCODE. As extensões não serão instaladas."
fi

for CMD in "${!EDITORES[@]}"; do
  if command -v "$CMD" &> /dev/null; then
    echo "▶ Detectado: $CMD"
    EDITORES_ENCONTRADOS=$((EDITORES_ENCONTRADOS + 1))

    CONFIG_DIR="$HOME/.config/${EDITORES[$CMD]}/User"
    mkdir -p "$CONFIG_DIR"

    echo "  - Criando links simbólicos para configurações do $CMD..."
    ln -sf "$_VSCODE/settings.json" "$CONFIG_DIR/settings.json"
    ln -sf "$_VSCODE/keybindings.json" "$CONFIG_DIR/keybindings.json"

    if [ -f "$_VSCODE/extensions.txt" ]; then
      if [ -n "$TERM_EXEC" ]; then
        echo "  - Abrindo nova janela para instalar extensões do $CMD..."
        $TERM_EXEC bash -c "
          echo '========================================='
          echo '   Instalando extensões para: $CMD'
          echo '========================================='

          cat '$_VSCODE/extensions.txt' | xargs -L 1 $CMD --install-extension

          echo '========================================='
          echo 'Instalação concluída com sucesso!'
          echo 'Pressione ENTER para fechar esta janela.'
          read
        "
      else
        # Caso esteja rodando via SSH ou num ambiente sem interface gráfica conhecida
        echo "  - Terminal externo não detectado. Instalando extensões na janela atual..."
        cat "$_VSCODE/extensions.txt" | xargs -L 1 "$CMD" --install-extension
      fi
    fi
  fi
done

if [ "$EDITORES_ENCONTRADOS" -eq 0 ]; then
  echo "✖ Nenhum editor (VS Code ou VSCodium) foi encontrado no sistema."
  return 1
else
  echo "✔ Configuração de editores finalizada com sucesso."
fi
