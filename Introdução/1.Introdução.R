
################
## Introdução ##
################

--------------------------------------------------------------------
"A linguagem R possui um conjunto de bases de dados, que podem ser 
usadas como exemplo, para vê-las usamos o código data()"
--------------------------------------------------------------------

data()

###### OPERADORES MATEMÁTICOS ######

5 + 3 # Soma
8 - 6 # Subtração
4 * 3 # Multiplicação
20 / 5 # Divisão
4 ** 2 ou 4 ^ 2 # Potenciação
sqrt (81) ou 81**(1/2) # Radiciação (quadrada)
125**(1/3) # Radiciação (cúbica)
abs (-10) # Módulo
factorial(3) # Fatorial
exp(1) # Exponencial
log(2.718281828) # Logatimo natural
log2(8) ou 2^3 = 8 # Logaritmo 
sin(pi/6) 

# Notação científica
2e32 #(2x10^32)
2e3 #(2x10^3)
2e-26 #(2x10^-26)
2e5 + 4e5 #(2x10^5 + 2x10^4)
3e20 * 2e12 #(3x10^20 * 2x10^12)
15e16 / 5e6 #(15x10^16 / 5x10^6)

-----------------------------------------------------------------------------------------
######## VARIÁVEIS #########

"A linguagem R é orientada ao objeto, por isso podemos atribuir a operação à uma variável,
para isso podemos usar os símbolos = ou <-"

resultado <- 4 * 7
print(resultado)

flores vermelhas <- 5
flores laranjas  <- 6
boque <- flores laranjas + flores vermelhas
print(bo)

------------------------------------------------------------------------------------------
###### TIPO BÁSICO DO OBJETO #####

"numeric: numérico
integer: inteiro
complex: número complexo
character (string): caractere
logical (boolean): lógicos (True e False)
factor: categorias bem definidas. ex: gênero(masculino e feminino)
estado civil(casado, solteiro, viúvo...), ano(2019, 2020, 2021...)"

# Identificando variável
y = 2
class(y)

# Convertendo variável
x = 2
class(x)
x <- as.integer(x)
class(x)
x

# identificando variável
genero <- c("masculino","feminino")
genero
class(genero)

# Convertendo variável
genero <- as.factor(genero)
genero
class(genero)

# Comprimento Variável
length(genero) # possui dois fatores c("masculino","feminino")

p <- 43
length(p) #possui apenas um fator

q <- "bom dia" 
length(p)

u <- c("1","2","3")
length(u)
-----------------------------------------------------------------------------------------
######  ESTRUTURA DOS DADOS ####### (class, table, summary, labels, levels)

escolaridade <- c("fundamental", "médio", "superior", "médio", "superior", "fundamental") 
print(escolaridade)
class(escolaridade)

# Determinando a posição de cada fator
posicao <- escolaridade[3]
posicao
posicao <- escolaridade[1]
posicao

# Fator (coloca na ordem)
escolaridade_fator <- as.factor(escolaridade)
print (escolaridade_fator)
class(escolaridade_fator)

posicao <- escolaridade_fator[1]
posicao <- escolaridade_fator[2]
posicao <- escolaridade_fator[3]
posicao <- escolaridade_fator[4]
posicao

summary (escolaridade)
summary (escolaridade_fator) # vária dependendo do tipo de objeto
table(escolaridade) # frequência das variáveis

tensao_casas <- c(110, 220, 110, 110, 110, 110, 220)
print(tensao_casas)
class(tensao_casas)
summary(tensao_casas)
table(tensao_casas)

tensao_casas_fator <- as.factor (tensao_casas)
print(tensao_casas_fator)
summary(tensao_casas_fator)

# level define os fatores
# label atribuição de cada fator

factor_temperature_vector <- factor(tensao_casas, levels = c("110", "220"), labels = c("Baixo","Alto"), order = T)
# order = True define se um fator é menor que o outro fator qualitativamente
factor_temperature_vector

speed_vector <- c('Fast','Slow','Slow','Fast','Ultra-fast')
factor_speed_vector <- factor(speed_vector, levels = c('Slow','Fast','Ultra-fast'), order = T)
factor_speed_vector
table(factor_speed_vector)
-----------------------------------------------------------------------------------------
###### VETORES & MATRIZES #######

vector <- c(1, 2, 3, 4, 5, 6, 7)
class(vector)

dias <- c("segunda", "terça", "quarta", "quinta", "sexta", "sábado", "domingo")
class(dias)

posicao<- vector[3]
posicao

juntando <- c(vector, dias)
juntando
class(juntando)

boolean_vector <- c(T,F,T)
print(boolean_vector)

gastos_dia <- c(400, 300, 100, 500, 150, 430, -70)
class(gastos_dia)
length(gastos_dia)

ordem_crescente <- sort(gastos_dia)
print(ordem_crescente)

total <- sum(gastos_dia)
total

minimo <- min(gastos_dia)
minimo

maximo <- max(gastos_dia)
maximo

media <- mean(gastos_dia)
media

limite <- (gastos_dia <= 300)
limite

intervalo <- (3:8)
intervalo

passo <- seq(2,42,by=5)
passo

repeticao <- rep(2,8)
repeticao

repeticao_multipla <- rep(c(3,5),c(4,6))
repeticao_multipla

repeticao_programada <- rep(3:5, each = 3)
repeticao_programada

repeticao_programada_2 <- rep(3:6,3)
repeticao_programada_2

vetor2 <- c(2,4,6,8,10,12)
vetor3 <- c(vetor2,14)
vetor3
class(vetor3)

vetor4 <- c(vetor3,"pares")
vetor4
class(vetor4)

posicao <- vetor2[2]
posicao

posicao_excluida <- vetor2[-3]
posicao_excluida

matriz <- matrix(c(1,5,10,30,15,8),nrow=3,ncol=2,byrow=TRUE)
print(matriz)

vetor2 <- c(2,4,6,8)
matriz <- matrix(vetor2,nrow=2,ncol=2,byrow=TRUE)
print(matriz)

#True = preencher pela linha
#False = preencher pela coluna

matriz <- matrix(c(4,8,12,16,20,24),nrow=3,ncol=2,byrow=FALSE)
print(matriz)

matriz <- matrix(c(4,8,12,16,20,24),nrow=2,ncol=3,byrow=TRUE)
print(matriz)

matriz [2,2]

vetorA <- c(2,5,8)
vetorB <- c(3,6,9)
matriz2 <- rbind(vetorA, vetorB)
matriz2

#rbind 
#bind � juntar
#r � de linha

#padr�o sempre � linha e depois coluna
matriz2 [2,1]

matriz3=matrix(2:9, ncol = 2)
matriz3

#N�mero de linhas e colunas.
dim(matriz3)
nrow(matriz3)
ncol(matriz3)

#Nomear linhas e colunas
dimnames(matriz3) <- list(c("Linha1","Linha2","Linha3","Linha4"),
c("Coluna1", "Coluna2"))
matriz3

matriz4=matrix(2:13, nrow = 4, byrow=TRUE,
dimnames = list(c("Linha1","Linha2","Linha3","Linha4"),
c("Coluna1", "Coluna2","Coluna3")))
matriz4

#Produto de um n�mero por uma matriz
produto <- 2 * matriz4
produto

#Soma ou subtra��o de matrizes
matriz5 = matrix(c(1,5,15,8),nrow=2,ncol=2,byrow=TRUE)
matriz5
matriz6 = matrix(c(2,4,6,10),nrow=2,ncol=2,byrow=TRUE)
matriz6

#M�dia das linhas ou colunas
matriz5 = matrix(c(1,5,15,8),nrow=2,ncol=2,byrow=TRUE)
matriz5

media_coluna <- colMeans(matriz5)
media_coluna

media_linha <- rowMeans(matriz5)
media_linha

#Soma das linhas ou colunas
soma_linhas <- rowSums(matriz5)
soma_linhas

soma_colunas <- colSums(matriz5)
soma_colunas

#Matriz com caracteres
matriz7 = matrix(c("segunda","ter�a","quarta","quinta"),nrow=2,ncol=2,byrow=TRUE)
matriz7

############################
##   ALGEBRA MATRICIAL    ##
############################

# Matrizes a serem utilizadas
M1 <- matrix(c(2, 3, 5, 6), nrow = 2)
M2 <- matrix(c(5, 3, 8, 2), nrow = 2)
M3 <- matrix(c(2, 4, 6, 2, 0, 1), nrow = 2, ncol = 3)
M4 <- matrix(c(1, 0.5, 0.3, 0.5, 1, 0.9, 0.3, 0.9, 1), nrow = 3, ncol = 3)

# Soma e subtra��o
soma <- M2 + M1
soma
subtracao <- M2 - M1
subtracao

# Multiplica��o escalar
prod_escalar <- 42 * M4
prod_escalar

# Multiplica��o matricial 
prod_matricial <- M1 %*% M3
prod_matricial

# Matriz transposta 
transposta <- t(M3)
transposta

# Determinante de uma matriz
determinante <- det(M2)
determinante

# Inversa de uma matriz 
inversa <- solve(M1)
inversa

#######################################################
###    ESTRUTURA DOS DADOS - LISTAS E DATA FRAME    ###
#######################################################

### DATA FRAME ###

# � uma tabela de dados onde cada linha representa um registro e as colunas
# representam os atributos ou vari�veis.
# Pode ter n�meros e caracteres juntos (essa � a principal diferen�a com rela��o � matriz).

mes_numero <- c(1,2,3,4,5,6,7,8,9,10,11,12)
mes_nome <- c("janeiro","fevereiro","mar�o","abril","maio","junho","julho",
              "agosto","setembro","outubro","novembro","dezembro")
ano <- c(2021,2021,2021,2021,2021,2021,2021,2021,2021,2021,2021,2021)
data.frame(mes_numero,mes_nome,ano)

# Data Frames pertencentes ao R
df <- mtcars
df

df2 <- airquality
df2

?airquality
?datasets
library(help = "datasets")

df3 = iris
df3

nrow(df3)
ncol(df3)
dim(df3)
summary(df3)


### LISTAS ###

# Podem conter elementos de diferentes tipos (tipo especial de vetor)

nome <- c("Luciano","Pedro","Joyce", "Maria")
idade <- c(46, 38, 27, 29)
curso <- c("Estat�stica", "Linguagem R", "Redes Neurais", "Python")
lista <- list(nome, idade, curso)
print(lista)

# objeto da lista, basta colocar entre colchetes.
lista[1]

# nomeando termos da lista
lista2 <- list(nome = c("Luciano","Pedro","Joyce", "Maria"),
idade = c(46, 38, 27, 29), curso = c("Estat�stica","Linguagem R","Redes Neurais","Python"))
lista2

lista2[3]

###############################################
###    ESTRUTURA CONDICIONAL - if e else    ###
###############################################


x <- 10
if (x < 10) {
  print("x � menor que 10!")
} else {
  print("x � maior ou igual a 10")
}




y <- 21
if (y < 20) {print("y � menor que 20!")
} else if (y == 20){
  print("y � igual a 20")
} else {
  print("y � maior que 20")
}



w <- 13
ifelse(w %% 2 == 0, "par", "impar")



nota <- 4.5
if (nota >= 6){
  print('Aprovado')
} else if (nota >= 5 & nota< 6){
  print('Recupera��o')
} else {
  print('Reprovado')
}

#####################
###    FUN��ES    ###
#####################

maior = function (x,y) {
  if (x < y) {
    return (y)
  } else { 
    return (x)
  }
}

x <- 10
y <- 8
maior (x , y)

# OU

maior (12,25)


pitagoras_hipotenusa <- function (cat1, cat2) {
  sqrt (cat1**2+cat2**2)
}

pitagoras_hipotenusa(4,3)

pitagoras_hipotenusa(8,6)


pitagoras = function (cat1, cat2, hip) {
  if (hip == "?") {
    sqrt (cat1**2+cat2**2)
  } else if (cat1 == "?") {
    sqrt (hip**2-cat2**2)
  } else {
    sqrt (hip**2-cat1**2)
  }
}

pitagoras(6,8,"?")

#####
##   IGUALDADE
#####

# Comparação de valores lógicos
TRUE == FALSE
TRUE != FALSE

# Comparação de valores numéricos
-6 * 14 != 17 - 101
-6 * 14 == 17 - 101

# Comparação de strings
"useR" != "user"

# Comparação de um valor numérico com outro lógico
TRUE == 1
FALSE == 0

#####
##   MAIOR OU MENOR QUE
#####

# Comparação de números (resultado de cada lado)
-6 * 5 + 2 >= -10 + 1

# Comparação de strings
"raining" <= "raining dogs"

# Comparação de strings
TRUE > FALSE

#####
##   COMPARAR VETORES
#####

# Vetores com acessos ao LinkedIn and Facebook
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)

# Dias populares
linkedin > 15
#sum(linkedin > 15)

# Dias com pouco acesso
linkedin <= 5

# Dias em que o LinkedIn foi mais popular que o Facebook
linkedin > facebook

#####
##   COMPARAR MATRIZES
#####

# Matriz com as visualizações do LinkedIn e Facebook
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)

rownames(views) <- c("linkedin","facebook")
colnames(views) <- c("Sun","Mon","Tues","Wed","Thur","Fri","Sat")


# Quando as visualizações foram iguais a 13?
views == 13

# Quando as visualizações foram menores ou iguais a 14?
views <= 14

# Com que frequência o Facebook tem visualizações iguais ou superiores às do LinkedIn multiplicado por 2?
testeSoma <- linkedin * 2
testeSoma2 <- sum(facebook >= linkedin * 2)

#####
##   & e |
#####

# Quando o LinkedIn excede 10 e Facebook menor que 10?
views
teste <- linkedin > 10 & facebook < 10
sum(linkedin > 10 & facebook < 10)
sum(teste)

# Quando um ou outro foi visitado mais que 12 vezes?
views
linkedin > 12 | facebook > 12
sum(linkedin > 12 | facebook > 12)

# Quando as visitas foram maiores que 11 e menores ou iguais a 14?
views > 11 & views <= 14
sum(views > 11 & views <= 14)

#####
##   NOT
#####

# Contrário do resultado da condição
!(5 > 3)

#####
##   IFELSE
#####

# Último dia de visualização do LinkedIn e Facebook
li <- 5
fb <- 5

# Ifelse para testar condições
if (li >= 15 & fb >= 15) {          # Testar se em ambos temos 15 ou mais visitas
  sms <- (li + fb) * 2              # Se for verdade, execute a soma das visitas multiplicado por 2 
} else  if (li < 10 & fb < 10) {     # Caso contrário, teste se em ambos temos menos que 10 visitas
  sms <- (li + fb) / 2              # Se for verdade, execute a média de visitas
} else {                            # Caso contrário, apenas some as visitas
  sms <- (li + fb)
}

# resultado
print(sms)

#####
##   WHILE LOOP
#####

# Uma variável de velocidade
speed <- 64

# Enquanto a velocidade for maior que 30 execute
while (speed > 30 ) {
  print(speed)
  print('Desacelerando!')
  speed <- speed - 7   # Desacelerar a velocidade        
}

# Mostre o resultado
print(speed)

#####
##   FOR LOOP
#####

#  Versão 1
for (i in linkedin) {       # Para cada valor da matriz views que existe no vetor linkedin
  print(i)                  # Mostre o valor
}

# Versão 2
for (i in 1:length(linkedin)) { # Para cada índice da sequência de 1 a length(linkedin) 
  print(linkedin[i])            # Mostre o valor do vetor do respectivo índice
}
# Versão 3: Usando a função seq_along. Ela cria um vetor 
# de inteiros com índices para acompanhar o objeto. 
for (i in seq_along(linkedin)) { # Para cada índice do vetor linkdedin
  print(linkedin[i])             # Mostre os resultados
}

#####
##   LOOP SOBRE UMA LISTA
#####

# Criando uma lista
nyc <- list(pop = 8405837, bairros = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island"), 
            capital = FALSE)

# Versão 1
for (i in nyc) {             # Para cada item da lista 
  print(i)                   # Mostre os valores contidos em cada item da lista
}

# Versão 2
for (i in 1:length(nyc)) {       # Para cada índice da sequência de 1 até o tamanho de itens na lista
  print(nyc[[i]])                # Mostre os valores contidos em cada item da lista usando o índice
}

#####
##   LOOP SOBRE UMA MATRIZ
#####

# Criar uma matriz
ttt <- matrix(c("O", NA, "X", NA, "O", NA, "X", "O", "X"), nrow = 3, ncol = 3)

# Executar o loop 
for (i in 1:nrow(ttt)) {        # Para cada linha da matriz (1:nrow(ttt) criará os índices das linhas)
  for (j in 1:ncol(ttt)) {      # Para cada coluna da matriz (1:ncol(ttt) criará os índices das colunas)
    print(paste("Na linha",i,"e coluna",j,"temos",ttt[i,j]))  # Mostre os resultados 
  }
}

#####
##   LOOP COM CONDIÇÕES
#####

# Executar o loop
#linkedin
for (i in linkedin) {            # Para cada índice do vetor linkedin (chamamos o índice de li)
  if (i > 10) {                  # Se o índice for maior que 10
    #print("Você é popular!")       # Mostre a mensagem "Você é popular"
    print(paste("Você é popular, teve",i, "likes"))
  } else {                        # Caso contrário, se o índice for <= 10
    #print("Seja mais visível!")   # Mostre outra mensagem "Seja mais visível"
    print(paste("Seja mais visível, teve",i,"likes"))
  }
}

################################
####   FUNÇÕES NATIVAS     #####
################################

# Para acessar a documentação de uma função nativa.
help(mean)
help(sd)

# Existem argumentos obrigatórios e opcionais em funções. Exemplo:
x <- c(15, 20, 25, NA)
sd(x, na.rm = TRUE)

################################
###   FUNÇÕES PRÓPRIAS       ###
################################

# Criando a função quadrado que recebe o argumento x
quadrado <- function(x) {
  result <- x * x
  return(result)
}

# Usando a função quadrado
quadrado(10)

# Criando a função somar_abs() que recebe os argumentos x e y
somar_abs <- function(x, y) {
  result <- (x * x) ^ (0.5) + (y * y) ^ (0.5)
  return(result)
}

# Usando a função somar_abs
somar_abs(-2, -10)

# Expandir a função quadrado() para receber os argumentos x e print_info
quadrado <- function(x, print_info = TRUE) {         # argumentos da função
  y <- x ^ 2                                      # tarefa a ser executada
  if (print_info == T) {                          # verificar o argumento print_info
    print(paste(x, 'elevado ao quadrado é', y))    # se TRUE, mostrar a mensagem
  }
  return(y)                                       # a função deve retornar como saído os valores de y
}

quadrado(5)
quadrado(5, print_info=T)
quadrado(5, print_info = F)

################################
######       APPLY         #####
################################

# matriz com 20 colunas e 10 linhas
x <- matrix(rnorm(200), ncol=20)
help(rnorm)
hist(x)

head(x)
tail(x)

# média na linha (MARGIN = 1)
media_linha <- apply(x, MARGIN = 1, mean)   # aplicar a função mean nas linhas
media_linha
desvio_linha <- apply(x, MARGIN = 1, sd)
desvio_linha

# média na coluna (MARGIN = 2)
media_coluna <- apply(x, MARGIN = 2, mean)  # aplicar a função mean nas colunas
media_coluna
desvio_coluna <- apply(x, MARGIN = 2, sd)
desvio_coluna

################################
######       LAPPLY        #####
################################

# Uma lista qualquer com 7 vetores de temperaturas em cada dia
temp <- list(
  c(3, 7,  9,  6, -1),
  c(6,  9, 12, 13,  5),
  c(4,  8,  3, -1, -3),
  c(1,  4,  7,  2, -2),
  c(5, 7, 9, 4, 2),
  c(-3,  5,  8,  9,  4),
  c(3, 6, 9, 4, 1)
)

# Temperatura mínima em cada dia. Retorna uma lista.
lapply(temp, min)

# Temperatura máxima em cada dia. Retorna uma lista. 
lapply(temp, max)

# Temperatura média em cada dia. Retorna uma lista.
lapply(temp, mean)

################################
######       SAPPLY        #####
################################

# Temperatura mínima em cada dia. Retorna um vetor.
minimo <- sapply(temp, min)

# Temperatura máxima em cada dia. Retorna um vetor.
maximo <- sapply(temp, max)

# Temperatura média em cada dia. Retorna um vetor.
sapply(temp, mean)

# Teste que retorna apenas em formato diferente, mas com resultados iguais
unlist(lapply(temp, max)) == sapply(temp, max)

# Função que calcula a média do mínimo e máximo de um vetor
extremes_avg <- function(x) {
  avg <- mean(c(min(x), max(x)))
  return(avg)
}

# Usando ela com o sapply(). Poderíamos usar ela em lapply() ou apply().
sapply(temp, extremes_avg)

################################
#####    DATA/TEMPO        #####
################################

# A data atual. A função primitiva Sys.Date() cria uma data no formato correto
today <- Sys.Date()
today

# Se excluirmos a classe vemos que teremos um número que não é interpretável 
unclass(today)

# A hora corrente
now <- Sys.time()
now

################################
####  CRIANDO DATA/TEMPO   #####
################################

# Definindo datas em um formato qualquer como character
str1 <- "2012-3-15"
str2 <- "02/27/92"

str3 <- "2012-3-20"
date3 <- as.Date(str3, format = "%Y-%m-%d")
date3
str4 <- "2021-3-21"
date4 <- as.Date(str4, format = "%Y-%m-%d")
date4

# Convertendo para datas no formato que o R reconhece
date1 <- as.Date(str1, format = "%Y-%m-%d")
date1
date2 <- as.Date(str2, format = "%m/%d/%y")
date2

help(as.Date)

# Definindo tempo em formato de string
str1 <- "2012-3-12 14:23:08"

# Converter as string para um objecto POSIXct
time1 <- as.POSIXct(str1, format = "%Y-%m-%d %T")
time1

################################
####  CÁLCULO DATA/TEMPO   #####
################################

# Datas
day1 <- as.Date("2017-03-12")
day2 <- as.Date("2017-03-14")
day3 <- as.Date("2017-03-19")
day4 <- as.Date("2017-03-25")
day5 <- as.Date("2017-03-30")

# Diferença entre o primeiro e o último dia
day5-day1

# Criar um vetor com as datas
pizza <- c(day1, day2, day3, day4, day5)
pizza

# Criar um vetor com a diferença entre os dias consecutivos
day_diff <- diff(pizza)
day_diff

# Período médio entre dois dias consecutivos 
mean(day_diff)

################################
#####      INSTALAR        #####
################################

# Além dessa opção você pode instalar pacotes diretamente no painel inferior direito do RStudio
install.packages("dplyr")
install.packages(c("dplyr", "data.table"))

################################
#####       CARREGAR       #####
################################

# Forma tradicional. Aqui, não precisamos das aspas porque o R já reconhece que há o pacote no ambiente
require(dplyr)
require(data.table)

# Alternativa para no momento de carregamento do pacote não aparecerem mensagens
suppressMessages(require(dplyr))
suppressMessages(require(data.table))

# Acionando todas as funções disponíveis no pacote
help(dplyr)
help(data.table)






