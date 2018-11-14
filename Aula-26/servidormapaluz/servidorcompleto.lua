msgr = require "mqttLoveLibrary"

local minhamat = "123"
local fileiras = 5
local posicoes = 6
local leituras = {}

local function serializaleituras ()
  local temp = {}
  for i = 1, fileiras do
   temp[i] = table.concat(leituras[i], ", ")
   temp[i] = "{".. temp[i].. "}"
  end
  local s = "{" .. table.concat (temp, ", ") .. "}"
  return s
end

local function mensagemRecebida (msg)
-- espera receber mensagens do tipo <tipomsg><valor(es)>

  local i, f, tipomsg = string.find (msg, "<(%a+)>")
  print("tipo ", tipomsg)
  if i == nil then
    print("mensagem invalida - nao contem campo tipo")
    return
  end
  if tipomsg == "reg" then
    print ("registro de luminosidade!")
    local x, y, z
     _, _, x, y, z  = string.find (msg, "<%s*(%d+)%s*,%s*(%d+)%s*,%s*(%d+)%s*>", f)
    local i, j, lum = tonumber (x), tonumber(y), tonumber(z)
    -- formato correto?
    if i == nil or j == nil or lum == nil then
      print("mensagem invalida - registro nao contem os 3 inteiros esperados")
      return
    -- fileira e posicao validas? 
    elseif i<1 or i>fileiras or j<1 or j>posicoes then
      print("fileira ou posicao invalida!")
      return
    end
    leituras[i][j] = lum
  elseif tipomsg == "req" then
    print ("requisição de luminosidade na sala")
    _, _, canalresp = string.find (msg, "<([%w%s]+)>", f)
    if canalresp == nil then
      print ("mensagem invalida - requisicao nao contem um canal para resposta")
      return
    end
    print ("canal de resposta: ", canalresp)
    msgr.sendMessage (serializaleituras(), canalresp)
  else
    print ("mensagem de tipo desconhecido")
  end
end

msgr.start(minhamat, "luminosidadesala", mensagemRecebida) 

for i = 1, fileiras do
  leituras[i] = {}
  for j = 1, posicoes do
    leituras[i][j] = 2000
  end
end

while true do
  msgr.checkMessages() -- tem que constar no love.update!!!
end

