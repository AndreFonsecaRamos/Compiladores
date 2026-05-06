#!/bin/bash

# Nome do ficheiro final
OUTPUT="jucompiler.zip"

# Lista exata dos ficheiros exigidos
FILES="ast.c ast.h codegen.c codegen.h jucompiler.l jucompiler.y semantics.c semantics.h"

echo "A preparar a submissão final do Juc..."

# Remover o zip antigo, caso exista, para evitar lixo acumulado
if [ -f "$OUTPUT" ]; then
    rm "$OUTPUT"
    echo "Ficheiro $OUTPUT antigo removido."
fi

# Criar o novo zip de forma silenciosa e limpa
zip -j $OUTPUT $FILES

# Verificar se o comando correu bem
if [ $? -eq 0 ]; then
    echo "✅ Sucesso! O ficheiro $OUTPUT está pronto para o Mooshak."
else
    echo "❌ Erro ao criar o ficheiro zip. Verifica se tens o pacote 'zip' instalado."
fi