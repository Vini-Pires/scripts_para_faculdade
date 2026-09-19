#!/bin/bash

# Não pode ter espaços entre o sinal de igual (=)
export TESTE="RODANDO"

export _PASTA_SCRIPTS=$(pwd)/scripts
export _PASTA_CONFIGS=$(pwd)/configs
export _VSCODE=$_PASTA_CONFIGS/vscode

export _GIT_CONFIG="git config --global"
export NOME_GIT="Vinicius Pires | UTFPR"
export EMAIL_GIT="viniciuspires@alunos.utfpr.edu.br"

export _REGISTRO_ALUNO="$(whoami)"
export _HOME_MEDIA="/media/$_REGISTRO_ALUNO/home"
export _KEYS_CUSTOM="$_HOME_MEDIA/configs/ssh"
export _KEYS_DEFAULT="$HOME/.ssh"

# URLs da Fonte Fira Code (Para o Editor)
export _FONT_URL=(

	# Fira Code
	"https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Regular.ttf"
	"https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Bold.ttf"
	"https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Medium.ttf"
	"https://github.com/tonsky/FiraCode/raw/master/distr/ttf/FiraCode-Retina.ttf"
)
export _PASTA_FONT="$HOME/.local/share/fonts"

echo "Variaveis globais prontas"
