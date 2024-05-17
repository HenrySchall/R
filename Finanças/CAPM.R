######################################
#### Importando dados Financeiros ####
######################################

# Pacotes necessários
# caso nao funcione usar funcao library()
source("C:/Users/henri/Documents/R/arquivos/install_and_load_packages.R")

#O quantmod (Quantitative Financial Modelling & Trading Framework for R) 
#é um pacote que tem como objetivo facilitar o acesso a dados financeiros e 
#disponibilizar funcionalidades permitam a análise de tais dados. 
#Em função disto, permite acessar dadod do Yahoo Finance, Google Finance, 
#dentre outros.

#Dados do Yahoo Finance e Google Finance

# Coletar os dados da VALE3.SA do Yahoo Finance. Temos as seguintes opções:
# - google: Google Finance
# - FRED: Federal Reserve Bank of St. Louis
# A opção auto.assign define se os dados devem ser incorporados no R com o nome
# do symbol ou um nome específico (auto.assign = FALSE). No nosso caso, optamos
# pelo nome vale.
vale <- quantmod::getSymbols("VALE3.SA", src = "yahoo", auto.assign = FALSE)

# Coletar os dados para um período específico
vale <- quantmod::getSymbols("VALE3.SA", src = "yahoo", auto.assign = FALSE, from = '2015-01-01', to = '2015-12-31')

# Coletar os dados de uma data específica até a última observação disponível sobre a ação
vale <- quantmod::getSymbols("VALE3.SA", src = "yahoo", auto.assign = FALSE, from = '2017-01-01')

# Coletar definido o tipo de dado que queremos no R
# - ts: série temporal
# - zoo: objeto zoo 
# - xts: no formato xts

vale <- quantmod::getSymbols("VALE3.SA", src = "yahoo", auto.assign = TRUE, from = '2017-01-01', return.class = 'xts')

# Formato da saída
knitr::kable(head(VALE3.SA), align = "c")

#Open: O preço de abertura nas datas especificadas
#High: O preço da alta nas datas especificadas
#Low: O preço da baixa nas datas especificadas
#Close: O preço de fechamento nas datas especificadas
#Volume: O volume nas datas especificadas
#Adjusted: O preço de fechamento ajustado depois de aplicar distribuições de 
#dividendos ou divisão da ação

# Calcular o retorno diário usando o log(p_t) - log(p_t-1). 
daily_return <- PerformanceAnalytics::Return.calculate(VALE3.SA$VALE3.SA.Close, method = "log")
daily_return <- periodReturn(VALE3.SA$VALE3.SA.Close,type="log",period="daily")

# Alterar o nome da coluna do objeto para VALE3.SA
colnames(daily_return) <- "VALE3.SA"

# Outra opção é o retorno diário por meio da opção method = "discrete"
daily_return <- PerformanceAnalytics::Return.calculate(VALE3.SA$VALE3.SA.Close, method = "discrete")
daily_return <- periodReturn(VALE3.SA$VALE3.SA.Close,type="arithmetic",period="daily")

# Outra opção é alterar a periodicidade dos retornos, neste caso tem-se o log-retorno mensal 
monthly_return <- periodReturn(VALE3.SA$VALE3.SA.Close,type="log",period="monthly")

# Visualizar os dados usando o pacote dygraphs. Mais detalhes em
# https://rstudio.github.io/dygraphs/
dygraphs::dygraph(daily_return, main = "Retorno Diário da VALE3.SA") %>% dyRangeSelector()
dygraphs::dygraph(monthly_return, main = "Retorno Mensal da VALE3.SA") %>% dyRangeSelector()

#############################
### Estimando modelo CAPM ###
#############################

# limpando a memória
rm(list=ls())

# carregando pacotes
library(quantmod) # cotações das ações e do Ibov
library()# Selic BACEN
library(ggplot2) # para gerar os gráficos
library(lmtest) # testes: breusch-godfrey, breuch-pagan
library(tseries) # jarque-bera 

#####################
###COLETA DE DADOS###
#####################

# Coleta das cotações mensais da petrobras e do ibovespa
getSymbols(c("PETR4.SA","^BVSP"),
           periodicity='monthly', 
           from='2000-01-01',
           to='2019-07-01'
)
[1] "PETR4.SA" "^BVSP"   
# Coleta da taxa selic mensal


# Checando a periodicidade dos dados da petrobras
periodicity(PETR4.SA)
periodicity(BVSP)
periodicity(selic)

# Gerando gráficos de cotações e índices
# petr4 
dygraphs::dygraph(PETR4.SA$PETR4.SA.Adjusted, main = "Preço Diário da PETR4.SA") %>% dyRangeSelector()

# ibov
dygraphs::dygraph(BVSP$BVSP.Adjusted, main = "Índice Bovespa") %>% dyRangeSelector()

########
##   CÁLCULO DOS RETORNOS
#####

# calculando retornos mensais petr4 e ibov com base no preço ajustado
dados <- merge(monthlyReturn(PETR4.SA[,6],type='log')[-1,], 
               monthlyReturn(BVSP[,6],type="log")[-1,]
)

# juntando os dados petr4, ibov e selic

dados <- merge(dados,as.xts(selic/100),join="inner")

# renomeando as colunas
names(dados) <- c("petr4","ibov","selic")
head(dados)

# Gerando gráficos dos retornos
# petr4 
dygraphs::dygraph(dados[,1], main = "Retorno Mensal da PETR4.SA") %>% dyRangeSelector()

# ibov
dygraphs::dygraph(dados[,2], main = "Retorno Mensal do Índice Bovespa") %>% dyRangeSelector()

# selic
dygraphs::dygraph(dados[,3], main = "Retorno Mensal SELIC") %>% dyRangeSelector()

# estimando o modelo de regressão do CAPM
mod1 <- lm(I(petr4 - selic) ~ I(ibov - selic), data=dados)
# mostrando os resultados
summary(mod1)

g6 <- ggplot(dados, aes(x=(ibov-selic), y=(petr4-selic))) + geom_point() + geom_smooth(method=lm, se=FALSE)
g6

########
##   ANÁLISE DOS RESÍDUOS
#####

g7 <- plot(mod1$residuals)


g8 <- plot.ts(mod1$residuals)


g9 <- hist(mod1$residuals)

# testando se os resíduos são normais
jarque.bera.test(mod1$residuals)

# testando se os resíduos da regressão estimada são homocedásticos (Breuch-Pagan)
# heteroscedasticidade
bptest(mod1)

# testando se há autocorrelação nos resíduos da regressão estimada (Breuch-Godfrey)
# autocorrelação
bgtest(mod1)