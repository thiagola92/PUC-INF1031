msgr = require "mqttNodeMCULibrary"

local minhamat = "1234"
local minhafileira = 2
local minhaposicao = 4
local sensor = 0

local tempoaceso = 300000 -- microsegundos

local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local function readlum()
  local lum = adc.read(sensor)
  print(lum)
  -- mandar luminosidade pro servidor!
  -- compõe mensagem m
  -- msgr.sendMessage(m, "luminosidadesala")
end

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

gpio.write(led1, gpio.LOW);
gpio.write(led2, gpio.LOW);

gpio.mode(sw1,gpio.INT,gpio.PULLUP)
gpio.mode(sw2,gpio.INT,gpio.PULLUP)

function periodica ()
  readlum()
  gpio.write(led1, gpio.HIGH);
  tmr.delay(tempoaceso)
  gpio.write(led1, gpio.LOW);
end

-- inicia servidor
-- msgr.start(minhamat) 

if not tmr.create():alarm(5000, tmr.ALARM_AUTO, periodica) then
  print("erro na criação do alarme")
end

