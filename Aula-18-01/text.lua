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
  meutexto.ancora = "no"

  return meutexto
end

function text.setString(obj, str)
  obj.texto.set(str)
end

local function setColorString(obj, str)
  if(cores.str ~= nil) then
    obj.cor = cores.str
    return
  end

  if(str == "random") then
    local i = math.random(#cores)
    local cor = cores[i]
    obj.cor = cores[cor]

    return
  end

  obj.cor = cores.black
end

function text.setColor(obj, r, g, b)
  if(type(r) == "string") then
    setColorString(obj, r)
  else
    obj.cor = {r, g, b}
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