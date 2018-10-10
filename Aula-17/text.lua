local text = {}

math.randomseed(os.time())

local cores = {
  preto = {0, 0, 0},
  azul = {0, 0, 1},
  verde = {0, 1, 0},
  vermelho = {1, 0, 0},
  verde_claro = {0, 0.5, 0},
  azul_claro = {0, 0, 0.5},
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
  obj.texto.set(str)
end

local function countTable()
  local contador = 0
  for _,_ in pairs(cores) do
    contador = contador + 1
  end
  
  return contador
end

local function setColorString(obj, str)
  if(cores.str ~= nil) then
    obj.cor = cores.str
    return
  end

  if(str == "random") then
    local start = 1
    local stop = math.random(countTable())

    for k, v in pairs(cores) do
      if(start == stop) then
        obj.cor = v
        break
      end

      start = start + 1
    end

    return
  end

  obj.cor = cores.preto
end

function text.setColor(obj, r, g, b)
  if(type(r) == "string") then
    setColorString(obj, r)
  else
    obj.cor = {r, g, b}
  end
end

function text.setAnchor(obj, value)
  obj.ancora = value
end

function text.getDimensions(obj)
  local width, height = obj.texto:getDimensions()

  return width, height
end

local function newPosition(x, y, width, height, ancora)
  if(ancora == "c") then
    x = x - width/2
    y = y - height/2
  elseif(ancora == "n") then
    x = x - width/2
  elseif(ancora == "s") then
    x = x - width/2
    y = y - height
  elseif(ancora == "e") then -- leste deveria ser letra l
    x = x - width
    y = y - height
  elseif(ancora == "o") then
    y = y - height/2
  elseif(ancora == "ne") then
    x = x - width
  elseif(ancora == "se") then
    x = x - width
    y = y - height
  elseif(ancora == "so") then
    y = y - height
  end

  return x, y
end

function text.draw(obj, x, y)
  love.graphics.push()

  local width, height = obj.texto:getDimensions()

  x, y = newPosition(x, y, width, height, obj.ancora)
  love.graphics.setColor(obj.cor)
  love.graphics.draw(obj.texto, x, y)

  love.graphics.pop()
end

return text