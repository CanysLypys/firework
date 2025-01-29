local function GetTime()
    local timestamp = os.time()
    local d = os.date("*t", timestamp).wday
    local h = tonumber(os.date("%H", timestamp))
    local m = tonumber(os.date("%M", timestamp))

    return {d = d, h = h, m = m}
end

CreateThread(function()
    while true do
        Wait(60000)
        local time = GetTime()
        if time.h == 0 and time.m == 0 then
            FireworkShow()
        elseif time.h == 0 and time.m == 15 then
            print("^1Fireworkshow is over.^0")
            TriggerClientEvent("firework:stopFireworkShow", -1)
        end
    end
end)

local function FireworkShow()
    print("It's new year! Time to shine. Starting Fireworkshow....")
    TriggerClientEvent("firework:startFireworkShow", -1)
end

RegisterCommand("fireworkshow", function(source)
    print("^2Fireworkshow started manually.^0")
    TriggerClientEvent("firework:startFireworkShow", -1)
end)

RegisterNetEvent("firework:launch")
AddEventHandler("firework:launch", function(fireworkPos, fireworkType)
    TriggerClientEvent("firework:launch", -1, fireworkPos, fireworkType)
end)
