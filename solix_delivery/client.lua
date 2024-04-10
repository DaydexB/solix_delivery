local model = Config.StartJobPedModel
local coords = Config.StartJobPedLocation
local heading = Config.StartJobPedHeading

local coords2 = Config.Delivery1
local model2 = Config.Delivery1PedModel
local heading2 = Config.Delivery1PedHeading
local message1 = Config.Delivery1Message

local coords3 = Config.Delivery2
local message2 = Config.Delivery2Message
local heading3 = Config.Delivery2PedHeading
local model3 = Config.Delivery2PedModel
local model4 = Config.Delivery3PedModel
local message3 = Config.Delivery3Message
local coords4 = Config.Delivery3
local heading4 = Config.Delivery3PedHeading

local message4 = Config.ClockOutMessage



local ped2 = nil
local ped3 = nil
local ped4 = nil

RequestModel(GetHashKey(model))
while not HasModelLoaded(GetHashKey(model)) do
    Wait(100)
end

local ped = CreatePed(CIVMALE, GetHashKey(model), coords, heading, true, false)


SetEntityInvincible(ped, true)
SetBlockingOfNonTemporaryEvents(ped, true)
FreezeEntityPosition(ped, true)

function SpawnEntity2(model2, coords2, heading2)
    RequestModel(GetHashKey(model2))
    while not HasModelLoaded(GetHashKey(model2)) do
        Wait(30000)
    end
	if not DoesEntityExist(ped2) then
     ped2 = CreatePed(CIVMALE, GetHashKey(model2), coords2, heading2, true, false)
    Wait(250)
    SetEntityInvincible(ped2, true)
    SetBlockingOfNonTemporaryEvents(ped2, true)
    FreezeEntityPosition(ped2, true)
    SetModelAsNoLongerNeeded(GetHashKey(model2))
    return ped2
    end
end

function SpawnEntity3(model3, coords3, heading3)
    RequestModel(GetHashKey(model3))
    while not HasModelLoaded(GetHashKey(model3)) do
        Wait(100)
    end
    if not DoesEntityExist(ped3) then
     ped3 = CreatePed(CIVMALE, GetHashKey(model3), coords3, heading3, true, false)
    Wait(250)
    SetEntityInvincible(ped3, true)
    SetBlockingOfNonTemporaryEvents(ped3, true)
    FreezeEntityPosition(ped3, true)
    SetModelAsNoLongerNeeded(GetHashKey(model3))
    return ped3
    end
end

function SpawnEntity4(model4, coords4, heading4)
    RequestModel(GetHashKey(model4))
    while not HasModelLoaded(GetHashKey(model4)) do
        Wait(100)
    end
    if not DoesEntityExist(ped4) then
    ped4 = CreatePed(CIVMALE, GetHashKey(model4), coords4, heading4, true, false)
    Wait(250)
    SetEntityInvincible(ped4, true)
    SetBlockingOfNonTemporaryEvents(ped4, true)
    FreezeEntityPosition(ped4, true)
    SetModelAsNoLongerNeeded(GetHashKey(model4))
    return ped4
    end
end

function showSubtitle(message1, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message1)
    EndTextCommandPrint(duration, true)
end

function hideSubtitle()
    ClearPrints()
end

function showSubtitle(message, duration)
    BeginTextCommandPrint('STRING')
    AddTextComponentString(message2)
    EndTextCommandPrint(duration, true)
end

function tipSystem()
    local notifications = {
        'The Person Was Satisfied With Their Food',
        'The Person Was Satisfied With Their Food',
        'The Person Was Satisfied With Their Food',
        'The Food Was Cold They Did Not Tip You!'
    }

    local randomIndex = math.random(1, #notifications) 
    local randomNotification = notifications[randomIndex] 

    ESX.ShowNotification(randomNotification)

    if randomNotification == 'The Food Was Cold They Did Not Tip You!' then
        return
    else
        if Config.TipSystem == false then
            randomNotification = 'The Person Was Satisfied With Their Food'
            return
        else
            TriggerServerEvent('solix_delivery:tipSystem')
        end
    end
end



RegisterNetEvent('solix_delivery:startJob')
AddEventHandler('solix_delivery:startJob', function()
    local count = exports.ox_inventory:Search('count', 'burger')
    if count >= 3 then
    else
        if count == 1 then
            TriggerServerEvent('solix_delivery:giveItem2', 'burger')
        else
            if count == 2 then
                TriggerServerEvent('solix_delivery:giveItem1', 'burger')
            else
    TriggerServerEvent('solix_delivery:giveItem', 'burger')
            end
        end
    end
end)

   
   RegisterNetEvent('solix_delivery:delivery1InProgress')
    AddEventHandler('solix_delivery:delivery1InProgress', function()
        TriggerServerEvent('esx:addInventoryItem', 'burger', 3)
        showSubtitle(Config.Subtitle1, 600000)
        SpawnEntity2(model2, coords2, heading2)
        Wait(250)
    end)

    RegisterNetEvent('solix_delivery:delivery2InProgress')
    AddEventHandler('solix_delivery:delivery2InProgress', function()
        RequestModel(Config.Delivery2PedModel)
        deliveryOption = true
        Wait(15000)       
        showSubtitle2(Config.Subtitle2, 600000)
        SetNewWaypoint(Config.Delivery2)
        Wait(1000) 
        SpawnEntity3(model3, coords3, heading3)
        DeleteEntity(ped2)
    end)
    
    RegisterNetEvent('solix_delivery:delivery3InProgress')
    AddEventHandler('solix_delivery:delivery3InProgress', function()
        delivery2Option = true
        Wait(10000)
        DeleteEntity(ped3)
        showSubtitle3(Config.Subtitle3, 600000)
        SetNewWaypoint(Config.Delivery3)
        SpawnEntity4(model4, coords4, heading4)
    end)
    
    RegisterNetEvent('solix_delivery:finishedDelivery')
    AddEventHandler('solix_delivery:finishedDelivery', function()
        delivery3Option = true
        Wait(10000)
        DeleteEntity(ped4)
        SetNewWaypoint(Config.StartJobPedLocation)
        showSubtitle4(message4, 600000)
    end)

    RegisterNetEvent('solix_delivery:handOverAnimation')
    AddEventHandler('solix_delivery:handOverAnimation', function()
        hideSubtitle() 
        local playerPed = PlayerPedId()
        local playerDict = "mp_common" 
        local playerAnim = "givetake1_a"
        local count = exports.ox_inventory:Search('count', 'burger')

        if count <= 0 then
            ESX.ShowNotification('You Dont Have Enough Items To Deliver!')
        else
    
        RequestAnimDict(playerDict)
    
        while not HasAnimDictLoaded(playerDict) do
            Wait(100)
        end
    
        TaskPlayAnim(playerPed, playerDict, playerAnim, 8.0, 8.0, -1, 0, 0, false, false, false)
        Wait(2000)
        TriggerServerEvent('solix_delivery:removeItem', 'burger')
        Wait(2000)
        tipSystem()
        TriggerServerEvent('solix_delivery:moddersAreWeird22392838')
        Wait(10000)
        TriggerEvent('solix_delivery:delivery2InProgress')
    end
    end)

    RegisterNetEvent('solix_delivery:handOverAnimation2')
    AddEventHandler('solix_delivery:handOverAnimation2', function()
        hideSubtitle() 
        local playerPed = PlayerPedId()
        local playerDict = "mp_common" 
        local playerAnim = "givetake1_a"
        local count = exports.ox_inventory:Search('count', 'burger')

        if count <= 0 then
            
        else
    
        RequestAnimDict(playerDict)
    
        while not HasAnimDictLoaded(playerDict) do
            Wait(100)
        end
    
        TaskPlayAnim(playerPed, playerDict, playerAnim, 8.0, 8.0, -1, 0, 0, false, false, false)
        Wait(2000)
        TriggerServerEvent('solix_delivery:removeItem', 'burger')
        Wait(2000)
        tipSystem()
        TriggerServerEvent('solix_delivery:moddersAreWeird22392838')
        Wait(10000)
        TriggerEvent('solix_delivery:delivery3InProgress')
    end
    end)


    RegisterNetEvent('solix_delivery:handOverAnimation3')
    AddEventHandler('solix_delivery:handOverAnimation3', function()
        hideSubtitle() 
        local playerPed = PlayerPedId()
        local playerDict = "mp_common" 
        local playerAnim = "givetake1_a"
        local count = exports.ox_inventory:Search('count', 'burger')

        if count <= 0 then
            ESX.ShowNotification('You Dont Have Enough Items To Deliver!')
        else
    
        RequestAnimDict(playerDict)
    
        while not HasAnimDictLoaded(playerDict) do
            Wait(100)
        end
    
        TaskPlayAnim(playerPed, playerDict, playerAnim, 8.0, 8.0, -1, 0, 0, false, false, false)
        Wait(2000)
        TriggerServerEvent('solix_delivery:removeItem', 'burger')
        Wait(2000)
        tipSystem()
        TriggerServerEvent('solix_delivery:moddersAreWeird22392838')
        Wait(5000)
        TriggerEvent('solix_delivery:finishedDelivery')
    end
    end)
    

    --------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- EVENTS
    
function StartJobOption(model, startJobOption)
    exports.ox_target:addModel(model, startJobOption)
end

function SpawnVehicleOption(model, spawnVehicleOption)
    exports.ox_target:addModel(model, spawnVehicleOption)
end

function EndJobOption(model, endJobOption)
    exports.ox_target:addModel(model, endJobOption)
end

function Delivery1(model2, deliverFoodOption)
    exports.ox_target:addModel(model2, deliverFoodOption)
end

function Delivery2(model3, deliverFoodOption)
    exports.ox_target:addModel(model3, deliverFoodOption)
end

function Delivery3(model4, deliverFoodOption)
    exports.ox_target:addModel(model4, deliverFoodOption)
end
----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- Functions

local startJobOption = {
    label = 'Start Job',
    groups = {'unemployed', 0},
    icon = 'fa-solid fa-briefcase',
    onSelect = function()
    TriggerServerEvent('esx:setJob', 'delivery')
    TriggerEvent('solix_delivery:startJob')
    TriggerEvent('solix_delivery:delivery1InProgress')
    SetNewWaypoint(Config.Delivery1)
end,
}

local spawnVehicleOption = {
    label = 'Get Company Vehicle',
    groups = {'delivery', 0},
    icon = 'fa-solid fa-car',
    onSelect = function()
        ESX.ShowNotification('Please Wait A Minute Your Vehicle Is On The Way')
        Wait(10000)
        ESX.Game.SpawnVehicle(Config.JobVehicle, Config.JobVehicleLocation, Config.JobVehicleHeading, function(vehicle)
            ESX.ShowNotification('Your Vehicle Is Now Ready')
        end)
    end,
}

local endJobOption = {
    label = 'Clock Out',
    groups = {'delivery', 0},
    icon = 'fa-solid fa-clock',
    onSelect = function()  
        TriggerServerEvent('esx:setJob', 'unemployed')
        hideSubtitle()
        DeleteWaypoint()
    end,
}
StartJobOption(model, startJobOption)
SpawnVehicleOption(model, spawnVehicleOption)
EndJobOption(model, endJobOption)

local deliverFoodOption = {
    label = 'Deliver Food',
    icon = 'fa-solid fa-burger',
    groups = {'delivery', 0},
    onSelect = function()
        if not deliveryOption then
        TriggerEvent('solix_delivery:handOverAnimation')
        else
            ESX.ShowNotification('You Have Already Delivered This Order!')
        end
    end,
}
Delivery1(model2, deliverFoodOption)

local deliverFoodOption2 = {
    label = 'Deliver Food',
    icon = 'fa-solid fa-burger',
    groups = {'delivery', 0},
    onSelect = function()
        if not delivery2Option then
            TriggerEvent('solix_delivery:handOverAnimation2')
            TriggerEvent('solix_delivery:delivery3InProgress')
        else
            ESX.ShowNotification('You Already Delivered This Order!')
            end
        end,
}
Delivery2(model3, deliverFoodOption2)

local deliverFoodOption3 = {
    label = 'Deliver Food',
    icon = 'fa-solid fa-burger',
    groups = {'delivery', 0},
    onSelect = function()
        if not delivery3Option then
            TriggerEvent('solix_delivery:handOverAnimation3')
        else
            ESX.ShowNotification('You Already Delivered This Order!')
        end
        end,
}
Delivery3(model4, deliverFoodOption3)
---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- Ox Target

local blips = {
    {
        title = Config.BlipName,
        colour = Config.BlipColour,
        id = Config.BlipId,
        x = Config.BlipLocation.x,
        y = Config.BlipLocation.y,
        z = Config.BlipLocation.z
    }
}
Citizen.CreateThread(function()

    for _, info in pairs(blips) do
      info.blip = AddBlipForCoord(info.x, info.y, info.z)
      SetBlipSprite(info.blip, info.id)
      SetBlipDisplay(info.blip, 2)
      SetBlipScale(info.blip, 0.8)
      SetBlipColour(info.blip, info.colour)
      SetBlipAsShortRange(info.blip, true)
	  BeginTextCommandSetBlipName("STRING")
      AddTextComponentString(info.title)
      EndTextCommandSetBlipName(info.blip)
    end
end)
