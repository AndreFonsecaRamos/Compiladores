CC = clang
CFLAGS = -Wall -Wno-unused-function -std=gnu17
LEX = flex
YACC = yacc
TARGET = jucompiler
TEST_LEXER = ../scripts/test_lexer.sh
TEST_YACC = ../scripts/test_yacc.sh
TEST_SEMANTICS = ../scripts/test_semantics.sh
TEST_FINAL = ../scripts/test_final.sh
TESTS_LEX_DIR = ../tests/lexer
TESTS_YACC_DIR = ../tests/yacc
TESTS_SEMANTICS_DIR = ../tests/lexer_yacc
TESTS_FINAL_DIR = ../tests/final

all: $(TARGET)

$(TARGET): y.tab.c lex.yy.c ast.c semantics.c
	$(CC) $(CFLAGS) y.tab.c lex.yy.c ast.c semantics.c -o $(TARGET)

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

test_semantics: $(TARGET)
	@chmod +x $(TEST_SEMANTICS)
	@$(TEST_SEMANTICS)

test_final: $(TARGET)
	@chmod +x $(TEST_FINAL)
	@$(TEST_FINAL)

test: test_lex test_yacc test_semantics

clean_test:
	@echo "A remover ficheiros .actual dos testes..."
	rm -f $(TESTS_LEX_DIR)/*.actual
	rm -f $(TESTS_YACC_DIR)/*.actual
	rm -f $(TESTS_SEMANTICS_DIR)/*.actual
	rm -f $(TESTS_FINAL_DIR)/*.actual

clean: clean_test
	@echo "A limpar ficheiros de compilação..."
	rm -f lex.yy.c y.tab.c y.tab.h $(TARGET)