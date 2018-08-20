print("Passe três números")
n1, n2, n3 = io.read("*n", "*n", "*n")

biggest = math.max(n1, n2, n3)
smallest = math.min(n1, n2, n3)

if(n1 ~= biggest and n1 ~= smallest) then
  middle = n1
elseif(n2 ~= biggest and n2 ~= smallest) then
  middle = n2
else
  middle = n3
end

print(smallest, middle, biggest)