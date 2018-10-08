local maxpals = 10

local easytext = require "text"

function love.load ()
  -- criar lista de palavras
  local arq = love.filesystem.newFile("martinlutherking.txt")
  local texto = arq:read()
  arq:close()

  -- conta ocorrencias de palavras
  local contapal = {}
  string.gsub(texto,"[%w\127-\255]+",function (s)
                            if #s > 4 then
                              s = string.lower(s)
                              contapal[s] = (contapal[s] or 0) + 1
                            end
                          end
             )

  -- armazena palavras num vetor e ordena
  local pals = {}
  for p, n in pairs(contapal) do
    pals[#pals+1] = p
  end
  table.sort (pals, function (a,b) return contapal[a]  > contapal[b]  end)

  local w, h = love.graphics.getDimensions()
  local x = w/2
  local y = h/maxpals
  textos = {}
  local numpals = math.min(maxpals, #pals)
  for i = 1, numpals do
    local size = ((maxpals - i)/ maxpals) * 50 + 20
    print(pals[i])
    local texto = easytext.new("Arial", size, pals[i])
    easytext.setAnchor (texto, "c")
    easytext.setColor (texto, "random")
    textos[i] = {pal = texto, x = x, y = y} 
    local tx, ty = easytext.getDimensions(textos[i].pal)
    y = y + ty
  end
end
    
function mostrapals ()
  for i = 1, #textos do
    easytext.draw(textos[i].pal, textos[i].x, textos[i].y)
  end
end
    

function love.draw()
  love.graphics.setBackgroundColor(1,1,1)
  mostrapals()
end