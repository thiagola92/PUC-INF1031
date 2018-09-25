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

    circles[i] = {x = x, y = y, r = r, color = color, selected = selected}
  end
end


function love.draw()
  for i=#circles, 1, -1 do
    if(circles[i].selected == true) then
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

function love.mousepressed(x, y)
  local s = nil

  for i=#circles, 1, -1 do
    if(is_colliding(x, y, circles[i])) then
      s = i
    end
  end

  if(s ~= nil) then
    if(#selected >= 2) then
      table.remove(selected, 1)
      circles[selected[1]].selected = not circles[s].selected
    end

    circles[s].selected = not circles[s].selected
    table.insert(selected, s)
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

  local s1, s2 = selected[1], selected[2]
  
  if(s1 ~= nil) then
    circles[s1].x = circles[s1].x + deslocamento*directionX
    circles[s1].y = circles[s1].y + deslocamento*directionY
  end

  if(s2 ~= nil) then
    circles[s2].x = circles[s2].x + deslocamento*directionX
    circles[s2].y = circles[s2].y + deslocamento*directionY
  end
end
