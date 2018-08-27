function potentiation(x , k)
  if(k == 0) then
    return 1
  end

  return potentiation(x, k - 1) * x
end

pot = potentiation(2, 3)
print("2^3", pot, 2^3)

pot = potentiation(-2, 3)
print("-2^3", pot, (-2)^3)

pot = potentiation(1, 0)
print("1^0", pot, 1^0)

pot = potentiation(-1, 0)
print("-1^0", pot, (-1)^0)
