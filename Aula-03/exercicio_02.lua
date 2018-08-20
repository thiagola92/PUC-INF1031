print("Passe três números")
n1, n2, n3 = io.read("*n", "*n", "*n")

biggest = math.max(n1, n2, n3)
print("Maior valor é " .. biggest)