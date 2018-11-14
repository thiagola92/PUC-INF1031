msgr = require "mqttLoveLibrary"

local bolas = {}
local jogadores = {}
local N = 20
local R = 50

local minhamat = "1721629"

local cores = {{102/255,255/255,102/255},
               {255/255,178/255,102/255},
               {160/255,160/255,160/255},
               {255/255,102/255,102/255},
               {76/255, 0, 153/255},
               {200/255, 50/255, 50/255},
               {0,51/255,102/255}}

local function mensagemRecebida (msg)
  local _,_,mov, jog = string.find (msg, "(%a+),(%d+)")
  print("recebeu: ", mov, jog)
  
  if(jogadores[jog] == nil) then
    jogadores[jog] = largura/2
  end
  
  -- trata jogada
  if mov == "atirar" then
    
    -- verificar se tem algum disco atingido
    -- sugest~ao: testar math.abs(posicao[jog]-bolas[i].x) < bolas[i].r
    for i=#bolas,1,-1 do
      if math.abs(jogadores[jog]-bolas[i].x) < bolas[i].r then
        table.remove(bolas, i)
        return
      end
    end
    
  elseif mov == "dir" then
    jogadores[jog] = jogadores[jog] + 10
  elseif mov == "esq" then
    jogadores[jog] = jogadores[jog] - 10
  else
    print ("movimento desconhecido!")
  end
end
-- por enquanto estou supondo apenas um jogador

function love.load ()
  msgr.start(minhamat, minhamat .. "love", mensagemRecebida)
  largura, altura = love.graphics.getDimensions()
  
  -- generate disks
  math.randomseed(os.time())
  for i = 1, N do
    local r = math.random(R/10,R)
    local x = math.random(r,largura-r)
    local cor = cores[math.random(1, #cores)]
    table.insert(bolas,{r = r, x = x, y = altura/3, cor = cor})
  end
  jogadores[minhamat] = largura/2 -- coordenada x do jogador
  
  -- init graphics
  love.graphics.setBackgroundColor(1,1,1)
end

function love.draw ()
  
  -- desenho discos que ainda existem:
  for i = 1, #bolas do
    love.graphics.setColor(bolas[i].cor[1],bolas[i].cor[2],bolas[i].cor[3])
    love.graphics.circle("fill",bolas[i].x,bolas[i].y,bolas[i].r)
  end
  love.graphics.setColor(0,0,0)
  
  -- desenho o disco do jogador:
  for k, v in pairs(jogadores) do
    love.graphics.circle ("fill", v, altura-altura/20, altura/60)
  end
end

function love.update(dt)
  msgr.checkMessages()
end
