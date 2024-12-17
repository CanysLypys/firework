local showStarted = false

function IsNewYear()
    local time = os.date("*t")
    return time.month == 1 and time.day == 1
end

CreateThread(function()
    while true do
        Wait(1000)
        local time = os.date("*t")

        if IsNewYear() then
            if time.hour == 0 and time.min == 0 then
                FireworkShow()
            elseif time.hour == 0 and time.min == 15 then
                StopFireworkShow()
                break
            end
        end
    end
end)

function FireworkShow()
    if not showStarted then
        TriggerClientEvent("firework:startFireworkShow", -1)

        showStarted = true

        print("^2Fireworkshow started manually.^0")
    else
        print("^1Fireworkshow is already running.^0")
    end
end

function StopFireworkShow()
    if showStarted then
        TriggerClientEvent("firework:stopFireworkShow", -1)

        showStarted = false

        print("^1Fireworkshow stopped manually.^0")
    else
        print("^1Fireworkshow is not running.^0")
    end
end

RegisterCommand("firework", function(source, args, rawCommand)
    local type = tostring(args[1])

    if type == "start" then
        FireworkShow()
    elseif type == "stop" then
        StopFireworkShow()
    elseif type == "status" then
        print("Fireworkshow is running: " .. tostring(showStarted))
    else
        print("----------")
        print("firework start - Start the firework show")
        print("firework stop - Stop the firework show")
        print("firework status - Check if the firework show is running")
        print("----------")
    end
end, true)

AddEventHandler("playerJoining", function()
    local playerId = source

    if showStarted then
        TriggerClientEvent("firework:startFireworkShow", playerId)
    end
end)
