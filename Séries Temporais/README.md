## Introdução
#### Conceitos:
Série Temporal -> é um conjunto de observações ordenadas no tempo ou um corte particular de um processo estocástico desconhecido
Matematicamente:

Processo Estocástico -> é uma coleção de variáveis aleatórias definidas num mesmo espaço de probabilidades (processo gerador de uma série de variáveis). A descrição de um 
processo estocástico é feita através de uma distribuição de probabilidade conjunta (o que é muito complexo de se fazer), então geralmente descrevemos ele por meio das funções:
- 𝜇(𝑡)=𝐸{𝑍(𝑡)} -> Média 
- 𝜎^2(𝑡)=𝑉𝑎𝑟{𝑍(𝑡)} -> Variância 
- 𝛾(𝑡1,𝑡2)=𝐶𝑜𝑣{𝑍(𝑡1),𝑍(𝑡2)} -> Autocovariância

![Captura de tela 2024-02-07 181930](https://github.com/HenrySchall/R/assets/96027335/7ea476dd-6ddf-4439-8aea-12fd6d06ab33)

Estacionaridade -> é quando uma série temporal apresenta todas suas características estatísticas constante ao longo do tempo
- Estacionaridade Fraca =
- Estacionaridade Forte = 

![IMG_1666](https://github.com/HenrySchall/R/assets/96027335/2e9ebb70-9d46-448a-ae0a-88f82e5c6f9e)

Passeio Aleatório (Random Walk) -> é a soma de pequenas flutuações estocásticas (tendência estocástica)
Matematicamente:

Autocorrelação -> é a correlação de determinados períodos anteriores com o período atual, onde cada período desse tipo de correlação é denominado lag e sua análise 
é o pressuposto para se criar previsões.

#### Objetivos:
- Analisar a origem da série
- Previsões futuras
- Descrição do comportamento da série 
- Analisar perodicidade ou tendência 

#### Tipos:
- Univariada = apenas uma variável se altera ao longo do tempo
- Multivariada = mais de uma variável se altera ao longo do tempo



