local QBCore = exports['qb-core']:GetCoreObject()

TriggerEvent('QBCore:GetObject', function(obj) QBCore = obj end)

RegisterServerEvent('boss:recievePackage')
AddEventHandler('boss:recievePackage', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	Player.Functions.AddItem("printerdocument", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["printerdocument"], 'add')

    TriggerClientEvent('QBCore:Notify', src, "Du tok imot pakken.")
	---TriggerClientEvent('mythic_notify:client:DoHudText', source, { type = 'success', text = 'You were handed $'..Config.Payment.. 'and some oxy!', length = 10000})
end)

RegisterServerEvent('boss:deliverPackage')
AddEventHandler('boss:deliverPackage', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
    pay = 1000
    erfaring = 5
	Player.Functions.RemoveItem("printerdocument", 1)
	TriggerClientEvent('inventory:client:ItemBox', src, QBCore.Shared.Items["printerdocument"], 'remove')
    Player.Functions.AddMoney('cash',pay)

    TriggerClientEvent('QBCore:Notify', src, "Du leverte pakken og fikk " .. pay .. " kroner " .. "og " .. erfaring .. " erfaring")
	---TriggerClientEvent('mythic_notify:client:DoHudText', source, { type = 'success', text = 'You were handed $'..Config.Payment.. 'and some oxy!', length = 10000})
end)

RegisterServerEvent('boss:killCompetition')
AddEventHandler('boss:killCompetition', function()
	local src = source
    local Player = QBCore.Functions.GetPlayer(src)
	local ringChance = math.random(1,10)
	Player.Functions.AddItem("labkey", 1)
	if ringChance >= 8 then
		Player.Functions.AddItem("rolex", 1)
	end


    TriggerClientEvent('QBCore:Notify', src, "Takk for nøkkelen.")
	---TriggerClientEvent('mythic_notify:client:DoHudText', source, { type = 'success', text = 'You were handed $'..Config.Payment.. 'and some oxy!', length = 10000})
end)