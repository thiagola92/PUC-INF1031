math.randomseed(os.time())
number = math.random(1, 1024)

function computerGuess(max_tries, guess, gap)
  if(max_tries == 0) then
    print("Acabaram suas tentativas")
    return 1
  end

  print("Chute do computador: " .. guess)
  print("Diga -1 se menor, 1 se maior, 0 se ele acertou")
  local answer = io.read("*n")

  if(answer == 1) then
    guess = guess + gap/2
  elseif(answer == -1) then
    guess = guess - gap/2
  else
    return 1
  end

  gap = gap/2
  return computerGuess(max_tries - 1, guess, gap) + 1
end

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

print("Quem tentará advinhar? 0 (o usuário) ou 1 (o computador)")
answer = io.read("*n")

if(answer == 0) then
  tries = guessNumber(20)
elseif(answer == 1) then
  try = 1024/2
  tries = computerGuess(20, try, try)
end

if(tries ~= nil and tries <= 20) then
  print("Você acertou em " .. tries .. " tentativas")
end
