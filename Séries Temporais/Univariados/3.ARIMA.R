################################
####     MODELO ARIMA      #####
################################

#####
##   PACOTES NECESSÁRIOS
#####

source("C:/Users/henri/Documents/R/arquivos/install_and_load_packages.R")

#################################
####    AÇÃO DA MICROSOFT     ####
##################################

#####
##   1: Visualizar os dados e identificar observações fora do padrão (outliers ou dados faltantes) e eliminá-las
#####

# Coletando dados do Yahoo Finance (https://finance.yahoo.com/) usando o pacote
# quantmod (https://www.quantmod.com/). Uma breve documentação do pacote pode ser
# encontrada neste link (http://statmath.wu.ac.at/~hornik/QFS1/quantmod-vignette.pdf) e 
# exemplos estão disponíveis em https://rpubs.com/hudsonchavs/coletardados
#microsoft <- quantmod::getSymbols("MSFT", src = "yahoo", warnings = FALSE, auto.assign = FALSE, return.class = "xts")
microsoft <- read_excel("C:/Users/henri/Documents/R/arquivos/microsoft.xls")


View(microsoft)
microsoft$MSFT.Close <- microsoft$Fechamento

logmicrosoft <- log(microsoft$MSFT.Close[1:7057]) - log(microsoft$MSFT.Close[2:7058])

# Gráfico da série temporal
par(mfrow=c(1,1)) 
#plot.xts(microsoft$MSFT.Close, xlab = "", ylab = "", main = "Preço da ação da Microsoft")
plot.ts(microsoft$MSFT.Close, xlab = "", ylab = "", main = "Preço da ação da Microsoft")
plot.ts(log(microsoft$MSFT.Close), xlab = "", ylab = "", main = "Preço da ação da Microsoft")

# Caso fosse necessário diminuir o impacto de outliers ou dados faltantes nos dados, uma alternativa é usar 
# uma transformação nos mesmos. Abaixo, mostramos como isso poderia ser feito para a nossa ação, lembrando 
# que continuamos com os dados sem transformação e este é apenas um exemplo
# Aqui, usamos a função tsclean do pacote forecast para substituir outliers da série. 
# A função tem as seguintes opções
# - x: série temporal que será tratada
# - replace.missing: TRUE ou FALSE para substituir NA por meio da interpolação entre valores antes e após o NA
# - lambda: parâmetro para a transformação de Box-Cox. Mais detalhes em http://www.portalaction.com.br/manual-estatistica-basica/transformacao-de-dados
microsoft_clean <- forecast::tsclean(x = microsoft$MSFT.Close, replace.missing = TRUE)

#####
##   2: Se necessário, transformar os dados para estabilizar a variância (logaritmo dos dados, variação ou retorno, por exemplo)
#####

# Calcular o retorno do fechamento dos preços da ação da Microsoft usando o logaritmo [lnPt-ln(Pt-1)]
# Usamos a função Return.calculate do pacote PerformanceAnalytics. Uma breve documentação do pacote
# pode ser encontrada neste link (http://braverock.com/brian/R/PerformanceAnalytics/html/PerformanceAnalytics-package.html)
#logmicrosoft <- PerformanceAnalytics::Return.calculate(microsoft$MSFT.Close, method = "log")
#logmicrosoft <- PerformanceAnalytics::Return.calculate(microsoft$Fechamento, method = "log")

# Gráfico da série temporal dos retornos.
plot.ts(logmicrosoft, xlab = "", ylab = "", main = "Retornos da ação da Microsoft")
 
par(mfrow=c(2,1))
plot.ts(microsoft$MSFT.Close, xlab = "", ylab = "", main = "Preço da ação da Microsoft")
plot.ts(logmicrosoft, xlab = "", ylab = "", main = "Retornos da ação da Microsoft")
plot.ts(logmicrosoft, xlab = "", ylab = "", main = "Retornos da ação da Microsoft")

#####
##   3: Testar se os dados são estacionários.
#####

#dicker fuller + adtest
# Aqui, usamos a função adfTest do pacote fUnitRoots para testar se há raiz unitária
# na série temporal avaliada. Como observamos no gráfico da série, não há tendência
# nos dados e assim o teste verificará se a série se comporta como um passeio aleatório
# sem drift. Isto é possível por meio da opção type que tem as seguintes alternativas:
# - nc: for a regression with no intercept (constant) nor time trend (passeio aleatório)
# - c: for a regression with an intercept (constant) but no time trend (passeio aleatório com drift)
# - ct: for a regression with an intercept (constant) and a time trend (passeio aleatório com constante e tendência)
# Além disso, definimos que no máximo duas defasagens da série devem ser usadas como
# variáveis explicativas da regressão do teste. As hipóteses do teste são:
# - H0: raiz unitária (passeio aleatório)
# - H1: sem raiz unitária (não é um passeio aleatório)
unit_root_microsoft <- fUnitRoots::adfTest(microsoft$MSFT.Close, lags = 2, type = c("nc"))
print(unit_root_microsoft)

unit_root_microsoft <- fUnitRoots::adfTest(logmicrosoft, lags = 2, type = c("nc"))
print(unit_root_microsoft)

unit_root_microsoft <- fUnitRoots::adfTest(log(microsoft$MSFT.Close), lags = 2, type = c("nc"))
print(unit_root_microsoft)

# Como resultado do teste temos um p-valor de 0.01 indicando que rejeitamos a hipótese nula de
# presença de raiz unitária ao nível de 5% de significância. Assim, continuamos com a série de
# retornos e não com qualquer diferença da mesma.

#####
##   4: Examinar as funções de autocorrelação (FAC) e autocorrelação parcial (FACP) para determinar as ordens máximas P e Q para os componentes AR e MA da série estacionária (diferenciada, se necessário)
#####

# Calcular a FAC usando o objeto logmicrosoft (retornos)
#acf_microsoft <- stats::acf(logmicrosoft, plot = FALSE, na.action = na.pass, max.lag = 25)
acf_microsoft <- stats::acf(microsoft$MSFT.Close, plot = FALSE, na.action = na.pass, max.lag = 100)


# Calcular a FACP usando o objeto logmicrosoft (retornos)
#pacf_microsoft <- stats::pacf(logmicrosoft, plot = FALSE, na.action = na.pass, max.lag = 25)
pacf_microsoft <- stats::pacf(microsoft$MSFT.Close, plot = FALSE, na.action = na.pass, max.lag = 100)

# Gráfico da FAC e FACP.
plot(acf_microsoft, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC) dos Retornos da Microsoft", adj = 0.5, line = 1)
plot(pacf_microsoft, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP) dos Retornos da Microsoft", adj = 0.5, line = 1)


#####
##   5: Estimar todas as combinações para p, d e q. Aqui, d será fixo e igual ao número de vezes necessárias para tornar a série original estacionáira. Se não foi preciso diferenciar a série, d=0
#####

# Todas as combinações possíveis de p=0 até p=max e q=0 até q=max
pars_microsoft <- expand.grid(ar = 0:3, diff = 1, ma = 0:3)

#diff = 1 -> serie de precos
#diff = 0 -> serie log-retorno

# Local onde os resultados de cada modelo será armazenado
modelo_microsoft <- list()

# Estimar os parâmetros dos modelos usando Máxima Verossimilhança (ML). Por default, a função arima
# usa a hipótese de que o termo de erro dos modelos arima segue uma distribuição Normal
for (i in 1:nrow(pars_microsoft)) {
  modelo_microsoft[[i]] <- arima(x = log(microsoft$MSFT.Close), order = unlist(pars_microsoft[i, 1:3]), method = "ML")
}

for (i in 1:nrow(pars_microsoft)) {
  modelo_microsoft[[i]] <- arima(x = microsoft$MSFT.Close, order = unlist(pars_microsoft[i, 1:3]), method = "ML")
}

# Obter o logaritmo da verossimilhança (valor máximo da função)
log_verossimilhanca_microsoft <- list()
for (i in 1:length(modelo_microsoft)) {
  log_verossimilhanca_microsoft[[i]] <- modelo_microsoft[[i]]$loglik
}

# Calcular o AIC
aicarima_microsoft <- list()
for (i in 1:length(modelo_microsoft)) {
  aicarima_microsoft[[i]] <- stats::AIC(modelo_microsoft[[i]])
}

# Calcular o BIC
bicarima_microsoft <- list()
for (i in 1:length(modelo_microsoft)) {
  bicarima_microsoft[[i]] <- stats::BIC(modelo_microsoft[[i]])
}

# Quantidade de parâmetros estimados por modelo
quant_paramentros_microsoft <- list()
for (i in 1:length(modelo_microsoft)) {
  quant_paramentros_microsoft[[i]] <- length(modelo_microsoft[[i]]$coef)+1 # +1 porque temos a variância do termo de erro 
}

# Montar a tabela com os resultados
especificacao_microsoft <- paste0("ARIMA",pars_microsoft$ar, pars_microsoft$diff, pars_microsoft$ma)
tamanho_amostra_microsoft <- rep(length(microsoft$MSFT.Close), length(modelo_microsoft))
resultado_microsoft <- data.frame(especificacao_microsoft, ln_verossimilhanca = unlist(log_verossimilhanca_microsoft),
                                  quant_paramentros_microsoft =  unlist(quant_paramentros_microsoft), 
                                  tamanho_amostra_microsoft, 
                                  aic = unlist(aicarima_microsoft), bic = unlist(bicarima_microsoft))

# Mostrar a tabela de resultado
print(resultado_microsoft)

#####
##   6: Escolher dentre todos os modelos estimados no passo anterior, o modelo com menor AIC e/ou BIC.
#####

# Modelo com menor AIC e/ou BIC
best <- which.min(resultado_microsoft$aic)
best
best2 <- which.min(resultado_microsoft$bic)
best2

# Parâmetros estimados do modelo com menor AIC e/ou BIC
# Aqui, usamos o número 6 para selecionar o modelo escolhido anteriormente. 
# Observe que o modelo ARMA(1,1) estava na linha 6 da tabela com todos os 
# demais modelos. Para gerar a tabela usamos a função stargazer do pacote stargazer
#stargazer::stargazer(modelo_microsoft[[best]], type = "text", title = "Resultado Estimação modelo ARIMA(1,0,1)")
coeftest(modelo_microsoft[[best]])

#####
##   7: Examinar se os resíduos se comportam como ruído branco. Caso contrário, retornar ao passo 3 ou 4.
#####

# Teste de autocorrelação dos resíduos
#  - H0: resíduos são não autocorrelacionados
#  - H1: resíduos são autocorrelacionados
acf_arima101_est <- stats::acf(modelo_microsoft[[best]]$residuals, na.action = na.pass, plot = FALSE, lag.max = 15)
plot(acf_arima101_est, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC) dos Resíduos do ARIMA(1,0,1)", adj = 0.5, line = 1)
Box.test(modelo_microsoft[[best]]$residuals,type="Ljung",lag=1)

# Teste de heterocedasticidade condicional
#  - H0: quadrado dos resíduos são não autocorrelacionados
#  - H1: quadrado dos resíduos são autocorrelacionados
acf_arima101_square <- acf(modelo_microsoft[[best]]$residuals^2, na.action = na.pass, plot = FALSE, lag.max = 20)
plot(acf_arima101_square, main = "", ylab = "", xlab = "Defasagem")
title("FAC do quadrado dos resíduos do ARIMA(1,0,1)", adj = 0.5, line = 1)
Box.test(modelo_microsoft[[best]]$residuals^2,type="Ljung",lag=1)
#archTest(modelo_microsoft[[best]]$residuals)

# Teste de Normalidade dos resíduos. As hipóteses para os dois testes são:
#  - H0: resíduos normalmente distribuídos
#  - H1: resíduos não são normalmente distribuídos
#shapiro.test(na.remove(modelo_microsoft[[6]]$residuals))
#normalTest(na.remove(modelo_microsoft[[best]]$residuals), method = "sw")
#jarque.bera.test(na.remove(modelo_microsoft[[6]]$residuals))
jarque.bera.test(na.remove(modelo_microsoft[[best]]$residuals))

# Gráfico do valores estimados para a série temporal e seus verdadeiros valores
fitted_microsoft <- stats::fitted(modelo_microsoft[[best]])
plot.ts(microsoft$MSFT.Close, type = "l", lty = 1, col = 2)
lines(fitted_microsoft, type = "l", lty = 1, col = 1)
legend("topright", legend = c("Real", "Ajustado"), col = c(2,1), lty = c(1,1))

logmicrosoft_fitted <- log(fitted_microsoft[1:7057]) - log(fitted_microsoft[2:7058])
par(mfrow=c(1,1)) 
plot.ts(logmicrosoft, type = "l", lty = 1, col = 2)
lines(logmicrosoft_fitted, type = "l", lty = 1, col = 1)
legend("topright", legend = c("Real", "Ajustado"), col = c(2,1), lty = c(1,1))




#####
##   8: Uma vez que os resíduos são ruído branco, obter as previsões.
#####

# Como os resíduos possuem heterocedasticidade condicional e a distribuição não se comporta como uma Normal
# assim como assumido no processo de estimação, não é recomendável usar o modelo para fazer previsões.

##################################
######        IPCA         #######
##################################

#####
##   1: Visualizar os dados e identificar observações fora do padrão (outliers ou dados faltantes) e eliminá-las
#####

# Definir sua api key (mais detalhes em https://www.rpubs.com/frank-pinho/517779)
Quandl.api_key('3gMh2BSgyDSpD4qxrsaT')

# Coletar a série temporal do IPCA diretamente do BACEN usando o Quandl (mais detalhes em https://rpubs.com/hudsonchavs/coletardados)
ipca <- Quandl::Quandl("BCB/1341", start_date = "1996-01-01", type = "ts")

# Gráfico da série temporal
par(mfrow=c(1,1))
plot(ipca, xlab = "", ylab = "", main = "Variação percentual do IPCA - mensal")

#####
##   2: Se necessário, transformar os dados para estabilizar a variância (logaritmo dos dados, variação ou retorno, por exemplo)
#####

#####
##   3: Testar se os dados são estacionários.
#####

# Aqui, usamos a função adfTest do pacote fUnitRoots para testar se há raiz unitária
# na série temporal avaliada. Como observamos no gráfico da série, não há tendência
# nos dados e assim o teste verificará se a série se comporta como um passeio aleatório
# sem drift. Isto é possível por meio da opção type que tem as seguintes alternativas:
# - nc: for a regression with no intercept (constant) nor time trend (passeio aleatório)
# - c: for a regression with an intercept (constant) but no time trend (passeio aleatório com drift)
# - ct: for a regression with an intercept (constant) and a time trend (passeio aleatório com constante e tendência)
# Além disso, definimos que no máximo duas defasagens da série devem ser usadas como
# variáveis explicativas da regressão do teste. As hipóteses do teste são:
# - H0: raiz unitária (passeio aleatório)
# - H1: sem raiz unitária (não é um passeio aleatório)
unit_root_ipca <- fUnitRoots::adfTest(ipca, lags = 2, type = c("nc"))
print(unit_root_ipca)

# Como resultado do teste temos um p-valor de 0.01 indicando que rejeitamos a hipótese nula de
# presença de raiz unitária ao nível de 5% de significância. Assim, continuamos com a série da
# variação percentual do ipca e não com qualquer diferença da mesma.

#####
##   4: Examinar as funções de autocorrelação (FAC) e autocorrelação parcial (FACP) para determinar as ordens máximas P e Q para os componentes AR e MA da série estacionária (diferenciada, se necessário)
#####

# Calcular a FAC usando o objeto ipca 
acf_ipca <- stats::acf(ipca, plot = FALSE, na.action = na.pass, max.lag = 25)

# Calcular a FACP usando o objeto ipca
pacf_ipca <- stats::pacf(ipca, plot = FALSE, na.action = na.pass, max.lag = 25)

# Gráfico da FAC e FACP
plot(acf_ipca, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC) do IPCA", adj = 0.5, line = 1)
Box.test(ipca, type="Ljung", lag=1)

plot(pacf_ipca, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação Parcial (FACP) do IPCA", adj = 0.5, line = 1)

#####
##   5: Estimar todas as combinações para p, d e q. Aqui, d será fixo e igual ao número de vezes necessárias para tornar a série original estacionáira. Se não foi preciso diferenciar a série, d=0
#####

# Todas as combinações possíveis de p=0 até p=max e q=0 até q=max
pars_ipca <- expand.grid(ar = 0:1, diff = 1, ma = 0:4)

# Local onde os resultados de cada modelo será armazenado
modelo_ipca <- list()

# Estimar os parâmetros dos modelos usando Máxima Verossimilhança (ML). Por default, a função arima
# usa a hipótese de que o termo de erro dos modelos arima segue uma distribuição Normal
for (i in 1:nrow(pars_ipca)) {
  modelo_ipca[[i]] <- arima(x = ipca, order = unlist(pars_ipca[i, 1:3]), method = "ML")
}

# Obter o logaritmo da verossimilhança (valor máximo da função)
log_verossimilhanca_ipca <- list()
for (i in 1:length(modelo_ipca)) {
  log_verossimilhanca_ipca[[i]] <- modelo_ipca[[i]]$loglik
}

# Calcular o AIC
aicarima_ipca <- list()
for (i in 1:length(modelo_ipca)) {
  aicarima_ipca[[i]] <- stats::AIC(modelo_ipca[[i]])
}

# Calcular o BIC
bicarima_ipca <- list()
for (i in 1:length(modelo_ipca)) {
  bicarima_ipca[[i]] <- stats::BIC(modelo_ipca[[i]])
}

# Quantidade de parâmetros estimados por modelo
quant_paramentros_ipca <- list()
for (i in 1:length(modelo_ipca)) {
  quant_paramentros_ipca[[i]] <- length(modelo_ipca[[i]]$coef)+1 # +1 porque temos a variância do termo de erro 
}

# Montar a tabela com os resultados
especificacao_ipca <- paste0("ARIMA",pars_ipca$ar,pars_ipca$diff,pars_ipca$ma)
tamanho_amostra_ipca <- rep(length(ipca), length(modelo_ipca))
resultado_ipca <- data.frame(especificacao_ipca, ln_verossimilhanca = unlist(log_verossimilhanca_ipca),
                             quant_paramentros_ipca =  unlist(quant_paramentros_ipca), 
                             tamanho_amostra_ipca, aic = unlist(aicarima_ipca), 
                             bic = unlist(bicarima_ipca))

# Mostrar a tabela de resultado
print(resultado_ipca)

#####
##   6: Escolher dentre todos os modelos estimados no passo anterior, o modelo com menor AIC e/ou BIC.
#####

# Modelo com menor AIC e/ou BIC
best = which.min(resultado_ipca$aic)
best
best2 = which.min(resultado_ipca$bic)
best2

# Parâmetros estimados do modelo com menor AIC e/ou BIC
#stargazer(modelo_ipca[[2]], type = "text", title = "Resultado Estimação modelo ARIMA(1,0,0)")
coeftest(modelo_ipca[[best]])
coeftest(modelo_ipca[[best2]])

#####
##   7: Examinar se os resíduos se comportam como ruído branco. Caso contrário, retornar ao passo 3 ou 4.
#####

# Teste de autocorrelação dos resíduos
#  - H0: resíduos são não autocorrelacionados
#  - H1: resíduos são autocorrelacionados
acf_arima100_est <- stats::acf(modelo_ipca[[best]]$residuals, na.action = na.pass, plot = FALSE, lag.max = 15)
plot(acf_arima100_est, main = "", ylab = "", xlab = "Defasagem")
title("Função de Autocorrelação (FAC) dos Resíduos", adj = 0.5, line = 1)
Box.test(modelo_ipca[[best]]$residuals, type="Ljung", lag=1)

# Teste de heterocedasticidade condicional
#  - H0: quadrado dos resíduos são não autocorrelacionados
#  - H1: quadrado dos resíduos são autocorrelacionados
acf_arima100_square <- acf(modelo_ipca[[best]]$residuals^2, na.action = na.pass, plot = FALSE, lag.max = 20)
plot(acf_arima100_square, main = "", ylab = "", xlab = "Defasagem")
title("FAC do quadrado dos resíduos do ARIMA(1,0,0)", adj = 0.5, line = 1)
Box.test(modelo_ipca[[best]]$residuals^2, type="Ljung", lag=1)
#archTest(modelo_ipca[[best]]$residuals)

# Teste de Normalidade dos resíduos. As hipóteses para os dois testes são:
#  - H0: resíduos normalmente distribuídos
#  - H1: resíduos não são normalmente distribuídos
#shapiro.test(na.remove(modelo_ipca[[best]]$residuals))
normalTest(na.remove(modelo_ipca[[best]]$residuals), method = "sw")
#jarque.bera.test(na.remove(modelo_ipca[[best]]$residuals))
normalTest(na.remove(modelo_ipca[[best]]$residuals), method = "jb")

#####
##   8: Se os resíduos são ruído branco, obtem-se as previsões.
#####

# Previsão do valor médio condicional esperado e respectivo desvio
# - object: o modelo escolhido anteriormente
# - level: o intervalo de confiança (abaixo, 80%)
# - h: o horizonte de previsão
forecast::forecast(object = modelo_ipca[[best]], level = 95, h = 10)

# gráfico da previsão
plot(forecast::forecast(object = modelo_ipca[[best]], level = 95, h = 10))

# http://faculty.chicagobooth.edu/ruey.tsay/teaching/bs41202/sp2017/IntroPackages.pdf
# http://www.unstarched.net/r-examples/rugarch/a-short-introduction-to-the-rugarch-package/
