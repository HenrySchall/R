
################
## Introdução ##
################

"A linguagem R possui um conjunto de bases de dados, que podem ser 
usadas como exemplo, para vê-las usamos o código data()"

data()
library(help = "datasets")

############################
## OPERADORES MATEMÁTICOS ##
############################

5 + 3 #Soma
8 - 6 #Subtração
4 * 3 #Multiplicação
20 / 5 #Divisão
4 ** 2 ou 4 ^ 2 #Potenciação
sqrt (81) ou 81**(1/2) #Radiciação (quadrada)
125**(1/3) #Radiciação (cúbica)
abs (-10) #Módulo
factorial(3) #Fatorial
exp(1) #Exponencial
log(2.718281828) #Logatimo natural
log2(8) ou 2^3 = 8 #Logaritmo 

#Notação científica
2e32 #(2x10^32)
2e3 #(2x10^3)
2e-26 #(2x10^-26)
2e5 + 4e5 #(2x10^5 + 2x10^4)
3e20 * 2e12 #(3x10^20 * 2x10^12)
15e16 / 5e6 #(15x10^16 / 5x10^6)

###############
## VARIÁVEIS ##
###############

"A linguagem R é orientada ao objeto, por isso podemos atribuir a operação à uma variável,
para isso podemos usar os símbolos = ou <-"

resultado <- 4 * 7
print(resultado)

flores vermelhas <- 5
flores laranjas  <- 6
boque <- flores laranjas + flores vermelhas
print(boque)

###########################
## TIPO BÁSICO DO OBJETO ##
###########################

#numeric: numérico
#integer: inteiro
#complex: número complexo
#character (string): caractere
#logical (boolean): lógicos (True e False)
#factor: categorias bem definidas. ex: gênero(masculino e feminino)
#estado civil(casado, solteiro, viúvo...), ano(2019, 2020, 2021...)

#Identificando variável
x = 2
class(x)

#Convertendo variável
x <- as.integer(x)
class(x)

genero <- c("masculino","feminino")
genero
class(genero)
genero <- as.factor(genero)
class(genero)

#Comprimento Variável
length(genero) #possui dois fatores
length(x) #possui apenas um fator

q <- "bom dia" 
length(q)

u <- c("1","2","3")
length(u)

#################
## Estatística ##
#################

####################
## Álgebra Linear ##
####################

"Campo da matemática que trabalha com equações lineares e funções lineares que são 
representadas através de matrizes e vetores."

# Tópicos
# - Sistemas de Equações Lineares.
# - Vetores = Representação matemática de uma grandeza vetorial (Módulo, Direção e Sentido)
# - Matrizes
# - Determinantes
# - Espaços vetoriais
# - Transformações lineares
# - Autovalores e Autovetores

# Grandezas
# - Escalar = Só necessita do seu valor para representar a grandeza (Tempo, Massa, Temperatura)
# - Vetorial = Necessita de módulo, direção e sentindo (Força, Velocidade, Aceleração)

#############
## VETORES ##
#############

#Criando um vetor
vetor <- c(1,2,3,4,5,6,7)
class(vetor)

dias <- c("segunda", "terca", "quarta", "quinta", "sexta", "sábado", "domingo")
class(dias)

#Juntando os dois vetores
juntando <- c(vetor, dias)
juntando
class(juntando)
length(juntando) #tamanho

#Colocando em ordem crescente
gastos_dia <- c(300, 400, 5000, 150, 250)
ordem_crescente <- sort(gastos_dia)
ordem_crescente

#Soma dos valores do vetor
total <- sum(gastos_dia) 
total

#Mínimo
minimo <- min(gastos_dia)
min(gastos_dia)

#Máximo
max(gastos_dia)
maximo <- max(gastos_dia)

#Média
media <- mean(gastos_dia)
mean(gastos_dia)

#Limite
limite <- (gastos_dia <= 300)
limite

#Intervalo
intervalo <- (3:8)
intervalo

#Sequência
passo <- seq(2,48,by=5)
passo

#Repetição
repeticao <- rep(2,8)
repeticao

#Repetição Multipla
repeticao_multipla <- rep(c(3,5),c(4,6))
repeticao_multipla

#Repetição Programada
repeticao_programada <- rep(3:5, each = 3)
repeticao_programada

repeticao_programada_2 <- rep(3:6,3)
repeticao_programada_2

##########################
## OPERAÇÕES DE VETORES ##
##########################

u <- c(2,-4,1)
print(u)

v <- c(3,2,-5)
print(v)

#Soma
soma <- u + v
soma

#Produto
produto <- u * v
produto

#Produto Interno (soma do produto)
produto_interno <- u %*% v
produto_interno

#Multiplicação Escalar
multiplicacao <- 5*u
multiplicacao

multiplicacao2 <- 3*v
multiplicacao2

produto_interno <- (5*u) %*% (3*v)
produto_interno 

#Norma
norm(u, type="2")
norm(v, type="2")

w = c(2,4,6,8,10,12)
norm(w, type="2")
round(norm(w, type="2"),3) #forma resumida

#Distância
# Criando Função Distância
dist <- function (vetor1, vetor2) {
  soma_quad = 0
  for (i in 1:length(vetor1)){
    soma_quad = soma_quad+(vetor1[i] - vetor2[i])**2}
  dist = soma_quad**(1/2)
}

# Calculando a distância entre vetores
distancia <- dist(u,v)
print(paste0("A distância entre os vetores: ", round(distancia, 2)))

#########################
## ESTRUTURA DOS DADOS ## 
#########################

#class
#table
#summary 
#labels
#levels

escolaridade <- c("fundamental", "médio", "superior") 
print(escolaridade)
class(escolaridade)

#Determinando a posição de cada fator
posicao <- escolaridade[2]
posicao
posicao <- escolaridade[1]
posicao

#Adicionando uma posição
escolaridade2 <- c(escolaridade,"1")
escolaridade2
class(escolaridade2)

#Excluindo posição
posicao_excluida <- escolaridade[-2]
posicao_excluida

#Fator (coloca na ordem)
escolaridade_fator <- as.factor(escolaridade)
print (escolaridade_fator)
class(escolaridade_fator)

posicao <- escolaridade_fator[1]
posicao <- escolaridade_fator[2]
posicao <- escolaridade_fator[3]
posicao <- escolaridade_fator[4]
posicao

summary (escolaridade)
summary (escolaridade_fator) #vária dependendo do tipo de objeto
table(escolaridade) #frequência das variáveis

tensao_casas <- c(110, 220, 110, 110, 110, 110, 220)
print(tensao_casas)
class(tensao_casas)
summary(tensao_casas)
table(tensao_casas)

tensao_casas_fator <- as.factor (tensao_casas)
print(tensao_casas_fator)
summary(tensao_casas_fator)

#level define os fatores
#label atribuição de cada fator
#order = True define se um fator é menor que o outro fator qualitativamente

factor_temperature_vector <- factor(tensao_casas, levels = c("110", "220"), labels = c("Baixo","Alto"), order = T)
factor_temperature_vector

##############
## MATRIZES ##
##############