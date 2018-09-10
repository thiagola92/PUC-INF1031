function mdc(x, y)
  if(x < y) then
    local temp = x
    x = y
    y = temp
  end
  
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

print(mdc(1800, 2020))
