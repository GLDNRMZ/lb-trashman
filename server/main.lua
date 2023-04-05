local QBCore = exports['qb-core']:GetCoreObject()

RegisterNetEvent('lb-trashman:server:sellItems', function()
    local src = source
    local price = 0
    local Player = QBCore.Functions.GetPlayer(src)

    if Player.PlayerData.items ~= nil and next(Player.PlayerData.items) ~= nil then
        for k, v in pairs(Player.PlayerData.items) do
            if Player.PlayerData.items[k] ~= nil then
                if Config.Items[Player.PlayerData.items[k].name] ~= nil then
                    price = price + (Config.Items[Player.PlayerData.items[k].name].price * Player.PlayerData.items[k].amount)
                    Player.Functions.RemoveItem(Player.PlayerData.items[k].name, Player.PlayerData.items[k].amount, k)
                    TriggerClientEvent('inventory:client:ItemBox', source, QBCore.Shared.Items[Player.PlayerData.items[k].name], "remove")
                end
            end
        end

        if price > 0 then
            Player.Functions.AddMoney("cash", price)
            TriggerClientEvent('QBCore:Notify', src, "Here's $"..price..", piss off.")
        else
            TriggerClientEvent('QBCore:Notify', src, "You ain't got shit I want")
        end
    
    end
end)