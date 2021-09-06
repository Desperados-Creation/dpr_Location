ESX = nil

TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)

RegisterNetEvent('dpr_Location:AchatVehicule')
AddEventHandler('dpr_Location:AchatVehicule', function(Nom, Vehicule, Price)
    local xPlayer = ESX.GetPlayerFromId(source)
    local car = Vehicule
    if xPlayer.getMoney() >= Price then 
        xPlayer.removeMoney(Price)
        local xPlayers = ESX.GetPlayers()
        TriggerClientEvent('dpr_Location:spawnCar',source,car)
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            Citizen.Wait(500)
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Location', 'Véhicule', 'Votre véhicule arrive d\'ici peu !', 'CHAR_CASTRO', 1)
            Citizen.Wait(10000)
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', "Un prélèvement de ~r~"..Price.." ~s~a été effectué sur votre compte pour ~r~une location ~s~!", 'CHAR_BANK_MAZE', 1)
        end
    else 
        local xPlayers	= ESX.GetPlayers()
        for i=1, #xPlayers, 1 do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            Citizen.Wait(500) 
            TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'Banque', 'Conseiller', "Vous n'avez pas suffisament d'argent sur votre compte bancaire ~s~!", 'CHAR_BANK_MAZE', 1)
        end
    end
end)