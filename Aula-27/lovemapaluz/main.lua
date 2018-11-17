msgr = require "mqttLoveLibrary"

local minhamat = "1721629"
local meucanal = minhamat .. "love"
local altura, largura
local fileiras = 5
local posicoes = 8
local leituras = {}

-- cores pre-determinadas:
local cores = {{1, 1, 0},
               {1, 0.8, 0.4},
               {1, 0.75, 0},
               {0.8, 0.5, 0},
               {0.2, 0.1, 0},
               {1, 0, 0}}

local function mensagemRecebida (msg)
  print ("recebeu: ", msg)
  local vals = loadstring ("return ".. msg)()
  for i = 1,fileiras do
    for j = 1,posicoes do
      if vals[i][j] > 2000 then
        leituras[i][j] = cores[6]
      elseif vals[i][j] > 1500 then
        leituras[i][j] = cores[5]
      elseif vals[i][j] > 1000 then
        leituras[i][j] = cores[4]
      elseif vals[i][j] > 800 then
        leituras[i][j] = cores[3]
      elseif vals[i][j] > 700 then
        leituras[i][j] = cores[2]
      else
        leituras[i][j] = cores[1]
      end
    end
  end

end

function love.mousepressed(x, y)
  local width = largura/posicoes
  local height = altura/fileiras
  
  posicaoPressed = math.floor(x / width) + 1
  fileiraPressed = math.floor(y / height) + 1
  
  msgr.sendMessage ("<req><" .. meucanal .. ">", "546_" .. fileiraPressed .. "_" .. posicaoPressed)
end

function love.keypressed (key)
  if(key == "a") then
    msgr.sendMessage ("<req><" .. meucanal .. ">", "servidor546")
  end
end

function love.load ()
  msgr.start(minhamat, meucanal,
             mensagemRecebida)
  largura, altura = love.graphics.getDimensions()
  -- inicializa mapa de cores
  for i = 1, fileiras do
    leituras[i] = {}
    for j = 1,posicoes do
      leituras[i][j] = cores[5]
    end
  end
  -- inicializa parte grÃ¡fica
  love.graphics.setBackgroundColor(1,1,1)
  local font = love.graphics.newFont("Arial.ttf",24)
  text1 = love.graphics.newText(font,"")
end

function love.update(dt)
  msgr.checkMessages() -- tem que constar no love.update!!!
end

function love.draw ()
  local x, y = 0, 0
  for i = 1, fileiras do
    for j = 1, posicoes do
      love.graphics.setColor(unpack(leituras[i][j]))
      love.graphics.rectangle ("fill", x, y, x+largura/posicoes, y+altura/fileiras)
      love.graphics.setColor(1,0,0)
      love.graphics.rectangle ("line", x, y, x+largura/posicoes, y+altura/fileiras)
      x = x+largura/posicoes
    end
    x = 0
    y = y+altura/fileiras
  end
end
