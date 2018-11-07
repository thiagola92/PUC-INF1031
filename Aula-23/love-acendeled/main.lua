msgr = require "mqttLoveLibrary"

local minhamat = '1721629' -- seu numero de matricula!
local W, H = 400, 300

local mostrabaleia = false

function love.keypressed(key)
  if(key == "return") then
    msgr.sendMessage("sinal", minhamat .. "node")
  end
end

local function mensagemRecebida (mensagem)  
  mostrabaleia = not mostrabaleia
end

function love.load()
  msgr.start(minhamat, minhamat .. "love",  mensagemRecebida)  
  love.window.setMode(W,H)
  love.graphics.setBackgroundColor (1 ,56/255 ,0)
  baleia = love.graphics.newImage("whale.png")
end

function love.update(dt)
  msgr.checkMessages() -- tem que constar no love.update!!!
end

function love.draw()
  love.graphics.print("Aperte <enter>!", W/3, H/10)
  
  if mostrabaleia then
    love.graphics.draw(baleia, W/3, H/3, 0, 0.5)
  end
  
end

