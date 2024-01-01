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
