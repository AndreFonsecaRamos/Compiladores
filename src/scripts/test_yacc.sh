#!/bin/bash

# Cores para output
GREEN="\033[0;32m"
RED="\033[0;31m"
YELLOW="\033[0;33m"
CYAN="\033[0;36m"
RESET="\033[0m"

# Directórios relativos ao script
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
PROJECT_DIR="$(cd "$SCRIPT_DIR/../.." && pwd)"
PARSER_DIR="$PROJECT_DIR/src/lexer & yacc"
TESTS_DIR="$PROJECT_DIR/src/tests/yacc"
EXE="$PARSER_DIR/jucompiler"

# Contadores
total=0
passed=0
failed=0

# Verificar se o executável existe
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}  Verificando o parser (Yacc)...${RESET}"
echo -e "${CYAN}========================================${RESET}"

if [ ! -f "$EXE" ]; then
    echo -e "${YELLOW}Executável não encontrado. A compilar...${RESET}"
    cd "$PARSER_DIR"
    make all
    if [ $? -ne 0 ]; then
        echo -e "${RED}Erro ao compilar o parser!${RESET}"
        exit 1
    fi
fi

echo -e "${GREEN}Parser pronto: $EXE${RESET}"
echo ""

# Verificar se existem testes
if [ ! -d "$TESTS_DIR" ]; then
    echo -e "${RED}Directório de testes não encontrado: $TESTS_DIR${RESET}"
    exit 1
fi

JAVA_FILES=$(find "$TESTS_DIR" -name "*.java" | sort)

if [ -z "$JAVA_FILES" ]; then
    echo -e "${YELLOW}Nenhum ficheiro .java encontrado em $TESTS_DIR${RESET}"
    exit 1
fi

# Executar testes
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}  Executando testes sintáticos...${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo ""

for java_file in $JAVA_FILES; do
    base_name=$(basename "$java_file" .java)
    dir_name=$(dirname "$java_file")
    out_file="$dir_name/$base_name.out"

    echo -ne "${CYAN}Teste $((total + 1)): $base_name${RESET} "

    # Verificar se existe o .out correspondente
    if [ ! -f "$out_file" ]; then
        echo -e "${YELLOW}SKIP (sem .out) - Ficheiro não encontrado:${RESET} $out_file"
        continue
    fi
    
    total=$((total + 1))

    # Forçar a flag -t para todos os testes desta meta para podermos comparar a árvore
    flag="-t"

    # Executar o parser e capturar output
    actual=$("$EXE" $flag < "$java_file" 2>&1)

    # Normalizar line endings: remover \r do expected
    expected=$(tr -d '\r' < "$out_file")

    # Guardar sempre o actual para debug
    actual_file="$dir_name/$base_name.actual"
    echo "$actual" > "$actual_file"

    # Comparar
    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}PASSED ✓${RESET}"
        passed=$((passed + 1))
        # Remover ficheiro de debug se passou
        rm -f "$actual_file"
    else
        echo -e "${RED}FAILED ✗${RESET}"
        failed=$((failed + 1))

        # Mostrar diferenças limitadas
        echo -e "${YELLOW}  Diferenças (< obtido, > esperado):${RESET}"
        diff_output=$(diff <(echo "$actual") <(echo "$expected"))
        echo "$diff_output" | head -40 | while IFS= read -r diff_line; do
            echo "    $diff_line"
        done

        diff_lines=$(echo "$diff_output" | wc -l)
        if [ "$diff_lines" -gt 40 ]; then
            echo -e "    ${YELLOW}... (mais $((diff_lines - 40)) linhas omitidas)${RESET}"
        fi

        echo -e "${YELLOW}  Output guardado em: $actual_file${RESET}"
    fi
done

# Resumo
echo ""
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}  Resumo Meta 2 (Lexer & Yacc)${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo -e "  Total:   $total"
echo -e "  ${GREEN}Passed:  $passed${RESET}"
echo -e "  ${RED}Failed:  $failed${RESET}"
echo ""

if [ $failed -eq 0 ] && [ $total -gt 0 ]; then
    echo -e "${GREEN}  Todos os testes passaram! ✓${RESET}"
elif [ $total -eq 0 ]; then
    echo -e "${YELLOW}  Nenhum ficheiro correspondente validado. - ${RESET}"
else
    echo -e "${RED}  $failed teste(s) falharam! ✗${RESET}"
fi