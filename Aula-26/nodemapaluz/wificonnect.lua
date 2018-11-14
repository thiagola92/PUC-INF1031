local function wifi_connected_callback(iptable)
  print("wifi_connected_callback")
  print("ip: " .. iptable.IP)
end

wificonf = {
  ssid = "NomeDoWifi_caseSensitive",
  pwd = "SenhaDoWifi",
  got_ip_cb = wifi_connected_callback,
  save = false,
}

wifi.setmode(wifi.STATION)
wifi.sta.config(wificonf)
