ESX = nil

disautostart = false
handbrake = false
sel = false
sel2 = false

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('esx:getSharedObject', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then
		ESX.PlayerData = ESX.GetPlayerData()
    end
end)

-------- Script --------

function OpenMenu()
    local vehmenu = RageUI.CreateMenu("Vehicle Menu", "Vehicle Menu", 0, 0, 'clk', 'interaction_bgd2', 0, 0, 0, 0) ---------
	local actionssub = RageUI.CreateSubMenu(vehmenu, "Vehicle Menu", "Vehicle Menu", 0, 0, 'clk', 'interaction_bgd2', 0, 0, 0, 0)
    local calculs = RageUI.CreateSubMenu(vehmenu, "Vehicle Menu", "Vehicle Menu", 0, 0, 'clk', 'interaction_bgd2', 0, 0, 0, 0)--------------
	local vehinfos = RageUI.CreateSubMenu(vehmenu, "Vehicle Menu", "Vehicle Menu", 0, 0, 'clk', 'interaction_bgd2', 0, 0, 0, 0)--------------


    RageUI.Visible(vehmenu, not RageUI.Visible(vehmenu))
    while vehmenu do
        Citizen.Wait(0)
            RageUI.IsVisible(vehmenu, true, true, true, function()

            RageUI.Separator("↓ ~o~Actions relatives au véhicule~s~ ↓")

			RageUI.ButtonWithStyle("• Informations Véhicule ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  end
			end, vehinfos)

			RageUI.ButtonWithStyle("• Actions Véhicule ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  end
			end, actionssub)

			RageUI.ButtonWithStyle("• Données du véhicule ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  end
			end, calculs)
            
    end, function()
	end)


	RageUI.IsVisible(actionssub, true, true, true, function()	
		Ped = GetPlayerPed(-1)
		veh = GetVehiclePedIsUsing(Ped)
		engineon = GetIsVehicleEngineRunning(veh)
		doorstatus = GetVehicleDoorLockStatus(veh)
		alarm = IsVehicleAlarmActivated(veh)
			
		RageUI.Separator("↓ ~o~Effectuer une Action sur le Véhicule~s~ ↓")

		RageUI.Checkbox("Éteindre le moteur",nil, moteur,{},function(Hovered,Active,Selected,Checked)
			if Selected then

				moteur = Checked


				if Checked then
					print(engineon)
					SetVehicleEngineOn(veh, false, true, true)
				else
					print(engineon)
					SetVehicleEngineOn(veh, true, true, true)
				end
			end
		end)

		--[[RageUI.ButtonWithStyle("• Allumer / Éteindre le moteur", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then
				if engineon then  
					print(engineon)
					SetVehicleEngineOn(veh, false, true, true)
				else
					print(engineon)
					SetVehicleEngineOn(veh, true, true, true)
				end
			end
		end)]]

		RageUI.ButtonWithStyle("• Serrer / Déserrer le frein à main ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then  
				if handbrake then
					handbrake = false
					Citizen.Wait(1000)
					--FreezeEntityPosition(veh, false)
					SetVehicleHandbrake(veh, false) --> To Test 
					RageUI.Popup({message = "Frein à main : ~g~Déserré"})
				else
					--FreezeEntityPosition(veh, true)
					Citizen.Wait(1000)
					handbrake = true
					SetVehicleHandbrake(veh, true)
					RageUI.Popup({message = "Frein à main : ~r~Serré"})
				end
			end
		end)
			

		RageUI.ButtonWithStyle("• Verrouiller / Déverrouiller les portes ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then  
				if doorstatus == 1 then -- unlocked
					SetVehicleDoorsLocked(veh, 2)
					SetVehicleDoorsLocked(veh, 4)
					RageUI.Popup({message = "Véhicule : ~r~Verouillé"})
					PlayVehicleDoorCloseSound(veh, 0)
					Citizen.Wait(100)
					SetVehicleLights(veh, 2)
					Citizen.Wait(200)
					SetVehicleLights(veh, 1)
					Citizen.Wait(200)
					SetVehicleLights(veh, 2)
					Citizen.Wait(200)
					SetVehicleLights(veh, 1)
					Citizen.Wait(200)
					SetVehicleLights(veh, 2)
					Citizen.Wait(200)
					SetVehicleLights(veh, 0)
				elseif doorstatus == 2 then --- locked
					SetVehicleDoorsLocked(veh, 1)
					RageUI.Popup({message = "Véhicule : ~g~Déverouillé"})
					SetVehicleLights(veh, 2)
					Citizen.Wait(100)
					SetVehicleLights(veh, 1)
					Citizen.Wait(100)
					SetVehicleLights(veh, 2)
					Citizen.Wait(100)
					SetVehicleLights(veh, 0)
				else
					SetVehicleDoorsLocked(veh, 1)
					RageUI.Popup({message = "Véhicule : ~g~Déverouillé"})
					SetVehicleLights(veh, 2)
					Citizen.Wait(100)
					SetVehicleLights(veh, 1)
					Citizen.Wait(100)
					SetVehicleLights(veh, 2)
					Citizen.Wait(100)
					SetVehicleLights(veh, 0)
				end
			end
		end)

		RageUI.ButtonWithStyle("• Allumer les feux de détresse -- To Redo ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then  
				if warnings then
					SetVehicleIndicatorLights(veh, 1, false)
					SetVehicleIndicatorLights(veh, 2, false)
					SetVehicleIndicatorLights(veh, 3, false)
					warnings = false
				else
					warnings = true
					SetVehicleIndicatorLights(veh, 1, true)
					SetVehicleIndicatorLights(veh, 2, true)
					SetVehicleIndicatorLights(veh, 3, true)
				end
			end
		end)

		RageUI.ButtonWithStyle("• Allumer / Éteindre l'alarme --- To Do", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
			if Selected then 
				veh2 = GetVehiclePedIsIn(Ped, false)
                StartVehicleAlarm(veh, true)
                SetVehicleAlarmTimeLeft(veh, 10000)
				SetVehicleAlarm(veh, true)

				StartVehicleAlarm(veh2, true)
                SetVehicleAlarmTimeLeft(veh2, 10000)
				SetVehicleAlarm(veh2, true)


				--[[if alarm then
					print(alarm)
					SetVehicleAlarm(veh, false)
					alarm = false
				else
					SetVehicleAlarm(veh, true)
					alarm = true
				end ]]
			end
		end)


	end, function() 
	end)

	RageUI.IsVisible(calculs, true, true, true, function()
			
		local Ped = GetPlayerPed(-1)
		veh = GetVehiclePedIsUsing(Ped)
		local turbop = GetVehicleTurboPressure(veh)
		local turbop2 = math.floor(turbop * turbop + 0.5) / turbop
		local temp = math.floor(GetVehicleEngineTemperature(veh))

		if sel then 
			--RageUI.ButtonWithStyle("				     ↓ ~o~Niveaux~s~ ↓ ", nil, {RightLabel = "→"}, true, function(Hovered, Active, Selected)
			RageUI.ButtonWithStyle("~c~Niveaux~s~", nil, {RightLabel = "↓"}, true, function(Hovered, Active, Selected)
				if Selected then  
					if sel then
						sel = false
					else
						sel = true
					end
				end
			end)
		else
			---RageUI.ButtonWithStyle("				         - ~o~Niveaux~s~ - ", nil, {},true, function(Hovered, Active, Selected)
			RageUI.ButtonWithStyle("~t~Niveaux~s~ ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  
					if sel then
						sel = false
					else
						sel = true
					end
				end
			end)
		end


		--[[RageUI.ButtonWithStyle("				↓ ~o~Niveaux~s~ ↓ ", nil, {},true, function(Hovered, Active, Selected)
			if Selected then  
				if sel then
					sel = false
				else
					sel = true
				end
			end
		end)]]


		if sel then
		RageUI.ButtonWithStyle("~b~• Niveau d'Usure Véhicule :~s~ " .. math.floor(GetVehicleBodyHealth(veh, 0)/10) .. "%", nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~d~• Niveau d'Usure Moteur :~s~ " .. math.floor(GetVehicleEngineHealth(veh, 0)/10) .. "%", nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~• Niveau d'Usure des Pneus :~s~ " .. math.floor(GetVehicleWheelHealth(veh, 0)/10) .. "%", nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~• Niveau d'Essence :~s~ " .. GetVehicleFuelLevel(veh, 0) .. "%", nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~• Niveau d'Huile :~s~ " .. GetVehicleOilLevel(veh, 0) .. "L", nil, {},true, function()
			if Selected then  end
		end)

		end
			
		RageUI.Separator("↓ ~o~Performances~s~ ↓")

		if temp < 80 then
			RageUI.ButtonWithStyle("~o~			Température Moteur :~s~~g~ " .. temp .. "°", nil, {},true, function()
				if Selected then  end
			end)
		elseif temp < 95 then
			RageUI.ButtonWithStyle("~o~			Température Moteur :~s~~o~ " .. temp .. "°", nil, {},true, function()
				if Selected then  end
			end)
		else
			RageUI.ButtonWithStyle("~o~			Température Moteur :~s~~r~ " .. temp .. "°", nil, {},true, function()
				if Selected then  end
			end)
		end



		if turbop > 0 then
			RageUI.ButtonWithStyle("~o~Pression du Turbo :~s~ " .. turbop2 .. "Bar", nil, {},true, function()
				if Selected then  end
			end)
		end

		RageUI.Separator("↓ ~o~Compression des suspensions~s~ ↓")

		RageUI.ButtonWithStyle("~o~			Avant-Gauche :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 0))*100, nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~			Avant-Droit :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 1))*100, nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~			Arrière-Gauche :~s~ " ..(GetVehicleWheelSuspensionCompression(veh, 2))*100, nil, {},true, function()
			if Selected then  end
		end)

		RageUI.ButtonWithStyle("~o~			Arrière-Droit :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 3))*100, nil, {},true, function()
			if Selected then  end
		end)

	end, function() 
	end)

    RageUI.IsVisible(vehinfos, true, true, true, function()
			
		local Ped = GetPlayerPed(-1)
		veh = GetVehiclePedIsUsing(Ped)

		if GetDisplayNameFromVehicleModel(veh) == "CARNOTFOUND" then
			RageUI.Separator("~o~Modèle du Véhicule : Inconnu~s~ " )
		else
			RageUI.Separator("~o~Modèle du Véhicule :~s~ " .. GetDisplayNameFromVehicleModel(veh))
		end

		RageUI.Separator("↓ ~o~Informations Constructeur~s~ ↓")
		RageUI.Separator("~o~Couleur :~s~ " .. GetVehicleColor(veh))
		RageUI.Separator("~o~Immatriculation :~s~ " .. GetVehicleNumberPlateText(veh))
		RageUI.Separator("~o~Vitesse maximale d'origine :~s~ " .. (GetVehicleEstimatedMaxSpeed(veh)*3.6) .. " km/h")
		RageUI.Separator("~o~Nombre de sièges :~s~ " .. GetVehicleModelNumberOfSeats(veh) .. " sièges")
		RageUI.Separator("~o~Nombre de vitesses :~s~ " .. GetVehicleHighGear(veh))
		RageUI.Separator("~o~Niveau de teinte des vitres :~s~ " .. (GetVehicleWindowTint(veh)*100) .. "%")
		
		

		end, function() 
	end)
		
        if not RageUI.Visible(vehmenu) and not RageUI.Visible(calculs) and not RageUI.Visible(actionssub) and not RageUI.Visible(vehinfos) then
            vehmenu = RMenu:DeleteType("vehmenu", true)
        end
    end

end

RegisterCommand('veh', function(source)
	--[[ESX.TriggerServerCallback('KorioZ-GangsBuilder:Admin_getUsergroup', function(plyGroup)
		if plyGroup ~= nil and (plyGroup == 'admin' or plyGroup == 'superadmin' or plyGroup == 'owner' or plyGroup == '_dev') then
			TriggerEvent('gb:OpenMenu', source)
		else
			ESX.ShowNotification('Vous devez être ~r~Admin ~w~pour ouvrir le ~g~GangsBuilder.')
		end
	end)]]
    OpenMenu()
end, false)


-------------------------------------------------------------------------------------------------------------------------

--TriggerServerEvent('clk_safezone:addzone', ZoneData)
