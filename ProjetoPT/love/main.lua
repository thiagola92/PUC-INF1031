msgr = require "mqttLoveLibrary"

local MAX_ASTEROIDS = 20

local id = "14214221721629"
local server = "ProjetoPT"

local time = love.timer.getTime()
local players = {}
local asteroids = {}

local colors = {
  {1,1,0}, -- amarelo
  {0,1,0}, -- verde
  {1,0,0}, -- vermelho
  {0,0,1}, -- azul
  {1,1,1}  -- branco
}



function drawAsteroids()
  love.graphics.setColor(139/255,69/255,19/255)
  for i = 1, #asteroids do
    love.graphics.circle("fill",asteroids[i].x,asteroids[i].y,asteroids[i].r)
  end
end

function createAsteroids()
  if #asteroids > MAX_ASTEROIDS then
    return
  end
  
  local timeNow = love.timer.getTime() - time
  
  math.randomseed(timeNow)
  print(timeNow)
  
  asteroids[#asteroids + 1]={
    x = love.graphics.getWidth() + math.random(0,750),
    y = math.random(0,love.graphics.getHeight()),
    r = math.random(20,35)    
  }
  
  createAsteroids()
end


function moveAsteroids()
  for i = #asteroids, 1, -1 do
    asteroids[i].x = asteroids[i].x - 3
    if asteroids[i].x < 0 then 
     table.remove(asteroids,i)
    end
  end
end


function createPlayer(player)
  math.randomseed(os.time())
  
  local index = math.random(1, #colors)
  
  players[player] = {
    x = 0,
    y = love.graphics.getHeight(),
    color = colors[index]
  }
  
end

function drawPlayer()
  for _, player in pairs(players) do
    love.graphics.setColor(player.color)
    love.graphics.circle("fill",player.x,player.y, 20)
  end
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
  createAsteroids()
  drawAsteroids()
  moveAsteroids()
end