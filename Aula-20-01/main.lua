msgr = require "mqttLoveLibrary"

local mostrabaleia = false
local baleia
local minhamat = '1721622' -- seu numero de matricula!
local W, H = 400, 300

function love.keypressed(key)
  if(key == "return") then
   msgr.sendMessage("sinal", "canalunico")
  end
end

local function mensagemRecebida (mensagem)
  if(mensagem == "sinal") then
    mostrabaleia = not mostrabaleia
  end
end

function love.load()
  msgr.start(minhamat, "canalunico",  mensagemRecebida)  
  baleia = love.graphics.newImage("whale.png")
  love.window.setMode(W,H)
  love.graphics.setBackgroundColor (0.5, 0.2,0)
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