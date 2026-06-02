local modem1 = peripheral.wrap("modem_1") or error("modem1 not found attached", 0)
modem.open(0)

while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    print(("Message received on side %s on channel %d (reply to %d) from %f blocks away with message %s"):format(
        side, channel, replyChannel, distance, tostring(message)
    ))
end
