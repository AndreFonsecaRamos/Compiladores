# Relatório do Projeto: Compilador para a Linguagem Juc

## (i) Gramática Re-escrita e Análise Sintática

O maior desafio nesta fase foi a conversão das regras gramaticais fornecidas no enunciado num conjunto de produções sem ambiguidades, garantindo simultaneamente a construção correta da Árvore Sintática Abstrata (AST).

Uma das decisões técnicas centrais foi a **resolução de ambiguidades**, em especial o problema do *dangling else*. Para garantir que um `else` é sempre associado ao `if` mais próximo, introduzimos a precedência explícita usando `%nonassoc NO_ELSE` e `%nonassoc ELSE`. Decidimos dar maior prioridade ao bloco `ELSE`, resolvendo o conflito de forma limpa sem comprometer a gramática com regras redundantes.

No que toca às precedências dos operadores, seguimos a precedência padrão do Juc, da menor para a maior precedência, declarando os operadores em blocos no ficheiro Yacc. Por exemplo, a atribuição (`=`) foi definida com associatividade à direita (`%right`), enquanto a grande maioria dos operadores binários foi definida com associatividade à esquerda (`%left`). Os operadores unários (sinais e a negação lógica) têm a maior precedência através de pseudotokens criados apenas para esse fim (`UNARY_MINUS`, `UNARY_PLUS`).

Outra opção importante na reescrita foi a estrutura em **listas e blocos genéricos** (`DeclList`, `StatementList`). Para evitar árvores demasiado profundas ou mal formadas, optámos por "espalhar" os filhos (usando iterações `while` na ação semântica) e colocá-los diretamente num nó pai temporário `Program` (que atua como lista). No final, ao compor o nó `Block` ou a raiz real do `Program`, todos os filhos dessa lista temporária são extraídos e adicionados, resultando numa AST plana e fácil de percorrer.

No (`main`) implementámos diferentes formas de compilação, lexicais, sintáticas ou semânticas, dependendo das *flags* da linha de comandos, permitindo que o desenvolvimento e o debug ocorressem de forma faseada. O *parser* tenta sempre recuperar de erros e continuar a análise quando se trata de declarações mal formatadas.

---

## (ii) Algoritmos e Estruturas de Dados da AST e da Tabela de Símbolos

### Árvore Sintática Abstrata (AST)
Para representar a AST, desenhamos a estrutura `node` (em `ast.h`), que guarda informações lexicais e semânticas cruciais: a categoria do nó (`enum category`), o token que o gerou (para identificadores ou literais), a linha e a coluna (usádas para mensagens de erro) e, mais tarde, o tipo extraído (`int type`) e a assinatura de parâmetros calculada para a impressão anotada (`char *param_sig`).

A hierárquia foi construída da forma *First Child, Next Sibling*, através de uma lista ligada (`struct node_list`). A função `addchild` é responsável de percorrer até ao final da lista de filhos de um nó pai e adicionar o novo nó, o que permite o acrescento de múltiplos campos ou parâmetros.

### Tabelas de Símbolos e Análise Semântica
O arquitetura da análise semântico divide-se fundamentalmente em duas estruturas e três iterações sobre a AST.

**Estruturas de Dados:**
Optámos por usar "Global + Múltiplos Locais". Existe uma tabela global (`class_table`) que guarda os atributos da classe e a lista de métodos. Os métodos, por sua vez, são tabelas independentes (`method_table`), cada uma contendo a sua própria lista de símbolos (variáveis locais e parâmetros). Cada símbolo (`symbol_entry`) regista: nome, tipo, se é método ou parâmetro e a localização. O tipo foi guardado sob a forma de `string`, de forma a simplificar comparações e impressões.

**Algoritmo de 3 Passagens:**
1. **`build_global_table`**: Percorre as declarações primárias. Regista os *FieldDecls* e verifica a existência de problemas de nome e símbolos reservados (`_`). Para os métodos, extrai a assinatura e guarda-a.
2. **`populate_method_tables`**: Inicializa as tabelas de símbolos específicas de cada método e adiciona os argumentos formais declarados no cabeçalho, desta forma garantindo que ficam imediatamente disponíveis para a verificação de tipos. Além disso, regista o tipo de retorno esperado dentro dessa mesma tabela, associando-o à variável reservada "return".
3. **`check_methods`**: Realiza o *type checking*. Percorre de forma pós-ordem (`check_expression`), verificando os nós-folha antes dos operadores. As chamadas a métodos foi a fase mais complicada de implementar: procurámos primeiro uma correspondência exata (*exact match*) e, caso falhe, efetuamos a procura por *compatible cast* (onde `int` pode ser transformado a `double`).

---

## (iii) Geração de Código (LLVM IR)

Na última etapa, o compilador traduz a AST validada para código intermédio LLVM, seguindo os princípios de *Static Single Assignment*. Toda a lógica encontra-se implementada no ficheiro `codegen.c`.

Como o LLVM exige que os registos sejam atribuídos uma única vez, a nossa escolha técnica para lidar com as variáveis mutáveis foi a utilização ativa da **memória (Stack)** local, usando, `alloca`, `store` e `load`. Para cada variável declarada e cada argumento passado, um espaço próprio é alocado. Assim, uma atribuição traduz-se numa expressão cujo resultado final é guardado com um `store`, enquanto uma leitura de variável desencadeia um `load` imediato para um novo registo temporário.

As operações foram desenhadas de forma de acordo com o LLVM, com verificações para saber se a operação é `i32` (`add`, `mul`, `icmp`) ou `double` (`fadd`, `fmul`, `fcmp`). Nos casos onde uma operação mista ocorre (ex: guardar um `int` numa variável `double`, ou passar `int` a um método que espera `double`), implementámos a função `cast_to_double` que invoca a instrução `sitofp` para a fazer o `cast` do tipo antes da operação principal.

Outro ponto que tivemos de resolver foi o controlo das instruções de decisão (`if` e `while`). Para resolver os (`if` e `while`), usámos (labels) para dizer ao compilador para onde saltar, por exemplo se tivermos um if com duas condições (`x != 0 && 10/x == 2` ), se o x for igual a 0, a primeira parte da condição (x != 0) é `Falsa`. Como estamos a usar um (`&&`), se o primeiro lado é Falso, é matematicamente impossível que a expressão toda seja Verdadeira. Corta-mos a execução ali mesmo e nem sequer tenta calcular a segunda parte. Para os (`&& e ||`), usámos esses mesmos saltos a meio das contas para fazer com que o compilador desista de calcular o resto da expressão se já souber o resultado, evitando assim que o programa vá abaixo com operações inválidas. Por exemplo: Se o compilador tentasse calcular (`10/0`), o programa ia tentar dividir um número por zero e ia crashar imediatamente.
