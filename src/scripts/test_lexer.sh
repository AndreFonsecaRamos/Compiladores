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
LEXER_DIR="$PROJECT_DIR/src/lexer_&_yacc"
TESTS_DIR="$PROJECT_DIR/src/tests/lexer"
EXE="$LEXER_DIR/jucompiler"

# Contadores
total=0
passed=0
failed=0

# Verificar se o executável existe
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}  Verificando o lexer...${RESET}"
echo -e "${CYAN}========================================${RESET}"

if [ ! -f "$EXE" ]; then
    echo -e "${YELLOW}Executável não encontrado. A compilar...${RESET}"
    cd "$LEXER_DIR"
    make all
    if [ $? -ne 0 ]; then
        echo -e "${RED}Erro ao compilar o lexer!${RESET}"
        exit 1
    fi
fi

echo -e "${GREEN}Lexer pronto: $EXE${RESET}"
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
echo -e "${CYAN}  Executando testes...${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo ""

for java_file in $JAVA_FILES; do
    base_name=$(basename "$java_file" .java)
    dir_name=$(dirname "$java_file")
    out_file="$dir_name/$base_name.out"

    total=$((total + 1))

    echo -ne "${CYAN}Teste $total: $base_name${RESET} "

    # Verificar se existe o .out correspondente
    if [ ! -f "$out_file" ]; then
        echo -e "${YELLOW}SKIP (sem .out)${RESET}"
        total=$((total - 1))
        continue
    fi

    # Determinar flag: ficheiros terminados em _e1 correm sem -l
    flag="-l"
    if [[ "$base_name" == *_e1 ]]; then
        flag=""
    fi

    # Executar o lexer e capturar output
    actual=$("$EXE" $flag < "$java_file" 2>&1)

    # Normalizar line endings: remover \r do expected
    expected=$(tr -d '\r' < "$out_file")

    # Comparar
    if [ "$actual" = "$expected" ]; then
        echo -e "${GREEN}PASSED ✓${RESET}"
        passed=$((passed + 1))
    else
        echo -e "${RED}FAILED ✗${RESET}"
        failed=$((failed + 1))

        # Mostrar diferenças
        echo -e "${YELLOW}  Diferenças (< obtido, > esperado):${RESET}"
        diff_output=$(diff <(echo "$actual") <(echo "$expected"))
        echo "$diff_output" | head -40 | while IFS= read -r diff_line; do
            echo "    $diff_line"
        done

        diff_lines=$(echo "$diff_output" | wc -l)
        if [ "$diff_lines" -gt 40 ]; then
            echo -e "    ${YELLOW}... (mais $((diff_lines - 40)) linhas omitidas)${RESET}"
        fi

        # Guardar output para debug
        actual_file="$dir_name/$base_name.actual"
        echo "$actual" > "$actual_file"
        echo -e "${YELLOW}  Output: $actual_file${RESET}"
    fi
done

# Resumo
echo ""
echo -e "${CYAN}========================================${RESET}"
echo -e "${CYAN}  Resumo${RESET}"
echo -e "${CYAN}========================================${RESET}"
echo -e "  Total:   $total"
echo -e "  ${GREEN}Passed:  $passed${RESET}"
echo -e "  ${RED}Failed:  $failed${RESET}"
echo ""

if [ $failed -eq 0 ]; then
    echo -e "${GREEN}  Todos os testes passaram! ✓${RESET}"
else
    echo -e "${RED}  $failed teste(s) falharam! ✗${RESET}"
fi

exit $failed