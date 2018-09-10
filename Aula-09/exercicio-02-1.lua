function raiz (x, n)
  local r = 1 -- estimativa inicial
  for i = 1, n do
    r = (r + x/r)/2
  end
  return r
end

function is_prime(number)
  if(number == 2 or number == 3) then
    return true
  elseif(number % 2 == 0 or number <= 1) then
    return false
  end

  local max_tries = raiz(number, 10)

  for i= 3, max_tries, 2 do
    if(number % i == 0) then
      return false
    end
  end

  return true
end

function print_all_primes(max)
  if(max >= 2) then
    io.write(2)
  end

  for i=3, max, 2 do
    if(is_prime(i)) then
      io.write("," .. i)
    end
  end

  print()
end

print("Diga até que número você quer saber os primos")
number = io.read("*n")
print_all_primes(number)