simpleMQTT = require("mqttNodeMCULibrary")

local button1 = 1
local button2 = 2
local buttonPressed = {}

local alarm = tmr.create()

local server = "ProjetoPT"
--local player = 1

buttonPressed[button1] = false
buttonPressed[button2] = false

local button1Down, button2Down

local function sendButtonsPressed()
  local message = "<%d><%s>"

  if(buttonPressed[button1] and buttonPressed[button2]) then
    message = message:format(player,"both")
  elseif(buttonPressed[button1]) then
    message = message:format(player,"button1")
  elseif(buttonPressed[button2]) then
    message = message:format(player,"button2")
  else
    return -- se não é nenhuma das opções que queremos, terminar aqui
  end

  simpleMQTT.sendMessage(message, server)
end

local function activeButtons()
  sendButtonsPressed()

  buttonPressed[button1] = false
  buttonPressed[button2] = false

  gpio.trig(button1, "down", button1Down)
  gpio.trig(button2, "down", button2Down)
end

button1Down = function ()
  gpio.trig(button1)

  buttonPressed[button1] = true

  -- se o outro botão não foi apertado então chamamos o alarme daqui 500ms
  -- caso tenha sido, não precisamos chamar o alarme pois daqui a 500ms já vamos chamar activeButtons
  if(buttonPressed[button2] == false) then
    alarm:register(250, tmr.ALARM_SINGLE, activeButtons)
    alarm:start()
  end
end

button2Down = function ()
  gpio.trig(button2)

  buttonPressed[button2] = true

  if(buttonPressed[button1] == false) then
    alarm:register(250, tmr.ALARM_SINGLE, activeButtons)
    alarm:start()
  end
end

gpio.mode(button1, gpio.INT, gpio.PULLUP)
gpio.mode(button2, gpio.INT, gpio.PULLUP)

gpio.trig(button1, "down", button1Down)
gpio.trig(button2, "down", button2Down)

simpleMQTT.start(server .. player, server .. player, function() end)
