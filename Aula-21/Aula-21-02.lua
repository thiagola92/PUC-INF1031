local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local stop = false
local apagado = false

print("Aula-21-02")

local function cbchave (level, timestamp)
  stop = not stop
end

local function piscapisca (t)
  if(stop == true) then
    return
  end

  if apagado then
    gpio.write(led1, gpio.HIGH);
  else
    gpio.write(led1, gpio.LOW);
  end
  apagado = not apagado
end

-- coloca os pinos dos leds em modo de saida
gpio.mode(led1, gpio.OUTPUT)
gpio.mode(led2, gpio.OUTPUT)

-- apaga os leds
gpio.write(led1, gpio.LOW)
gpio.write(led2, gpio.LOW)

-- coloca um sinal estavel nas chaves 1 e 2
gpio.mode(sw1,gpio.INT,gpio.PULLUP)
gpio.mode(sw2,gpio.INT,gpio.PULLUP)

-- cadastra a funcao cbchave para ser chamada se
-- a chave 1 for apertada
gpio.trig(sw1, "down", cbchave)

local mytimer = tmr.create()
mytimer:register(500, tmr.ALARM_AUTO, piscapisca)
mytimer:start()
