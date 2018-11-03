local led1 = 3
local led2 = 6
local switch1 = 1
local switch2 = 2

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

gpio.write(led1, gpio.LOW);
gpio.write(led2, gpio.LOW);

gpio.mode(switch1,gpio.INT,gpio.PULLUP)
gpio.mode(switch2,gpio.INT,gpio.PULLUP)

local tempo_de_espera = 200000
local sequencia_gravada = {}
local tamanho_da_sequencia = 5

local jogando = false
local ganhando = true
local indice_atual = 1

local cb_switch1, cb_switch2
local alarme = tmr.create()

local function gera_sequencia (semente)
  print ("veja a sequencia:")
  tmr.delay(2*tempo_de_espera)

  print ("(" .. tamanho_da_sequencia .. " itens)")
  math.randomseed(semente)

  for i = 1,tamanho_da_sequencia do
    sequencia_gravada[i] = math.floor(math.random(1.5,2.5))
    print(sequencia_gravada[i])
    gpio.write(3*sequencia_gravada[i], gpio.HIGH)
    tmr.delay(3*tempo_de_espera)
    gpio.write(3*sequencia_gravada[i], gpio.LOW)
    tmr.delay(2*tempo_de_espera)
  end

  print ("agora (seria) sua vez:")
  indice_atual = 1
  jogando = true
  ganhando = true
end

local function terminou_jogo()
  if(ganhando == true) then
    print("ganhou")
    gpio.write(led2, gpio.HIGH)
  else
    print("perdeu")
    gpio.write(led1, gpio.HIGH)
  end
    
  tmr.delay(3*tempo_de_espera)
  gpio.write(led1, gpio.LOW)
  gpio.write(led2, gpio.LOW)
  tmr.delay(2*tempo_de_espera)
    
  jogando = false
  return
end

local function apertou(botao)
  local resposta = sequencia_gravada[indice_atual]

  if(resposta ~= botao) then
    print("errou")
    ganhando = false
  else
    print("acertou")
  end

  indice_atual = indice_atual + 1

  if(indice_atual > tamanho_da_sequencia) then
    terminou_jogo()
  end
end

local function ativa_botoes()
  -- ativando os botoes
  gpio.trig(switch1, "down", cb_switch1)
  gpio.trig(switch2, "down", cb_switch2)
end

cb_switch1 = function (_, contador)
  -- desativando os dois botões
  gpio.trig(switch1)
  gpio.trig(switch2)
  
  if(jogando == true) then
    apertou(2)
  else
    gera_sequencia (contador)
  end

  alarme:register(300, tmr.ALARM_SINGLE, ativa_botoes)
  alarme:start()
end

cb_switch2 = function (_, contador)
  -- desativando os dois botões
  gpio.trig(switch1)
  gpio.trig(switch2)
  
  if(jogando == true) then
    apertou(1)
  end
  
  alarme:register(500, tmr.ALARM_SINGLE, ativa_botoes)
  alarme:start()
end

gpio.trig(switch1, "down", cb_switch1)
