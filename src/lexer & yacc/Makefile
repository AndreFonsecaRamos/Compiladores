CC = clang
CFLAGS = -Wall -Wno-unused-function -std=gnu17
LEX = flex
YACC = yacc
TARGET = jucompiler
TEST_LEXER = ../scripts/test_lexer.sh
TEST_YACC = ../scripts/test_yacc.sh
TESTS_LEX_DIR = ../tests/lexer
TESTS_YACC_DIR = ../tests/yacc

all: $(TARGET)

# ADICIONADO: ast.c nas dependências e no comando de compilação!
$(TARGET): y.tab.c lex.yy.c ast.c
	$(CC) $(CFLAGS) y.tab.c lex.yy.c ast.c -o $(TARGET)

y.tab.c y.tab.h: jucompiler.y
	$(YACC) -d jucompiler.y

lex.yy.c: jucompiler.l y.tab.h
	$(LEX) jucompiler.l

test_lex: $(TARGET)
	@chmod +x $(TEST_LEXER)
	@$(TEST_LEXER)

test_yacc: $(TARGET)
	@chmod +x $(TEST_YACC)
	@$(TEST_YACC)

test: test_lex test_yacc

clean_test:
	@echo "A remover ficheiros .actual dos testes..."
	rm -f $(TESTS_LEX_DIR)/*.actual
	rm -f $(TESTS_YACC_DIR)/*.actual

clean: clean_test
	@echo "A limpar ficheiros de compilação..."
	rm -f lex.yy.c y.tab.c y.tab.h $(TARGET)