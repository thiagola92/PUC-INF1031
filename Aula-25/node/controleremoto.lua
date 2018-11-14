local led1 = 3
local led2 = 6
local sw1 = 1
local sw2 = 2

local minhamat = "1721629"

local msgr = require "mqttNodeMCULibrary"

local cb_switch1, cb_switch2
local alarme1, alarme2

alarme1 = tmr.create()
alarme2 = tmr.create()
alarme3 = tmr.create()

function atirar()
    msgr.sendMessage("atirar," .. minhamat, minhamat .. "love")

    alarme3:register(300, tmr.ALARM_SINGLE, function()
                                                gpio.trig(sw1, "down", cb_switch1)
                                                gpio.trig(sw2, "down", cb_switch2)
                                                end)
    alarme3:start()
end

cb_switch1 = function()
    gpio.trig(sw1)

    local is_running = alarme2:state()
    if(is_running) then 
        alarme2:unregister();
        atirar()
        return
    end

    alarme1:register(300, tmr.ALARM_SINGLE, function()
                                                msgr.sendMessage("esq," .. minhamat, minhamat .. "love")
                                                gpio.trig(sw1, "down", cb_switch1)
                                                end)
    alarme1:start()
end

cb_switch2 = function()
    gpio.trig(sw2)

    local is_running = alarme1:state()
    if(is_running) then
        alarme1:unregister();
        atirar()
        return
    end

    alarme2:register(300, tmr.ALARM_SINGLE, function() 
                                                msgr.sendMessage("dir," .. minhamat, minhamat .. "love")
                                                gpio.trig(sw2, "down", cb_switch2)
                                                end)
    alarme2:start()
end

gpio.mode(sw1, gpio.INT, gpio.PULLUP)
gpio.mode(sw2, gpio.INT, gpio.PULLUP)

gpio.trig(sw1, "down", cb_switch1)
gpio.trig(sw2, "down", cb_switch2)

msgr.start(minhamat, minhamat .. "node", function() end) -- use unique id
