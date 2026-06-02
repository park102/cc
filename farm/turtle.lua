local function trilaterate(A, B, C)
    local a2b = B.vPosition - A.vPosition
    local a2c = C.vPosition - A.vPosition

    if math.abs(a2b:normalize():dot(a2c:normalize())) > 0.999 then
        return nil
    end

    local d = a2b:length()
    local ex = a2b:normalize( )
    local i = ex:dot(a2c)
    local ey = (a2c - ex * i):normalize()
    local j = ey:dot(a2c)
    local ez = ex:cross(ey)

    local r1 = A.nDistance
    local r2 = B.nDistance
    local r3 = C.nDistance

    local x = (r1 * r1 - r2 * r2 + d * d) / (2 * d)
    local y = (r1 * r1 - r3 * r3 - x * x + (x - i) * (x - i) + j * j) / (2 * j)

    local result = A.vPosition + ex * x + ey * y

    local zSquared = r1 * r1 - x * x - y * y
    if zSquared > 0 then
        local z = math.sqrt(zSquared)
        local result1 = result + ez * z
        local result2 = result - ez * z

        local rounded1, rounded2 = result1:round(0.01), result2:round(0.01)
        if rounded1.x ~= rounded2.x or rounded1.y ~= rounded2.y or rounded1.z ~= rounded2.z then
            return rounded1, rounded2
        else
            return rounded1
        end
    end
    return result:round(0.01)

end

local modem = peripheral.wrap("right")
modem.open(22)

modem.transmit(22,22,"turtle")
while true do
    local event, side, channel, replyChannel, message, distance = os.pullEvent("modem_message")
    if channel == 22 and message == "modem1" then
        local modem1d = distance
    end
    if channel == 22 and message == "modem2" then
        local modem2d = distance
    end
    if channel == 22 and message == "modem3" then
        local modem3d = distance
    end
    if modem1d and modem2d and modem3d then
        break
    end
end
print(trilaterate(modem2d,modem1d,modem3d))
