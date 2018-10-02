local dados =
{
  { nome = "Edvaldo Nogueira",
    tempo = "2",
    cidade = "Aracaju"},
  { nome = "Zenaldo Coutinho",
    tempo = "5",
    cidade = "Belem"},
  { nome = "Alexandre Kalil",
    tempo = "2",
    cidade = "Boa Vista"},
  { nome = "Teresa Sutita",
    tempo = "5",
    cidade = "Boa Vista"},
  { nome = "Marquinhos Trad",
    tempo = "2",
    cidade = "Campo Grande"},
  { nome = "Emanuel Pinheiro",
    tempo = "2",
    cidade = "Cuiabá"}
}

local texto = [[
Prezado <nome>,

  Gostaríamos de parabenizá-lo pelo trabalho que vem desenvolvendo
nos últimos <tempo> anos na cidade de <cidade>.

saudações,
]]

for k, v in pairs(dados) do
  local function substitui(rotulo)
    return dados[k][rotulo]
  end

  local s = texto:gsub("<(.-)>", substitui)

  print(s)
  print("-------------------------------")
end
