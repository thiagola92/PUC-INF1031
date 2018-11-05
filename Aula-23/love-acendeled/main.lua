msgr = require "mqttLoveLibrary"

local minhamat = '1721629' -- seu numero de matricula!
local W, H = 400, 300

local estadolove = false

function love.keypressed(key)
  if(key == "return") then
    msgr.sendMessage("sinal", minhamat .. "node")
  end
end

local function mensagemRecebida (mensagem)
  if estadolove == true then
    love.graphics.setBackgroundColor (1 ,56/255 ,0)
  else 
    love.graphics.setBackgroundColor (56/255 ,1 ,0)
  end
  
  estadolove = not estadolove
end

function love.load()
  msgr.start(minhamat, minhamat .. "love",  mensagemRecebida)  
  love.window.setMode(W,H)
  love.graphics.setBackgroundColor (1 ,56/255 ,0)
end

function love.update(dt)
  msgr.checkMessages() -- tem que constar no love.update!!!
end

function love.draw()
  love.graphics.print("Aperte <enter>!", W/3, H/10)
end

