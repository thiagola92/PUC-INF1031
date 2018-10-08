local traducao = {a = 'c', b = 'd', c = 'a', d = 'm'}

function codifica(texto, traducoes)
  local novo_texto = ""

  for i=1,string.len(texto) do
    local letra = string.sub(texto,i,i)
    for k,v in pairs(traducoes) do
      if(k == letra) then
        letra = v
        break
      end
    end

    novo_texto = novo_texto .. letra
  end

  return novo_texto
end

print(codifica("abderfraab", traducao))
