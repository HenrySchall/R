###########################
### Tratamento de dados ###
###########################

getwd() #representa o diretório de trabalho atual do processo R
setwd("C:/Users/henri/OneDrive/Repositórios") #comando para definir o diretório de trabalho

dados <- read.csv2("C:/Users/henri/OneDrive/Repositórios/Datasets/chuva_mensal_sp.csv",
sep = ";", header=TRUE, encoding="UTF-8")

View(dados)

#############################
### Tipagem dos atributos ###
#############################

# EXISTEM 7 TIPOS BÁSICOS:
# character (caracteres)
# integer (números inteiros)
# numeric (números reais)
# logical (falso ou verdadeiro)
# complex (n?meros complexos)
# factor (fator: Sequ?ncia de valores definidos por n?veis)
# date (data)

str(dados)

###########################
### Modificando tipagem ###
###########################

# Nesse caso não foi necessário
# dados$Janeiro <- as.numeric(dados$Janeiro)
# dados$Fevereiro <- as.numeric(dados$Fevereiro)
# dados$Março <- as.numeric(dados$Março)
# dados$Maio <- as.numeric(dados$Maio)
# dados$Junho <- as.numeric(dados$Junho)
# dados$Julho <- as.numeric(dados$Julho)
# dados$Agosto <- as.numeric(dados$Agosto)
# dados$Setembro <- as.numeric(dados$Setembro)
# dados$Outubro <- as.numeric(dados$Outubro)
# dados$Novembro <- as.numeric(dados$Novembro)
# dados$Dezembro <- as.numeric(dados$Dezembro)

# View(dados)

#####################################
######   Eliminando linha    ########
#####################################

dados <- dados [c(-25),] 
# dados <- dados %>% filter(ano!="Media")

View(dados)

#######################
### Eliminar coluna ###
#######################

dados <- subset(dados, select = -c(Ano))

###################################
### Verificando valores missing ###
###################################

# NA = valores ausentes (iguais a zero)
# NAN = not a number(valor indefinido)
sapply(dados, function(x) sum(is.na(x)))
sapply(dados, function(x) sum(is.nan(x)))

##################################
### Substituir valores missing ###
##################################

# Substituindo pela média
dados$Janeiro[is.na(dados$Janeiro)] <- mean(dados$Janeiro[which(dados$Janeiro!='NA')])
dados$Fevereiro[is.na(dados$Fevereiro)] <- mean(dados$Fevereiro[which(dados$Fevereiro!='NA')])
dados$Março[is.na(dados$Março)] <- mean(dados$Março[which(dados$Março!='NA')])
dados$Maio[is.na(dados$Maio)] <- mean(dados$Maio[which(dados$Maio!='NA')])
dados$Junho[is.na(dados$Junho)] <- mean(dados$Junho[which(dados$Junho!='NA')])
dados$Julho[is.na(dados$Julho)] <- mean(dados$Julho[which(dados$Julho!='NA')])
dados$Agosto[is.na(dados$Agosto)] <- mean(dados$Agosto[which(dados$Agosto!='NA')])
dados$Setembro[is.na(dados$Setembro)] <- mean(dados$Setembro[which(dados$Setembro!='NA')])
dados$Outubro[is.na(dados$Outubro)] <- mean(dados$Outubro[which(dados$Outubro!='NA')])
dados$Novembro[is.na(dados$Novembro)] <- mean(dados$Novembro[which(dados$Novembro!='NA')])
dados$Dezembro[is.na(dados$Dezembro)] <- mean(dados$Dezembro[which(dados$Dezembro!='NA')])

View(dados)

##############################
### Exportação de arquivos ###
##############################

write.table(dados, file ="chuvas_mensal_sp_tratado.csv", sep = ";")

