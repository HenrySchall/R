############################
### IMPORTAÇÃO DOS DADOS ###
############################
# Tipo de dado que queremos no R
# - ts: série temporal
# - zoo: objeto zoo 
# - xts: no formato xts
# - timeSeries: série financeira

# Configurando API (https://data.nasdaq.com/publishers/QDL) -> criar sua própria API Key
Quandl.api_key("iVtrK8_YHwXzG9pA4mmQ")

###########
### SGS ###
###########

dados <- gbcbd_get_series(id = 4380, first.date = "2000-01-01",last.date = Sys.Date())
View(dados)
dygraph(dados, main = "Título") %>% dyRangeSelector()

# Criando série
dados_x <- dados$"value"
serie <- ts(dados_x, frequency = 12, star= c(2000), end=(2004))
title("Título")
plot(serie)

# Se tivermos uma base tratada, uma outra alterntiva seria transformar dataframe em vetor.
# dados_vec <- as.vector(t(dados))
# print(dados_vec)

############
### IPEA ###
############

series_ipeadata <- available_series()
filter(series_ipeadata,str_detect(source, regex("caged", ignore_case = TRUE)))
View(series_ipeadata)

#Selecionando a série desejada
glp <- ipeadata("ANP_CGASN")
View(glp)

dados_x <- glp$"value"
gnp_serie <- ts(dados_x, frequency = 12, star= c(2005))
plot(gnp_serie)

#################
### Excel/CSV ###
#################

getwd() #representa o diretório de trabalho atual do processo R
setwd("C:/Users/henri/OneDrive/Repositórios")

dados <- read.csv2("C:/Users/henri/OneDrive/Repositórios/R/Introdução/Datasets/chuva_mensal_sp.csv",
sep = ";", header=TRUE, encoding="UTF-8")

dados <- read_excel("C:/Users/henri/OneDrive/Repositórios/R/Introdução/Datasets/chuva_mensal_sp.xls")
View(dados)

# header = cabeçario
# stringsAsFactors = considerar todas as caracteres como fatores
# sep = separando as variáveis 
# fileEncoding = "UTF-8" or "latin1"
# read.csv -> o default é sep=”,” e dec=”.”
# read.csv2 -> o default é sep=”;” e dec=”,”.

#####################
### Yahoo Finance ###
#####################

microsoft <- getSymbols("MSFT", src = "yahoo", auto.assign = FALSE, return.class = 'xts')
View(microsoft)
plot(microsoft)

# Open: O preço de abertura nas datas especificadas
# High: O preço da alta nas datas especificadas
# Low: O preço da baixa nas datas especificadas
# Close: O preço de fechamento nas datas especificadas
# Volume: O volume nas datas especificadas
# Adjusted: O preço de fechamento ajustado depois de aplicar distribuições de dividendos ou divisão da ação.
