
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

######## VARIÁVEIS #########

"A linguagem R é orientada ao objeto, por isso podemos atribuir a operação à uma variável,
para isso podemos usar os símbolos = ou <-"

resultado <- 4 * 7
print(resultado)

flores vermelhas <- 5
flores laranjas  <- 6
boque <- flores laranjas + flores vermelhas
print(bo)

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

