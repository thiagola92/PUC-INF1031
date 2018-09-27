local discs = {}
local selected = {}

function love.load ()
  w, h = love.graphics.getDimensions()
  local S = os.time()

  math.randomseed(S)
  for i = 1, 150 do
    local r = math.random(10,40)
    local x = math.random(r,w-r)
    local y = math.random(r,h-r)
    local color = {math.random(0,1*255), math.random(0,1*255), math.random(0,1*255)}
    table.insert(discs, {r = r, x = x, y = y, color = color})
  end

  delta = math.min (w,h)/10000

  love.graphics.setBackgroundColor(0.75*255,0.75*255,0.75*255)
end

local function overlap (i, j)
  local dx = discs[i].x - discs[j].x
  local dy = discs[i].y - discs[j].y

  local len = math.sqrt(dx*dx + dy*dy)

  local d = len - (discs[i].r+discs[j].r)
  if d < 0 then

    local ux = dx*d/len
    local uy = dy*d/len
    return ux, uy
  else
    return 0, 0
  end
end

local function overlap_edge(i)
  local ux, uy = 0, 0

  if(discs[i].x - discs[i].r < 0) then
    ux = discs[i].x - discs[i].r
  elseif(discs[i].x + discs[i].r - w > 0) then
    ux = discs[i].x + discs[i].r - w
  end

  if(discs[i].y - discs[i].r < 0) then
    uy = discs[i].y - discs[i].r
  elseif(discs[i].y + discs[i].r - h > 0) then
    uy = discs[i].y + discs[i].r - h
  end

  return ux, uy
end

local function relaxation()
  for k1,_ in pairs(selected) do
    local vetorx, vetory = 0, 0

    for k2,_ in pairs(selected) do
      if(k1 ~= k2) then
        local ux, uy = overlap(k1, k2)
        vetorx = vetorx + ux
        vetory = vetory + uy
      end
    end

    local ux, uy = overlap_edge(k1)
    vetorx = vetorx + ux
    vetory = vetory + uy

    discs[k1].x = discs[k1].x - vetorx/2
    discs[k1].y = discs[k1].y - vetory/2
  end
end

function love.update()
  local dx, dy = 0, 0
  if love.keyboard.isDown("right") then
    dx = 1
  elseif love.keyboard.isDown("left") then
    dx = -1
  elseif love.keyboard.isDown("down") then
    dy = 1
  elseif love.keyboard.isDown("up") then
    dy = -1
  end
  for index,_ in pairs(selected) do
    discs[index].x = discs[index].x + 25*dx*delta
    discs[index].y = discs[index].y + 25*dy*delta
  end

  if love.keyboard.isDown("t") then
    relaxation()
  end
end

function love.draw ()
  for i = 1, #discs do
    if selected[i] then
      love.graphics.setColor(0.5,0,0)
    else
      love.graphics.setColor(discs[i].color[1],discs[i].color[2],discs[i].color[3])
    end
   love.graphics.circle("fill",discs[i].x,discs[i].y,discs[i].r)
  end
end

function love.keypressed (key)
  if key == " " or key == "space" then
    for k,_ in pairs(selected) do
      selected[k] = nil
    end
  elseif key == "r" then
    relaxation()
  end
end

function love.mousepressed (x, y, bt)
  for i = #discs, 1, -1 do
    if math.sqrt((x-discs[i].x)^2 + (y-discs[i].y)^2) < discs[i].r then
      selected[i] = true
      break
    end
  end
end
