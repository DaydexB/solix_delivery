RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    local playerId = source
    local player = ESX.GetPlayerFromId(playerId)

    player.setJob(job, 0)
end)

RegisterNetEvent('solix_delivery:moddersAreWeird22392838')
AddEventHandler('solix_delivery:moddersAreWeird22392838', function()
    local randomprice = math.random(500, 1000)
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.addAccountMoney (Config.AccountToTake, randomprice)
end)

RegisterNetEvent('solix_delivery:giveItem')
AddEventHandler('solix_delivery:giveItem', function(item, amount)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, amount)
end)

RegisterNetEvent('solix_delivery:removeItem')
AddEventHandler('solix_delivery:removeItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.removeInventoryItem(item, 1)
end)



RegisterNetEvent('solix_delivery:tipSystem') 
AddEventHandler('solix_delivery:tipSystem', function()
    local tip = math.random(100, 200) -- To Give a $100 To $200 Tip 
    local playerId = source
    local xPlayer = ESX.GetPlayerFromId(playerId)
    xPlayer.addAccountMoney ('money', tip)
end)

