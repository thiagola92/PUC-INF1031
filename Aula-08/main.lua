-- Atualmente eu utilizo a versão 0.9.1 do LOVE2D
-- Pois a versão 11 gerava algum problema com o MQTT/Socket no Ubuntu
-- Por isso utilizo esse código para corrigir cores.
local function color(red, green, blue, alpha)
  local major, minor, revision = love.getVersion()

  red = red or 1
  green = green or 1
  blue = blue or 1
  alpha = alpha or 1

  if(major == 0 and minor < 10) then
    red = red * 255
    green = green * 255
    blue = blue * 255
    alpha = alpha * 255
  end

  return red, green, blue, alpha
end

function love.load()
  love.graphics.setNewFont("Arial.ttf", 32)
end

function desenhar_relogio()
  local width, height = love.graphics.getDimensions()
  local pont_largura = 10
  local angle = 0

  love.graphics.push()
  love.graphics.translate(width/2, height/2)

  -- circulo
  love.graphics.setColor(color(0.5, 0.5, 0.5))
  love.graphics.circle("fill", 0, 0, 250)

  -- ponteiro dos segundos
  angle = (2*math.pi/60) * horario.sec
  love.graphics.rotate(angle)
  love.graphics.setColor(color(1, 0, 0))
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -250)
  love.graphics.rotate(-angle)

  -- ponteiro dos minutos
  angle = (2*math.pi/60) * horario.min
  love.graphics.setColor(color(0, 0, 1))
  love.graphics.rotate(angle)
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -200)
  love.graphics.rotate(-angle)

  -- ponteiro das horas
  angle = (2*math.pi/12) * horario.hour
  love.graphics.setColor(color(0, 1, 0))
  love.graphics.rotate(angle)
  love.graphics.rectangle("fill", -pont_largura/2, 0, pont_largura, -150)

  love.graphics.pop()
end

function desenhar_horarios()
  local fonte = love.graphics.getFont()
  local width, height = love.graphics.getDimensions()
  local angle = (2*math.pi/12)

  love.graphics.push()
  love.graphics.setColor(0, 0, 0)
  love.graphics.translate(width/2, height/2)

  local date = os.date("%x")
  local fonte_width = fonte:getWidth(date)
  love.graphics.print(date, -fonte_width/2)

  for i=1,12 do
    -- Versão 0.9.1 não tinha love.graphics.newText
    fonte_width = fonte:getWidth(i .. "")

    love.graphics.rotate(angle*i)
    love.graphics.print(i, 0, -230, -angle*i, 1, 1, fonte_width/2, 16)
    love.graphics.rotate(-angle*i)
  end

  love.graphics.pop()
end

function love.draw()
  horario = os.date("*t")

  love.graphics.setBackgroundColor(color(1, 1, 1))

  desenhar_relogio()
  desenhar_horarios()
end
