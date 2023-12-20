library(dplyr)
library(tidyverse)
library(TeachingDemos)
library(EnvStats)
library(dygraphs)
library(xtable)
library(stargazer)
library(highcharter)
library(quantmod)
library(dygraphs)
library(tseries)
library(htmltools)
library(Quandl)
library(nycflights13)
library(magrittr)
library(discreteRV)
library(aTSA)
library(fGarch)
library(fUnitRoots)
library(vars)
library(MTS)
library(seasonal)
library(dynlm)
library(tbl2xts)
library(dlm)
library(stats)
library(tcltk)
library(forecast)
library(ggplot2)
library(PerformanceAnalytics)
library(nortest)
library(scales)
library(readxl)

dadosx <- read_excel("C:/Users/henri/OneDrive/Repositórios/venda.xls")
dados_l <- dadosx$"valor"
dados <- ts(dados_l, frequency = 12, star= c(1990,1))

glimpse(dados)
View(dados)

dygraphs::dygraph(dados, main = "Vendas de Automóveis pelas Concessionárias") %>% dyRangeSelector()

### Examinar a existência de tendência e/ou sazonalidade nos dados ###

par(mfrow=c(1,1)) 
decomp <- stats::stl(dados, "periodic")
colnames(decomp$time.series) = c("sazonalidade","tendência","restante")
plot(decomp)

### Verificando a necessidade de transformar os dados para estabilizar a variância ###

dadosl <- (log(dados))
par(mfrow=c(2,1)) 
plot(dados, xlab = "Mensal", ylab = "Vendas de Automóveis pelas Concessionárias", main = "Variação")
plot(dadosl, xlab = "Mensal", ylab = "Log Vendas de Automóveis pelas Concessionárias", main = "Variação")

#necessita logartimizar a séries porque os dados tem alta variabilidade

### Testar se os dados são estacionários ###

# Caso tenha raiz unitária é preciso diferenciar os dados até se tornarem estacionários. Para isso, testa-se novamente se a série diferenciada se tornou estacionária.

# - H0: raiz unitária (passeio aleatório)
# - H1: sem raiz unitária (não é um passeio aleatório)

adf_dados <- fUnitRoots::adfTest(dadosl, lags = 12, type = c("nc"))
print(adf_dados)

# Necessito diferenciar os dados p-valor > 10% (nível de significância)
-------------------------------------------------------------------------------------
"Não rejeito H0 -> não estacionário, como resultado do teste temos um p-valor > 10%, 
há presença de raiz unitária. Assim, a série apresenta raiz unitária e precisamos 
aplicar diferenciação para torná-la estacionária."
--------------------------------------------------------------------------------------

# Realizando 1 diferença
dados_diff <- timeSeries::diff(timeSeries::diff(dadosl, lag = 1, differences = 1), lag = 12, differences = 1)
par(mfrow=c(1,1)) 
plot(dados_diff)

adf_dados_diff <- fUnitRoots::adfTest(dados_diff, lags = 12, type = c("nc"))
print(adf_dados_diff)

# Uma diferença é o suficiente
-------------------------------------------------------------------------------------------
"Examinar as funções de autocorrelação parcial (FAC) e autocorrelação parcial (FACP) 
para determinar as ordens máximas P e Q para os componentes AR e MA tanto da parte regular 
quanto da parte sazonal da série estacionária:"
-------------------------------------------------------------------------------------------

#####################
### Sem diferença ###
#####################

# Calcular a FAC
acf_dadosl<- stats::acf(dadosl, plot = FALSE, na.action = na.pass, lag.max = 24)

# Calcular a FACP 
pacf_dadosl<- stats::pacf(dadosl, plot = FALSE, na.action = na.pass, lag.max = 24)

# Gráfico da FAC e FACP.
par(mfrow=c(2,1))
plot(dadosl, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC)", adj = 0.5, line = 1)
plot(dadosl, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP)", adj = 0.5, line = 1)

#######################
###  Com diferença  ###
#######################

# Calcular a FAC 
acf_dados_diff <- stats::acf(dados_diff, plot = FALSE, na.action = na.pass, lag.max = 36)

# Calcular a FACP 
pacf_dados_diff <- stats::pacf(dados_diff, plot = FALSE, na.action = na.pass, lag.max = 36)

# Gráfico da FAC e FACP.
plot(acf_dados_diff, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC)", adj = 0.5, line = 1)
plot(pacf_dados_diff, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP)", adj = 0.5, line = 1)

#############################
### Selecionando o modelo ###
#############################

pars_dados <- expand.grid (ar = 0, diff = 1, ma = 0, ars = 0:1, diffs = 0:1, mas = 0:1)
modelos <- list()

for (i in 1:nrow(pars_dados)) {
  modelos[[i]] <- arima(x = dados, order = unlist(pars_dados[i, 1:3]), 
                        seasonal = list(order = unlist(pars_dados[i,4:6]), period = 12), method = "ML")
}

log_verossimilhanca <- list()

for (i in 1:length(modelos)){
  log_verossimilhanca[[i]] <- modelos[[i]]$loglik
}

# Calcular o AIC
aic_sarima <- list()

for (i in 1:length(modelos)) {
  aic_sarima[[i]] <- stats::AIC(modelos[[i]])
}

# Calcular o BIC
bic_sarima <- list()

for (i in 1:length(modelos)) {
  bic_sarima[[i]] <- stats::BIC(modelos[[i]])
}

#Quantidade de parâmetros estimados por modelo
quant_parametros <- list()

for (i in 1:length(modelos)) {
  quant_parametros[[i]] <- length(modelos[[i]]$coef)+1 
}

especificacao <- paste0("SARIMA",pars_dados$ar, pars_dados$diff, pars_dados$ma, pars_dados$ars,
                        pars_dados$diffs, pars_dados$mas)

resultado <- data.frame(especificacao,
                        ln_verossimilhanca = unlist(log_verossimilhanca),
                        quant_parametros = unlist(quant_parametros),                         
                        aic = unlist(aic_sarima), 
                        bic = unlist(bic_sarima))

print(resultado)

best1 <- which.min(resultado$aic)
print(best1)

best2 <- which.min(resultado$bic)
print(best2)

coeftest(modelos[[best1]])

###########################
### Validação do Modelo ###
###########################

# Teste de autocorrelação dos resíduos
#  - H0: resíduos são não autocorrelacionados
#  - H1: resíduos são autocorrelacionados
Box.test(modelos[[best1]]$residuals,type="Ljung",lag = 24)

# Teste de heterocedasticidade condicional
#  - H0: quadrado dos resíduos são não autocorrelacionados
#  - H1: quadrado dos resíduos são autocorrelacionados
Box.test(modelos[[best1]]$residuals^2,type="Ljung",lag = 24)

# Teste de Normalidade dos resíduos.
#  - H0: resíduos normalmente distribuídos
#  - H1: resíduos não são normalmente distribuídos
jarque.bera.test(modelos[[best1]]$residuals)

################
### Previsão ###
################

# Uma vez que os resíduos são ruído branco, obter as previsões.

modelo_prev <- arima(dados, order = c(0,1,0), seasonal = list(order=c(0,1,1), period = 12))
prev <- predict(modelo_prev, n.ahead = 12)
print(prev)

#Gráfico da previsão

plot(forecast::forecast(object = modelo_prev, Title = , h = 12, level = 0.95))

# Gráfico Real x Previsto
par(mfrow=c(1,1))
Modelo_RealxModelo_Previsto <- stats::fitted(modelo_prev)
plot(Modelo_RealvsModelo_Previsto, type = "l", lty = 1, col = 2)
lines(dados, type = "l", lty = 1, col = 4)
legend("topleft", legend = c("Ajustado", "Real"), col = c(1,2), lty = c(1,3))
