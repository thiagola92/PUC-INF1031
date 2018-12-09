local new_animation = require("animation")
local animation = new_animation({"stars1.png","stars3.png","stars2.png","stars3.png"}, 0.5)

function love.update()
end

function love.draw()
  animation.draw()
end
