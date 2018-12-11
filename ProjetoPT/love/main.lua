msgr = require "mqttLoveLibrary"

local MAX_ASTEROIDS = 20

local id = "14214221721629"
local server = "ProjetoPT"

local time = love.timer.getTime()
local createPlanetTime  = time + 2.5
local players = {}
local asteroids = {}
local planet = { alive = false }
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
    asteroids[i].x = asteroids[i].x - 2
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
    y = love.graphics.getHeight()/2,
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
  if planet.alive == false and createPlanetTime < love.timer.getTime() then
    planet.x = love.graphics.getWidth() + 76
    planet.y = love.graphics.getHeight()/2
    planet.r = 75
    planet.alive = true
  end
end

function drawPlanet()
  if planet.alive == true then
    love.graphics.setColor(1,1,1)
    love.graphics.circle("fill",planet.x,planet.y, planet.r)
    if planet.x > 0 then
      planet.x = planet.x - 0.5
    end
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

function playerPlanetCollision()
  if(planet.alive == false) then
    return
  end
  
  for _, player in pairs(players) do
    if circleCollision(player.x, player.y, 20, planet.x, planet.y, planet.r) and player.alive then
      require("victory")
    end
  end
end


function bulletAsteroidCollision()
  for i = #bullets, 1, -1 do
    for j= #asteroids, 1, -1 do
      
      if(bullets[i] ~= nil) then
        if circleCollision(bullets[i].x, bullets[i].y, bullets[i].r, asteroids[j].x, asteroids[j].y, asteroids[j].r) then
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
  for i = 0, -2, -1 do
    local bullet = {
      x = 15*i,
      y = y,
      r = 5
    }
    
    table.insert(bullets, bullet)
  end
end

local function reachBorder()
  for key, playerContent in pairs(players) do
    if players[key].y >= love.graphics.getHeight() then
       players[key].playerDirection = -1
    elseif players[key].y <= 0 then
      players[key].playerDirection = 1      
    end
  end
end

local function mensagemRecebida (message)
  local player, button = string.match(message, "<(.*)><(.*)>")
  
  if(players[player] == nil) then
    createPlayer(player)
  end
  
  if(players[player].alive == false) then
    return
  end
  
  if(button == "button1") then
    players[player].playerDirection = players[player].playerDirection * (-1)
  elseif(button == "button2") then
    createBullet(players[player].y)
  elseif(button == "both") then
    players[player].playerDirection = players[player].playerDirection * (-1)
    createBullet(players[player].y)
  end
  
end

function love.load()
  msgr.start(id, server, mensagemRecebida) 
end

function love.keypressed(key)
  if key == "1" then
    love.graphics.setColor(1,1,1)
    require("extra1")
  elseif key == "2" then
    love.graphics.setColor(1,1,1)
    require("extra2")
  elseif key == "3" then
    love.graphics.setColor(1,1,1)
    require("extra3")
  end
end

function love.update()
  msgr.checkMessages()
  
  createPlanet()
  
  createAsteroids()
  moveAsteroids()
  
  playerAsteroidCollision()
  playerPlanetCollision()
  bulletAsteroidCollision()
  
  reachBorder()
end

function love.draw()
  drawPlanet()
  drawAsteroids()
  drawPlayer()
  drawBullets()
end
