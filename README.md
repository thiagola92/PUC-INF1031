![WARNING](WARNING.png)

# PUC-INF1031
Introdução a computação

# ZeroBrane
O bom dessa IDE é que você não precisa instalar, se você pretende usar muito na máquina então instale mas se você estiver em algum lugar que não permite instalação de software (PUC) então baixe o ZIP extraia tudo dele em uma pasta e rode.  

## Rodando duas janelas ZeroBrane
As vezes você precisa rodar dois programa LUA ou LOVE então precisa abrir duas janelas do ZeroBrane, o padrão não permite mas você pode alterar as configurações.  

* Abra **ZeroBrane**
* **Edit**
* **Preferences**
* Selecione um dos **Settings::**
  * **Settings:System** se você for o dono da máquina  
  * **Settings:User** se você não for dono da máquina  
* Escreva após todas as linhas "**singleinstance=false**"
* Feche e abra o ZeroBrane para que ele carregue as novas configurações

Agora você pode abrir mais que um ZeroBrane  

# ESPlorer
Utilizaremos essa IDE para conectar com o NodeMCU e escrever programas para ele.  

O link do download em seguida costuma falhar na primeira vez que você acessa (tente abrir duas vezes ou mais):  
http://esp8266.ru/esplorer-latest/?f=ESPlorer.zip  

A biblioteca do NodeMCU (lá você consegue ver as funções que o node possui e como funcionam):  
https://nodemcu.readthedocs.io/en/master/  

Conectar seu NodeMCU ao computador pode ser uma tarefa meio chata e complicada.  
Eu documentei todos meus problemas e soluções em uma outra matéria que utilizei ele:  
https://github.com/thiagola92/PUC-INF1805/blob/master/Aula-07/Exemplo-01/main.lua  
