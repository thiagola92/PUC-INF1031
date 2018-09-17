function love.load()
  math.randomseed(os.time())
  
  width, height = love.graphics.getDimensions()
  circles = {}
  selected = nil
  
  for i=1, 150 do
    local r = math.random(10,40)
    local x = math.random(r, width - r)
    local y = math.random(r, height - r)
    local color = {math.random(0,1), math.random(0,1), math.random(0,1)}
    
    circles[i] = {x = x, y = y, r = r, color = color}
  end
end

function love.draw()
  for k, v in pairs(circles) do
    if(k == selected) then
      love.graphics.setColor(1, 0, 0)
    else
      love.graphics.setColor(v.color)
    end
    
    love.graphics.circle("fill", v.x, v.y, v.r)
  end
  
end

function is_colliding(x, y, v)
  local distance = math.sqrt((x - v.x)^2 + (y - v.y)^2)
  return distance < v.r
end

function love.mousepressed(x, y)
  for k, v in pairs(circles) do
    if(is_colliding(x, y, v)) then
      selected = k
    end
  end
end

