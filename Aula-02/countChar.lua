print("Digite a linha e o caracter procurado: ")
line, char = io.read("*l", "*l")

line, count = string.gsub(line, char, char)
answer = string.format("Resposta: %d", count)
print(answer)