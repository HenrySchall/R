##################
#### Ggplot2 #####
##################

# https://ggplot2.tidyverse.org/reference/ggplot.html"

dados <- read.csv2("C:/Users/henri/OneDrive/Repositórios/R/Introdução/Dados/sell_bmw_eu.csv",
header=TRUE, stringsAsFactors=FALSE, fileEncoding="latin1")

View(dados)
str(dados)

##########################
### Camadas do ggplot2 ###
##########################

##################################
### Modificando Tipo Primitivo ###
##################################

dados$model <- as.factor(dados$model)
dados$registration_date <- as.Date(dados$registration_date , format = "%Y-%m-%d") 
dados$sold_at <- as.Date(dados$sold_at, format = "%Y-%m-%d")

# Y maiúsculo significa que nosso formato possui 4 dígitos
# Format deve ser similar ao padrão do banco de dados


# 1. dados
# 2. estética (aes) -> eixo X e eixo Y
# 3. geom (tipo de gráfico)

# Resumo:
# data(aes()) + geom() -> Melhor forma
# data() + geom(aes())

# Possibilidades de camadas de geom: https://ggplot2.tidyverse.org/reference/

#########################
### Tipos de Gráficos ###
#########################

### correlação ###
ggplot(data = dados, aes(y = mileage, x = price)) + geom_point() #presença de outliers
### boxplot ###
ggplot(data = dados) + geom_boxplot(aes(x = paint_color, y = price))
### barras ###
ggplot(data = dados) + geom_histogram(aes(x = paint_color), stat = "count")
### linhas ###
ggplot(data = dados) + geom_line(aes(x = model, group = 1), stat = "count")

#################################
##### Modificações do geom ######
#################################

#############
### color ###
#############

# Atribuindo dentro do geom (definido por uma varável)
ggplot(data = dados) + geom_line(aes(x = mileage , y = model, color = model))

# Atribuindo fora do geom (definido pelos dados)
ggplot(data = dados) + geom_line(aes(x = price, y = model, 
shape = model), color = "darkred")

####################
### shape & size ###
####################

#http://www.sthda.com/english/wiki/ggplot2-point-shapes

ggplot(data = dados) + geom_point(aes(x = price, y = mileage, 
color = paint_color))

ggplot(data = dados) + geom_point(aes(x = price, y = mileage, 
shape = car_type))

# dentro da aes -> tamanho definido pela variável
ggplot(data = dados) + geom_line(aes(x = price, y = model, 
color = model, size = price))

# fora da aes -> tamanho não é definido por uma variável
ggplot(data = dados) + geom_point(aes(x = price, y = mileage),
fill = "black", color = "purple", shape = 25, size = 1.5)

#########################
### Usando mais geons ###
#########################

#Resumo:
#(data(aes()) + geom() + geom() -> MELHOR FORMA
#data() + geom(aes()) + geom(aes())
#A ordem dos geoms importa -> lógica camadas do Photoshop

glimpse(dados)

ggplot(data = dados,(aes(x = price, y = engine_power)))+
geom_point(color = "Black", shape = 16, size = 0.7) +
geom_smooth(method = "lm") # smooth = Linha de tendência

ggplot(data = dados,(aes(x = price, y = engine_power))) +
geom_point(color = "Black", shape = 16, size = 0.7) +
geom_smooth(method = "lm", se = FALSE, color = "Red", size = 0.5)

ggplot(data = dados, aes(x = price, y = engine_power)) +
geom_point(color = "Black", shape = 16, size = 0.7) +
geom_smooth(method = "lm", se = F, size = 0.5, linetype = "dashed")

##################################################################

###################
## Usando Dplyr ###
###################

dados %>% filter(paint_color == "black") %>% 
ggplot(aes(x = price, y = mileage)) +
geom_point(color = "orange", shape = 16, size = 0.7) +
geom_smooth(method = "lm", se = F, color = "black", size = 0.5, aes(linetype = paint_color))





















## Usando o geom para representar um "summary"
### (stat = summary) x stat_summary()
ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean")

ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  stat_summary(geom = "point", fun = "mean")

ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  stat_summary(geom = "point", fun = "median")

## Incluindo barras de erros (usando também o summary)


ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_se")


ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean") +
  geom_errorbar(stat = "summary", fun.min = "min", fun.max = "max")


ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_se", width = 0.3)


## Usando IC 95% ao invés de erro-padrão (pacote ggpubr)

pacman::p_load(ggpubr)

ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_ci", width = 0.3)


ggplot(data = dados, aes(x = Genero, y = LucroLocal)) +
  geom_point(stat = "summary", fun = "mean") +
  geom_errorbar(stat = "summary", fun.data = "mean_sd", width = 0.3)




























