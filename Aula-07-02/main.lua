function love.load()
  width, height = love.graphics.getDimensions()
end

function love.draw()
  love.graphics.setBackgroundColor(1, 1, 1)
  
  love.graphics.setColor(0, 0, 0)
  love.graphics.circle("line", width/2, height/2, 100)
  
  love.graphics.setColor(0, 0, 0.5)
  love.graphics.circle("fill", width/2, height/2, 70)
  love.graphics.circle("fill", width/2 + 75, height/2 - 75, 20)
  
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", width/2 + 30, height/2 - 30, 20)
  
  local fonte = love.graphics.newFont("Arial.ttf", 64)
  local texto = love.graphics.newText(fonte, "Lua")
  local tw, th = texto:getDimensions()
  
  love.graphics.draw(texto, (width-tw)/2, (height-th)/2 + 10)
end
