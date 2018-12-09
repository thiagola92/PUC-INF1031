local function new(list_of_path, delay)
  local animation = {}

  animation.delay = delay or 1
  animation.list_of_images = {}
  animation.index = 1
  animation.next_change = love.timer.getTime() + animation.delay

  for i=1, #list_of_path do
    animation.list_of_images[i] = love.graphics.newImage(list_of_path[i])
  end

  function animation.change_image()
    local now = love.timer.getTime()

    if(now >= animation.next_change) then
      animation.next_change = now + animation.delay
      animation.index = animation.index + 1

      if(animation.index > #animation.list_of_images) then
        animation.index = 1
      end

    end
  end

  function animation.draw(x, y)
    love.graphics.setColor(1,1,1,1)
    love.graphics.draw(animation.list_of_images[animation.index], x, y)
    animation.change_image()
  end

  return animation
end

return new
