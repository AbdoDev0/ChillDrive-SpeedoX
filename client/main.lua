RegisterNetEvent("speedometer:show")
AddEventHandler("speedometer:show", function(isMetric, speed, rpm, gear)
    SendNUIMessage({
        action = "show",
        isMetric = isMetric,
        speed = speed,
        rpm = rpm,
        gear = gear
    })
end)

RegisterNetEvent("speedometer:hide")
AddEventHandler("speedometer:hide", function()
    SendNUIMessage({
        action = "hide"
    })
end)

Citizen.CreateThread(function()
    while true do
        local playerPed = GetPlayerPed(-1)
        local pedVehicle = GetVehiclePedIsIn(playerPed, false)

        local isMetric, speed, rpm, gear

        if pedVehicle ~= 0 and GetIsVehicleEngineRunning(pedVehicle) then
            isMetric = ShouldUseMetricMeasurements()
            speed = GetEntitySpeed(pedVehicle)
            rpm = GetVehicleCurrentRpm(pedVehicle)
            gear = GetVehicleCurrentGear(pedVehicle)

            TriggerEvent("speedometer:show", isMetric, speed, rpm, gear)
        else
            TriggerEvent("speedometer:hide")
        end

        HideHudComponentThisFrame(7) -- Hide wanted stars
        HideHudComponentThisFrame(9) -- Hide vehicle name

        Citizen.Wait(1) -- Delay to control thread execution frequency
    end
end)
