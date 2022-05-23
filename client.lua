ESX = nil

disautostart = false
handbrake = false

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

    RageUI.Visible(vehmenu, not RageUI.Visible(vehmenu))
    while vehmenu do
        Citizen.Wait(0)
            RageUI.IsVisible(vehmenu, true, true, true, function()

            RageUI.Separator("↓ ~o~Actions relatives au véhicule~s~ ↓")

			RageUI.ButtonWithStyle("• Actions Véhicule ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  end
			end, actionssub)

			RageUI.ButtonWithStyle("• Données du véhicule ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  end
			end, calculs)
            
    end, function()
	end)


    RageUI.IsVisible(calculs, true, true, true, function()
			
			local Ped = GetPlayerPed(-1)
			veh = GetVehiclePedIsUsing(Ped)
			
			RageUI.Separator("↓ ~o~Niveaux~s~ ↓")
			RageUI.Separator("~o~Niveau d'Essence :~s~ " .. GetVehicleFuelLevel(veh, 0) .. "%")--*100
			RageUI.Separator("~o~Niveau d'Huile :~s~ " .. GetVehicleOilLevel(veh, 0) .. "L")--*100
			

			RageUI.Separator("↓ ~o~Compression des suspensions~s~ ↓")
			RageUI.Separator("~o~Avant-Gauche :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 0))*100)
			RageUI.Separator("~o~Avant-Droit :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 1))*100)
			RageUI.Separator("~o~Arrière-Gauche :~s~ " ..(GetVehicleWheelSuspensionCompression(veh, 2))*100)
			RageUI.Separator("~o~Arrière-Droit :~s~ " .. (GetVehicleWheelSuspensionCompression(veh, 3))*100)


	end, function() 
	end)

		RageUI.IsVisible(actionssub, true, true, true, function()
				
			Ped = GetPlayerPed(-1)
			veh = GetVehiclePedIsUsing(Ped)
			engineon = GetIsVehicleEngineRunning(veh)
			doorstatus = GetVehicleDoorLockStatus(veh)
			alarm = IsVehicleAlarmActivated(veh)
			
			RageUI.Separator("↓ ~o~Effectuer une Action sur le Véhicule~s~ ↓")

			RageUI.ButtonWithStyle("• Allumer / Éteindre le moteur ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then
					if engineon then  
						print(engineon)
						SetVehicleEngineOn(veh, false, true, true)
					else
						print(engineon)
						SetVehicleEngineOn(veh, true, true, true)
					end
				end
			end)

			--[[RageUI.ButtonWithStyle("• Activer / Désactiver le démarrage automatique du moteur ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then
					if engineon then
						if disautostart then
							SetVehicleEngineOn(veh, true, true, false)
							RageUI.Popup({message = "~r~Démarrage Automatique Activé"})
						else
							SetVehicleEngineOn(veh, true, true, true)
							RageUI.Popup({message = "~r~Démarrage Automatique Désactivé"})
						end  
						
					else
						if disautostart then
							SetVehicleEngineOn(veh, false, true, false)
							RageUI.Popup({message = "~r~Démarrage Automatique Activé"})
						else
							SetVehicleEngineOn(veh, false, true, true)
							RageUI.Popup({message = "~r~Démarrage Automatique Désactivé"})
						end  
					end
				end
			end)]]

			RageUI.ButtonWithStyle("• Serrer / Déserrer le frein à main ", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
				if Selected then  
					if handbrake then
						handbrake = false
						Citizen.Wait(1000)
						FreezeEntityPosition(veh, false)
						RageUI.Popup({message = "Frein à main : ~g~Déserré"})
					else
						FreezeEntityPosition(veh, true)
						Citizen.Wait(1000)
						handbrake = true
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
		
        if not RageUI.Visible(vehmenu) and not RageUI.Visible(calculs) and not RageUI.Visible(actionssub) then
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
