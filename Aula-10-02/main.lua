function love.load()
  window_size = 800
  square_size = window_size/8
  love.window.setMode(window_size, window_size)
end

function draw_squares()
  love.graphics.setColor(85/255, 24/255, 0)
  
  for i=1, 8 do
    for j=1, 8 do
      if((i + j) % 2 == 0) then
        love.graphics.rectangle("fill", 0, 0, square_size, square_size)
      end
      
      love.graphics.translate(square_size, 0)
    end
    
    love.graphics.translate(-window_size, square_size)
  end
  
  love.graphics.translate(0, -window_size)
end

function draw_pieces(start, r, g, b)
  local coord = square_size * (start - 1)
  
  love.graphics.setColor(r, g, b)
  love.graphics.translate(0, coord)
  
  for i=1, 3 do
    for j=1, 8 do
      if((i + start - 1 + j) % 2 == 0) then
        love.graphics.circle("fill", square_size/2, square_size/2, square_size/3)
      end
      
      love.graphics.translate(square_size, 0)
    end
    
    love.graphics.translate(-window_size, square_size)
  end
  
  coord = -square_size * 3 - coord
  love.graphics.translate(0, coord)
end

function love.draw()
  love.graphics.setBackgroundColor(111/255, 64/255, 0)
  
  draw_squares()
  draw_pieces(1, 0, 0, 0)
  draw_pieces(6, 1, 1, 1)
end
