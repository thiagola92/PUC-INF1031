function minmax(array)
  local min = nil
  local max = nil
  
  for k, v in pairs(array) do
    if(max == nil or v > max) then
      max = v
    end
    
    if(min == nil or v < min) then
      min = v
    end
  end
  
  return {min = min, max = max}
end

a = {}
a[1] = 10
a[2] = 3
a[10] = 20
a["coe"] = 15

x = minmax(a)
print("min", x.min)
print("max", x.max)
