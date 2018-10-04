function love.load()
  local arq = io.open("martinlutherking.txt","r")
  if not arq then
    print("Nao foi possivel abrir arquivo:",nomearq)
    return nil
  end
  local texto = arq:read("*a")
  contapal = {}
  string.gsub(texto,"%w+",function (s)
                            if #s > 4 then -- ignora palavras pequenas
                              s = string.lower(s)
                              if contapal[s] then
                                contapal[s] = contapal[s]+ 1
                              else
                                contapal[s] = 1
                              end
                            end
                          end)
  -- armazena palavras num vetor e 
  pals = {}
  for p, n in pairs(contapal) do
    pals[#pals+1] = p
  end

  -- falta ordenar ordenar vetor
  table.sort(pals, function(a, b) return contapal[a] > contapal[b] end)
  table.sort(contapal, function(a, b) return a > b end)

  -- mostra resultados
  max = math.min(10, #pals)

  for i = 1, max do
    print (pals[i], contapal[pals[i]])
  end
  
  width, height = love.graphics.getDimensions()
  
  paramostrar = {}
  for i = 1, max do
    local font = love.graphics.newFont("Arial.ttf", 64 - i*4)
    local text = love.graphics.newText(font, pals[i])
    local mostrar = {
      x = width/2 - text:getWidth()/2,
      y = i*(height-50)/max - 50,
      cor = {math.random(0,1), math.random(0,1), math.random(0,1)},
      s = 2,
      text = text,
    }
    
    paramostrar[i] = mostrar
  end
end

function love.draw()
  for i = 1, #paramostrar do
    love.graphics.setColor(paramostrar[i].cor)
    love.graphics.draw(paramostrar[i].text, paramostrar[i].x, paramostrar[i].y)
  end
end
