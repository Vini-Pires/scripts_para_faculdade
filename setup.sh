#!/bin/bash

. scripts/variables.sh

# Verificar condições de existencia
# . $_PASTA_SCRIPTS/verify_RA.sh || exit 1

echo "Bem-vindo $_REGISTRO_ALUNO!"
echo ""
echo "========================================="
echo "        MENU DE INSTALAÇÃO SETUP         "
echo "========================================="
echo "[ 1 ] Configurar Chaves SSH"
echo "[ 2 ] Configurar Git"
echo "[ 3 ] Configurar VSCodium/VSCode"
echo "[ 4 ] Instalar Fontes (Fira Code/Meslo)"
echo "[ T ] Executar TUDO"
echo "[ 0 ] Sair"
echo "========================================="

# Solicita a entrada do usuário
read -p "Digite os números desejados separados por espaço (ex: 2 4 5): " ESCOLHAS

# Transforma vírgulas em espaços caso você digite "2,4,5" por engano
ESCOLHAS=$(echo "$ESCOLHAS" | tr ',' ' ')

echo "========================================="

# Loop que lê cada número digitado e executa a opção correspondente
for OPCAO in $ESCOLHAS; do
  case $OPCAO in
    1)
      echo "▶ Executando: Configuração de Chaves SSH..."
      . "$_PASTA_SCRIPTS/setup_keys.sh"
      ;;
    2)
      echo "▶ Executando: Configuração do Git..."
      . "$_PASTA_SCRIPTS/setup_git.sh"
      ;;
    3)
      echo "▶ Executando: Configuração do VSCode..."
      . "$_PASTA_SCRIPTS/setup_vscode.sh"
      ;;
    4)
      echo "▶ Executando: Instalação de Fontes..."
      . "$_PASTA_SCRIPTS/install_fonts.sh"
      ;;
    T|t)
      echo "▶ Executando: TODAS as etapas..."
      . "$_PASTA_SCRIPTS/setup_keys.sh"
      . "$_PASTA_SCRIPTS/setup_git.sh"
      . "$_PASTA_SCRIPTS/setup_vscode.sh"
      . "$_PASTA_SCRIPTS/install_fonts.sh"
      # O break interrompe o loop para não executar opções repetidas caso você digite "T 2 4"
      break
      ;;
    0)
      echo "Saindo do setup..."
      exit 0
      ;;
    *)
      echo "⚠ Aviso: A opção [$OPCAO] é inválida e será ignorada."
      ;;
  esac
done

echo "========================================="
echo "          Instalação Concluída           "
echo "========================================="
