local text = {}

math.randomseed(os.time())

local cores = {
  "black",
  "white",
  "red",
  "green",
  "light_green",
  "blue",
  "light_blue",
  black = {0, 0, 0},
  white = {1, 1, 1},
  red = {1, 0, 0},
  green = {0.13, 0.47, 0.18},
  light_green = {0.15, 0.75, 0.25},
  blue = {0.25, 0.1, 0.85},
  light_blue = {0.1, 0.7, 0.85},
}

local ancoras = {
  no = true,
  n = true,
  ne = true,
  o = true,
  c = true,
  e = true,
  so = true,
  s = true,
  se = true,
}

function text.new(fontname, tam, str)
  local meutexto = {}

  local fonte = love.graphics.newFont(fontname .. ".ttf", tam)
  local texto = love.graphics.newText(fonte, str)

  meutexto.texto = texto
  meutexto.cor = cores.black
  meutexto.contorno = {0, 0, 0, 0}
  meutexto.borda = {0, 0, 0, 0}
  meutexto.ancora = "no"

  return meutexto
end

function text.setString(obj, str)
  obj.texto:set(str)
end

local function setColorString(obj, str)
  if(str == "random") then
    local i = math.random(#cores)
    local cor = cores[i]

    return cores[cor]
  end

  assert(cores[str], "cor inexistente")
  return cores[str]
end

function text.setColor(obj, r, g, b)
  if(type(r) == "string") then
    obj.cor = setColorString(obj, r)
  else
    obj.cor = {r, g, b}
  end
end

function text.setFillColor(obj, r, g, b)
  if(type(r) == "string") then
    obj.contorno = setColorString(obj, r)
  else
    obj.contorno = {r, g, b}
  end
end

function text.setLineColor(obj, r, g, b)
  if(type(r) == "string") then
    obj.borda = setColorString(obj, r)
  else
    obj.borda = {r, g, b}
  end
end

function text.setAnchor(obj, value)
  assert(ancoras[value], "ancora invalida")
  obj.ancora = value
end

function text.getDimensions(obj)
  local width, height = obj.texto:getDimensions()

  return width, height
end

local function translate(width, height, ancora)
  local x, y = 0, 0

  if(ancora == "c") then
    x = -width/2
    y = -height/2
  elseif(ancora == "n") then
    x = -width/2
  elseif(ancora == "s") then
    x = -width/2
    y = -height
  elseif(ancora == "e") then -- leste deveria ser letra l
    x = -width
    y = -height/2
  elseif(ancora == "o") then
    y = -height/2
  elseif(ancora == "ne") then
    x = -width
  elseif(ancora == "se") then
    x = -width
    y = -height
  elseif(ancora == "so") then
    y = -height
  end

  return x, y
end

local function getColor()
  local cor = love.graphics.getColor() -- retorna 1 quando você nunca usou setColor

  if(type(cor) ~= "table") then
    return {0, 0, 0, 0}
  end

  return cor
end

function text.draw(obj, x, y)
  local backupcolor = getColor()
  love.graphics.push()

  local width, height = obj.texto:getDimensions()
  local translate_x, translate_y = translate(width, height, obj.ancora)

  love.graphics.translate(translate_x, translate_y)
  love.graphics.setColor(obj.contorno)
  love.graphics.rectangle("fill", x, y, width, height)
  love.graphics.setColor(obj.borda)
  love.graphics.rectangle("line", x, y, width, height)
  love.graphics.setColor(obj.cor)
  love.graphics.draw(obj.texto, x, y)

  love.graphics.pop()
  love.graphics.setColor(backupcolor)
end

return text
