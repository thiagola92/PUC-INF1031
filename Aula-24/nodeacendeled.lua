local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local minhamat = "1721629"

local msgr = require "mqttNodeMCULibrary"

local estadoled = gpio.LOW

local alarme = tmr.create()
local alarme2 = tmr.create()

local intervalo = false

local function mudaled()
  if estadoled == gpio.LOW then
    estadoled = gpio.HIGH
  else
   estadoled = gpio.LOW
  end
  gpio.write(led1, estadoled)
end

local function mensagemRecebida (mensagem)
  if(mensagem == "sinal") then
    mudaled()
  end
end

local cb_switch1, cb_switch2

local function ativa_botoes()
    gpio.trig(sw1, "down", cb_switch1)
    gpio.trig(sw2, "down", cb_switch2)
end

local function saidointervalo()
    intervalo = false
end

cb_switch1 = function()
    gpio.trig(sw1)

    if intervalo == false then
        intervalo = true
        alarme2:register(100, tmr.ALARM_SINGLE, saidointervalo)
        alarme2:start()
    else
        msgr.sendMessage("sinal", minhamat .. "love")
        return
    end
    
    alarme:register(300, tmr.ALARM_SINGLE, ativa_botoes)
    alarme:start()
    msgr.sendMessage("sinalL", minhamat .. "love")
end

cb_switch2 = function()
    gpio.trig(sw2)

    if intervalo == false then
        intervalo = true
        alarme2:register(100, tmr.ALARM_SINGLE, saidointervalo)
        alarme2:start()
    else
        msgr.sendMessage("sinal", minhamat .. "love")
        return
    end
    
    alarme:register(300, tmr.ALARM_SINGLE, ativa_botoes)
    alarme:start()
    msgr.sendMessage("sinalR", minhamat .. "love")
end

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

gpio.mode(sw1, gpio.INT, gpio.PULLUP)
gpio.mode(sw2, gpio.INT, gpio.PULLUP)

gpio.trig(sw1, "down", cb_switch1)
gpio.trig(sw2, "down", cb_switch2)

msgr.start(minhamat, minhamat .. "node", mensagemRecebida) -- use unique id
