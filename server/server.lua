ESX = nil

TriggerEvent("esx:getSharedObject", function(obj) ESX = obj end)


GetTime = function()
	local timestamp = os.time()
	local d = os.date("*t", timestamp).wday
	local h = tonumber(os.date("%H", timestamp))
	local m = tonumber(os.date("%M", timestamp))

	return {d = d, h = h, m = m}
end

local fireworkOver = false


CreateThread(function()
    while true do
        Wait(0)
        time = GetTime()
        if time.h == 0 and time.m == 0 then
            FireworkShow()
            break
        end
    end
end)

CreateThread(function()
    while true do
        Wait(0)
        time = GetTime()
        if time.h == 0 and time.m == 15 then
            fireworkOver = true
            print("^1Fireworkshow is over.^0")
            break
        end
    end
end)

FireworkShow = function()
    print("It's new year! Time to shine. Starting Fireworkshow....")
    TriggerClientEvent("firework:startFireworkShow", -1)
end

RegisterCommand("fireworkshow", function(source)
    local xPlayer = ESX.GetPlayerFromId(source)

    print("^Fireworkshow started manually.^0")
    TriggerClientEvent("firework:startFireworkShow", xPlayer.source)
end)

RegisterNetEvent("firework:battery")
AddEventHandler("firework:battery", function(fireworkPos)
   if fireworkOver then
        return
    else
        TriggerClientEvent("firework:battery", -1, fireworkPos)
    end
end)

RegisterNetEvent("firework:rocket")
AddEventHandler("firework:rocket", function(fireworkPos)
   if fireworkOver then
        return
    else
        TriggerClientEvent("firework:rocket", -1, fireworkPos)
    end
end)

RegisterNetEvent("firework:fountain")
AddEventHandler("firework:fountain", function(fireworkPos)
    if fireworkOver then
        return
    else
        TriggerClientEvent("firework:fountain", -1, fireworkPos)
    end
end)