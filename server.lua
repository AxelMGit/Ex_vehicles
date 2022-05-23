--[[function GetZones()
	local data = LoadResourceFile('clk_safezone', 'data/zones.json')
	return data and json.decode(data) or {}
end

RegisterServerEvent('clk_safezone:addzone')
AddEventHandler('clk_safezone:addzone', function(data)
		--table.insert(ZoneData, data)
		SaveResourceFile('clk_safezone', 'data/zones.json', json.encode(ZoneData))
end)]]

--[[AddEventHandler('chatMessage', function(player, message)
    if message == '/zonemenu2' then
        TriggerEvent('clk_safezone:openmenu')
        print('Ok')
    end
end)]]

--RegisterCommand("zonemenu", function(source)
    --[[if source > 0 then
        print("You are not console.")
    else
        print("This is console!")
    end]]
    --TriggerClientEvent('clk_safezone:openmenu', source)
    --TriggerEvent('clk_safezone:openmenu', source)

    --TriggerClientEvent("testt", source)
   -- TriggerEvent('testt')
----end, false)

--TriggerEvent('testt')
--print('ASG')