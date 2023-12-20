## Introdução

A linguagem R é uma linguagem estatística criada no departamento de Estatística da Universidade de Auckland, Nova Zelândia, por Ross Ihaka e Robert Gentleman, 
na década de 1990. Ela é utilizada na manipulação, análise e visualização de dados.

#### Configuração para uso no Visual Studio Code 
Fontes:

[https://code.visualstudio.com/docs/languages/r](https://code.visualstudio.com/docs/languages/r)

[https://fromthebottomoftheheap.net/2019/06/18/radian-console-for-r/](https://fromthebottomoftheheap.net/2019/06/18/radian-console-for-r/)

#### Comandos para configurar

```r
#Rodar no terminal do R
install.packages("languageserver")
install.packages("httpgd")
```

```r
#Preferences (Open User Settings (JSON)
"editor.quickSuggestions.other": false
r.lsp.diagnostics": false
"r.plot.useHttpgd": true
```
#### Pacotes da linguagem R

[https://cran.r-project.org/](https://cran.r-project.org/)

[https://www.bioconductor.org/](https://www.bioconductor.org/)