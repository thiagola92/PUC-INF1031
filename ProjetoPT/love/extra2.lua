
local rects = {}
local player = {}
local movingRight = true
local ballSpeed = 1
local time = 1

player.x = love.graphics.getWidth()/2
player.y = 50

function collision(r1x,r1y,r1w,r1h,r2x,r2y,r2w,r2h)
  
  if (r1x + r1w >= r2x and
      r1x <= r2x + r2w and
      r1y + r1h >= r2y and
      r1y <= r2y + r2h) then
        return true;
  end
  
  return false;
end

function loadRect()
  if(#rects == 5) then
    return
  end
  
  math.randomseed(love.timer.getTime())
  
  local y
  if(#rects == 0) then
    y = love.graphics.getHeight()
  else
    y = rects[#rects].y + love.graphics.getHeight()/5
  end
  
  local r = {
    x = math.random(0, love.graphics.getWidth()),
    y = y,
    w = math.random(25, love.graphics.getWidth()/2),
    h = 20
  }
  
  table.insert(rects, r)
end

function love.update(dt)
  time = time + dt
  
  if time >= 5 and ballSpeed < 10 then
   ballSpeed = ballSpeed + 1
   time = 0
  end
  
  if movingRight then
    player.x = player.x + ballSpeed
  else
    player.x = player.x - ballSpeed
  end
  
  loadRect()
  
  for _,r in pairs(rects) do
    r.y = r.y - ballSpeed
    
    if(collision(r.x,r.y,r.w,r.h,player.x,player.y,20,20)) then
      require("victory")
    end
    
  end
  
  if(rects[1].y <= -20) then
    table.remove(rects, 1)
  end
  
  if player.x < -20 or player.x > love.graphics.getWidth() + 20 then
    require("victory")
  end
  
end

function love.mousepressed()
  movingRight = not movingRight
end

function love.draw()
  love.graphics.rectangle("fill", player.x, player.y, 20, 20)
  
  for _,r in pairs(rects) do
    love.graphics.rectangle("fill", r.x, r.y, r.w, r.h)
  end
  
end
