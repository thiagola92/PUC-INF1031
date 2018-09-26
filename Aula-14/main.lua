function love.load()
  math.randomseed(os.time())

  width, height = love.graphics.getDimensions()
  circles = {}
  selected = {}
  deslocamento = 25*math.min (width, height)/2000

  for i=1, 150 do
    local r = math.random(10,40)
    local x = math.random(r, width - r)
    local y = math.random(r, height - r)
    local color = {math.random(0,1), math.random(0,1), math.random(0,1)}
    local selected = false

    circles[i] = {x = x, y = y, r = r, color = color}
  end
end


function love.draw()
  for i=#circles, 1, -1 do
    if(selected[i] == true) then
      love.graphics.setColor(1, 0, 0)
    else
      love.graphics.setColor(circles[i].color)
    end

    love.graphics.circle("fill", circles[i].x, circles[i].y, circles[i].r)
  end
end

function is_colliding(x, y, circulo)
  local distance = math.sqrt((x - circulo.x)^2 + (y - circulo.y)^2)
  return distance < circulo.r
end

function select_circle(s)
  if(s == nil) then
    return
  end

  for k, _ in pairs(selected) do
    if(k == s) then
      selected[s] = nil
      return
    end
  end

  circles[s].selected = true
  selected[s] = true
end

function love.mousepressed(x, y)
  local s = nil

  for i=#circles, 1, -1 do
    if(is_colliding(x, y, circles[i])) then
      s = i
    end
  end

  select_circle(s)
end

function move_circles(x, y)
  local s1, s2 = selected[1], selected[2]

  if(s1 ~= nil) then
    circles[s1].x = circles[s1].x + deslocamento*x
    circles[s1].y = circles[s1].y + deslocamento*y
  end

  if(s2 ~= nil) then
    circles[s2].x = circles[s2].x + deslocamento*x
    circles[s2].y = circles[s2].y + deslocamento*y
  end
end

function overlap(i, j)
  local distanceX = circles[i].x - circles[j].x
  local distanceY = circles[i].y - circles[j].y
  local distance = math.sqrt(distanceX^2 + distanceY^2)
  local distanceToCollide = distance - (circles[i].r + circles[j].r)

  local x, y = 0, 0

  if(distanceToCollide < 0) then
    x = distanceX * distanceToCollide / distance
    y = distanceY * distanceToCollide / distance
  end

  return x, y
end

function displace_circle()
  for i, _ in pairs(selected) do
    local movex, movey = 0, 0
    
    for j, _ in pairs(selected) do
      
      if(i ~= j) then
        local x, y = overlap(i, j)
        
        movex = movex + x/2
        movey = movey + y/2
      end
      
    end
      
    circles[i].x = circles[i].x - movex
    circles[i].y = circles[i].y - movey
  end
end

function unselect()
  for i, _ in pairs(selected) do
    selected[i] = nil
  end
end

function love.keypressed(key)
  local directionX, directionY = 0, 0

  if love.keyboard.isDown("up") then
    directionY = -1
  elseif love.keyboard.isDown("down") then
    directionY = 1
  end

  if love.keyboard.isDown("right") then
    directionX = 1
  elseif love.keyboard.isDown("left") then
    directionX = -1
  end

  if love.keyboard.isDown("r") then
    displace_circle()
  end
  
  if love.keyboard.isDown("space") then
    unselect()
  end

  move_circles(directionX, directionY)
end