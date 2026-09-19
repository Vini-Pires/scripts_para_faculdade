#!/bin/bash

if [ ! -d "$_KEYS_CUSTOM" ]; then
	echo "Pasta de chaves não encontradas"
	return 1
fi

if [ -z "$(ls "$_KEYS_CUSTOM")" ]; then
	echo "Não há chave armazenadas em $_KEYS_CUSTOM"
	echo "Abortando..."
	return 1
fi

mkdir -p "$_KEYS_DEFAULT"
chmod 700 "$_KEYS_DEFAULT"

cp -t "$_KEYS_DEFAULT" "$_KEYS_CUSTOM"/*

chmod 600 "$_KEYS_DEFAULT"/*
chmod 644 "$_KEYS_DEFAULT"/*.pub 2>/dev/null
chmod 644 "$_KEYS_DEFAULT"/know* 2>/dev/null

echo "Chaves copiadas e permissões configuradas com sucesso para $_KEYS_DEFAULT"
