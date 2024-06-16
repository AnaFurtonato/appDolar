<h1>Aplicativo de Real(R$) para Dolar($)</h1>

Esse aplicativo tem como objetivo transformar o valor do real colocado no input pelo usuário e fazer a conversão em dólar do valor total que deu e mostrar a cotação do dia. O aplicativo usa uma API para consumir os dados do dólar em tempo real e foi feito completamente em Flutter.

Url da API (request GET): https://economia.awesomeapi.com.br/last/USD-BRL

O aplicativo tem todos esses requisitos funcionando certinho:

01 - O aplicativo possuir uma imagem no topo, embarcada no App;<br>
02 - O campo "Valor em Real" é obrigatório ser preenchido antes da cotação, exibindo mensagem abaixo quando não for preenchido;<br>
03 - Deve ser exibido em "ShowDialog", exceptions que possam ocorrer, exemplo falta de internet;<br>
04 - Ao clicar no floatingActionButton enviada uma requisição para API;<br>
05 - É lido o retorno da API no campo "bid";<br>
06 - O aplicativo faz a conversão do valor em real para o valor em dólar;<br>
07 - Abaixo do valor convertido, exibe o valor do Dólar recebido da API;<br>
08 - A imagem do topo é um evento OnLongPress, caso acionado, devem ser limpos todos os campos da tela;<br>
09 - Ao clicar no botão floatingActionButton, muda o campo "Valor em Dólar" para "Aguarde ..." enquanto estiver processando.
