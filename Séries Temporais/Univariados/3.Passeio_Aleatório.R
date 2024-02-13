################################
####     PASSEIO ALEATÓRIO   ###
################################


###################################
### PASSEIO ALEATÓRIO SEM DRIFT ###
###################################

set.seed(123)

# Simulação de um passeio aleatório sem drift
n <- 1000
p0 <- 10
phi1 <- 1
pt <- rep(p0,n)
for (i in 1:(n-1)) {
  pt[i+1] <- phi1*pt[i] + rnorm(1)
}

# Dividir a página de gráficos em duas linhas e uma coluna. Aqui, usamos a função
# par() onde incluímos a opção mfrow = c(nrows, ncols) para criar uma matriz de nrows
# e ncols gráficos que serão adicionados por linha. Como temos 2 gráficos (um do passeio
# aleatório e outro da primeira diferença do passeio aleatório), vamos dividir a tela em
# 2 linhas e 1 coluna, mas poderíamos fazer 1 linha e 2 colunas, por exemplo.
par(mfrow=c(2,1)) 

# Visualização do passeio aleatório.
plot(pt, type = "l", xlab = "", ylab = "preço", main = "Simulação Passeio Aleatório sem Drift")

# Visualização da primeira diferença do passeio aleatório que é estacionário
plot(diff(pt), type = "l", xlab = "", ylab = "", main = "Diferença nos preços - Estacionária")

#####
##   PASSEIO ALEATÓRIO COM DRIFT
#####

# Simulação de um passeio aleatório com drift
n <- 1000
p0 <- 10
mi <- 0.2
phi1 <- 1
pt_drift <- rep(p0,n)
for (i in 1:(n-1)) {
  pt_drift[i+1] <- mi + phi1*pt_drift[i] + rnorm(1)
}

# Visualização do passeio aleatório com drift
plot(pt_drift, type = "l", xlab = "", ylab = "preço", main = "Simulação Passeio Aleatório com Drift")

# Visualização da primeira diferença do passeio aleatório que é estacionário
plot(diff(pt_drift), type = "l", xlab = "", ylab = "", main = "Diferença nos preços - Estacionária")

#####
##   PASSEIO ALEATÓRIO COM DRIFT E TENDÊNCIA
#####

# Simulação de um passeio aleatório com drift e tendência 
n <- 1000
p0 <- 10
mi <- 0.2
phi1 <- 1
trend <- 1:n
pt_drift_trend <- rep(p0,n)
for (i in 1:(n-1)) {
  pt_drift_trend[i+1] <- mi + trend + phi1*pt_drift_trend[i] + rnorm(1)
}

# Visualização do passeio aleatório com drift
plot(pt_drift_trend, type = "l", xlab = "", ylab = "preço", main = "Simulação Passeio Aleatório com Drift")

#  Visualização da primeira diferença do passeio aleatório que é estacionário
plot(diff(pt_drift_trend), type = "l", xlab = "", ylab = "", main = "Diferença nos preços - Estacionária")

# Retornar o ambiente para ter um gráfico por página, ou seja, 1 linha e 1 coluna
par(mfrow=c(1,1)) 