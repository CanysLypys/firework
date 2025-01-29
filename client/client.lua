local particleDict = "scr_indep_fireworks"
local fireworkOver = false

RegisterNetEvent("firework:startFireworkShow")
AddEventHandler("firework:startFireworkShow", function()
    for i = 1, #Config.FireworkLocations, 1 do
        local fireworkPos = vector3(Config.FireworkLocations[i]["x"], Config.FireworkLocations[i]["y"], Config.FireworkLocations[i]["z"])
        local fireworkType = Config.FireworkLocations[i]["Fireworktype"]

        TriggerServerEvent("firework:launch", fireworkPos, fireworkType)
    end
end)

RegisterNetEvent("firework:stopFireworkShow")
AddEventHandler("firework:stopFireworkShow", function()
    fireworkOver = true
end)

RegisterNetEvent("firework:launch")
AddEventHandler("firework:launch", function(fireworkPos, fireworkType)
    RequestNamedPtfxAsset(particleDict)
    while not HasNamedPtfxAssetLoaded(particleDict) do
        Wait(1)
    end

    local particleEffect = ""
    local delay = 1500
    local iterations = 10

    if fireworkType == "Battery" then
        particleEffect = "scr_indep_firework_trailburst"
    elseif fireworkType == "Rocket" then
        particleEffect = "scr_indep_firework_starburst"
    elseif fireworkType == "Fountain" then
        particleEffect = "scr_indep_firework_fountain"
        delay = 2500
        iterations = 8
    end

    for i = 1, iterations do
        if fireworkOver then
            return
        end

        UseParticleFxAssetNextCall(particleDict)
        StartNetworkedParticleFxNonLoopedAtCoord(particleEffect, fireworkPos, 0.0, 0.0, 0.0, math.random() * 0.5 + 0.8, false, false, false, false)
        Wait(delay)
    end

    if not fireworkOver then
        TriggerEvent("firework:launch", fireworkPos, fireworkType)
    end
end)
