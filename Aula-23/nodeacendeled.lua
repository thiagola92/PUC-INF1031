local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local minhamat = "1721629"

local msgr = require "mqttNodeMCULibrary"

local estadoled = gpio.LOW

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

local function cb_switch()
    msgr.sendMessage("sinal", minhamat .. "love")
end

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

gpio.mode(sw1, gpio.INT, gpio.PULLUP)
gpio.mode(sw2, gpio.INT, gpio.PULLUP)

gpio.trig(sw1, "down", cb_switch)
gpio.trig(sw2, "down", cb_switch)

msgr.start(minhamat, minhamat .. "node", mensagemRecebida) -- use unique id
