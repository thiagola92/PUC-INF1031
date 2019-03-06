local collision = {}

function collision.circle_circle(x1, y1, r1, x2, y2, r2)
  local distance = math.sqrt((x1-x2)^2 + (y1-y2)^2)
  
  if (distance <= r1 + r2) then
    return true
  end
  
  return false
end

function collision.circle_rectangle(x1, y1, r1, x2, y2, w2, h2)
  local x3
  local y3
  
  if (x1 > x2 and x1 < x2 + w2) then
    x3 = x1
  elseif (x1 <= x2) then
    x3 = x2
  elseif (x1 >= x2 + w2) then
    x3 = x2 + w2
  end
  
  if (y1 > y2 and y1 < y2 + h2) then
    y3 = y1
  elseif (y1 <= y2) then
    y3 = y2
  elseif (y1 >= y2 + h2) then
    y3 = y2 + h2
  end
  
  return collision.circle_circle(x1, y1, r1, x3, y3, 0)
end

function collision.rectangle_rectangle(x1, y1, w1, h1, x2, y2, w2, h2)
  if (x1 + w1 >= x2 and y1 + h1 >= y2 and x2 + w2 >= x1 and y2 + h2 >= y1) then
    return true
  end
  
  return false
end

function collision.line_point(x1, y1, x2, y2, x3, y3)
  local line_length = math.sqrt((x1-x2)^2 + (y1-y2)^2)
  
  local distance_to_line1 = math.sqrt((x1-x3)^2 + (y1-y3)^2)
  local distance_to_line2 = math.sqrt((x2-x3)^2 + (y2-y3)^2)
  local distance = distance_to_line1 + distance_to_line2
  
  local accurate = 0.1
  
  if (distance >= line_length - accurate and distance <= line_length + accurate) then
    return true
  end
  
  return false
end

function collision.line_circle(x1, y1, x2, y2, x3, y3, r3)
  local line_length = math.sqrt((x1-x2)^2 + (y1-y2)^2)
  
  local dot_x = (x3-x1) * (x2-x1)
  local dot_y = (y3-y1) * (y2-y1)
  local dot = (dot_x + dot_y) / (line_length^2)
  
  local x4 = x1 + (dot * (x2-x1))
  local y4 = y1 + (dot * (y2-y1))
  
  if (collision.line_point(x1, y1, x2, y2, x4, y4) == false) then
    return false
  end
  
  return collision.circle_circle(x3, y3, r3, x4, y4, 0)
end

function collision.line_line(x1, y1, x2, y2, x3, y3, x4, y4)
  local uA = ((x4-x3)*(y1-y3) - (y4-y3)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1))
  local uB = ((x2-x1)*(y1-y3) - (y2-y1)*(x1-x3)) / ((y4-y3)*(x2-x1) - (x4-x3)*(y2-y1))
  
  if (uA >= 0 and uA <= 1 and uB >= 0 and uB <= 1) then
    return true
  end
  
  return false
end

return collision
