####################
###  Introdução  ###
####################

######################
### Série Temporal ###
######################

# Criando dados aleatórios
set.seed(10) #definir ponto inicial para gerar mesmos valores aleatórios
dados1 <- rnorm(40) #rnorm torna os resíduos normalmente distribuídos, outra alternativa, seria a função rt para resíduos distribuídos conforme uma t de Student.
print(dados1)

# Criando série (Anual)
serie1 <- ts(dados1, start = c(1980), end=c(2020), frequency=1) #frequency define o prazo da série 1(ano), 12(meses).
print(serie1)
plot(serie1)

# Criando Série (Mensal)
#set.seed(10)
#dados2 <- rnorm(70)
#serie2 <- ts(dados2,start = c(2015,1), end=c(2020,12), frequency=12)
#print(serie2)
#plot(serie2)
#shapiro.test(serie1)
#jarque.bera.test(serie1)

#########################
### Passeio Aleatório ###
#########################

# Criando 41 números aleatórios entre 0 e 100
dados1 <- runif(41, min=0, max=100);

# Criando Passeio Aleatório 
s1 <- ts(dados1, start = 1980, end=2020, frequency=1)
plot(s1)

# Criando 41 números aleatórios entre 0 e 100 (Com repetição)
dados2 <- sample(0:100, 41, replace=TRUE)

# Criando Passeio Aleatório 
s2 = ts(dados2, start = c(1980), end=c(2020), frequency=1)
plot(s2)

##############
### Testes ###
##############

### Testes de Normalidade ###

#  - H0: resíduos normalmente distribuídos (p > 0.05)
#  - H1: resíduos não são normalmente distribuídos (p <= 0.05)
shapiro.test(serie1)
jarque.bera.test(serie1)

### Testes de Estacionaridade ###

# Teste KPSS (Kwiatkowski-Phillips-Schmidt-Shin)
#  - H0 = é estacionária: teste estatístico < valor crítico
#  - H1 = não é estacionária: teste estatístico >= valor crítico
ur.kpss(serie1)

# Teste pp (Philips-Perron)
#   - H0 = é estacionária: p > 0.05
#   - H1 = não é estacionária: p <= 0.05
pp <- ur.pp(serie1)
summary(pp)

# Teste Dickey Fuller
#  - H0 = é estacionária:  teste estatístico < valor crítico
#  - H1 = não é estacionária: teste estatístico > valor crítico
ur.df(serie1)

### Testes de Autocorrelação ###

# Teste de Ljung-Box 
#  - H0: não autocorrelacionados (p > 0.05)
#  - H1: são autocorrelacionados (p <= 0.05)
Box.test (serie1, type = "Ljung")

#################################
### Decomposição e Suavização ###
#################################

library(help="datasets")
sunspots
plot(sunspots)

### Decomposição ###
decomposicao <- decompose(sunspots)
plot(decomposicao)

### Suavização ###
suavizacao <- tsclean(sunspots)
plot(suavizacao)

# Comparação com o original
plot(sunspots)
lines(suavizacao, col="green")