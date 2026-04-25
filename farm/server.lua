local modem1 = peripheral.wrap("modem_1") or error("modem1 not found attached", 0)
local modem2 = peripheral.wrap("modem_2") or error("modem2 not found attached", 0)
local modem3 = peripheral.wrap("modem_3") or error("modem3 not found attached", 0)
modem.open(22)

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if channel == 22 and message == "turtle" then 
        modem1.transmit(22,22,"modem1")
        modem2.transmit(22,22,"modem2")
        modem3.transmit(22,22,"modem3")
    end
end
