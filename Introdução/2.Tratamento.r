###########################
### Tratamento de dados ###
###########################

getwd() #representa o diretório de trabalho atual do processo R
setwd("C:/Users/henri/OneDrive/Códigos/R") #comando para definir o diretório de trabalho

dados <- read.csv("C:/Users/henri/OneDrive/Repositórios/R/Introdução/Dados/sell_bmw_eu.csv",
sep = ";", header=TRUE, stringsAsFactors=FALSE, fileEncoding="latin1")

# header = cabeçario
# stringsAsFactors = considerar todas as caracteres como fatores
# sep = separando as variáveis 
# fileEncoding = "UTF-8" or "latin1"
# read.csv -> separa as variáveis númericas por .
# read.csv2 -> separa as variáveis númericas por ,

str(dados) #mostra o tipo de dado

##############################################
### Verificando valores missing (Ausentes) ###
##############################################

# NA = valores ausentes
# NAN = not a number(valor indefinido)

sapply(chuva, function(x) sum(is.na(x)))
sapply(chuva, function(x) sum(is.nan(x)))

##################################
### Substituir valores missing ###
##################################

covid_sp2 <- replace(x = covid_sp,list = is.na(covid_sp), values=0)
sapply(covid_sp2, function(x) sum(is.na(x)))

# TIPAGEM DOS ATRIBUTOS (Variáveis)
# EXISTEM 7 TIPOS BÁSICOS:
# character (caracteres)
# integer (números inteiros)
# numeric (n?meros reais)
# logical (falso ou verdadeiro)
# complex (n?meros complexos)
# factor (fator: Sequ?ncia de valores definidos por n?veis)
# date (data)

#####################################
######   Eliminando linha    ########
#####################################

dados <- dados [c(-1),] 
View(dados)

##################################
### Modificando Tipo Primitivo ###
##################################

dados$model <- as.factor(dados$model)
dados$registration_date <- as.Date(dados$registration_date , format = "%Y-%m-%d") 
dados$sold_at <- as.Date(dados$sold_at, format = "%Y-%m-%d")

# Y maiúsculo significa que nosso formato possui 4 dígitos
# Format deve ser similar ao padrão do banco de dados

#######################
### Eliminar coluna ###
#######################

dados <- dados %>% mutate(maker_key = NULL)
dados <- dados %>% mutate(feature_1 = NULL)
dados <- dados %>% mutate(feature_2 = NULL)
dados <- dados %>% mutate(feature_3 = NULL)
dados <- dados %>% mutate(feature_4 = NULL)
dados <- dados %>% mutate(feature_5 = NULL)
dados <- dados %>% mutate(feature_6 = NULL)
dados <- dados %>% mutate(feature_7 = NULL)
dados <- dados %>% mutate(feature_8 = NULL)
dados <- dados %>% mutate(model_key = NULL)

dados
head(dados) # mostrando os 6 primeiros


#Substituir valores missing

chuva$Janeiro[is.na(chuva$Janeiro)] <- mean(chuva$Janeiro[which(chuva$Janeiro!='NA')])
chuva$Fevereiro[is.na(chuva$Fevereiro)] <- mean(chuva$Fevereiro[which(chuva$Fevereiro!='NA')])
chuva$Mar�o[is.na(chuva$Mar�o)] <- mean(chuva$Mar�o[which(chuva$Mar�o!='NA')])
chuva$Maio[is.na(chuva$Maio)] <- mean(chuva$Maio[which(chuva$Maio!='NA')])
chuva$Junho[is.na(chuva$Junho)] <- mean(chuva$Junho[which(chuva$Junho!='NA')])
chuva$Julho[is.na(chuva$Julho)] <- mean(chuva$Julho[which(chuva$Julho!='NA')])
chuva$Agosto[is.na(chuva$Agosto)] <- mean(chuva$Agosto[which(chuva$Agosto!='NA')])
chuva$Setembro[is.na(chuva$Setembro)] <- mean(chuva$Setembro[which(chuva$Setembro!='NA')])
chuva$Outubro[is.na(chuva$Outubro)] <- mean(chuva$Outubro[which(chuva$Outubro!='NA')])
chuva$Novembro[is.na(chuva$Novembro)] <- mean(chuva$Novembro[which(chuva$Novembro!='NA')])
chuva$Dezembro[is.na(chuva$Dezembro)] <- mean(chuva$Dezembro[which(chuva$Dezembro!='NA')])

sapply(chuva, function(x) sum(is.na(x)))
str(chuva)

#Excluir Linhas
chuva2 <- chuva %>% filter(ano!=2021)
chuva2 <- chuva2 %>% filter(ano!="Media")
View(chuva2)

# EXCLUIR UMA COLUNA
chuva2 <- subset(chuva2, select = -c(ano))

# Exporta��o de arquivos
write.table(chuva2, file ="chuva_tratado.csv", sep = ";")

chuva$Janeiro <- as.numeric(chuva$Janeiro)
chuva$Fevereiro <- as.numeric(chuva$Fevereiro)
chuva$Mar�o <- as.numeric(chuva$Mar�o)
chuva$Maio <- as.numeric(chuva$Maio)
chuva$Junho <- as.numeric(chuva$Junho)
chuva$Julho <- as.numeric(chuva$Julho)
chuva$Agosto <- as.numeric(chuva$Agosto)
chuva$Setembro <- as.numeric(chuva$Setembro)
chuva$Outubro <- as.numeric(chuva$Outubro)
chuva$Novembro <- as.numeric(chuva$Novembro)
chuva$Dezembro <- as.numeric(chuva$Dezembro)


# Renomeando vari�veis (colunas)
chuva <- rename(chuva, ano = X.U.FEFF.Ano)
View(chuva)
