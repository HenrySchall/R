## Séries Temporais
#### Objetivos:
- Analisar a origem da série
- Previsões futuras
- Descrição do comportamento da série 
- Analisar perodicidade ou tendência 

#### Tipos:
- Univariada = apenas uma variável se altera ao longo do tempo
- Multivariada = mais de uma variável se altera ao longo do tempo

#### Conceitos:
Série Temporal -> é um conjunto de observações ordenadas no tempo ou um corte particular de um processo estocástico desconhecido

#### Matematicamente: Y = Tdt + Szt + et 
- Tendência (Tdt): Mudanças graduais em longo prazo (crescimento populacional).
- Sazonalidade (Szt): oscilações de subida e de queda que sempre ocorrem em um determinado período (maior valor da conta de energia elétrica no inverno).
- Resíduos (et): apresenta movimentos ascendentes e descendentes da série após a retirada do efeito de tendência ou sazonal (sequência de variáveis aleatórias).

![Sem título](https://github.com/HenrySchall/R/assets/96027335/b60d5d3f-0d12-4695-ac17-eb49a8e8b42a)

Processo Estocástico -> é uma coleção de variáveis aleatórias definidas num mesmo espaço de probabilidades (processo gerador de uma série de variáveis). A descrição de um 
processo estocástico é feita através de uma distribuição de probabilidade conjunta (o que é muito complexo de se fazer), então geralmente descrevemos ele por meio das funções:
- 𝜇(𝑡)=𝐸{𝑍(𝑡)} -> Média 
- 𝜎^2(𝑡)=𝑉𝑎𝑟{𝑍(𝑡)} -> Variância 
- 𝛾(𝑡1,𝑡2)=𝐶𝑜𝑣{𝑍(𝑡1),𝑍(𝑡2)} -> Autocovariância

![Captura de tela 2024-02-07 181930](https://github.com/HenrySchall/R/assets/96027335/7ea476dd-6ddf-4439-8aea-12fd6d06ab33)

Estacionaridade -> é quando uma série temporal apresenta todas suas características estatísticas constante ao longo do tempo
- Estacionaridade Fraca = é quando as propriedades estatiaticas, são constantes no tempo, E(x)=U, Var(x) = 𝜎^2, COV(X,X-n) = k (corariância entre observações em diferentes pontos no tempo depende do tempo específico em que elas ocorreram). Na literatura, geralmente estacionalidade significa estacionalidade fraca.

- Estacionaridade Forte = também chamada de estrita, é quando a função de probabilidade conjunta é invariante no tempo, ou seja, as distribuições individuais são iguais para todos "ts". Com isso a covariância depende apenas da distância entre as observações e não do tempo especifico que ocorreram. 

![IMG_1666](https://github.com/HenrySchall/R/assets/96027335/2e9ebb70-9d46-448a-ae0a-88f82e5c6f9e)

Passeio Aleatório (Random Walk) -> é a soma de pequenas flutuações estocásticas (tendência estocástica)
Matematicamente: 𝑍𝑡 = 𝑍(𝑡−1)+ et

Autocorrelação -> é a correlação de determinados períodos anteriores com o período atual, ou seja, o grau de dependência serial. Onde cada período desse tipo de correlação é denominado lag (defasagem) e sua análise 
é o pressuposto para se criar previsões.

Ruído Branco (White Noise) -> é quando o erro de uma série temporal, segue uma distribuição normal, ou seja, um processo puramente aleatório. 
- E(Xt) = 0 
- Var(Xt) = 𝜎^2

#### Processos de transformação e diferenciação
A transformação é uma técnica que buscar deixar a série o mais próximo possível de uma distribuição normal. Já a diferenciação, busca transformar uma série não estacionária em estacionária, por meio da diferença de dois períodos consecutivos. De qualquer forma, ambas técnicas procuram deixar os modelos mais eficientes, entre os tipos existentes, podemos citar:
1) Log (indicada para distribuição assimétrica positiva e variação crescente com a média)
2) Suavização Exponencial (casos em que há impossibilidade da log)
3) Suavização por Média Móvel (casos em que há impossibilidade da log)
4) Box-Cox (onde a série deve ter somente valores positivos)





