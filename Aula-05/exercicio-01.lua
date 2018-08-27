function escrevenumeros(n)
  if(n > 0) then
    escrevenumeros(n - 1) -- Para botar de ordem decrescente, troque essa linha de lugar com a linha de baixo
    print(n)
  end
end

print("Digite um número")
numero = io.read("*n")
print("=================")
escrevenumeros(numero)
