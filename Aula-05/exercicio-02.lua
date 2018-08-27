function palindrome(s)
  local len = string.len(s)

  if(len == 0) then
    return true
  end

  local first_letter = string.sub(s, 1, 1)
  local last_letter = string.sub(s, len, len)
  
  if(first_letter ~= last_letter) then
    return false
  end
  
  local new_string = string.sub(s, 2, len - 1)
  return palindrome(new_string)
end

print("Diga a frase")
local line = io.read("*line")

if(palindrome(line)) then
  print("É palíndrome")
else
  print("Não é palíndrome")
end
