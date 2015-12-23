--uart.setup(0,9600,8,0,1)
tmr.delay(500000)
print("Connecting...")
wifi.sta.config("AP_SSID","AP_password")
wifi.setmode(wifi.STATIONAP)
wifi.sta.autoconnect(1)
wifi.sta.connect()

id = wifi.sta.getmac()

if (host == nil or host == '') then
     host = "hostname.com"
end
if (port == nil or port == '' or port == 0) then
     port = 80
end
if (path == nil or path == '') then
     path = "/path/to.php?data="
end
if (tag == nil or tag == '') then
     tag = "buttonPressed"
end
if (samplingPeriod == nil or samplingPeriod == '') then
     samplingPeriod = 10
end
if (sendInterval == nil or sendInterval == '') then
     sendInterval = 30
end

function sendData(dataString)

     wifi.sleeptype(wifi.NONE_SLEEP)
     --print("Sending data")
     time = tmr.now()
     cn=net.createConnection(net.TCP,0)
     cn:on("receive", function(cn,pl) print(pl) end)
     cn:on("sent", function(cn) --[[print("Data sent")]] cn:close() end)
     --cn:on("disconnection", function(cn) print("DC: Disconnected") end)
     
     cn:connect(port,host)
     cn:on("connection", function(conn,pld)
          --print("Connected")
          conn:send("GET ".. path .. dataString .. " HTTP/1.1\r\n")
          conn:send("Host: "..host .."\r\n")
          conn:send("Accept: */*\r\n")
          conn:send("\r\n")
          end)
          print("Data sent")
          tmr.alarm(1,7000,0,goToSleep)
     wifi.sleeptype(wifi.MODEM_SLEEP)

     end
     
function buttonPress()

     sendData('{"buttonPress","id"="'..id..'","tag"="'..tag..'"}')
end

function goToSleep()
     print("Going to sleep")
     node.dsleep(0)
end

tmr.alarm(0,1000,0,buttonPress)
tmr.alarm(1,15000,1,goToSleep)

