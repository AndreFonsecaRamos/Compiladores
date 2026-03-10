# Compilador Juc (2025/26)

Este repositório contém o desenvolvimento de um compilador para a linguagem **Juc**, um subconjunto da linguagem **Java** baseado na especificação **Java SE 9**. O projeto é realizado no âmbito da unidade curricular de **Compiladores** da Universidade de Coimbra.

---

## Meta 1: Analisador Lexical (`jucompiler`)

O objetivo desta meta é o desenvolvimento de um analisador lexical utilizando a ferramenta **Lex** e a linguagem **C**. O analisador processa o ficheiro de entrada através do `stdin` e identifica os tokens de acordo com a especificação da linguagem.

### Setup do Ambiente

```bash
sudo apt-get update
sudo apt-get install -y flex bison gcc make valgrind gdb
```

### Como Executar

O binário gerado deve obrigatoriamente chamar-se `jucompiler`.

#### 1. Compilação
Para gerar o analisador, utiliza os seguintes comandos no terminal:
```bash
lex jucompiler.l
```
```bash
cc lex.yy.c -o jucompiler
```
#### 2. Execução

O programa aceita diferentes opções de visualização no `stdout`:

* **Listagem de Tokens (`-l`)**: Imprime todos os tokens identificados e as mensagens de erro. Sempre que um token admita mais do que um valor semântico, este é impresso entre parêntesis logo a seguir ao nome do token.
    ```bash
    ./jucompiler -l
    ```
* **Apenas Erros (`-e1` ou sem opção)**: Na ausência de qualquer opção, ou se invocado com a opção `-e1`, o programa escreve no `stdout` apenas as mensagens de erro.
    ```bash
    ./jucompiler -e1 
    ```
* **Executar Todos os Casos de Teste**:
    ```bash
    chmod +x /root/comp-26-project/src/scripts/test_lexer.sh
    /root/comp-26-project/src/scripts/test_lexer.sh
    ```
---

### Tratamento de Erros Lexicais

O analisador foi desenhado para recuperar da ocorrência de erros lexicais a partir do fim do respetivo token. O programa reporta a localização exata (linha e coluna) do início do token que originou o erro, sendo que tanto as linhas como as colunas são numeradas a partir de 1.

As mensagens seguem o formato:  
`Line <num linha>, col <num coluna>: <mensagem>`.

| Tipo de Erro | Mensagem de Erro |
| :--- | :--- |
| **Caráter ilegal** | `illegal character (<c>)`  |
| **Sequência de escape inválida** | `invalid escape sequence (<c>)`  |
| **Comentário não terminado** | `unterminated comment`  |
| **String não terminada** | `unterminated string literal`  |