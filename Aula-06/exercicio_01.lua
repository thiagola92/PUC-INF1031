
math.randomseed(os.time())
number = math.random(1, 1024)

function guessNumber(max_tries)
  if(max_tries == 0) then
    print("Acabaram suas tentativas")
    return 1
  end

  print("Tente advinhar o número")
  local guess = io.read("*n")

  if(guess > number) then
    print("-1")
  elseif(guess < number) then
    print("1")
  else
    print("0")
    return 1
  end

  return guessNumber(max_tries - 1) + 1
end

tries = guessNumber(20)
if(tries <= 20) then
  print("Você acertou em " .. tries .. " tentativas")
end
