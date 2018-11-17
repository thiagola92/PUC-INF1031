msgr = require "mqttNodeMCULibrary"

local minhamat = "1721629"
local minhafileira = 2
local minhaposicao = 4
local sensor = 0

local tempoaceso = 300000 -- microsegundos

local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local strenvio = "<reg><".. minhafileira .. "," .. minhaposicao .. ",%d>"

local pause = false
local blink = false

local function readlum()
  local lum = adc.read(sensor)
  print(lum)
  -- mandar luminosidade pro servidor!
  local m = string.format(strenvio, lum)
  msgr.sendMessage(m, "servidor546")
end

gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

gpio.write(led1, gpio.LOW);
gpio.write(led2, gpio.LOW);

gpio.mode(sw1,gpio.INT,gpio.PULLUP)
gpio.mode(sw2,gpio.INT,gpio.PULLUP)

local function stopSending()
  pause = not pause

  if(pause == true) then
    local m = string.format(strenvio, "9999")
    msgr.sendMessage(m, "servidor546")
  end
end

local function piscar()
  gpio.write(led1, gpio.HIGH);
  tmr.delay(tempoaceso)
  gpio.write(led1, gpio.LOW);
  tmr.delay(tempoaceso)
  gpio.write(led2, gpio.HIGH);
  tmr.delay(tempoaceso)
  gpio.write(led2, gpio.LOW);
end

local alarmBlink = tmr.create()
alarmBlink:alarm(1000, tmr.ALARM_AUTO, piscar)

local function stopBlinking()
  alarmBlink:stop()
end

local function startBliking()
  alarmBlink:start()
end

gpio.trig(sw2, "down", stopBlinking)
gpio.trig(sw1, "down", stopSending)

local function periodica ()
  print(pause)
  if(pause == true) then
    return
  end
  
  readlum()
end

msgr.start(minhamat, "546_" .. minhafileira .. "_" .. minhaposicao, startBliking)
if not tmr.create():alarm(5000, tmr.ALARM_AUTO, periodica) then
  print("erro na criacao do alarme")
end
