function love.load()
end

function desenhar_relogio()
  local horario = os.date("*t")
  local width, height = love.graphics.getDimensions()
  local pont_largura = 10
  local angle = 0
  love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
  love.graphics.translate(width/2, height/2)
  
  -- circulo
  love.graphics.setColor(1, 1, 1)
  love.graphics.circle("fill", 0, 0, 250)
  
  -- ponteiro dos segundos
  print("seg", horario.sec)
  angle = (2*math.pi/60) * horario.sec
  love.graphics.rotate(angle)
  love.graphics.setColor(1, 0, 0)
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -250)
  love.graphics.rotate(-angle)
  
  -- ponteiro dos minutos
  print("min", horario.min)
  angle = (2*math.pi/60) * horario.min
  love.graphics.setColor(0, 0, 1)
  love.graphics.rotate(angle)
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -200)
  love.graphics.rotate(-angle)
  
  -- ponteiro das horas
  print("hora", horario.hour)
  angle = (2*math.pi/12) * horario.hour
  love.graphics.setColor(0, 1, 0)
  love.graphics.rotate(angle)
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -150)
  love.graphics.rotate(-angle)
end


function love.draw()
  desenhar_relogio()
end

