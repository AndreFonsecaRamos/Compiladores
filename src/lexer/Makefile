CC = clang
CFLAGS = -Wall -Wno-unused-function -std=gnu17
LEX = flex
TARGET = jucompiler
TEST_SCRIPT = ../scripts/test_lexer.sh
TESTS_DIR = ../tests/lexer

all: $(TARGET)

$(TARGET): lex.yy.c
	$(CC) $(CFLAGS) lex.yy.c -o $(TARGET)

lex.yy.c: jucompiler.l
	$(LEX) jucompiler.l

test: $(TARGET)
	@chmod +x $(TEST_SCRIPT)
	@$(TEST_SCRIPT)

clean_test:
	@echo "A remover ficheiros .actual..."
	rm -f $(TESTS_DIR)/*.actual

clean: clean_test
	@echo "A limpar ficheiros de compilação..."
	rm -f lex.yy.c $(TARGET)

.PHONY: all test clean clean_test