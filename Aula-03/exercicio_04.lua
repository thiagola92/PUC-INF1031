print("Insira a nota da P1 e P2")
p1, p2 = io.read("*n", "*n")
media = (p1 + p2) / 2

if(p1 < 3 or p2 < 3 or media < 5) then
  print("Insira a nota da P3")
  p3 = io.read("*n")
  maior_nota = math.max(p1, p2)

  media = (p3 + maior_nota) / 2
end

if(media >= 5) then
  print(media, "Aprovado")
else
  print(media, "Reprovado")
end