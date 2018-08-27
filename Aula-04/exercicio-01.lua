radius, height = io.read("*n", "*n")

function volume_and_area(r, h)
  v = math.pi * math.pow(r, 2) * h
  a = 2 * math.pi * r * (r + h)

  return v, a
end

volume, area = volume_and_area(radius, height)

print("Volume = " .. volume, "Area = " .. area)
