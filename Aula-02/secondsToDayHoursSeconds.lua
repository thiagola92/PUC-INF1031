print("Digite o numero de segundos:")

s = io.read("*n")

d = math.floor(s / 86400)
s = s % 86400

h = math.floor(s / 3600)
s = s % 3600

m = math.floor(s / 60)
s = s % 60

answer = string.format("%d dias, %d horas, %d minutos, %d segundos", d, h, m, s)
print(answer)