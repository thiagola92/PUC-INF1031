
local player = {
  x = 20,
  y = love.graphics.getHeight() - 100,
}
local floor = {}

local min = 50
local max = 150

local spaceMin = 30
local spaceMax = 70

local moving = false
local force = 0
local half = 0
local safe = true

function collision(r1x,r1y,r1w,r1h,r2x,r2y,r2w,r2h)
  
  if (r1x + r1w >= r2x and
      r1x <= r2x + r2w and
      r1y + r1h >= r2y and
      r1y <= r2y + r2h) then
        return true;
  end
  
  return false;
end

function loadFloor()
  math.randomseed(love.timer.getTime())
  
  if(#floor > 0 and floor[#floor].x + floor[#floor].w > love.graphics.getWidth()) then
    return
  end
  
  
  if(#floor == 0) then
    x = 20
  else
    x = floor[#floor].x + floor[#floor].w + math.random(spaceMin, spaceMax)
  end
  
  
  local f = {
    x = x,
    y = love.graphics.getHeight() - 80,
    w = math.random(min, max),
    h = 100
  }

  table.insert(floor, f)
end

function love.mousepressed()
  if(moving == true) then
    return
  end
  
  force = love.timer.getTime()
end

function love.mousereleased()
  if(moving == true) then
    return
  end
  
  force = love.timer.getTime() - force
  force = force * 500
  half = force/2
  
  moving = true
  
  print(force)
end

function checkCollision()
  
  for _,r in pairs(floor) do
    if collision(player.x, player.y, 20, 20,r.x,r.y,r.w,r.h) then
      return true
    end
  end
  
  return false
end

function love.update()
  loadFloor()
  
  if moving then
    local m = 5
    if(force - m < 0) then
      m = force
    end
    
    for i = #floor, 1, -1 do
      floor[i].x = floor[i].x - m
      
      if(floor[i].x + floor[i].w < 0) then
        table.remove(floor, i)
      end
    end
    
    if(force > half) then
      player.y = player.y - 2
    elseif(force < half) then
      player.y = player.y + 2
    end
    
      
    force = force - m
    if(force <= 0 and checkCollision()) then
      moving = false
    end
  end
  
  if(player.y > love.graphics.getHeight()) then
    require("victory")
  end
  
end

function love.draw()
  love.graphics.setColor(1,1,1)
  love.graphics.rectangle("fill",player.x, player.y, 20, 20)
  
  for _,v in pairs(floor) do
    love.graphics.setColor(0.5,0.5,0.5)
    love.graphics.rectangle("fill",v.x, v.y, v.w, v.h)
  end
  
end
