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

Transformação e Suavização -> São técnicas que buscam deixar a série o mais próximo possível de uma distribuição normal. Transformando o valor das varáveis ou suavizando a tendência e/ou sazonaliade da série. Dentre todas as técnicas existentes podemos citar:
1) Tranformação Log 
2) Tranformação Expoencial
3) Tranformação Box-Cox
4) Suavização Média Móvel Exponencial (MME) - Curto período 
5) Suavização por Média Móvel Simples (MMS) - Longo período

Diferenciação -> A diferenciação, busca transformar uma série não estacionária em estacionária, por meio da diferença de dois períodos consecutivos


 - Modelos não lineares: autorregressivo com limiar (TAR), autorregressivo com transição suave (STAR), troca de regime markoviano (MSM) e redes neurais artificiais autorregressivas (AR-ANN).

#### Modelos das séries temporais:
 - Modelos autorregressivos (AR)
 - Modelos médias móveis (MA)
 - Modelos autorregressivos e médias móveis (ARMA)
 - Modelos autorregressivos integrados e de médias móveis (ARIMA)
 - Modelos de longas dependências temporais ou memória longa (ARFIMA)
 - Modelos autorregressivos integrados e de médias móveis com sazonalidade (SARIMA)
 
Modelos não lineares:
 - Autorregressivo com limiar (TAR)
 - Autorregressivo com transição suave (STAR)
 - Troca de regime markoviano (MSM)
 - Redes neurais artificiais autorregressivas (AR-ANN)

Estrutura: 
Autorregressivo (AR): indica que a variável é regressada em seus valores anteriores. 
Integrado (I): indica que os valores de dados foram substituídos com a diferença entre seus valores e os valores anteriores (diferenciação).
Média móvel (MA): Indica que o erro de regressão é uma combinação linear dos termos de erro dos valores passados.

Codificação: (p, d, q)
Parâmetro d só pode ser inteiro

p = ordem da autorregressão.
d = grau de diferenciação.
q = ordem da média móvel.

Quando adicionamos a sazonalidade, além da codificação Arima (p, d, q), incluimos a codificação para a Sazonalidade (P, D, Q). Então um modelo SARIMA é definido por: (p, d, q)(P, D, Q)

Exemplos:
Modelo ARFIMA: (1, 0.25, 1)
Modelo ARIMA: (2, 1, 1)
Modelo AR: (1, 0, 0)
Modelo MA (0, 0, 3)
Modelo I: (0, 2, 0)
Modelo ARMA: (4, 0, 1)
Modelo SARIMA: (1, 1, 2)(2, 0, 1)



















