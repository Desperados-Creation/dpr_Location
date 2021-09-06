ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

-- Menu --
local open = false
local MenuLocation = RageUI.CreateMenu("Location", "INTERACTION")
MenuLocation.Display.Header = true
MenuLocation.Close = function() 
    open = false
end

function OpenMenuLocation() 
    if open then 
        open = false
        RageUI.Visible(MenuLocation, false)
        return
    else
        open = true
        RageUI.Visible(MenuLocation, true)
        CreateThread(function()
            local cooldown = false
            while open do 
                RageUI.IsVisible(MenuLocation, function()
                    RageUI.Separator("↓     ~b~Véhicule     ~s~↓")
                    for k, v in pairs(Config.LocationVehicule.vehicule) do 
                        RageUI.Button(v.Nom, nil, {RightLabel = "~r~"..v.Price.."$"}, not cooldown, {
                            onSelected = function()
                                TriggerServerEvent('dpr_Location:AchatVehicule', v.Nom, v.Vehicule, v.Price)

                                Citizen.Wait(1000)
                                FreezeEntityPosition(PlayerPedId(), false)
                                RenderScriptCams(0, true, 2000)
                                cooldown = true
                                Citizen.Wait(5000)
                                cooldown = false
                            end
                        })
                    end

                    RageUI.Separator("↓     ~b~Retour     ~s~↓")
                    RageUI.Button("Rendre la location", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            RenderScriptCams(0, true, 2000)
                            FreezeEntityPosition(PlayerPedId(), false)
                            local veh,dist = ESX.Game.GetClosestVehicle(playerCoords)
                            if dist < 4 then
                                DeleteEntity(veh)
                                ESX.ShowAdvancedNotification("Location", "~b~Retour", "Le véhicule à bien été récupéré !", "CHAR_CASINO_MANAGER", 1)
                                RageUI.CloseAll()
                            end
                        end
                    })

                    RageUI.Separator("↓     ~r~Fermeture     ~s~↓")
                    RageUI.Button("~r~Fermer", nil, {RightLabel = "~y~→→"}, true, {
                        onSelected = function()
                            FreezeEntityPosition(PlayerPedId(), false)
                            RenderScriptCams(0, true, 2000)
                            RageUI.CloseAll()
                        end
                    })
                end)
            Wait(0)
            end
        end)
    end
end

local camCoords = vector3(-503.66, -661.51, 33.11)
local cam

Citizen.CreateThread(function()
    cam = CreateCam("DEFAULT_SCRIPTED_CAMERA")
    SetCamCoord(cam, camCoords)
    PointCamAtCoord(cam, -499.76, -672.79, 32.8)
    SetCamActive(cam, true)
end)

Citizen.CreateThread(function()
    while true do
		local wait = 750

			for k in pairs(Config.LocationVehicule.position) do
			local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
            local pos = Config.LocationVehicule.position
			local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

            if dist <= Config.MarkerDistance then
                wait = 0
                DrawMarker(Config.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, Config.MarkerSizeLargeur, Config.MarkerSizeEpaisseur, Config.MarkerSizeHauteur, Config.MarkerColorR, Config.MarkerColorG, Config.MarkerColorB, Config.MarkerOpacite, Config.MarkerSaute, true, p19, Config.MarkerTourne)  
            end

			if dist <= 2.0 then
                wait = 0
                Visual.Subtitle(Config.Text, 1)
                if IsControlJustPressed(1,51) then
                    FreezeEntityPosition(PlayerPedId(), true)
                    OpenMenuLocation()
                    RenderScriptCams(1, true, 2000)
                end
		    end
            if IsControlJustPressed(1, 177) then
                FreezeEntityPosition(PlayerPedId(), false)
                RenderScriptCams(0, true, 2000)
            end
		end
    Wait(wait)
    end
end)

-- Faire spawn le véhicule
RegisterNetEvent('dpr_Location:spawnCar')
AddEventHandler('dpr_Location:spawnCar', function(car)
    local car = GetHashKey(car)
    local retval = PlayerPedId()

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    Citizen.Wait(500)
    local vehicle = CreateVehicle(car, -504.67, -668.48, 32.79, 268.39, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local plaque = "Location"
    SetVehicleNumberPlateText(vehicle, plaque) 
    TriggerServerEvent('ddx_vehiclelock:givekey', 'no', GetVehicleNumberPlateText(vehicle))
end)

-- Ped --
Citizen.CreateThread(function()
	if Config.Ped then
		function LoadModel(model)
			while not HasModelLoaded(model) do
				RequestModel(model)
				Wait(1)
			end
		end
		LoadModel(Config.PedType)
		Ped = CreatePed(2, GetHashKey(Config.PedType), Config.PedPosition, Config.PedRotation, 0, 0)
		DecorSetInt(Ped, "Desperados", 5431)
		FreezeEntityPosition(Ped, 1)
		SetEntityInvincible(Ped, true)
		SetBlockingOfNonTemporaryEvents(Ped, 1)
	end
end)

-- Blips --
Citizen.CreateThread(function()
    if Config.blip then
        for k, v in pairs(Config.LocationVehicule.position) do
            local blip = AddBlipForCoord(v.x, v.y, v.z)

            SetBlipSprite(blip, Config.BlipId)
            SetBlipScale (blip, Config.BlipTaille)
            SetBlipColour(blip, Config.BlipCouleur)
            SetBlipAsShortRange(blip, Config.BlipRange)

            BeginTextCommandSetBlipName('STRING')
            AddTextComponentSubstringPlayerName(Config.BlipName)
            EndTextCommandSetBlipName(blip)
        end
    end
end)