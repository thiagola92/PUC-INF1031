local easytext = require "text"

local width, height = 0, 0

local textos = {}
function love.load()
  local t
  
  t = easytext.new("Arial", 32, "X")
  easytext.setAnchor(t, "no")
  table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "n")
  --table.insert(textos, t)
  
  t = easytext.new("Arial", 32, "X")
  easytext.setAnchor(t, "ne")
  table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "o")
  --table.insert(textos, t)
  
  t = easytext.new("Arial", 32, "X")
  easytext.setAnchor(t, "c")
  table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "e")
  --table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "so")
  --table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "s")
  --table.insert(textos, t)
  
  --t = easytext.new("Arial", 32, "X")
  --easytext.setAnchor(t, "se")
  --table.insert(textos, t)
  
  width, height = love.graphics.getDimensions()
end

function love.draw()
  love.graphics.setBackgroundColor(0.5, 0.5, 0.5)
  
  for k,v in pairs(textos) do
    easytext.draw(v, width/2, height/2)
  end
end