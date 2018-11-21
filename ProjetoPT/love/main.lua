--msgr.sendMessage ("<req><" .. meucanal .. ">", "servidor546")

msgr = require "mqttLoveLibrary"

local id = "14214221721629"
local server = "ProjetoPT"

local players = {}

local colors = {
  {1,1,0}, -- amarelo
  {0,1,0}, -- verde
  {1,0,0}, -- vermelho
  {0,0,1}, -- azul
  {1,1,1}  -- branco
}

function createPlayer(player)
  math.randomseed(os.time())
  
  local index = math.random(1, #colors)
  
  players[player] = {
    x = 0,
    y = love.graphics.getHeight,
    color = colors[index]
  }
  
end

local function mensagemRecebida (message)
  local player, button = string.match(message, "<(.*)><(.*)>")
  
  if(players[player] == nil) then
    createPlayer(player)
  end
  
  if(button == "button1") then
    players[player].y = players[player].y + 10
  elseif(button == "button2") then
    players[player].y = players[player].y - 10
  end
end

function love.load()
  msgr.start(id, server, mensagemRecebida) 
end

function love.update()
  msgr.checkMessages()
end

function love.draw()
end
