function mdc(x, y)
  local r = x % y
  
  while(r ~= 0) do
    r = x % y
    
    if(r == 0) then
      return y
    end
    
    x = y
    y = r
  end
  
  return y
end

print("Diga os dois numeros que voce quer saber o MDC:")
n1 = io.read("*n")
n2 = io.read("*n")
print(mdc(n1, n2))
