local QBCore = exports['qb-core']:GetCoreObject()

PlayerJob = {}

AddEventHandler('onResourceStart', function(resource)
    if resource == GetCurrentResourceName() then
        Wait(200)
        PlayerJob = QBCore.Functions.GetPlayerData().job
        isLoggedIn = true
    end
end)

AddEventHandler('onResourceStart', function(resourceName)
    if GetCurrentResourceName() == resourceName then
        PlayerJob = QBCore.Functions.GetPlayerData().job
        TrashGuy()
    end
end)

AddEventHandler('QBCore:Client:OnPlayerLoaded', function()
    PlayerJob = QBCore.Functions.GetPlayerData().job
    TrashGuy()
end)

RegisterNetEvent('QBCore:Client:OnJobUpdate')
AddEventHandler('QBCore:Client:OnJobUpdate', function(JobInfo)
    PlayerJob = JobInfo
end)

function loadAnimDict(dict) while (not HasAnimDictLoaded(dict)) do RequestAnimDict(dict) Wait(0) end end

function TrashGuy()

    if not DoesEntityExist(trashguy) then

        RequestModel(Config.TrashModel) while not HasModelLoaded(Config.TrashModel) do Wait(0) end

        trashguy = CreatePed(0, Config.TrashModel, Config.TrashCoords, false, false)
        
        SetEntityAsMissionEntity(trashguy)
        SetPedFleeAttributes(trashguy, 0, 0)
        SetBlockingOfNonTemporaryEvents(trashguy, true)
        SetEntityInvincible(trashguy, true)
        FreezeEntityPosition(trashguy, true)
        loadAnimDict("amb@world_human_bum_slumped@male@laying_on_left_side@idle_a")        
        TaskPlayAnim(trashguy, "amb@world_human_bum_slumped@male@laying_on_left_side@idle_a", "idle_b", 8.0, 1.0, -1, 01, 0, 0, 0, 0)

        exports['qb-target']:AddTargetEntity(trashguy, { 
            options = {
                { 
                    type = "client",
                    event = "lb-trashman:client:MainMenu",
                	icon = "fa-solid fa-location-dot",
                	label = "Sell Trash",
                },
                
            }, 
            distance = 1.5, 
        })
    end
end

RegisterNetEvent('lb-trashman:client:MainMenu', function()
    local MainMenu = {
        {
            isMenuHeader = true,
            header = "Sell Trash"
        },
        {
            header = "Sell me all your shit",
            txt = "",
            icon = "fa-solid fa-bars",
            params = {
                isServer = true,
                event = "lb-trashman:server:sellItems",
            }
        },
       
    }

    exports['qb-menu']:openMenu(MainMenu)
end)


