msgr = require "mqttLoveLibrary"

local MAX_ASTEROIDS = 20

local id = "14214221721629"
local server = "ProjetoPT"

local time = love.timer.getTime()
local createPlanetTime  = time + 2.5
local players = {}
local asteroids = {}
local planet = nil
local bullets = {}

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
  
  --local timeNow = love.timer.getTime() - time
  
  math.randomseed(love.timer.getTime())
  --print(love.timer.getTime())
  
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
    color = colors[index],
    playerDirection = 1,
    alive = true
  }
  
end

function drawPlayer()
  for _, player in pairs(players) do
    if player.alive == true then
      love.graphics.setColor(player.color)
      love.graphics.circle("fill",player.x,player.y, 20)
      player.y = player.y + player.playerDirection * 2
    end
  end
end

function createPlanet()
  if planet == nil then
    if createPlanetTime < love.timer.getTime() then
      planet = {
        x = love.graphics.getWidth() + 76,
        y = love.graphics.getHeight()/2      
      }    
    end
  end
end

function drawPlanet()
  if planet ~= nil then
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",planet.x,planet.y, 75)
    planet.x = planet.x - 2
  end
end

function circleCollision(x, y, r, x2, y2, r2)
  local dist = math.sqrt((x - x2)^2 +(y - y2)^2)
  
  if(dist <= r + r2) then
    return true
  end
  
  return false
end

function playerAsteroidCollision()
  
  for k, player in pairs(players) do
      for j= #asteroids, 1, -1 do
        
         if circleCollision(player.x, player.y, 20, asteroids[j].x, asteroids[j].y, asteroids[j].r) then
          player.alive = false
          table.remove(asteroids, j)
         end
         
      end      
  end
end

function bulletAsteroidCollision()
  for i = #bullets, 1, -1 do
    for j= #asteroids, 1, -1 do
      
      if(bullets[i] ~= nil) then
        if circleCollision(bullets[i].x, bullets[i].y, bullets[i].r, asteroids[j].x, asteroids[j].y, asteroids[j].r) then
          print(bullets, i, bullets[i])
          table.remove(bullets, i)
          table.remove(asteroids, j)
        end
      end
         
    end
  end
end

local function drawBullets()
  for i = #bullets, 1, -1 do
    love.graphics.setColor(1,0,0)
    love.graphics.circle("fill",bullets[i].x,bullets[i].y,bullets[i].r)
    bullets[i].x = bullets[i].x + 10
    
    if(bullets[i].x > love.graphics.getWidth()) then
      table.remove(bullets, i)
    end
    
  end
end

local function createBullet(y)
  local bullet = {
    x = 0,
    y = y,
    r = 5
  }
  
  table.insert(bullets, bullet)
end

local function mensagemRecebida (message)
  local player, button = string.match(message, "<(.*)><(.*)>")
  
  if(players[player] == nil) then
    createPlayer(player)
  end
  
  if(button == "button1") then
    players[player].playerDirection = players[player].playerDirection * (-1)
  elseif(button == "button2" and players[player].alive == true) then
    createBullet(players[player].y)
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
  drawPlayer()
  createPlanet()
  drawPlanet()
  playerAsteroidCollision()
  drawBullets()
  bulletAsteroidCollision()
end
