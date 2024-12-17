local showStarted = false

local function RequestPtfxAsset()
	if not HasNamedPtfxAssetLoaded(Config.ParticleDict) then
		RequestNamedPtfxAsset(Config.ParticleDict)

		while not HasNamedPtfxAssetLoaded(Config.ParticleDict) do
			Wait(1)
		end
	end
end

local function fireFirework(fireworkPos, effectType)
	if not Config.EffectName[effectType] then
		return error("Invalid firework type")
	end

	CreateThread(function()
		RequestPtfxAsset()

		while showStarted do
			for i = 1, 10, 1 do
				local wait = math.random(500, 1000)

				Wait(wait)

				UseParticleFxAssetNextCall(Config.ParticleDict)

				StartParticleFxNonLoopedAtCoord(Config.EffectName[effectType], fireworkPos.x, fireworkPos.y,
					fireworkPos.z, 0.0, 0.0, 0.0,
					2.5, false, false, false)
				Wait(1500)
			end
		end
	end)
end

local function startShow()
	if showStarted then
		return
	end

	showStarted = true

	for _, data in pairs(Config.FireworkLocations) do
		local position = data.position
		local effectName = data.effectName

		fireFirework(position, effectName)
	end
end

RegisterNetEvent("firework:startFireworkShow", function()
	startShow()
end)

RegisterNetEvent("firework:stopFireworkShow", function()
	showStarted = false
end)
