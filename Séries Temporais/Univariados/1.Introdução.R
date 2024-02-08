####################
###  Introdução  ###
####################

# Conceitos:
#   1) Série Temporal = é um conjunto de observações ordenadas no tempo ou um corte particular de um processo estocástico desconhecido
#   Matematicamente:

#   2) Processo Estocástico = é uma coleção de variáveis aleatórias definidas num mesmo espaço de probabilidades (processo gerador de uma série de variáveis). A descrição de um 
#   processo estocástico é feita através de uma distribuição de probabilidade conjunta (o que é muito complexo de se fazer), então geralmente descrevemos ele por meio das funções:
#   𝜇(𝑡)=𝐸{𝑍(𝑡)} -> Média 
#   𝜎^2(𝑡)=𝑉𝑎𝑟{𝑍(𝑡)} -> Variância 
#   𝛾(𝑡1,𝑡2)=𝐶𝑜𝑣{𝑍(𝑡1),𝑍(𝑡2)} -> Autocovariância

Imagem 

#   3) Estacionaridade = é quando uma série temporal apresenta todas suas características estatísticas constante ao longo do tempo
#    - Estacionaridade Fraca =
#    - Estacionaridade Forte = 

imagem 

#   4) Passeio Aleatório (Random Walk) =  é a soma de pequenas flutuações estocásticas (tendência estocástica)
#   Matematicamente:

#   5) Autocorrelação = é a correlação de determinados períodos anteriores com o período atual, onde cada período desse tipo de correlação é denominado lag e sua análise 
#   é o pressuposto para se criar previsões.

# Objetivos:
#   Analisar a origem da série
#   Previsões futuras
#   Descrição do comportamento da série 
#   Analisar perodicidade ou tendência 

# Tipos:
#   Univariada = apenas uma variável se altera ao longo do tempo
#   Multivariada = mais de uma variável se altera ao longo do tempo

##############################
### Criando Série Temporal ###
##############################

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

# Teste Dickey Fuller)
#  - H0 = é estacionária:  teste estatístico < valor crítico
#  - H1 = não é estacionária: teste estatístico > valor crítico
ur.df(serie1)

### Testes de Autocorrelação ###

# Autocorrelação dos resíduos
#  - H0: resíduos são não autocorrelacionados
#  - H1: resíduos são autocorrelacionados

# Heterocedasticidade condicional
#  - H0: quadrado dos resíduos são não autocorrelacionados
#  - H1: quadrado dos resíduos são autocorrelacionados
