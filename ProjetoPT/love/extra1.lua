
local ball = {}
local columns = {}
local columnMoving = false
local ballMovingRight = true
local ballSpeed = 1

ball.x = love.graphics.getWidth()/2
ball.y = love.graphics.getHeight()/2

function loadColumn()
  math.randomseed(love.timer.getTime())
  
  local x = math.random(love.graphics.getWidth()/8, 3*love.graphics.getWidth()/8)
  
  if(ballMovingRight) then
    x = x + love.graphics.getWidth()/2
  end
  
  local c = {
    x = x,
    y = love.graphics.getHeight() - 100
  }
  table.insert(columns, c)
end

loadColumn()
ballMovingRight = not ballMovingRight
loadColumn()
ballMovingRight = not ballMovingRight

function collision()
  local testX = ball.x
  local testY = ball.y
  
  if (ball.x < columns[1].x) then
    testX = columns[1].x
  elseif (ball.x > columns[1].x + 100) then
    testX = columns[1].x + 100
  end
  
  if (ball.y < columns[1].y) then
    testY = columns[1].y
  elseif (ball.y > columns[1].y + love.graphics.getHeight()) then
    testY = columns[1].y + love.graphics.getHeight()
  end
  
  local distX = ball.x - testX
  local distY = ball.y - testY
  
  local distance = math.sqrt(distX*distX + distY*distY)
  
  if(distance <= 20) then
    return true
  end
  
  return false
end

function love.update()
  if(ballMovingRight) then
    ball.x = ball.x + ballSpeed
  else
    ball.x = ball.x - ballSpeed
  end
  
  if(columnMoving) then
    columns[1].y = columns[1].y - 20
    
    if(collision()) then
      table.remove(columns, 1)
      loadColumn()
      
      ballMovingRight = not ballMovingRight
      columnMoving = false
      
      if(ballSpeed < 20) then
        ballSpeed = ballSpeed + 1
      end
    end
  end
  
  if(columns[1].y < 0) then
    columns[1].y = love.graphics.getHeight() - 100
    columnMoving = false
  end  
  
  if(ball.x < -20 or ball.x > love.graphics.getWidth() + 20) then
    require("victory")
  end
  
end

function love.mousepressed()
  columnMoving = true
end

function love.draw()
  love.graphics.circle("fill", ball.x, ball.y, 20)
  
  for _,c in pairs(columns) do
    love.graphics.rectangle("fill", c.x, c.y, 100, love.graphics.getHeight() - c.y)
  end
  
end
