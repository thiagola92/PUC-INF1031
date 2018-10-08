local text = {}

math.randomseed(os.time())

local cores = {
  preto = {0, 0, 0},
  azul = {0, 0, 1},
  verde = {0, 1, 0},
  vermelho = {1, 0, 0},
  verde_claro = {0, 0.5, 0},
  azul_claro = {0, 0, 0.5},
  random = {0, 0, 0},
}

function text.new(fontname, size, str)
  local meutexto = {}
  
  local fonte = love.graphics.newFont(fontname .. ".ttf", size)
  local texto = love.graphics.newText(fonte, str)
  
  meutexto.texto = texto
  meutexto.cor = cores.preto
  meutexto.ancora = "no"
  
  return meutexto
end

function text.setString(obj, str)
  
end

function text.setColor(obj, r, g, b)
  if(type(r) == "string") then
  end
end

function text.setAnchor(obj, value)
end

function text.getDimensions(obj)
  
  return 0, 0
end

function text.draw(obj, x, y)
end

return text