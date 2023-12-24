################################
####     SIMULAÇÃO MA        ###
################################

#####
##   PACOTES NECESSÁRIOS
#####

source("/cloud/project/install_and_load_packages.R")

#####
##   OPÇÕES
#####

# Definir ponto inicial para permitir replicar o exemplo. Gerar mesmos valores aleatórios
set.seed(123)

#####
##   MA(1)
#####

# Dados Simulados:
# - arima.sim: função do pacote stats que nos permite simular um modelo arima, usando:
#    - model: uma lista com as especificações ar, diff e ma do modelo com as seguintes opções:
#      - order: a ordem do modelo (no exemplo abaixo, arima(0,0,1), ou seja um arma(0,1))
#      - ar: valores para os parâmetros ar do modelo (no exemplo abaixo não temos nenhum valor porque em order não especificamos ar)
#      - ma: valores para os parâmetros ma do modelo (no exemplo abaixo, apenas um valor para o ma1)
#    - n: o tamanho da série temporal a ser simulada
#    - rand.gen: a função a ser usada para gerar os resíduos do modelo. Abaixo, usamos a função
# rnorm o que torna os resíduos normalmente distribuídos. Outra alternativa, seria usar a função
# rt para resíduos distribuídos conforme uma t de Student. 
ma1 <- stats::arima.sim(model = list(order = c(0,0,1), 
                                     ma = c(0.3)), 
                        n = 1000, 
                        rand.gen = rnorm)

# Gráfico da série temporal simulada
plot.ts(ma1, main = "MA(1) Simulado", xlab = "", ylab = "")

# Função de autocorrelação
acf_ma1 <- stats::acf(ma1, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação. 
# a opção adj define a posição do titulo no que tange mais à esquerda (próximo de zero)
# ou mais à direita (próximo de 1). 0.5 significa no meio, ou seja, centralizado. 
# a opção line define a altura do título quanto maior o valor, mas distante.
plot(acf_ma1, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC)", adj = 0.5, line = 1)

# Função de autocorrelação parcial
pacf_ma1 <- stats::pacf(ma1, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação parcial. 
plot(pacf_ma1, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP)", adj = 0.5, line = 1)

# Estimação do Modelo MA(1)
model1 <- arima(ma1, order=c(0,0,1))
coeftest(model1)
names(model1)
model1$coef

#####
##   MA(2)
#####

# Dados Simulados
ma2 <- stats::arima.sim(model = list(order = c(0,0,2), 
                                     ma = c(0.3,0.5)), 
                        n = 1000, 
                        rand.gen = rnorm)

# Gráfico da série temporal simulada
plot.ts(ma2, main = "MA(2) Simulado", xlab = "", ylab = "")

# Função de autocorrelação
acf_ma2 <- stats::acf(ma2, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação. 
plot(acf_ma2, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC)", adj = 0.5, line = 1)

# Função de autocorrelação parcial
pacf_ma2 <- stats::pacf(ma2, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação parcial. 
plot(pacf_ma2, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP)", adj = 0.5, line = 1)

# Estimação do Modelo MA(2)
model2 <- arima(ma2, order=c(0,0,2))
coeftest(model2)
names(model2)
model2$coef

#####
##   MA(3)
#####

# Dados Simulados
ma3 <- stats::arima.sim(model = list(order =c(0,0,3), 
                                     ma = c(0.3,0.5,-0.4)), 
                        n = 1000, 
                        rand.gen = rnorm)

# Gráfico da série temporal simulada
plot.ts(ma3, main = "MA(3) Simulado", xlab = "", ylab = "")

# Função de autocorrelação
acf_ma3 <- stats::acf(ma3, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação. 
plot(acf_ma3, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC)", adj = 0.5, line = 1)

# Função de autocorrelação parcial
pacf_ma3 <- stats::pacf(ma3, na.action = na.pass, plot = FALSE, lag.max = 15)

# Gráfico da função de autocorrelação parcial. 
plot(pacf_ma3, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP)", adj = 0.5, line = 1)

# Estimação do Modelo MA(3)
model3 <- arima(ma3, order=c(0,0,3))
coeftest(model3)
names(model3)
model3$coef

