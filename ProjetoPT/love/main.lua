--msgr.sendMessage ("<req><" .. meucanal .. ">", "servidor546")

msgr = require "mqttLoveLibrary"

local meuid = "14214221721629"
local meucanal = meuid .. "love"

local function mensagemRecebida (msg)
  print("qualquer coisa")
end

function love.load()
  msgr.start(meuid, meucanal, mensagemRecebida) 
end

function love.update()
  msgr.checkMessages()
end

function love.draw()
end
