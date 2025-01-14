function KeyboardInput(TextEntry, ExampleText, MaxStringLenght)

	AddTextEntry('FMMC_KEY_TIP1', TextEntry)
	DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end
		
	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false --This unblocks new Input when typing is done
		return result --Returns the result
	else
		Citizen.Wait(500) --Little Time Delay, so the Keyboard won't open again if you press enter to finish the typing
		blockinput = false --This unblocks new Input when typing is done
		return nil --Returns nil if the typing got aborted
	end
end

function PlayAnim(animDict, animName, duration)
    RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do Wait(0) end
    TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, duration, 1, 1, false, false, false)
    RemoveAnimDict(animDict)
end

Citizen.CreateThread(function()
    while true do
        interval = 750
        if CreatingPerso then
            interval = 1
            DisplayRadar(false)
            DisableControlAction(2, 30, true)
			DisableControlAction(2, 31, true)
			DisableControlAction(2, 32, true)
			DisableControlAction(2, 33, true)
			DisableControlAction(2, 34, true)
			DisableControlAction(2, 35, true)
			DisableControlAction(2, 322, true)
			DisableControlAction(0, 25, true) -- Input Aim
            DisableControlAction(0, 24, true) -- Input Attack

            DisableControlAction(0, 1, true) -- Disable pan
            DisableControlAction(0, 2, true) -- Disable tilt
            DisableControlAction(0, 257, true) -- Attack 2
            DisableControlAction(0, 263, true) -- Melee Attack 1

            DisableControlAction(0, 45, true) -- Reload
            DisableControlAction(0, 44, true) -- Cover
            DisableControlAction(0, 37, true) -- Select Weapon
            DisableControlAction(0, 23, true) -- Also 'enter'?

            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen

            DisableControlAction(0, 288,  true) -- Disable phone
            DisableControlAction(0, 289, true) -- Inventory
            DisableControlAction(0, 170, true) -- Animations
            DisableControlAction(0, 167, true) -- Job
            DisableControlAction(0, 327, true) -- F5
            DisableControlAction(0, 318, true)  -- F5

            DisableControlAction(0, 0, true) -- Disable changing view
            DisableControlAction(0, 26, true) -- Disable looking behind
            DisableControlAction(0, 73, true) -- Disable clearing animation
            DisableControlAction(2, 199, true) -- Disable pause screen

            DisableControlAction(0, 59, true) -- Disable steering in vehicle
            DisableControlAction(0, 71, true) -- Disable driving forward in vehicle
            DisableControlAction(0, 72, true) -- Disable reversing in vehicle

            DisableControlAction(2, 36, true) -- Disable going stealth

            DisableControlAction(0, 47, true)  -- Disable weapon
            DisableControlAction(0, 264, true) -- Disable melee
            DisableControlAction(0, 257, true) -- Disable melee
            DisableControlAction(0, 140, true) -- Disable melee
            DisableControlAction(0, 141, true) -- Disable melee
            DisableControlAction(0, 142, true) -- Disable melee
            DisableControlAction(0, 143, true) -- Disable melee
            DisableControlAction(0, 75, true)  -- Disable exit vehicle
            DisableControlAction(27, 75, true) -- Disable exit vehicle
        end
        Wait(interval)
    end
end)

function bateau(x, y, z, heading, x2, y2, z2, model)
    
    DisplayRadar(false)
    local cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
    local boatModel = GetHashKey(1448677353)
    modelHash = 1448677353

    pilotModel = GetHashKey("s_m_m_pilot_01")

    RequestModel(modelHash)
    while not HasModelLoaded(modelHash) do
        Citizen.Wait(0)
    end

    RequestModel(pilotModel)
    while not HasModelLoaded(pilotModel) do
        Citizen.Wait(0)
    end

    SetOverrideWeather("EXTRASUNNY")
	
    if HasModelLoaded(modelHash) and HasModelLoaded(pilotModel) then

        ClearAreaOfEverything( -1229.66, -1926.75, 0.13, 1500, false, false, false, false, false)

        Boat = CreateVehicle(modelHash, -1229.66, -1926.75, 0.13, 314.47, true, false)

        pilot = CreatePedInsideVehicle(Boat, 6, pilotModel, -1, true, false)

        SetBlockingOfNonTemporaryEvents(pilot, true)

         local netVehid = NetworkGetNetworkIdFromEntity(Boat)
         SetNetworkIdCanMigrate(netVehid, true)
         NetworkRegisterEntityAsNetworked(VehToNet(Boat))
         NetworkSetEntityInvisibleToNetwork(Boat, true)
         SetEntityCollision(Boat, true)


         local netPedid = NetworkGetNetworkIdFromEntity(pilot)
         SetNetworkIdCanMigrate(netPedid, true)
         NetworkRegisterEntityAsNetworked(pilot)
         NetworkSetEntityInvisibleToNetwork(pilot, true)

        totalSeats = GetVehicleModelNumberOfSeats(modelHash)

        SetPedIntoVehicle(GetPlayerPed(-1), Boat, 0)
      
        SetModelAsNoLongerNeeded(modelHash)
        SetModelAsNoLongerNeeded(pilotModel)
    end
    TaskVehicleDriveToCoordLongrange(pilot, Boat, -814.84, -1504.05, 0.30, 20.0, 524863, 0)
    local ped = PlayerPedId()
	PointCamAtEntity(cam, ped, 0, 0, 0, 1)
	RenderScriptCams(1, 1, 1000, 1, 1)
    SetCamShakeAmplitude(cam, 3.0)
    SetCamActive(cam, 1)
    SetCamParams(cam, -1168.70, -1905.117, 20.25, -1.6106, -0.5186, -80.0, 44.9959, 0, 1, 1, 2)
	SetCamParams(cam, -1158.70, -1975.117, 16.25, -2.8529, -0.5186, -90.0, 44.9959, 6000, 0, 0, 2)
    RenderScriptCams(true, false, 3000, 1, 1, 0)
    Wait(10000)
	SetCamParams(cam, -923.62, -1714.51, 33.55, -14.367, 0.0, 350.00, 42.2442, 0, 1, 1, 2)
	SetCamParams(cam, -913.62, -1685.51, 29.55, -9.6114, 0.0, 350.00, 44.8314, 6500, 0, 0, 2)
	ShakeCam(cam, "HAND_SHAKE", 0.15)
    RenderScriptCams(true, false, 3000, 1, 1, 0)
    Wait(10000)
    SetCamParams(cam, -849.93, -1519.35, 10.26, -1.6106, -0.5186, -80.0, 44.9959, 0, 1, 1, 2)
	SetCamParams(cam, -839.93, -1490.35, 6.26, -2.8529, -0.5186, -90.0, 44.9959, 6000, 0, 0, 2)
	RenderScriptCams(true, false, 3000, 1, 1, 0)
    SetVehicleDoorsLocked(Boat, 4)
    Wait(15000)
    TaskVehiclePark(pilot, Boat, -784.50, -1494.42, 0.30, 290.43, 0, 20.0, false)
    Wait(6500)
    SetVehicleEngineOn(Boat, 0, 0, 0)
    FreezeEntityPosition(Boat, true)
    Wait(250)
    RenderScriptCams(0, 1, 1000, 1, 1)
    DestroyCam(cam, true)
    TaskLeaveVehicle(GetPlayerPed(-1), Boat, 0)
    TaskLeaveVehicle(pilot, Boat, 0)
    while not HasAnimDictLoaded("mp_common") do
        RequestAnimDict("mp_common")
        Citizen.Wait(1)
    end
    Wait(1000)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    Wait(500)
    SetEntityHeading(GetPlayerPed(-1), 287.53)
    TaskPlayAnim(GetPlayerPed(-1), "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)
    TaskPlayAnim(pilot, "mp_common", "givetake1_a", 2.0, 2.0, -1, 0, 0, false, false, false)    
    FreezeEntityPosition(GetPlayerPed(-1), false)
    Wait(10000)
    DeleteEntity(Boat)
    DeleteEntity(pilot)
    DisplayRadar(true)
    TriggerEvent('instance:close')
    TriggerServerEvent('instance:leave')
end


FinishIdentity = function()
    RageUI.CloseAll()
    ClearPedTasks(PlayerPedId())
    SetEntityInvincible(PlayerPedId(), true)
    FreezeEntityPosition(GetPlayerPed(-1), true)
    DoScreenFadeOut(3000)
    while not IsScreenFadedOut() do Wait(1) end
    Wait(1200)
    SetEntityInvincible(PlayerPedId(), false) 
    FreezeEntityPosition(GetPlayerPed(-1), false)
    DoScreenFadeIn(1000)
end