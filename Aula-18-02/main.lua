local easytext = require "text"

local width, height = 0, 0

local testeCorAncoraString = {}
local testeContornoLinha = {}

function love.load()
  local t

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "black")
  easytext.setAnchor(t, "no")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "white")
  easytext.setAnchor(t, "n")
  easytext.setString(t, "B")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "red")
  easytext.setAnchor(t, "ne")
  easytext.setString(t, "C")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "green")
  easytext.setAnchor(t, "o")
  easytext.setString(t, "D")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "light_green")
  easytext.setAnchor(t, "c")
  easytext.setString(t, "E")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "blue")
  easytext.setAnchor(t, "e")
  easytext.setString(t, "F")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "light_blue")
  easytext.setAnchor(t, "so")
  easytext.setString(t, "G")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, "random")
  easytext.setAnchor(t, "s")
  easytext.setString(t, "H")
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setColor(t, 0.5, 0, 0.5) -- roxo
  easytext.setAnchor(t, "se")
  easytext.setString(t, "K")  -- Pois I e J não possuem o mesmo tamanho que as outras
  print(easytext.getDimensions(t))
  table.insert(testeCorAncoraString, t)

  ----------------------------------------------------------

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "black")
  easytext.setLineColor(t, 0.5, 0, 0.5)
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "white")
  easytext.setLineColor(t, "random")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "red")
  easytext.setLineColor(t, "light_blue")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "green")
  easytext.setLineColor(t, "blue")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "light_green")
  easytext.setLineColor(t, "green")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "blue")
  easytext.setLineColor(t, "light_green")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "light_green")
  easytext.setLineColor(t, "red")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, "random")
  easytext.setLineColor(t, "white")
  table.insert(testeContornoLinha, t)

  t = easytext.new("Arial", 128, "A")
  easytext.setAnchor(t, "c")
  easytext.setFillColor(t, 0.5, 0, 0.5)
  easytext.setLineColor(t, "black")
  table.insert(testeContornoLinha, t)

  ----------------------------------------------------------

  width, height = love.graphics.getDimensions()
end

function love.draw()
  love.graphics.setBackgroundColor(0.5, 0.5, 0.5)

  for k,v in pairs(testeCorAncoraString) do
    easytext.draw(v, width/2, height/2)
  end

  for i,v in ipairs(testeContornoLinha) do
    easytext.draw(v, 45*i + 45*(i - 1), 50)
  end
end
