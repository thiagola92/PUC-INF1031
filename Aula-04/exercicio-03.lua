n = io.read("*n")

function exercise(n)
  if(n <= 0) then
    return 0
  end

  value = 1 / (2 ^ n)
  return value + exercise(n - 1)
end

print(exercise(n))
