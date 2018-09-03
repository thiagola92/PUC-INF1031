function love.draw()
  -- Pegando o tamanho da tela
  local width, height = love.graphics.getDimensions();
  
  -- Pegando o tempo
  local horario = os.date("*t")
  local horario_texto = string.format("%d horas, %d minutos, %d segundos", horario.hour, horario.min, horario.sec)
  
  -- Escolhendo a fonte do texto, depois criando o texto desenhavel
  local fonte = love.graphics.newFont("Arial.ttf", 32)
  local texto = love.graphics.newText(fonte, horario_texto)
  
  -- Desenhando no centro da tela
  local t_width, t_height = texto:getDimensions()
  love.graphics.draw(texto, (width - t_width)/2, (height- t_height)/2)
end