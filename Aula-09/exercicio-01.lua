function raiz (x, n)
  local r = 1 -- estimativa inicial
  for i = 1, n do
    r = (r + x/r)/2
  end
  return r
end

for i=1, 9 do
  local r = raiz(81, i)
  print("iterações " .. i, r)
end
