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
    xPlayer.addAccountMoney ('money', randomprice)
end)

RegisterNetEvent('solix_delivery:giveItem')
AddEventHandler('solix_delivery:giveItem', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 3)
end)

RegisterNetEvent('solix_delivery:giveItem1')
AddEventHandler('solix_delivery:giveItem1', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 1)
end)


RegisterNetEvent('solix_delivery:giveItem2')
AddEventHandler('solix_delivery:giveItem2', function(item)
    local xPlayer = ESX.GetPlayerFromId(source)

    xPlayer.addInventoryItem(item, 2)
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

